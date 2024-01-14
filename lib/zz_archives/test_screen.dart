import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/drawing/expander.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class TheTestScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TheTestScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: const Verse(
        id: '',
        translate: false,
      ),
      skyType: SkyType.grey,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain(''),
        ),

      ],
      child: FloatingList(
        columnChildren: [

          Container(
            width: 50,
            height: 10,
            color: Colorz.red255,
          ),

          Container(
            width: 100,
            height: Scale.screenHeight(context),
            color: Colorz.bloodTest,
          ),

          Container(
            width: 50,
            height: 10,
            color: Colorz.red255,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                width: 50,
                height: MediaQuery.of(context).size.height,
                color: Colorz.yellow255,
              ),

              Container(
                width: 50,
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                color: Colorz.yellow200,
              ),

              Container(
                width: 50,
                height: MediaQuery.of(context).size.height
                    - MediaQuery.of(context).padding.top
                    - MediaQuery.of(context).padding.bottom,
                color: Colorz.yellow125,
              ),


            ],
          ),

          Container(
            width: 50,
            height: 10,
            color: Colorz.red255,
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
