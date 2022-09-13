import 'package:bldrs/a_models/bz/target/target_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/targets/dialog_of_slides_and_ankhs.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DialogOfTargetAchievement extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DialogOfTargetAchievement({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  static Future<void> show({
    BuildContext context,
    TargetModel target
  }) async {

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_congrats',
        translate: true,
      ),
      bodyVerse: Verse(
        pseudo: 'You have achieved the ${target.name} target and your account increased\n${target.reward.slides} Slides & ${target.reward.ankh} Ankhs',
        text: 'phid_target_achievement_congrats_description',
        translate: true,
        varTag: [target.name, target.reward.slides, target.reward.ankh]
      ),
      confirmButtonVerse: const Verse(
        text: 'phid_claim',
        translate: true,
      ),
      child: Column(
        children: <Widget>[
          SuperVerse(
            verse: const Verse(
              pseudo: 'To know more about Slides and Ankhs\nTap here',
              text: 'phid_know_more_about_slides_and_ankhs',
              translate: true,
            ),
            maxLines: 3,
            weight: VerseWeight.thin,
            italic: true,
            size: 1,
            color: Colorz.blue255,
            labelColor: Colorz.white10,
            onTap: () async {
              await DialogOfSlidesAndAnkhs.show(
                context: context,
              );
            },
          ),
        ],
      ),
    );
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SuperVerse(
          verse: const Verse(
            pseudo: 'To know more about Slides and Ankhs\nTap here',
            text: 'phid_know_more_about_slides_and_ankhs',
            translate: true,
          ),
          maxLines: 3,
          weight: VerseWeight.thin,
          italic: true,
          size: 1,
          color: Colorz.blue255,
          labelColor: Colorz.white10,
          onTap: () async {
            await DialogOfSlidesAndAnkhs.show(
              context: context,
            );
          },
        ),
      ],
    );

  }
  /// --------------------------------------------------------------------------
}
