import 'package:bcsports_mobile/features/social/data/models/banner_model.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String? displayName;
  final String username;
  final BannerModel banner;
  final String? avatarUrl;
  double evmBill;
  List<dynamic> favouritesNftList;

  Color get avatarColor => Color(banner.color);

  Color get bannerColor => Color(banner.color);

  UserModel(this.id, this.displayName, this.username, this.banner,
      this.avatarUrl, this.evmBill, this.favouritesNftList);

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        displayName = json['displayName'],
        username = json['username'],
        avatarUrl = json['avatarUrl'],
        evmBill = double.parse('${json['evmBill']}'),
        favouritesNftList = json['favourites_list'] ?? [],
        banner = BannerModel.fromJson(json['banner']);

  UserModel.create(this.id, this.username, int color)
      : displayName = null,
        evmBill = 1000,
        banner = BannerModel.create(color),
        favouritesNftList = [],
        avatarUrl = null;

  UserModel copyWith(
      String? newUsername, String? newDisplayName, String? newAvatarUrl) {
    return UserModel(id, newDisplayName ?? displayName, newUsername ?? username,
        banner, newAvatarUrl ?? avatarUrl, evmBill, favouritesNftList);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'username': username,
        'avatarUrl': avatarUrl,
        "evmBill": evmBill,
        'banner': banner.toJson(),
      };
}
