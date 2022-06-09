import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/obelisk_layout/obelisk_row.dart';
import 'package:flutter/material.dart';

class ObeliskPages extends StatelessWidget {

  const ObeliskPages({
    @required this.screenHeight,
    Key key
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {

    final double _obeliskRadius = (ObeliskRow.circleWidth + 10) * 0.5;
    const List<BzTab> _bzTabs = BzModel.bzTabsList;


    return PageView.builder(
      physics: const BouncingScrollPhysics(),
        itemCount: _bzTabs.length,
        itemBuilder: (_, index){

        final BzTab _bzTab = _bzTabs[index];

          return PageBubble(
            appBarType: AppBarType.basic,
            screenHeightWithoutSafeArea: screenHeight,
            color: Colorz.white10,
            bubbleWidth: BldrsAppBar.width(context) - _obeliskRadius,
            corners: superBorderOnly(
              context: context,
              enBottomLeft: _obeliskRadius,
              enBottomRight: _obeliskRadius,
              enTopRight: Ratioz.appBarCorner,
              enTopLeft: Ratioz.appBarCorner,
            ),
            child: SuperVerse(
              verse: BzModel.translateBzTab(_bzTab),
            ),
          );

        }
    );

  }
}
