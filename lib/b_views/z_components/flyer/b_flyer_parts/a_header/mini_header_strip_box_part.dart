import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_right_spacer_part.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/follow_and_call_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_left_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_middle_spacer_part.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MiniHeaderStripBoxPart extends StatelessWidget {

  const MiniHeaderStripBoxPart({
    @required this.flyerBoxWidth,
    @required this.minHeaderHeight,
    @required this.logoSizeRatioTween,
    @required this.headerLeftSpacerTween,
    @required this.tinyMode,
    @required this.headerBorders,
    @required this.children,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final double minHeaderHeight;
  final Animation<double> logoSizeRatioTween;
  final Animation<double> headerLeftSpacerTween;
  final bool tinyMode;
  final BorderRadius headerBorders;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: flyerBoxWidth,
      height: (minHeaderHeight * logoSizeRatioTween.value) + (headerLeftSpacerTween.value),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: headerLeftSpacerTween.value),
      decoration: BoxDecoration(
        color: tinyMode == true ? Colorz.white50 : Colorz.black80,
        borderRadius: Borderers.superBorderOnly(
          context: context,
          enTopRight: headerBorders.topRight.x,
          enTopLeft: headerBorders.topRight.x,
          enBottomRight: 0,
          enBottomLeft: 0,
        ),
      ),

      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        key: const PageStorageKey<String>('miniHeaderStrip'),
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );

  }
}
