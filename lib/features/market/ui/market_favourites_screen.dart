// import 'package:bcsports_mobile/features/market/bloc/favourite/favourite_cubit.dart';
// import 'package:bcsports_mobile/features/market/bloc/market/market_cubit.dart';
// import 'package:bcsports_mobile/features/market/data/market_repository.dart';
// import 'package:bcsports_mobile/features/market/ui/widgets/nft_card.dart';
// import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
// import 'package:bcsports_mobile/models/market/nft_model.dart';
// import 'package:bcsports_mobile/utils/animations.dart';
// import 'package:bcsports_mobile/utils/colors.dart';
// import 'package:bcsports_mobile/utils/enums.dart';
// import 'package:bcsports_mobile/utils/fonts.dart';
// import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MarketFavouritesScreen extends StatefulWidget {
//   const MarketFavouritesScreen({super.key});

//   @override
//   State<MarketFavouritesScreen> createState() => _MarketFavouritesScreenState();
// }

// class _MarketFavouritesScreenState extends State<MarketFavouritesScreen> {
//   String text = "Favourites";

//   void onNftCardTap(NftModel nft) {
//     Navigator.of(context).pushNamed('/market/details',
//         arguments: {'nft': nft, "target": ProductTarget.buy});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColors.black,
//       child: SafeArea(
//         child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: BlocBuilder<MarketCubit, MarketState>(
//               builder: (context, state) {
//                 if (state is MarketLoading) {
//                   return Center(
//                     child: AppAnimations.circleIndicator,
//                   );
//                 } else if (state is MarketSuccess) {
//                   return buildMainInfoWidget();
//                 }
//                 return Container();
//               },
//             )),
//       ),
//     );
//   }

//   Widget buildMainInfoWidget() {
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//             backgroundColor: AppColors.black,
//             surfaceTintColor: Colors.transparent,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             floating: true,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 ButtonBack(
//                   onTap: () => Navigator.pop(context),
//                 )
//               ],
//             )),
//         SliverPadding(
//           padding: const EdgeInsets.symmetric(horizontal: 23),
//           sliver: SliverToBoxAdapter(
//             child: Text(
//               text,
//               style: AppFonts.font18w600,
//             ),
//           ),
//         ),
//         const SliverToBoxAdapter(
//           child: SizedBox(height: 16),
//         ),
//         SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 23),
//             sliver: BlocBuilder<FavouriteCubit, FavouriteState>(
//               builder: (context, state) {
//                 final ProfileRepository profileRepository =
//                     context.read<ProfileRepository>();
//                 final MarketRepository marketRepository =
//                     context.read<MarketRepository>();

//                 final List<dynamic> likedNftIdList =
//                     profileRepository.user.favouritesNftList;

//                 final List<NftModel> favouriteNftList = marketRepository.nftList
//                     .where((nft) => likedNftIdList.contains(nft.documentId))
//                     .toList();

//                 return SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       mainAxisSpacing: 29,
//                       crossAxisSpacing: 8,
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.59),
//                   delegate: SliverChildBuilderDelegate(
//                       (context, index) => MarketNftCard(
//                             nft: favouriteNftList[index],
//                             onTap: () {
//                               onNftCardTap(favouriteNftList[index]);
//                             },
//                           ),
//                       childCount: favouriteNftList.length),
//                 );
//               },
//             ))
//       ],
//     );
//   }
// }
