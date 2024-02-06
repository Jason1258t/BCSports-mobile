class BannerModel {
  final String? url;
  final int color;

  BannerModel.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        color = json['color'];

  BannerModel.create(this.color) : url = null;

  Map<String, dynamic> toJson() => {'url': url, 'color': color};
}
