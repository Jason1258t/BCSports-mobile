class NftModel {
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

  NftModel({
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
  });

  factory NftModel.fromJson(Map<String, dynamic> json) {
    return NftModel(
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
      weight: json['weight'],
    );
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

  static NftModel fish = NftModel(
    birthday: DateTime(2000, 1, 1),
    citizenship: 'Test Citizenship',
    club: 'Test Club',
    country: 'Test Country',
    height: 180,
    imagePath: 'gs://example.com/test/photo.png',
    isRightFoot: true,
    name: 'Test Player',
    position: 'Test Position',
    role: 'Test Role',
    weight: 70,
  );
}
