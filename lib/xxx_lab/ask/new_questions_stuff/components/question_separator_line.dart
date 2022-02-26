

import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class QuestionSeparatorLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionSeparatorLine({
    this.lineIsON = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool lineIsON;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);

    return Container(
      width: _bubbleClearWidth,
      height: 0.25,
      // alignment: Aligners.superCenterAlignment(context),
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
      color: lineIsON ? Colorz.yellow255 : null,
      // child: Container(
      //   width: _bubbleClearWidth * 0.8,
      //   height: 0.25,
      //   color: Colorz.yellow255,
      // ),
    );
  }
}
