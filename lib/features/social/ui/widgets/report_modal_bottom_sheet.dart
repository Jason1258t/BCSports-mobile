import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class ReportModalBottomSheet extends StatelessWidget {
  const ReportModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: BoxDecoration(
            color: AppColors.black_s2new_1A1A1A,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 2,
              decoration: ShapeDecoration(
                color: AppColors.grey_B3B3B3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const PostReportLineWidget(
              iconPath: 'assets/icons/trash.svg',
              text: "Spam",
            ),
            const PostReportLineWidget(
              iconPath: 'assets/icons/gun.svg',
              text: "Violence",
            ),
            const PostReportLineWidget(
              iconPath: 'assets/icons/hand.svg',
              text: "Child Abuse",
            ),
            const PostReportLineWidget(
              iconPath: 'assets/icons/porno.svg',
              text: "Pornograpghy",
            ),
            const PostReportLineWidget(
              iconPath: 'assets/icons/trash.svg',
              text: "Copyright",
            ),
            const PostReportLineWidget(
              iconPath: 'assets/icons/pills.svg',
              text: "Illegal Drugs",
            ),
            const PostReportLineWidget(
              iconPath: 'assets/icons/person_details.svg',
              text: "Personal Details",
            ),
            const PostReportLineWidget(
              iconPath: 'assets/icons/info.svg',
              text: "Other",
            ),
          ],
        ),
      ),
    );
  }
}
