import 'dart:developer';

import 'package:bcsports_mobile/features/market/data/nft_service.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketRepository {
  final NftService nftService;
  List<MarketItemModel> productList = [];

  Stream<QuerySnapshot> marketStream =
      FirebaseCollections.marketCollection.snapshots();

  MarketRepository({required this.nftService}) {
    subscribeOnMarketStream();
  }

  subscribeOnMarketStream() {
    marketStream.listen((snapshot) {
      productList.clear();

      snapshot.docs.forEach((doc) {
        try {
          Map productMap = doc.data() as Map;
          final nftId = productMap['nft_id'];
          final NftModel productNft = nftService.nftCollectionList
              .where((nftItem) => nftItem.documentId == nftId)
              .first;
          MarketItemModel marketItemModel =
              MarketItemModel.fromJson(productMap, productNft, doc.id);
          productList.add(marketItemModel);
        } catch (e) {
          log("Fail to parse market item by id ${doc.id}");
        }
      });
    });
  }

  Future<void> removeProductFromMarket(MarketItemModel prod) async {
    final product =  FirebaseCollections.marketCollection.doc(prod.id);
    await product.delete();

    log("Product deleted from market!");
  }
}
