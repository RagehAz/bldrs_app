import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/ui_manager/super_text_test/src/create_style_method.dart';
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
                text: '# @FUCK you |  x thing thing ',
                boxWidth: 200,
                // height: 20,
                textColor: Colorz.white255,
                // style: TextStyle(
                //   height: 1,
                //   fontSize: 100,
                //   color: Colorz.red255,
                //   backgroundColor: Colorz.black255,
                //   fontFamily: 'BldrsHeadlineFont',
                //
                // ),
                maxLines: 2,
                boxColor: Colorz.yellow255,
                // leadingDot: true,
                style: createTextStyle(
                  lineHeight: 50,
                  color: Colorz.red255,
                  backgroundColor: Colorz.black255,
                  fontFamily: 'BldrsHeadlineFont',
                  decorationColor: Colorz.yellow255,
                ),
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
