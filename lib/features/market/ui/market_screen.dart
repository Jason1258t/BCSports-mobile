import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black_090723,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("market"),
          ),
          body: CustomScrollView(
            slivers: [
              
            ],
          ),
        ),
      ),
    );
  }
}