import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/bz/target/target_model.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/bz/dialog_of_slides_and_ankhs.dart';
import 'package:flutter/material.dart';

class DialogOfTargetAchievement extends StatelessWidget {

  static Future<void> show({BuildContext context, TargetModel target}) async {

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Congratulations',
      body: 'You have achieved the ${target.name} target and your account increased\n${target.reward.slides} Slides & ${target.reward.ankh} Ankhs',
      boolDialog: false,
      confirmButtonText: 'CLAIM',
      child: Column(
        children: <Widget>[

          SuperVerse(
            verse: 'To know more about Slides and Ankhs\nTap here',
            maxLines: 3,
            weight: VerseWeight.thin,
            italic: true,
            size: 1,
            color: Colorz.Blue225,
            labelColor: Colorz.White10,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        SuperVerse(
          verse: 'To know more about Slides and Ankhs\nTap here',
          maxLines: 3,
          weight: VerseWeight.thin,
          italic: true,
          size: 1,
          color: Colorz.Blue225,
          labelColor: Colorz.White10,
          onTap: () async {

            await DialogOfSlidesAndAnkhs.show(
              context: context,
            );

          },
        ),

      ],
    );
  }
}
