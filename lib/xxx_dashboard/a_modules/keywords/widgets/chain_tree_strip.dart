import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/translations_controller.dart';
import 'package:flutter/material.dart';

class ChainTreeStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainTreeStrip({
    @required this.level,
    @required this.secondLine,
    @required this.firstLine,
    @required this.onTriggerExpansion,
    this.expanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int level;
  final String secondLine;
  final String firstLine;
  final Function onTriggerExpansion;
  final bool expanded;
  /// --------------------------------------------------------------------------
  static const double stripHeight = 40;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth  = Scale.superScreenWidth(context);
    const Color _stripColor = Colorz.black255;

    final double _levelPaddingWidth = stripHeight * level;
    final double _stringsWidth = _screenWidth - _levelPaddingWidth;

    return Container(
      width: _screenWidth,
      color: Color.fromRGBO(_stripColor.red, _stripColor.green, _stripColor.blue, (90 - (20 * level)) / 100),
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: <Widget>[

          /// LEVEL PADDING + ARROW BOX
          GestureDetector(
            onTap: onTriggerExpansion,
            child: Container(
              width: _levelPaddingWidth,
              height: stripHeight,
              alignment: superInverseCenterAlignment(context),
              child:
              expanded == null ?
              const SizedBox()
                  :
              DreamBox(
                width: stripHeight,
                height: stripHeight,
                icon: expanded ? Iconz.arrowDown : superArrowENRight(context),
                iconSizeFactor: 0.3,
                bubble: false,
              ),
            ),
          ),

          /// STRINGS
          Container(
            width: _stringsWidth,
            height: stripHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SuperVerse(
                  verse: firstLine,
                  italic: true,
                  onTap: () => onCopyText(context, firstLine),
                ),

                SuperVerse(
                  verse: '$level : $secondLine',
                  size: 1,
                  weight: VerseWeight.thin,
                  onTap: () => onCopyText(context, secondLine),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
