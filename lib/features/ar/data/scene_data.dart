class SceneData {
  final String? sceneId;
  final String? title;

  SceneData({this.title, this.sceneId});

  Map<String, dynamic> toJson() => {'scene': sceneId, 'title': title};

  SceneData.fromJson(Map json)
      : sceneId = json['scene'],
        title = json['title'];
}
