import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
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
    final String _bzTypeString = bzTypePluralStringer(context, questionModel.directedTo);
    final String _icon = Iconizer.bzTypeIconOff(questionModel.directedTo);

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