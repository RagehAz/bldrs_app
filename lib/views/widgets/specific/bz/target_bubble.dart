import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/bz/target/target_model.dart';
import 'package:bldrs/models/bz/target/target_progress.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/bz/target_progress_bar.dart';
import 'package:flutter/material.dart';

class TargetBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TargetBubble({
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
    final double _titleBoxWidth = _bubbleClearWidth / 2 + 20;
    const double _titleBoxHeight = 30;

    final TargetProgress _progress = target.progress;
    final bool _targetReached = _progress.current == _progress.objective;

    return Container(
      width: _bubbleClearWidth,
      decoration: BoxDecoration(
        color: Colorz.white10,
        borderRadius: Borderers.superBorderAll(context, Bubble.clearCornersValue),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// TITLE AND PROGRESS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// TITLE
              SizedBox(
                width: _titleBoxWidth,
                height: _titleBoxHeight,
                // color: Colorz.BloodTest,
                child: SuperVerse(
                  verse: target.name,
                  centered: false,
                  margin: 5,
                  color: Colorz.yellow255,
                ),
              ),

              /// PROGRESS
              TargetProgressBar(
                target: target,
              ),

            ],
          ),

          /// DESCRIPTION
          SuperVerse(
            verse: target.description,
            centered: false,
            weight: VerseWeight.thin,
            maxLines: 10,
            margin: 5,
          ),

          /// INSTRUCTIONS
          if (target.instructions != null && target.instructions.isNotEmpty && _targetReached == false)
            ... List<Widget>.generate(target.instructions.length, (int index){

              return
                SuperVerse(
                  verse: target.instructions[index],
                  leadingDot: true,
                  size: 1,
                  centered: false,
                  maxLines: 5,
                  margin: 2,
                  weight: VerseWeight.thin,
                  italic: true,
                  color: Colorz.blue255,
                );

            }),

          /// CLAIM BUTTON
          if (_targetReached == true)
            DreamBox(
              width: _bubbleClearWidth - 10,
              height: 70,
              verse: 'CLAIM',
              verseWeight: VerseWeight.black,
              verseItalic: true,
              color: Colorz.yellow255,
              verseColor: Colorz.black255,
              onTap: onClaimTap,
            ),

        ],
      ),
    );
  }
}
