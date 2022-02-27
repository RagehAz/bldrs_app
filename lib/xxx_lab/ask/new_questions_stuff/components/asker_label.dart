import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class AskerLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AskerLabel({
    @required this.userModel,
    @required this.questionModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final QuestionModel questionModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);
    const double _userLabelBoxHeight = 55;
    final double _userNameBoxWidth = _bubbleClearWidth - _userLabelBoxHeight;

    final String _superTimeDifferenceString = Timers.getSuperTimeDifferenceString(from: questionModel.time, to: DateTime.now());

    return SizedBox(
      key: const ValueKey('Asker_Label'),
      width: _bubbleClearWidth,
      // height: _userLabelBoxHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// ASKER PICTURE
          UserBalloon(
            userModel: userModel,
            balloonType: userModel.status,
            balloonWidth: _userLabelBoxHeight,
            loading: false,
            // onTap: () {
            //   blog('this person should ask a fucking question');
            // },
          ),

          /// USER NAME
          Container(
            width: _userNameBoxWidth,
            // height: _userLabelBoxHeight,
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SuperVerse(
                  verse: userModel.name,
                  size: 4,
                ),

                SuperVerse(
                  verse: '${userModel.title} @ ${userModel.company}',
                ),

                SuperVerse(
                  verse: 'Asked $_superTimeDifferenceString',
                  weight: VerseWeight.thin,
                  italic: true,

                ),

                SuperVerse(
                  verse: 'Directed to ${TextGen.bzTypePluralStringer(context, questionModel.directedTo)}',
                  weight: VerseWeight.thin,
                  italic: true,
                ),

                // DreamBox(
                //   height: 25,
                //   verse: Timers.getSuperTimeDifferenceString(from: questionModel.time, to: DateTime.now()),
                //   verseScaleFactor: 0.8,
                //   verseWeight: VerseWeight.thin,
                //   icon: Iconz.clock,
                //   iconSizeFactor: 0.8,
                //   bubble: false,
                // ),
                //
                // DreamBox(
                //   height: 25,
                //   verse: 'Directed to ${TextGen.bzTypePluralStringer(context, questionModel.directedTo)}',
                //   verseScaleFactor: 0.8,
                //   verseWeight: VerseWeight.thin,
                //   icon: Iconizer.bzTypeIconOff(questionModel.directedTo),
                //   iconSizeFactor: 0.8,
                //   bubble: false,
                // ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
