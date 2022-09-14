import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainTreeStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainTreeStrip({
    @required this.width,
    @required this.level,
    @required this.phid,
    @required this.phraseValue,
    @required this.onTriggerExpansion,
    @required this.onStripTap,
    @required this.searchValue,
    this.expanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final int level;
  final String phid;
  final String phraseValue;
  final Function onTriggerExpansion;
  final bool expanded;
  final ValueChanged<String> onStripTap;
  final ValueNotifier<String> searchValue;
  /// --------------------------------------------------------------------------
  static const double stripHeight = 40;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    // --------------------
    const Color _stripColor = Colorz.black255;
    final double _levelPaddingWidth = stripHeight + (stripHeight * 0.6 * (level - 1));
    final double _stringsWidth = width - _levelPaddingWidth - stripHeight;
    // --------------------
    return Container(
      key: const ValueKey<String>('chain_tree_strip'),
      width: width,
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
              alignment: Aligners.superInverseCenterAlignment(context),
              child:
              expanded == null ?
              const SizedBox()
                  :
              DreamBox(
                width: stripHeight,
                height: stripHeight,
                icon: expanded ? Iconz.arrowDown : Iconizer.superArrowENRight(context),
                iconSizeFactor: 0.3,
                bubble: false,
              ),
            ),
          ),

          /// PHRASE ID AND VALUE
          GestureDetector(
            onTap: (){

              onStripTap(phid);

            },
            child: Container(
              width: _stringsWidth,
              height: stripHeight,
              alignment: Aligners.superCenterAlignment(context),
              // color: Colorz.white10,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[

                  /// ICON
                  DreamBox(
                    height: stripHeight,
                    width: stripHeight,
                    iconSizeFactor: Phrase.isKeywordPhid(phid) ? 1 : 0.7,
                    bubble: false,
                    icon: _chainsProvider.getPhidIcon(
                      son: phid,
                      context: context,
                    ),
                  ),

                  const SizedBox(
                    width: stripHeight * 0.2,
                    height: stripHeight,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// TRANSLATION
                      SuperVerse(
                        verse: Verse(
                          text: phraseValue,
                          translate: false,
                        ),
                        italic: true,
                        centered: false,
                        highlight: searchValue,
                        // onTap: () => onCopyText(context, phraseValue),
                      ),

                      /// ID
                      SuperVerse(
                        verse: Verse(
                          text: '( lvl $level ) : $phid',
                          translate: false,
                        ),
                        size: 1,
                        centered: false,
                        weight: VerseWeight.thin,
                        highlight: searchValue,
                        // onTap: () => onCopyText(context, phraseID),
                      ),


                    ],
                  ),

                ],
              ),
            ),
          ),


        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
