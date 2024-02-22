import 'package:bcsports_mobile/features/social/bloc/home/home_social_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/like/like_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/report/report_cubit.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/appBar/empty_app_bar.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<SocialRepository>(context);

    final localize = AppLocalizations.of(context)!;

    return BlocListener<ReportCubit, ReportState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();

        if (state is ReportFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar("Попробуйте еще раз ("));
        }
        if (state is ReportSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar("Жалоба отправлена"));
        }
      },
      child: CustomScaffold(
          padding: EdgeInsets.zero,
          floatingButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000)),
            backgroundColor: AppColors.primary,
            onPressed: () =>
                Navigator.pushNamed(context, AppRouteNames.createPost),
            child: Icon(
              Icons.add,
              color: AppColors.background,
              size: 28,
            ),
          ),
          appBar: EmptyAppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Image.asset(
                    Assets.images('logo.png'),
                    height: 28,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<LikeCubit>(context).getFavourites();
                      Navigator.pushNamed(
                          context, AppRouteNames.favouritesPost);
                    },
                    child: SvgPicture.asset(
                      Assets.icons('heart.svg'),
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: BlocBuilder<HomeSocialCubit, HomeSocialState>(
            builder: (context, state) {
              if (state is HomeSocialSuccessState) {
                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.black_s2new_1A1A1A,
                  onRefresh: () async {
                    repository.refreshPosts();
                  },
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 18,
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) => FeedPostWidget(
                          postId: repository.posts[index].postModel.id,
                          source: repository,
                        ),
                        childCount: repository.posts.length,
                      ))
                    ],
                  ),
                );
              } else if (state is HomeSocialSuccessState &&
                  repository.posts.isEmpty) {
                return Center(
                  child: Text(
                    localize.no_post,
                    style: AppFonts.font36w800,
                  ),
                );
              } else {
                return CustomScaffold(
                    body: Center(
                  child: AppAnimations.circleIndicator,
                ));
              }
            },
          )),
    );
  }
}
