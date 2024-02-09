class CommentModel {
  late final String id;
  final String creatorId;
  final int _createdAtMs;
  final String text;

  int likesCount;
  bool liked;

  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(_createdAtMs);

  CommentModel.fromJson(Map<String, dynamic> json, this.id)
      : creatorId = json['creatorId'],
        _createdAtMs = json['createdAtMs'],
        text = json['text'],
        liked = false,
        likesCount = json['likesCount'];

  CommentModel.create(this.text, this.creatorId)
      : likesCount = 0,
        liked = false,
        _createdAtMs = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {
        'creatorId': creatorId,
        'createdAtMs': _createdAtMs,
        'text': text,
        'likesCount': likesCount,
      };
}
