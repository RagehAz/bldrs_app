import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainTreeStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainTreeStrip({
    @required this.level,
    @required this.phraseID,
    @required this.phraseValue,
    @required this.onTriggerExpansion,
    @required this.onStripTap,
    this.expanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int level;
  final String phraseID;
  final String phraseValue;
  final Function onTriggerExpansion;
  final bool expanded;
  final ValueChanged<String> onStripTap;
  /// --------------------------------------------------------------------------
  static const double stripHeight = 40;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    final double _screenWidth  = Scale.superScreenWidth(context);
    const Color _stripColor = Colorz.black255;

    final double _levelPaddingWidth = stripHeight + (stripHeight * 0.6 * (level - 1));
    final double _stringsWidth = _screenWidth - _levelPaddingWidth - stripHeight;

    return Container(
      key: const ValueKey<String>('chain_tree_strip'),
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

          /// PHRASE ID AND VALUE
          GestureDetector(
            onTap: (){

              onStripTap(phraseID);

            },
            child: Container(
              width: _stringsWidth,
              height: stripHeight,
              alignment: superCenterAlignment(context),
              color: Colorz.white10,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// TRANSLATION
                      SuperVerse(
                        verse: phraseValue,
                        italic: true,
                        centered: false,
                        // onTap: () => onCopyText(context, phraseValue),
                      ),

                      /// ID
                      SuperVerse(
                        verse: '$level : $phraseID',
                        size: 1,
                        centered: false,
                        weight: VerseWeight.thin,
                        // onTap: () => onCopyText(context, phraseID),
                      ),


                    ],
                  ),

                ],
              ),
            ),
          ),

          /// ICON
          DreamBox(
            height: stripHeight,
            width: stripHeight,
            icon: _chainsProvider.getKeywordIcon(
              son: phraseID,
              context: context,
            ),
          ),

        ],
      ),
    );
  }
}
