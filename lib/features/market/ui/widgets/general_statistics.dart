import 'package:bcsports_mobile/features/market/ui/widgets/player_details_article.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_details_line.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_match_stats.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralStatistics extends StatefulWidget {
  final NftModel nft;
  const GeneralStatistics({super.key, required this.nft});

  @override
  State<GeneralStatistics> createState() => _GeneralStatisticsState();
}

class _GeneralStatisticsState extends State<GeneralStatistics> {
  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
    
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.black_s2new_1A1A1A,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22).copyWith(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localize.description,
              style: AppFonts.font24w600.copyWith(color: AppColors.white),
            ),
            const SizedBox(
              height: 32,
            ),
             PlayerDetailsArticleWidget(
              title: localize.about,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              localize.fast_player_good_dribbling,
              style: AppFonts.font12w400.copyWith(color: AppColors.grey_B3B3B3),
            ),
            const SizedBox(
              height: 32,
            ),
             PlayerDetailsArticleWidget(
              title: localize.player_details,
            ),
            const SizedBox(
              height: 20,
            ),
            PlayerDetailsLineWidget(
              attr: localize.name,
              value: widget.nft.name,
            ),
            PlayerDetailsLineWidget(
              attr: localize.birth,
              value: DateFormat('dd.MM.yyyy')
                  .format(widget.nft.birthday)
                  .toString(),
            ),
            PlayerDetailsLineWidget(
              attr: localize.club_name,
              value: widget.nft.club,
            ),
            PlayerDetailsLineWidget(
              attr: localize.citizen,
              value: widget.nft.citizenship,
            ),
            PlayerDetailsLineWidget(
              attr: localize.height,
              value: widget.nft.height.toString(),
            ),
            PlayerDetailsLineWidget(
              attr: localize.position,
              value: widget.nft.position,
            ),
            PlayerDetailsLineWidget(
              attr: localize.weight,
              value: widget.nft.weight.toString(),
            ),
            PlayerDetailsLineWidget(
              attr: localize.foot,
              value: widget.nft.isRightFoot ? "Right foot" : "Left foot",
            ),
            const SizedBox(
              height: 36,
            ),
             PlayerDetailsArticleWidget(
              title: localize.stats,
            ),
            const SizedBox(
              height: 8,
            ),
             Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 8,
              spacing: 7,
              children: [
                PlayerMatchStatsWidget(
                  attr: localize.quantity_matches,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.minuts_played,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.goals,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.assists,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.assists,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.duel_air,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.dribbling_siffered,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.duel_tackle,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.ball_recovery,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.killer_passes,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.duel_lost,
                ),
                PlayerMatchStatsWidget(
                  attr: localize.fouls,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
