import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NftService {
  List<NftModel> nftCollectionList = [];
  late NftModel lastLoadedNft;

  Future<void> loadNftCollection() async {
    final nftColl = await FirebaseCollections.playersNftCollection.get();
    nftColl.docs.forEach((doc)  async {
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

  Future<int> loadNftCardFavouritesValue(String nftId) async {
    final userColl = await FirebaseCollections.usersCollection.get();
    int total = 0;

    userColl.docs.forEach((doc) {
      Map userDoc = doc.data();
      final userNftIdList = userDoc['favourites_list'] ?? [];
      if (userNftIdList.contains(nftId)) {
        total += 1;
      }
    });
    return total;
  }
}
