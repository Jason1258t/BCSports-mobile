

import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.url, this.child});

  final String url;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;

    return Container(
      clipBehavior: Clip.hardEdge,
      width: size,
      height: size,
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
      child: child,
    );
  }
}
