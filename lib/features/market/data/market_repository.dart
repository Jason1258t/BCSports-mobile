import 'dart:developer';

import 'package:bcsports_mobile/features/market/data/nft_service.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class MarketRepository {
  late final NftService nftService;
  late final ProfileRepository profileRepository;
  List<MarketItemModel> productList = [];
  List<MarketItemModel> lotsList = [];

  Stream<QuerySnapshot> marketStream =
      FirebaseCollections.marketCollection.snapshots();

  BehaviorSubject<LoadingStateEnum> lotsStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  MarketRepository({required this.nftService, required this.profileRepository});

  subscribeOnMarketStream()  {
    marketStream.listen((snapshot) {
      productList.clear();
      snapshot.docs.forEach((doc)  {
        try {
          MarketItemModel marketItemModel =  parseMarketDocument(doc);
          productList.add(marketItemModel);
        } catch (e) {
          log("Fail to parse market item by id ${doc.id} ! ${e}");
        }
      });
    });
  }

  Future<void> removeProductFromMarket(MarketItemModel prod) async {
    final product = FirebaseCollections.marketCollection.doc(prod.id);
    await product.delete();

    log("Product deleted from market!");
  }

  Future<void> getUserLots() async {
    String userId = profileRepository.user.id;

    lotsStream.add(LoadingStateEnum.loading);
    try {
      lotsList =
          productList.where((item) => item.lastOwnerId == userId).toList();
      lotsStream.add(LoadingStateEnum.success);
    } catch (e) {
      lotsStream.add(LoadingStateEnum.fail);
    }
  }

  MarketItemModel parseMarketDocument(doc) {
    Map productMap = doc.data() as Map;
    print(productMap);
    final nftId = productMap['nft_id'];
    final NftModel productNft = nftService.nftCollectionList
        .where((nftItem) => nftItem.documentId == nftId)
        .first;
    MarketItemModel marketItemModel = MarketItemModel.fromJson(
        productMap, productNft, doc.id);

    return marketItemModel;
  }

  Future<int> getLotFavouritesValue(String lotId) async {
    final userColl = await FirebaseCollections.usersCollection.get();
    int total = 0;

    userColl.docs.forEach((doc) {
      final userFavs = doc.data()["favourites_list"] ?? [];

      if (userFavs.contains(lotId)) {
        total += 1;
      }
    });

    return total;
  }
}
