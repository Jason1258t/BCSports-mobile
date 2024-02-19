import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ButtonBack(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ),
        body: PhotoView(
          maxScale: 0.4,
          minScale: PhotoViewComputedScale.contained,
          imageProvider: NetworkImage(url),
        ));
  }
}
