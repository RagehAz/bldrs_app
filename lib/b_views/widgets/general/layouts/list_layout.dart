import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ListLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ListLayout({
    this.pageTitle,
    this.pyramids,
    this.mapModels,
    this.icons,
    this.onItemTap,
    this.pageIcon,
    this.pageIconVerse,
    this.sky = SkyType.night,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String pageTitle;
  final String pyramids;
  final List<MapModel> mapModels;
  final List<String> icons;
  final ValueChanged<String> onItemTap;
  final String pageIcon;
  final String pageIconVerse;
  final SkyType sky;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    final double _verseHeight =
        SuperVerse.superVerseRealHeight(context, 2, 1, Colorz.white10);
    final double _bubbleHeight = _screenHeight -
        Ratioz.stratosphere -
        Ratioz.appBarSmallHeight -
        _verseHeight -
        (Ratioz.appBarMargin * 4);
// -----------------------------------------------------------------------------
    return MainLayout(
      skyType: sky,
      appBarType: AppBarType.basic,
      pageTitle: pageTitle,
      pyramids: pyramids,
      // appBarBackButton: true,
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          if (pageIcon != null)
            DreamBox(
              height: Ratioz.appBarSmallHeight,
              corners: Iconizer.iconIsContinent(pageIcon)
                  ? Ratioz.appBarSmallHeight / 2
                  : Ratioz.boxCorner12,
              icon: pageIcon,
            ),

          if (pageIconVerse != null)
            SuperVerse(
              verse: pageIconVerse,
              labelColor: Colorz.white10,
            ),

          const SizedBox(
            height: 10,
          ),

          SizedBox(
            width: _screenWidth,
            height: _bubbleHeight,
            // color: Colorz.YellowAir,
            child: Bubble(
              // title: 'Countries',
              centered: true,
              width: Bubble.clearWidth(context),
              columnChildren: <Widget>[
                SizedBox(
                  width: Bubble.clearWidth(context) - 10,
                  height: _bubbleHeight - (Ratioz.appBarMargin * 5),
                  // color: Colorz.BloodTest,
                  child: MaxBounceNavigator(
                    boxDistance: _bubbleHeight - (Ratioz.appBarMargin * 5),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: mapModels.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Aligners.superCenterAlignment(context),
                          child: DreamBox(
                            height: 40,
                            width: Bubble.clearWidth(context) - 10,
                            icon: icons == null || icons.isEmpty
                                ? null
                                : icons[index],
                            iconSizeFactor: 0.8,
                            verse: mapModels[index].value,
                            bubble: false,
                            margins: const EdgeInsets.symmetric(vertical: 5),
                            verseScaleFactor: 0.8,
                            color: Colorz.white10,
                            // textDirection: superTextDirection(context),
                            onTap: () => onItemTap(mapModels[index].key),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
