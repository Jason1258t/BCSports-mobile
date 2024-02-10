import 'package:bcsports_mobile/features/market/ui/widgets/player_details_article.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_details_line.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_match_stats.dart';
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
              "Description",
              style: AppFonts.font24w600.copyWith(color: AppColors.white),
            ),
            const SizedBox(
              height: 32,
            ),
            const PlayerDetailsArticleWidget(
              title: "About player",
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Fast player with good dribbling and passing. Looks good in attack but has some work to do in defence.",
              style: AppFonts.font12w400.copyWith(color: AppColors.grey_B3B3B3),
            ),
            const SizedBox(
              height: 32,
            ),
            const PlayerDetailsArticleWidget(
              title: "Player detailis",
            ),
            const SizedBox(
              height: 20,
            ),
            PlayerDetailsLineWidget(
              attr: "Name",
              value: widget.nft.name,
            ),
            PlayerDetailsLineWidget(
              attr: "Date of birth",
              value: DateFormat('dd.MM.yyyy')
                  .format(widget.nft.birthday)
                  .toString(),
            ),
            PlayerDetailsLineWidget(
              attr: "Club name",
              value: widget.nft.club,
            ),
            PlayerDetailsLineWidget(
              attr: "Citizenship",
              value: widget.nft.citizenship,
            ),
            PlayerDetailsLineWidget(
              attr: "Height",
              value: widget.nft.height.toString(),
            ),
            PlayerDetailsLineWidget(
              attr: "Position",
              value: widget.nft.position,
            ),
            PlayerDetailsLineWidget(
              attr: "Weight",
              value: widget.nft.weight.toString(),
            ),
            PlayerDetailsLineWidget(
              attr: "Foot",
              value: widget.nft.isRightFoot ? "Right foot" : "Left foot",
            ),
            const SizedBox(
              height: 36,
            ),
            const PlayerDetailsArticleWidget(
              title: "Statistic",
            ),
            const SizedBox(
              height: 8,
            ),
            const Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 8,
              spacing: 7,
              children: [
                PlayerMatchStatsWidget(
                  attr: 'Quantity of matches',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Minutes played',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Goals',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Assists',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Penalties',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Duel air',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Dribbling suffered',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Duel tackle',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Ball recovery',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Killer passes',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Duel lost',
                ),
                PlayerMatchStatsWidget(
                  attr: 'Fouls',
                ),
                SizedBox(
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
