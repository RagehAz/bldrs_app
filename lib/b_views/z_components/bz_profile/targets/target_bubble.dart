import 'package:bldrs/a_models/bz/target/target_model.dart';
import 'package:bldrs/a_models/bz/target/target_progress.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/bz_profile/targets/target_progress_bar.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class TargetCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TargetCard({
    @required this.target,
    @required this.onClaimTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TargetModel target;
  final Function onClaimTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context) - 10;
    // final double _titleBoxWidth = _bubbleClearWidth / 2 + 20;
    // const double _titleBoxHeight = 30;

    final TargetProgress _progress = target.progress;
    final bool _targetReached = _progress.current == _progress.objective;

    return Container(
      width: _bubbleClearWidth,
      decoration: BoxDecoration(
        color: Colorz.white20,
        borderRadius: Borderers.superBorderAll(context, 20),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// TITLE
          SuperVerse(
            verse: target.name,
            centered: false,
            margin: 5,
            color: Colorz.yellow255,
            size: 3,
            maxLines: 2,
          ),

          /// DESCRIPTION
          SuperVerse(
            verse: target.description,
            centered: false,
            weight: VerseWeight.thin,
            maxLines: 10,
            margin: 5,
          ),

          /// PROGRESS
          TargetProgressBar(
            target: target,
          ),


          /// INSTRUCTIONS
          if (
          target.instructions != null &&
              target.instructions.isNotEmpty &&
              _targetReached == false
          )
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SuperVerse(
                  verse: xPhrase(context, '##Instructions'),
                  size: 3,
                  color: Colorz.blue255,
                  italic: true,
                  weight: VerseWeight.thin,
                  margin: 10,
                ),

                ListView.builder(
                    itemCount: target.instructions.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return SuperVerse(
                        verse: target.instructions[index],
                        leadingDot: true,
                        centered: false,
                        maxLines: 5,
                        margin: 2,
                        weight: VerseWeight.thin,
                        italic: true,
                        color: Colorz.blue255,
                      );
                    }),

              ],
            ),

          /// CLAIM BUTTON
          if (_targetReached == true)
            Align(
              child: DreamBox(
                width: _bubbleClearWidth,
                height: 70,
                verse: xPhrase(context, '##CLAIM ${target.reward.slides} Slides '),
                verseWeight: VerseWeight.black,
                verseItalic: true,
                color: Colorz.yellow255,
                verseColor: Colorz.black255,
                onTap: onClaimTap,
              ),
            ),
        ],
      ),
    );
  }
}
