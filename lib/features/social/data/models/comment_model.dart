class CommentModel {
  late final String id;
  final String creatorId;
  final String postId;
  final int _createdAtMs;
  final String text;

  int likesCount;
  bool liked;

  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(_createdAtMs);

  CommentModel.fromJson(Map<String, dynamic> json, this.id)
      : creatorId = json['creatorId'],
        _createdAtMs = json['createdAtMs'],
        text = json['text'],
        postId = json['postId'],
        liked = false,
        likesCount = json['likesCount'];

  CommentModel.create(this.text, this.creatorId, this.postId)
      : likesCount = 0,
        liked = false,
        _createdAtMs = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {
        'creatorId': creatorId,
        'postId': postId,
        'createdAtMs': _createdAtMs,
        'text': text,
        'likesCount': likesCount,
      };
}
