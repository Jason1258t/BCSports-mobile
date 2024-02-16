import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NftService {
  List<NftModel> nftCollectionList = [];
  late NftModel lastLoadedNft;

  Future<void> loadNftCollection() async {
    final nftColl = await FirebaseCollections.playersNftCollection.get();
    nftColl.docs.forEach((doc) {
      NftModel nft = NftModel.fromJson(doc.data(), doc.id);
      nftCollectionList.add(nft);
    });
  }

  Future<void> updateNftViewsCounter(String id) async {
    final doc = FirebaseCollections.playersNftCollection.doc(id);
    await doc.update({'views': FieldValue.increment(1)});
  }

  Future<void> loadNftDetailsData(String id) async {
    final resNftRaw = FirebaseCollections.playersNftCollection.doc(id);
    final nft = await resNftRaw.get();
    lastLoadedNft = NftModel.fromJson(nft.data()!, nft.id);
  }

  Future<NftModel> loadNftData(String docId) async {
    final nftDb = FirebaseCollections.playersNftCollection.doc(docId);
    final nft = await nftDb.get();
    return NftModel.fromJson(nft.data()!, nft.id);
  }
}