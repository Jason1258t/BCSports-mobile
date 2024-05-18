import 'package:bcsports_mobile/models/user_model.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class SmallAvatarWidget extends StatelessWidget {
  const SmallAvatarWidget({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundImage:
          user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
      backgroundColor: user.avatarColor,
      child: user.avatarUrl == null
          ? Center(
              child: Text(
                user.displayName[0].toUpperCase(),
                style: AppFonts.font16w400,
              ),
            )
          : null,
    );
  }
}
