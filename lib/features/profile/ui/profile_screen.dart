import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/nft_card.dart';
import 'package:bcsports_mobile/features/profile/bloc/user/user_cubit.dart';
import 'package:bcsports_mobile/features/profile/bloc/user_nft/user_nft_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/ui/widgets/toggle_bottom.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<UserNftCubit>().loadUserNft();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeof = MediaQuery.sizeOf(context);

    final repository = RepositoryProvider.of<ProfileRepository>(context);

    const separator = SliverToBoxAdapter(
      child: SizedBox(
        height: 20,
      ),
    );

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserSuccessState) {
          var user = RepositoryProvider.of<ProfileRepository>(context).user;

          return CustomScaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 120,
                        ),
                      ],
                    ),
                    Text(
                      'Profile',
                      style: AppFonts.font18w600,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, AppRouteNames.createPost),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRouteNames.profileSettings);
                          },
                        ),
                      ],
                    )
                  ],
                )),
            body: RefreshIndicator.adaptive(
              onRefresh: () async{
                repository.setUser(user.id);
              },
              child: CustomScrollView(
              slivers: [
                separator,
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: sizeof.width * 0.70,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: sizeof.width * 0.50,
                          ),
                          width: double.infinity,
                          decoration: user.banner.url == null
                              ? BoxDecoration(
                                  color: user.bannerColor,
                                  borderRadius: BorderRadius.circular(15),
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(user.banner.url!),
                                      fit: BoxFit.cover),
                                ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: sizeof.width * 0.20,
                            backgroundColor: AppColors.black_090723,
                            child: CircleAvatar(
                                radius: sizeof.width * 0.18,
                                backgroundColor: user.avatarColor,
                                backgroundImage: user.avatarUrl != null
                                    ? NetworkImage(user.avatarUrl!)
                                    : null,
                                child: user.avatarUrl == null
                                    ? Center(
                                        child: Text(
                                          (user.displayName ?? user.username)[0]
                                              .toUpperCase(),
                                          style: AppFonts.font64w400,
                                        ),
                                      )
                                    : Container()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                separator,
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Text(
                        user.displayName ?? user.username,
                        style: AppFonts.font20w600,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '@${user.username}',
                        style: AppFonts.font13w100,
                      ),
                    ],
                  ),
                ),
                separator,
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ToggleButton(
                        activeTap: repository.activeTab,
                        width: sizeof.width * 0.4,
                        enumTap: ProfileTabsEnum.nft,
                        text: 'NFT',
                        onTap: () {
                          repository.setProfileActiveTab(ProfileTabsEnum.nft);
                          setState(() {});
                        },
                      ),
                      ToggleButton(
                        activeTap: repository.activeTab,
                        width: sizeof.width * 0.4,
                        enumTap: ProfileTabsEnum.posts,
                        text: 'Posts',
                        onTap: () {
                          repository.setProfileActiveTab(ProfileTabsEnum.posts);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                separator,
                separator,
                repository.activeTab == ProfileTabsEnum.nft
                    ? buildNftTab()
                    : buildPostsTab(repository),
                separator
              ]),
            ),
          );
        } else {
          return CustomScaffold(
              body: Center(
            child: AppAnimations.circleIndicator,
          ));
        }
      },
    );
  }

  Widget buildNftTab() {
    return BlocBuilder<UserNftCubit, UserNftState>(
      builder: (context, state) {
        if (state is UserNftLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: AppAnimations.circleIndicator,
            ),
          );
        } else if (state is UserNftSuccess &&
            context.read<ProfileRepository>().userNftList.isNotEmpty) {
          return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 29,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                  childAspectRatio: 0.59),
              delegate: SliverChildBuilderDelegate(
                  (context, index) => MarketNftCard(
                        nft: context
                            .read<ProfileRepository>()
                            .userNftList[index],
                      ),
                  childCount:
                      context.read<ProfileRepository>().userNftList.length));
        }

        return SliverToBoxAdapter(
            child: Center(
                child: Text(
          'Sorry, you don\'t have NFTs.',
          style: AppFonts.font20w600,
        )));
      },
    );
  }

  Widget buildPostsTab(ProfileRepository repository) {
    return StreamBuilder(
        stream: repository.userPostsState.stream,
        builder: (context, snapshot) {
          if (snapshot.data == LoadingStateEnum.success &&
              repository.posts.isNotEmpty) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) => FeedPostWidget(
                postId: repository.posts[index].postModel.id,
                source: repository,
              ),
              childCount: repository.posts.length,
            ));
          } else if (repository.posts.isEmpty) {
            return SliverToBoxAdapter(
                child: Center(
                    child: Text(
              'Sorry, you don\'t have Posts.',
              style: AppFonts.font20w600,
            )));
          } else {
            return SliverToBoxAdapter(
              child: Center(
                child: AppAnimations.circleIndicator,
              ),
            );
          }
        });
  }
}
