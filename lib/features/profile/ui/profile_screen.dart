import 'package:bcsports_mobile/features/profile/bloc/edit_user/edit_user_cubit.dart';
import 'package:bcsports_mobile/features/profile/bloc/user/user_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/ui/widgets/Nft_item.dart';
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
            body: CustomScrollView(slivers: [
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
                        decoration: BoxDecoration(
                          color: user.bannerColor,
                          borderRadius: BorderRadius.circular(15),
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
                                  ? NetworkImage(user.avatarUrl ?? '')
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
                      width: sizeof.width * 0.4,
                      enumTap: ProfileTabsEnum.nft,
                      text: 'NFT',
                      onTap: () {
                        repository.setProfileActiveTab(ProfileTabsEnum.nft);
                        setState(() {});
                      },
                    ),
                    ToggleButton(
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
                  ? SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 30.0,
                        childAspectRatio: 0.615,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return NftItemWidget(
                            width: sizeof.width * 0.43,
                            height: sizeof.width * 0.7,
                          );
                        },
                        childCount: 20,
                      ))
                  : StreamBuilder(
                      stream: repository.userPostsState.stream,
                      builder: (context, snapshot) {
                        if (snapshot.data == LoadingStateEnum.success) {
                          return SliverList(
                              delegate: SliverChildBuilderDelegate(
                            (context, index) => FeedPostWidget(
                              postId: repository.posts[index].postModel.id,
                              source: repository,
                            ),
                            childCount: repository.posts.length,
                          ));
                        } else {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: AppAnimations.circleIndicator,
                            ),
                          );
                        }
                      })
            ]),
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
}
