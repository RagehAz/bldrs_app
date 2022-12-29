import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/ui_manager/super_text_test/src/super_text.dart';
import 'package:flutter/material.dart';

class SuperTextScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperTextScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: const Verse(
        text: '',
        translate: false,
      ),
      skyType: SkyType.black,
      child: Container(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        color: Colorz.bloodTest,
        alignment: Alignment.center,
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [

              Center(
                child: Container(
                  width: 10,
                  height: 100,
                  color: Colorz.blue125,
                ),
              ),

              SuperText(
                /// TEXT
                text: 'fuck', //'# @FUCK you |  x thing thing ',
                // highlight: ValueNotifier('FU'),
                /// SCALES
                // boxWidth: 300,
                // boxHeight: 100,
                // lineHeight: 100,
                centered: false,
                maxLines: 50,
                margin: 10,
                // lineThickness: 2,
                /// COLORS
                textColor: Colorz.black150,
                // boxColor: Colorz.white20,
                // highlightColor: Colorz.black150,
                // lineColor: Colorz.red255,
                /// WEIGHT
                weight: FontWeight.w600,
                /// STYLE
                font: 'BldrsHeadlineFont',
                italic: true,
                // line: TextDecoration.underline,
                // lineStyle: TextDecorationStyle.dotted,
                /// DOTS
                leadingDot: false,
                // redDot: true,
                /// GESTURES
                onTap: () => blog('fuck you once'),
                onDoubleTap: () => blog('fuck you twice'),
                // leadingDot: true,
                // style: createTextStyle(
                //   lineHeight: 50,
                //   color: Colorz.red255,
                //   backgroundColor: Colorz.black255,
                //   decorationColor: Colorz.yellow255,
                // ),
              ),

            ],
          ),
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
