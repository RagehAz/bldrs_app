import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class PrivateRepliesCounter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PrivateRepliesCounter({
    @required this.questionModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QuestionModel questionModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);

    const int _numberOfBzReplies = 123;
    final String _bzTypeString = BzModel.translateBzType(
      context: context,
      bzType: questionModel.directedTo,
    );
    final String _icon = BzModel.getBzTypeIconOff(questionModel.directedTo);

    return DreamBox(
      height: 35,
      width: _bubbleClearWidth,
      bubble: false,
      icon: _icon,
      iconSizeFactor: 0.8,
      verse: '$_numberOfBzReplies private $_bzTypeString replies',
      verseWeight: VerseWeight.thin,
      verseScaleFactor: 0.8,
      verseCentered: false,
    );
  }
}
