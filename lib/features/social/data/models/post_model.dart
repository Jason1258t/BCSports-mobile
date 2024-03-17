import 'dart:typed_data';

import 'package:bcsports_mobile/features/social/bloc/create_post/create_post_cubit.dart';
import 'package:dio/dio.dart';

class PostModel {
  late final String id;
  final String creatorId;
  final String? imageUrl;
  final String? compressedImageUrl;
  final String? text;
  int likesCount;
  int commentsCount;
  late final int _createdAtMs;
  bool _liked = false;

  late final Future<Uint8List> image;
  late final Future<Uint8List> compressedImage;

  bool get like => _liked;
  bool _loadingStarted = false;

  void setLike(bool value) => _liked = value;

  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(_createdAtMs);

  PostModel.fromJson(Map<String, dynamic> json)
      : creatorId = json['creatorId'],
        imageUrl = json['imageUrl'],
        id = json['id'],
        compressedImageUrl = json['compressedImageUrl'],
        text = json['text'],
        likesCount = json['likesCount'],
        commentsCount = json['commentsCount'],
        _createdAtMs = json['createdAtMs'];

  void loadImages() {
    if (_loadingStarted) return;
    _loadingStarted = true;
    image = _getImage(imageUrl ?? '');
    compressedImage = _getImage(compressedImageUrl ?? '');
  }

  Future<Uint8List> _getImage(String url) async {
    final res = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    return res.data;
  }

  PostModel.create({
    required this.creatorId,
    this.text,
    PostImageDTO? image,
  })  : likesCount = 0,
        commentsCount = 0,
        imageUrl = image?.imageUrl,
        compressedImageUrl = image?.compressedImageUrl,
        _createdAtMs = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {
        'creatorId': creatorId,
        'imageUrl': imageUrl,
        'compressedImageUrl': compressedImageUrl,
        'text': text,
        'likesCount': likesCount,
        'commentsCount': commentsCount,
        'createdAtMs': _createdAtMs
      };
}
