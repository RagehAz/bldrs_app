import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ListLayout extends StatelessWidget {
  final String pageTitle;
  final String pyramids;
  final List<Map<String, dynamic>> idValueMaps;
  final List<String> icons;
  final Function onItemTap;
  final String pageIcon;
  final String pageIconVerse;
  final Sky sky;

  ListLayout({
    this.pageTitle,
    this.pyramids,
    this.idValueMaps,
    this.icons,
    this.onItemTap,
    this.pageIcon,
    this.pageIconVerse,
    this.sky = Sky.Night,
});

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    double _verseHeight = superVerseRealHeight(context, 2, 1, Colorz.White10);
    double _bubbleHeight = _screenHeight - Ratioz.stratosphere - Ratioz.appBarSmallHeight - _verseHeight  - (Ratioz.appBarMargin * 4);
// -----------------------------------------------------------------------------
    return MainLayout(
      sky: sky,
      appBarType: AppBarType.Basic,
      pageTitle: pageTitle,
      pyramids: pyramids,
      // appBarBackButton: true,
      layoutWidget: Column(

        children: <Widget>[

          Stratosphere(),

          if (pageIcon != null)
          DreamBox(
            height: Ratioz.appBarSmallHeight,
            corners: Iconizer.iconIsContinent(pageIcon) ? Ratioz.appBarSmallHeight / 2 : Ratioz.boxCorner12,
            icon: pageIcon,
          ),

          if (pageIconVerse != null)
          SuperVerse(
            verse: pageIconVerse,
            size: 2,
            labelColor: Colorz.White10,
          ),

          SizedBox(height: 10,),

          Container(
            width: _screenWidth,
            height: _bubbleHeight,
            // color: Colorz.YellowAir,
            child: InPyramidsBubble(
              // title: 'Countries',
              centered: true,
              columnChildren: <Widget>[

                Container(
                  width: Scale.superBubbleClearWidth(context),
                  height: _bubbleHeight - (Ratioz.appBarMargin * 5),
                  // color: Colorz.BloodTest,
                  child: GoHomeOnMaxBounce(
                    height: _bubbleHeight - (Ratioz.appBarMargin * 5),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),

                      shrinkWrap: false,
                      itemCount: idValueMaps.length,
                      itemBuilder: (context, index){

                        return
                          Align(
                            alignment: Aligners.superCenterAlignment(context),
                            child: DreamBox(
                              height: 40,
                              width: Scale.superBubbleClearWidth(context) - 10,
                              icon: icons == null || icons.length == 0 ? null : icons[index],
                              iconSizeFactor: 0.8,
                              verse: idValueMaps[index]['value'],
                              bubble: false,
                              margins: const EdgeInsets.all(5),
                              verseScaleFactor: 0.8,
                              color: Colorz.White10,
                              // textDirection: superTextDirection(context),
                              onTap: () => onItemTap(idValueMaps[index]['id']),
                              verseCentered: true,
                            ),
                          );

                      },
                    ),
                  ),
                ),

              ],
            ),
          )


        ],

      ),
    );
  }
}
