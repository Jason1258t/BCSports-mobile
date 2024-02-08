import 'dart:developer';

import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketRepository {
  List<NftModel> nftList = [];
  final String _nftCollectionName = 'players_NFT';

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> loadNft() async {
    nftList.clear();

    final collection = await _db.collection(_nftCollectionName).get();
    collection.docs.forEach((element) {
      nftList.add(NftModel.fromJson(element.data(), element.id));
    });
  }

  Future<void> updateNftAuctionPrice(double newPrice, NftModel nft) async {
    final docInst =
        await _db.collection(_nftCollectionName).doc(nft.documentId);

    await docInst.update({"current_bit": newPrice});

    final NftModel prevNft =
        nftList.where((element) => element.documentId == nft.documentId).first;

    prevNft.currentBit = newPrice;

    log("New price for ${nft.documentId}");
  }
}
