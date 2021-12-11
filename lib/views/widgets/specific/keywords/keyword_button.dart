import 'package:bldrs/helpers/theme/colorz.dart';
import 'package:bldrs/helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/helpers/theme/ratioz.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class KeywordBarButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeywordBarButton({
    @required this.keyword,
    @required this.xIsOn,
    @required this.onTap,
    this.color = Colorz.blue80,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final KW keyword;
  final bool xIsOn;
  final Function onTap;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _corners = Ratioz.boxCorner12;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          IntrinsicWidth(

            child: Container(
              height: 40,
              // width: buttonWidth,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(_corners),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  if (xIsOn)
                    const SizedBox(width: 10,),

                  if (xIsOn)
                    DreamBox(
                      height: 15,
                      width: 15,
                      icon: Iconz.xLarge,
                      iconSizeFactor: 09,
                      bubble: false,
                      iconColor: Colorz.white200,
                      onTap: onTap,
                      splashColor: Colorz.nothing,
                    ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// 'Group' TITLE
                        // if (title != null)
                          SuperVerse(
                            // '${Keyword.getSubGroupNameByKeywordID(context, secondKeyword?.keywordID)}'
                            // '${Keyword.getTranslatedKeywordTitleBySequence(context, sequence)}',
                            verse: KW.translateKeyword(context, keyword),
                            size: 1,
                            italic: true,
                            weight: VerseWeight.thin,
                            centered: false,
                          ),

                        /// CURRENT SECTION NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[

                            SuperVerse(
                              verse: KW.translateKeyword(context, keyword),
                              size: 1,
                              centered: false,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

          ),

        ],
      ),
    );
  }
}

class AddKeywordsButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddKeywordsButton({
    @required this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _corners = Ratioz.boxCorner12;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          IntrinsicWidth(

            child: Container(
              height: 40,
              // width: buttonWidth,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colorz.blue20,
                borderRadius: BorderRadius.circular(_corners),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// 'Group' TITLE
                        // if (title != null)
                        const SuperVerse(
                          verse: 'Add ...',
                          size: 1,
                          italic: true,
                          color: Colorz.white125,
                          weight: VerseWeight.thin,
                          centered: false,
                        ),

                        /// CURRENT SECTION NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const <Widget>[

                            SuperVerse(
                              verse: 'Keywords',
                              size: 1,
                              color: Colorz.white125,
                              centered: false,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

          ),

        ],
      ),
    );
  }
}
