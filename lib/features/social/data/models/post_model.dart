import 'package:bcsports_mobile/features/social/bloc/create_post/create_post_cubit.dart';

class PostModel {
  late final String id;
  final String creatorId;
  final String? imageUrl;
  final String? compressedImageUrl;
  final String? text;
  final int likesCount;
  final int commentsCount;
  late final int _createdAtMs;

  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(_createdAtMs);

  PostModel.fromJson(Map<String, dynamic> json, this.id)
      : creatorId = json['creatorId'],
        imageUrl = json['imageUrl'],
        compressedImageUrl = json['compressedImageUrl'],
        text = json['text'],
        likesCount = json['likesCount'],
        commentsCount = json['commentsCount'],
        _createdAtMs = json['createdAtMs'];

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
