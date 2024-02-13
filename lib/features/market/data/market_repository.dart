import 'dart:developer';

import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketRepository {
  List<NftModel> nftList = [];

  late NftModel lastOpenedNft;

  Future<void> loadNft() async {
    nftList.clear();

    final collection = await FirebaseCollections.playersNftCollection.get();
    collection.docs.forEach((element) {
      nftList.add(NftModel.fromJson(element.data(), element.id));
    });
  }

  Future<void> getNftById(String id) async {
    final nftDoc = FirebaseCollections.playersNftCollection.doc(id);
    final nftDocInst = await nftDoc.get();
    final NftModel nftModel = NftModel.fromJson(nftDocInst.data()!, nftDoc.id);

    lastOpenedNft = nftModel;
  }

  Future<void> updateNftViewsCounter(String id) async {
    final nftDb = FirebaseCollections.playersNftCollection.doc(id);
    await nftDb.update({"views": FieldValue.increment(1)});
  }
}
