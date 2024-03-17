import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage(
      {super.key, required this.image, this.child, this.color});

  final Future<Uint8List> image;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;

    return FutureBuilder(
        future: image,
        builder: (context, snapshot) {
          return Container(
            clipBehavior: Clip.hardEdge,
            width: size,
            height: size,
            decoration: BoxDecoration(
                color: color,
                // borderRadius: BorderRadius.circular(16),
                image: snapshot.hasData
                    ? DecorationImage(
                        image: MemoryImage(snapshot.data!), fit: BoxFit.cover)
                    : null),
            child: child,
          );
        });
  }
}
