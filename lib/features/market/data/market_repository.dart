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
        Map productMap = doc.data() as Map;
        final nftId = productMap['nft_id'];
        final NftModel productNft = nftService.nftCollectionList
            .where((nftItem) => nftItem.documentId == nftId)
            .first;
        MarketItemModel marketItemModel =
            MarketItemModel.fromJson(productMap, productNft);

        productList.add(marketItemModel);
      });
      print(productList);
    });
  }

  // List<NftModel> nftList = [];

  // late NftModel lastOpenedNft;

  // Future<void> loadNft() async {
  //   nftList.clear();

  //   final collection = await FirebaseCollections.playersNftCollection.get();
  //   collection.docs.forEach((element) {
  //     nftList.add(NftModel.fromJson(element.data(), element.id));
  //   });
  // }

  // Future<void> getNftById(String id) async {
  //   final nftDoc = FirebaseCollections.playersNftCollection.doc(id);
  //   final nftDocInst = await nftDoc.get();
  //   final NftModel nftModel = NftModel.fromJson(nftDocInst.data()!, nftDoc.id);

  //   lastOpenedNft = nftModel;
  // }

  // Future<void> updateNftViewsCounter(String id) async {
  //   final nftDb = FirebaseCollections.playersNftCollection.doc(id);
  //   await nftDb.update({"views": FieldValue.increment(1)});
  // }
}
