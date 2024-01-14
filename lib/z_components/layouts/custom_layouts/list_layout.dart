import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/bubbles/model/bubble_header_vm.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/models/continent_model.dart';
import 'package:basics/layouts/handlers/max_bounce_navigator.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class ListLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ListLayout({
    required this.canSwipeBack,
    this.pageTitleVerse,
    this.pyramids,
    this.mapModels,
    this.icons,
    this.onItemTap,
    this.pageIcon,
    this.pageIconVerse,
    this.sky = SkyType.black,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? pageTitleVerse;
  final String? pyramids;
  final List<MapModel>? mapModels;
  final List<String>? icons;
  final ValueChanged<String>? onItemTap;
  final String? pageIcon;
  final Verse? pageIconVerse;
  final SkyType sky;
  final bool canSwipeBack;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    final double _verseHeight = BldrsText.superVerseRealHeight(
      context: context,
      size: 2,
      sizeFactor: 1,
      hasLabelBox: true,
    );
    // --------------------
    final double _bubbleHeight = _screenHeight - Ratioz.stratosphere - Ratioz.appBarSmallHeight - _verseHeight -
        (Ratioz.appBarMargin * 4);
    // --------------------
    final double _clearWidth = Bubble.clearWidth(context: context);
    // --------------------
    return MainLayout(
      canSwipeBack: canSwipeBack,
      skyType: sky,
      appBarType: AppBarType.basic,
      title: pageTitleVerse,
      pyramidsAreOn: true,
      // appBarBackButton: true,
      child: Column(
        children: <Widget>[

          const Stratosphere(),

          if (pageIcon != null)
            BldrsBox(
              height: Ratioz.appBarSmallHeight,
              icon: pageIcon,
              corners: Continent.checkIconIsContinent(pageIcon) ?
              Ratioz.appBarSmallHeight / 2
                  :
              Ratioz.boxCorner12,
            ),

          if (pageIconVerse != null)
            BldrsText(
              verse: pageIconVerse,
              labelColor: Colorz.white10,
            ),

          const SizedBox(
            height: 10,
          ),

          SizedBox(
            width: _screenWidth,
            height: _bubbleHeight,
            child: Bubble(
              bubbleHeaderVM: const BubbleHeaderVM(
                centered: true,
              ),
              childrenCentered: true,
              width: Bubble.clearWidth(context: context),
              columnChildren: <Widget>[
                SizedBox(
                  width: _clearWidth - 10,
                  height: _bubbleHeight - (Ratioz.appBarMargin * 5),
                  // color: Colorz.BloodTest,
                  child: MaxBounceNavigator(
                    boxDistance: _bubbleHeight - (Ratioz.appBarMargin * 5),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: mapModels?.length ?? 0,
                      // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: BldrsAligners.superCenterAlignment(context),
                          child: BldrsBox(
                            height: 40,
                            width: _clearWidth - 10,
                            icon: Lister.checkCanLoop(icons) == false ? null : icons![index],
                            iconSizeFactor: 0.8,
                            verse: Lister.checkCanLoop(mapModels) == false ? null : mapModels![index].value,
                            bubble: false,
                            margins: const EdgeInsets.symmetric(vertical: 5),
                            verseScaleFactor: 0.8,
                            color: Colorz.white10,
                            // textDirection: superTextDirection(context),
                            onTap: Lister.checkCanLoop(mapModels) == false ? null
                                :
                                () => onItemTap?.call(mapModels![index].key!),
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
    // --------------------
  }
/// --------------------------------------------------------------------------
}
