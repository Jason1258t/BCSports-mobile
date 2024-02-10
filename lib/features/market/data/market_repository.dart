import 'dart:developer';

import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketRepository {
  List<NftModel> nftList = [];
  final String _nftCollectionName = 'players_NFT';

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late NftModel lastOpenedNft;

  Future<void> loadNft() async {
    nftList.clear();

    final collection = await _db.collection(_nftCollectionName).get();
    collection.docs.forEach((element) {
      nftList.add(NftModel.fromJson(element.data(), element.id));
    });
  }

  Future<void> getNftById(String id) async {
    final nftDoc = _db.collection(_nftCollectionName).doc(id);
    final nftDocInst = await nftDoc.get();
    final NftModel nftModel = NftModel.fromJson(nftDocInst.data()!, nftDoc.id);

    lastOpenedNft = nftModel;
  }

  Future<void> updateNftAuctionPrice(
      double newPrice, NftModel nft, UserModel lastBidder) async {
    final docInst =
         _db.collection(_nftCollectionName).doc(nft.documentId);

    await docInst
        .update({"current_bit": newPrice, "last_bidder": lastBidder.username});

    lastOpenedNft.currentBit = newPrice;
    lastOpenedNft.lastBidderName = lastBidder.username;

    log("New price for ${nft.documentId}");
  }
}
