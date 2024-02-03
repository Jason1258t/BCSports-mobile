class NftModel {
  final String imagePath;
  final double price;
  final String name;

  NftModel({required this.imagePath, required this.price, required this.name});

  static NftModel fish = NftModel(imagePath: "", name: "nft name", price: 133);
}
