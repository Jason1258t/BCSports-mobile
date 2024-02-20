import 'package:bcsports_mobile/features/market/ui/widgets/nft_card.dart';
import 'package:bcsports_mobile/features/profile/bloc/profile_view/profile_view_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/features/profile/ui/widgets/toggle_bottom.dart';
import 'package:bcsports_mobile/features/social/bloc/post_comments/post_comments_cubit.dart';
import 'package:bcsports_mobile/features/social/ui/comments_screen.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/custon_network_image.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeof = MediaQuery.sizeOf(context);
    final repository = RepositoryProvider.of<ProfileViewRepository>(context);

    const separator = SliverToBoxAdapter(
      child: SizedBox(
        height: 20,
      ),
    );

    final localize = AppLocalizations.of(context)!;

    return BlocBuilder<ProfileViewCubit, ProfileViewState>(
      builder: (context, state) {
        if (state is ViewProfileSuccessState) {
          var user = RepositoryProvider.of<ProfileViewRepository>(context).user;

          return CustomScaffold(
            padding: EdgeInsets.zero,
            appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ButtonBack(onTap: () {
                      Navigator.pop(context);
                    }),
                    Text(
                      localize.profile,
                      style: AppFonts.font18w600,
                    ),
                    const SizedBox(
                      width: 50,
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
                        decoration:  BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Assets.images('profile/profile_photo.png')),
                                    fit: BoxFit.cover),
                              ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: sizeof.width * 0.20,
                          backgroundColor: AppColors.background,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        text: localize.posts,
                        onTap: () {
                          repository.setProfileActiveTab(ProfileTabsEnum.posts);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              separator,
              separator,
              repository.activeTab == ProfileTabsEnum.nft
                  ? buildNftTab(repository)
                  : buildPostsTab(repository),
              separator
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

  Widget buildNftTab(ProfileViewRepository repository) {
    final localize = AppLocalizations.of(context)!;

    if (repository.userNftList.isEmpty) {
      return SliverToBoxAdapter(
          child: Center(
              child: Text(
        localize.you_dont_nfts,
        style: AppFonts.font20w600,
      )));
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 29,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              childAspectRatio: 0.59),
          delegate: SliverChildBuilderDelegate(
              (context, index) => MarketNftCard(
                    onTap: () {},
                    nft: repository.userNftList[index],
                  ),
              childCount: repository.userNftList.length)),
    );
  }

  Widget buildPostsTab(ProfileViewRepository repository) {
    final localize = AppLocalizations.of(context)!;
    final sizeOf = MediaQuery.sizeOf(context);

    return StreamBuilder(
        stream: repository.userPostsState.stream,
        builder: (context, snapshot) {
          if (snapshot.data == LoadingStateEnum.success &&
              repository.posts.isNotEmpty) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => InkWell(
                  onTap: () {
                    context.read<PostCommentsCubit>().setPost(
                        repository.posts[index],
                        RepositoryProvider.of<ProfileViewRepository>(context));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CommentsScreen()));
                  },
                  child: SizedBox(
                    width: (sizeOf.width - 4) / 3,
                    height: (sizeOf.width - 4) / 3,
                    child: CustomNetworkImage(
                      color: AppColors.black_s2new_1A1A1A,
                      url: repository.posts[index].compressedImageUrl!,
                      child: CustomNetworkImage(
                          url: repository.posts[index].imageUrl!),
                    ),
                  ),
                ),
                childCount: repository.posts.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1,
              ),
            );
          } else if (repository.posts.isEmpty) {
            return SliverToBoxAdapter(
                child: Center(
                    child: Text(
              localize.you_dont_posts,
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
