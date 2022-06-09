import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/obelisk_layout/bz_obelisk.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/obelisk_layout/obelisk_row.dart';
import 'package:flutter/material.dart';

class ObeliskLayout extends StatefulWidget {

  const ObeliskLayout({
    Key key
  }) : super(key: key);

  @override
  State<ObeliskLayout> createState() => _ObeliskLayoutState();
}

class _ObeliskLayoutState extends State<ObeliskLayout> {

  bool isBig = false;

  final ValueNotifier<bool> isExpanded = ValueNotifier(false);

  void onTriggerExpansion(){
    isExpanded.value = !isExpanded.value;
  }

  void onRowTap(BzTab bzTab){
    blog('bzTab : $bzTab');
  }

  @override
  Widget build(BuildContext context) {

    final double _screenHeight = superScreenHeightWithoutSafeArea(context);

    final double _obeliskRadius = (ObeliskRow.circleWidth + 10) * 0.5;

    return MainLayout(
      pyramidType: PyramidType.crystalYellow,
      pyramidsAreOn: true,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pageTitle: 'The Obelisk',
      layoutWidget: Stack(
        children: <Widget>[

          PageBubble(
            appBarType: AppBarType.basic,
            screenHeightWithoutSafeArea: _screenHeight,
            color: Colorz.white10,
            bubbleWidth: BldrsAppBar.width(context) - _obeliskRadius,
            corners: superBorderOnly(
              context: context,
              enBottomLeft: _obeliskRadius,
              enBottomRight: _obeliskRadius,
              enTopRight: Ratioz.appBarCorner,
              enTopLeft: Ratioz.appBarCorner,
            ),
            child: Container(),
          ),

          BzObelisk(
              isExpanded: isExpanded,
              onTriggerExpansion: onTriggerExpansion,
              onRowTap: onRowTap
          ),

        ],
      ),
    );

  }

}
