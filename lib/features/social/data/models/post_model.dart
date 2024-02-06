class PostModel {
  late final String id;
  final String creatorId;
  final String imageUrl;
  final String compressedImageUrl;
  final String text;
  final int likesCount;
  final int commentsCount;
  late final int _createdAtMs;

  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(_createdAtMs);

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        creatorId = json['creatorId'],
        imageUrl = json['imageUrl'],
        compressedImageUrl = json['compressedImageUrl'],
        text = json['text'],
        likesCount = json['likesCount'],
        commentsCount = json['commentsCount'],
        _createdAtMs = json['createdAtMs'];

  PostModel.create(
      {required this.creatorId,
      required this.text,
      required this.imageUrl,
      required this.compressedImageUrl})
      : likesCount = 0,
        commentsCount = 0 {
    id = 'new';
    _createdAtMs = DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'creatorId': creatorId,
        'imageUrl': imageUrl,
        'compressedImageUrl': compressedImageUrl,
        'text': text,
        'likesCount': likesCount,
        'commentsCount': commentsCount,
        'createdAtMs': _createdAtMs
      };
}
