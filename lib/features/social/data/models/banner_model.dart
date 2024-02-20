class BannerModel {
  final int color;

  BannerModel.fromJson(Map<String, dynamic> json)
      : color = json['color'];

  BannerModel.create(this.color);

  Map<String, dynamic> toJson() => {'color': color};
}
