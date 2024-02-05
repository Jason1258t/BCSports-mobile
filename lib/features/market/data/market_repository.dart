import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketRepository {
  List<NftModel> nftList = [];

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> loadNft() async {
    nftList.clear();

    final collection = await _db.collection("players_NFT").get();
    collection.docs.forEach((element) {
      nftList.add(NftModel.fromJson(element.data()));
    });
  }
}
