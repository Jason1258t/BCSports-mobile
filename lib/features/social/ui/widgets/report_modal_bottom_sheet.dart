import 'package:bcsports_mobile/features/social/bloc/report/report_cubit.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportModalBottomSheet extends StatefulWidget {
  final String postId;

  const ReportModalBottomSheet({super.key, required this.postId});

  @override
  State<ReportModalBottomSheet> createState() => _ReportModalBottomSheetState();
}

class _ReportModalBottomSheetState extends State<ReportModalBottomSheet> {
  void onTap(String reportType) {
    context
        .read<ReportCubit>()
        .report(postId: widget.postId, type: reportType);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          PostReportLineWidget(
            iconPath: 'assets/icons/trash.svg',
            text: "Spam",
            onTap: () => onTap(ReportType.spam),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/gun.svg',
            text: "Violence",
            onTap: () => onTap(ReportType.violence),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/hand.svg',
            text: "Child Abuse",
            onTap: () => onTap(ReportType.childAbuse),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/porno.svg',
            text: "Pornograpghy",
            onTap: () => onTap(ReportType.porn),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/trash.svg',
            text: "Copyright",
            onTap: () => onTap(ReportType.copyright),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/pills.svg',
            text: "Illegal Drugs",
            onTap: () => onTap(ReportType.drugs),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/person_details.svg',
            text: "Personal Details",
            onTap: () => onTap(ReportType.personalDetails),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/info.svg',
            text: "Other",
            onTap: () => onTap(ReportType.other),
          ),
        ],
      ),
    );
  }
}
