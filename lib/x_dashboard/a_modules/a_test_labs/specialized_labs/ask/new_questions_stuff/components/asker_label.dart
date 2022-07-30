import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
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

    final String _superTimeDifferenceString = Timers.calculateSuperTimeDifferenceString(from: questionModel.time, to: DateTime.now());

    final String _bzTypeString = BzModel.translateBzType(
        context: context,
        bzType: questionModel.directedTo,
    );

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
            userStatus: userModel.status,
            size: _userLabelBoxHeight,
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
                  verse: 'Directed to $_bzTypeString',
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
