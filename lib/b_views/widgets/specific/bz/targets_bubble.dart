import 'package:bldrs/a_models/bz/target/target_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/bz/dialogs/dialog_of_target_achievement.dart';
import 'package:bldrs/b_views/widgets/specific/bz/target_bubble.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/targetz.dart' as Targetz;
import 'package:flutter/material.dart';

class TargetsBubble extends StatelessWidget {
  const TargetsBubble({Key key}) : super(key: key);

// -----------------------------------------------------------------------------
  static List<TargetModel> getAllTargets() {
    final List<TargetModel> _allTargets =
        Targetz.insertTargetsProgressIntoTargetsModels(
      allTargets: Targetz.allTargets(),
      targetsProgress: Targetz.dummyTargetsProgress(),
    );

    return _allTargets;
  }

// -----------------------------------------------------------------------------
  Future<void> _onClaimTap({BuildContext context, TargetModel target}) async {
    await DialogOfTargetAchievement.show(
      context: context,
      target: target,
    );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final List<TargetModel> _allTargets = getAllTargets();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        // title: 'Targets',
        // leadingIcon: Iconz.achievement,
        // bubbleColor: Colorz.nothing,
        // width: superScreenWidth(context),
        // margins: 0,
        children: <Widget>[

          const SuperVerse(
            verse:
                'Achieving the below targets will put you on track, and will give you an idea how to use Bldrs.net to acquire new customers and boost potential sales.',
            maxLines: 10,
            centered: false,
            margin: 10,
            color: Colorz.yellow255,
            weight: VerseWeight.thin,
          ),

          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _allTargets.length,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                final TargetModel _target = _allTargets[index];

                return TargetCard(
                  target: _target,
                  onClaimTap: () =>
                      _onClaimTap(context: context, target: _target),
                );

              }),

        ],
      ),
    );
  }
}
