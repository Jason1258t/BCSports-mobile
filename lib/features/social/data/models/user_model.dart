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
  List<dynamic> ownUserNftList;

  Color get avatarColor => Color(banner.color);

  Color get bannerColor => Color(banner.color);

  UserModel(this.id, this.displayName, this.username, this.banner,
      this.avatarUrl, this.evmBill, this.favouritesNftList, this.ownUserNftList);

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        displayName = json['displayName'],
        username = json['username'],
        avatarUrl = json['avatarUrl'],
        evmBill = double.parse('${json['evmBill']}'),
        favouritesNftList = json['favourites_list'] ?? [],
        ownUserNftList = json['user_nft'] ?? [],
        banner = BannerModel.fromJson(json['banner']);

  UserModel.create(this.id, this.username, BannerModel bannerModel)
      : displayName = null,
        evmBill = 1000,
        banner = bannerModel,
        favouritesNftList = [],
        ownUserNftList = [],
        avatarUrl = null;

  UserModel copyWith(
      String? newUsername, String? newDisplayName, String? newAvatarUrl) {
    return UserModel(id, newDisplayName ?? displayName, newUsername ?? username,
        banner, newAvatarUrl ?? avatarUrl, evmBill, favouritesNftList, ownUserNftList);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'username': username,
        'avatarUrl': avatarUrl,
        'ownUserNft': ownUserNftList,
        "evmBill": evmBill,
        'banner': banner.toJson(),
      };
}
