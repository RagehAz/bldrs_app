import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:flutter/material.dart';

class NoPageFoundScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoPageFoundScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      appBarType: AppBarType.non,
      pyramidsAreOn: true,
      title: const Verse(
        id: '',
        translate: false,
      ),
      skyType: SkyType.blackStars,
      pyramidType: PyramidType.glass,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          // BldrsText(
          //   verse: getVerse('phid_bldrsUnderConstruction'),
          //   width: Bubble.bubbleWidth(context: context) * 0.7,
          //   maxLines: 4,
          //   size: 5,
          //   italic: true,
          //   scaleFactor: Bubble.bubbleWidth(context: context) * 0.003,
          // ),
          //

          BldrsText(
            verse: Verse.plain('No page found'),
            width: Bubble.bubbleWidth(context: context) * 0.7,
            maxLines: 4,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.yellow50,
            size: 4,
            margin: 10,
          ),

          BldrsBox(
            verse: Verse.plain('Go home'),
            height: 100,
            icon: Iconz.bldrsAppIcon,
            bubble: false,
            iconColor: Colorz.yellow50,
            onTap: () => DynamicRouter.goTo(route: RouteName.home),
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
