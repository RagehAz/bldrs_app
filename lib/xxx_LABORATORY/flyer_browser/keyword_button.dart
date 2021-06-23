import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeywordButton extends StatelessWidget {
  final String title;
  final String keyword;
  final bool xIsOn;
  final Function onTap;
  final Color color;

  KeywordButton({
    this.title,
    @required this.keyword,
    @required this.xIsOn,
    @required this.onTap,
    this.color = Colorz.BabyBlueSmoke
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
              margin: EdgeInsets.symmetric(horizontal: 2.5),
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
                      iconColor: Colorz.WhiteLingerie,
                      boxFunction: onTap,
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
                            color: Colorz.White,
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
                              verse: keyword,
                              size: 1,
                              italic: false,
                              color: Colorz.White,
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

