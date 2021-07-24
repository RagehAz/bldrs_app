import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class KeywordBarButton extends StatelessWidget {
  final String keywordID;
  final String title;
  final String keywordName;
  final bool xIsOn;
  final Function onTap;
  final Color color;

  KeywordBarButton({
    @required this.keywordID,
    this.title,
    @required this.keywordName,
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
                    SizedBox(
                      width: 10,
                    ),

                  if (xIsOn)
                    DreamBox(
                      height: 40,
                      icon: Iconz.XLarge,
                      iconSizeFactor: 0.3,
                      bubble: false,
                      iconColor: Colorz.White200,
                      onTap: onTap,
                      splashColor: Colorz.Nothing,
                    ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// 'Section' TITLE
                      if (title != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SuperVerse(
                            verse: title,
                            size: 1,
                            italic: true,
                            color: Colorz.White255,
                            weight: VerseWeight.thin,
                            designMode: _designMode,
                            centered: false,
                          ),
                        ),
                      /// CURRENT SECTION NAME
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[

                            SuperVerse(
                              verse: keywordName,
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
  }
}

