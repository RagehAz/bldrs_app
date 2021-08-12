import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class KeywordBarButton extends StatelessWidget {
  final Keyword keyword;
  final bool xIsOn;
  final Function onTap;
  final Color color;

  KeywordBarButton({
    @required this.keyword,
    @required this.xIsOn,
    @required this.onTap,
    this.color = Colorz.Blue80
});

  @override
  Widget build(BuildContext context) {

    double _corners = Ratioz.boxCorner12;

    bool _designMode = false;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  if (xIsOn)
                    const SizedBox(width: 10,),

                  if (xIsOn)
                    DreamBox(
                      height: 15,
                      width: 15,
                      icon: Iconz.XLarge,
                      iconSizeFactor: 09,
                      bubble: false,
                      iconColor: Colorz.White200,
                      onTap: onTap,
                      splashColor: Colorz.Nothing,
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
                            verse: Keyword.translateKeyword(context, keyword.groupID),
                            size: 1,
                            italic: true,
                            color: Colorz.White255,
                            weight: VerseWeight.thin,
                            designMode: _designMode,
                            centered: false,
                          ),

                        /// CURRENT SECTION NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[

                            SuperVerse(
                              verse: Keyword.translateKeyword(context, keyword.keywordID),
                              size: 1,
                              italic: false,
                              color: Colorz.White255,
                              weight: VerseWeight.bold,
                              scaleFactor: 1,
                              designMode: _designMode,
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
  final Function onTap;

  AddKeywordsButton({
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    double _corners = Ratioz.boxCorner12;

    bool _designMode = false;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          IntrinsicWidth(

            child: Container(
              height: 40,
              // width: buttonWidth,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colorz.Blue20,
                borderRadius: BorderRadius.circular(_corners),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        SuperVerse(
                          verse: 'Add ...',
                          size: 1,
                          italic: true,
                          color: Colorz.White125,
                          weight: VerseWeight.thin,
                          designMode: _designMode,
                          centered: false,
                        ),

                        /// CURRENT SECTION NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[

                            SuperVerse(
                              verse: 'Keywords',
                              size: 1,
                              italic: false,
                              color: Colorz.White125,
                              weight: VerseWeight.bold,
                              scaleFactor: 1,
                              designMode: _designMode,
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
