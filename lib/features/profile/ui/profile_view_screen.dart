import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/chat/ui/pages/chat_messages_screen.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/nft_card.dart';
import 'package:bcsports_mobile/features/profile/bloc/profile_view/profile_view_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/features/profile/ui/widgets/toggle_bottom.dart';
import 'package:bcsports_mobile/features/social/bloc/post_comments/post_comments_cubit.dart';
import 'package:bcsports_mobile/features/social/ui/comments_screen.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/custon_network_image.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/user_model.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  void messageToUser(UserModel user) async {
    final chatRepository = RepositoryProvider.of<ChatRepository>(context);

    Dialogs.show(context, Center(child: AppAnimations.circleIndicator));

    Room? room = await chatRepository.roomWithUserExists(user.id);
    room ??= await chatRepository.createRoomWithUser(user);

    chatRepository.setActiveUser(user);
    openChatScreen(room);
  }

  void openChatScreen(Room room) {
    Navigator.pop(context);

    Navigator.push(context,
        CupertinoPageRoute(builder: (_) => ChatMessagesScreen(room: room)));
  }

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
            isSafeArea: true,
            body: CustomScrollView(slivers: [
              separator,
              SliverToBoxAdapter(
                child: SizedBox(
                  height: sizeof.width,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: sizeof.width * 0.50,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  Assets.images('profile/profile_photo.png')),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ButtonBack(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    backgroundColor: AppColors.black26,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              height: sizeof.width * 0.2 + 130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.black_s2new_1A1A1A,
                                  borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    user.displayName,
                                    style: AppFonts.font20w600,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '@${user.username}',
                                    style: AppFonts.font13w100,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextButton(
                                    text: localize.message,
                                    color: AppColors.white,
                                    height: 26,
                                    onTap: () => messageToUser(user),
                                    isActive: true,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: sizeof.width * 0.20 + 51),
                                child: CircleAvatar(
                                  radius: sizeof.width * 0.20,
                                  backgroundColor: AppColors.black_s2new_1A1A1A,
                                  child: CircleAvatar(
                                      radius: sizeof.width * 0.18,
                                      backgroundColor: user.avatarColor,
                                      backgroundImage: user.avatarUrl != null
                                          ? NetworkImage(user.avatarUrl!)
                                          : null,
                                      child: user.avatarUrl == null
                                          ? Center(
                                              child: Text(
                                                user.displayName[0]
                                                    .toUpperCase(),
                                                style: AppFonts.font64w400,
                                              ),
                                            )
                                          : Container()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separator,
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleButton(
                        activeTap: repository.activeTab,
                        width: sizeof.width * 0.4,
                        enumTap1: ProfileTabsEnum.nft,
                        enumTap2: ProfileTabsEnum.posts,
                        text1: 'NFT',
                        text2: localize.posts,
                        onTap1: () {
                          repository.setProfileActiveTab(ProfileTabsEnum.nft);
                          setState(() {});
                        },
                        onTap2: () {
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
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => CommentsScreen(
                                  isYours: false,
                                )));
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
