import 'package:bcsports_mobile/features/social/bloc/report/report_cubit.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
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
    context.read<ReportCubit>().report(postId: widget.postId, type: reportType);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

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
            text: localize.spam,
            onTap: () => onTap(ReportType.spam),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/gun.svg',
            text: localize.violence,
            onTap: () => onTap(ReportType.violence),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/hand.svg',
            text: localize.child_abuse,
            onTap: () => onTap(ReportType.childAbuse),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/porno.svg',
            text: localize.porn,
            onTap: () => onTap(ReportType.porn),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/copyright.svg',
            text: localize.copy,
            onTap: () => onTap(ReportType.copyright),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/pills.svg',
            text: localize.drugs,
            onTap: () => onTap(ReportType.drugs),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/person_details.svg',
            text: localize.personal_details,
            onTap: () => onTap(ReportType.personalDetails),
          ),
          PostReportLineWidget(
            iconPath: 'assets/icons/info.svg',
            text: localize.other,
            onTap: () => onTap(ReportType.other),
          ),
        ],
      ),
    );
  }
}
