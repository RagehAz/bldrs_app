import 'dart:math' as math;
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double _flyerWidthSizeFactor({
  @required double tween,
  @required double minFactor,
  @required double maxFactor,
}){
  /// EW3AAA
  final double _flyerWidthSizeFactor = minFactor + (tween * (maxFactor - minFactor));
  return _flyerWidthSizeFactor;
}


class AbstractFlyer extends StatelessWidget {

  const AbstractFlyer({
    this.sizeFactor = 1,
    this.onTap,
    this.color,
    Key key,
  }) : super(key: key);

  final double sizeFactor;
  final Function onTap;
  final Color color;

  static const double flyerSmallWidth = 200;



  @override
  Widget build(BuildContext context) {

    final double _flyerBoxWidth = FlyerBox.width(context, sizeFactor);
    final double _flyerZoneHeight = FlyerBox.height(context, _flyerBoxWidth);
    final double _headerHeight = FlyerBox.headerBoxHeight(
      flyerBoxWidth: _flyerBoxWidth,
      bzPageIsOn: false,
    );

    final double _footerHeight = FlyerFooter.boxHeight(context: context, flyerBoxWidth: _flyerBoxWidth);

    blog('THE FUCKING FUCKING ABSTRACT FLYER IS BUILDING : sizeFactor : $sizeFactor');

    return Container(
      width: _flyerBoxWidth,
      height: _flyerZoneHeight,
      color: color,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          /// HEADER
          Positioned(
            top: 0,
            child: Container(
              width: _flyerBoxWidth,
              height: _headerHeight,
              color: Colorz.yellow255,
              child: Row(
                children: [

                  // Container(
                  //   width: _headerHeight,
                  //   height: _headerHeight,
                  //   color: Colorz.white50,
                  // ),
                  //
                  // const Expander(),

                ],
              ),
            ),
          ),

          /// FOOTER
          Positioned(
            bottom: 0,
            child: Container(
              width: _flyerBoxWidth,
              height: _footerHeight,
              color: Colorz.blue255,
            ),
          ),

        ],
      ),
    );

  }
}
