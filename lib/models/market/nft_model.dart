class NftModel {
  final String documentId;

  final DateTime birthday;
  final String citizenship;
  final String club;
  final String country;
  final int height;
  final String imagePath;
  final bool isRightFoot;
  final String name;
  final String position;
  final String role;
  final int weight;
  final String previewImagePath;
  final DateTime auctionStopTime;
  final double currentBit;

  NftModel(
      {
      required this.documentId,
      required this.birthday,
      required this.citizenship,
      required this.club,
      required this.country,
      required this.height,
      required this.imagePath,
      required this.isRightFoot,
      required this.name,
      required this.position,
      required this.role,
      required this.weight,
      required this.auctionStopTime,
      required this.currentBit,
      required this.previewImagePath});

  factory NftModel.fromJson(Map<String, dynamic> json, String documentId) {
    return NftModel(
        documentId: documentId,
        birthday: json['birthday'].toDate(),
        citizenship: json['citizenship'],
        club: json['club'],
        country: json['country'],
        height: json['height'],
        imagePath: json['image_path'],
        isRightFoot: json['is_right_foot'],
        name: json['name'],
        position: json['position'],
        role: json['role'],
        currentBit: double.parse(json['current_bit'].toString()),
        weight: json['weight'],
        auctionStopTime: json['auction_stop_time'].toDate(),
        previewImagePath: json['mini_image_path']);
  }

  Map<String, dynamic> toJson() {
    return {
      'birthday': birthday.toIso8601String(),
      'citizenship': citizenship,
      'club': club,
      'country': country,
      'height': height,
      'image_path': imagePath,
      'is_right_foot': isRightFoot,
      'name': name,
      'position': position,
      'role': role,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return 'Player {'
        ' birthday: $birthday,'
        ' citizenship: $citizenship,'
        ' club: $club,'
        ' country: $country,'
        ' height: $height,'
        ' imagePath: $imagePath,'
        ' isRightFoot: $isRightFoot,'
        ' name: $name,'
        ' position: $position,'
        ' role: $role,'
        ' weight: $weight'
        ' }';
  }
}
