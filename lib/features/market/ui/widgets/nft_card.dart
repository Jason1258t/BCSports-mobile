import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:flutter/material.dart';

class MarketNftCard extends StatefulWidget {
  final NftModel nft;

  const MarketNftCard({super.key, required this.nft});

  @override
  State<MarketNftCard> createState() => MarketNftCardState();
}

class MarketNftCardState extends State<MarketNftCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }
}
