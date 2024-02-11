import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class SmallUserCard extends StatelessWidget {
  const SmallUserCard(
      {super.key, required this.onTap, required this.userModel});

  final Function() onTap;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: userModel.avatarColor,
              radius: sizeOf.width * 0.05,
              backgroundImage: userModel.avatarUrl == null ? null : NetworkImage(userModel.avatarUrl!),
              child: userModel.avatarUrl == null
                  ? Center(
                      child: Text(
                        (userModel.displayName ?? userModel.username)[0]
                            .toUpperCase(),
                        style: AppFonts.font12w400,
                      ),
                    )
                  : Container(),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              userModel.username,
              style: AppFonts.font14w500,
            ),
          ],
        ));
  }
}
