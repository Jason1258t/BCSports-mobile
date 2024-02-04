class NftModel {
  final String imagePath;
  final double price;
  final String name;

  NftModel({required this.imagePath, required this.price, required this.name});

  static NftModel fish = NftModel(
      imagePath:
          "https://cdn.finam.ru/images/publications/1482315/NFT_obezyana_s_sajta_Sothebys_6b56ec21a7.jpg",
      name: "nft name",
      price: 133);
}
