import 'package:bcsports_mobile/models/market/nft_model.dart';

class MarketItemModel {
  final double currentPrice;
  final String lastOwnerId;
  final DateTime lastSaleDate;
  final String nftId;
  final NftModel nft;

  MarketItemModel(
      {required this.currentPrice,
      required this.lastOwnerId,
      required this.lastSaleDate,
      required this.nftId, 
      required this.nft});

  factory MarketItemModel.fromJson(Map json, NftModel responseNft) {
    return MarketItemModel(
        currentPrice: double.parse(json['current_price'].toString()),
        lastOwnerId: json['last_owner'],
        lastSaleDate: json['last_sale_date'].toDate(),
        nftId: json['nft_id'],
        nft: responseNft
        );
  }
}
