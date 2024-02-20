import 'package:bcsports_mobile/features/social/data/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class UserModel {
  final String id;
  final String? displayName;
  final String username;
  final BannerModel banner;
  final String? avatarUrl;
  double evmBill;
  List<dynamic> favouritesNftList;
  Map<dynamic, dynamic> userNftList;

  Color get avatarColor => Color(banner.color);

  UserModel(this.id, this.displayName, this.username, this.banner,
      this.avatarUrl, this.evmBill, this.favouritesNftList, this.userNftList);

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        displayName = json['displayName'],
        username = json['username'],
        avatarUrl = json['avatarUrl'],
        evmBill = double.parse('${json['evmBill']}'),
        favouritesNftList = json['favourites_list'] ?? [],
        userNftList = json['user_nft'] ?? {},
        banner = BannerModel.fromJson(json['banner']);

  UserModel.create(this.id, this.username, BannerModel bannerModel)
      : displayName = null,
        evmBill = 1000,
        banner = bannerModel,
        favouritesNftList = [],
        userNftList = {},
        avatarUrl = null;

  UserModel copyWith(
      String? newUsername, String? newDisplayName, String? newAvatarUrl) {
    return UserModel(id, newDisplayName ?? displayName, newUsername ?? username,
        banner, newAvatarUrl ?? avatarUrl, evmBill, favouritesNftList, userNftList);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'username': username,
        'avatarUrl': avatarUrl,
        'user_nft': userNftList,
        "evmBill": evmBill,
        'banner': banner.toJson(),
      };

  User toChatUser() => User(id: id, firstName: displayName ?? username, imageUrl: avatarUrl);
}
