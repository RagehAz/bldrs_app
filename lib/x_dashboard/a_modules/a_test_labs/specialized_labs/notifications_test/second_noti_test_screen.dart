import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SecondNotiTestScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SecondNotiTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      pageTitleVerse:  'Second Notification Screen',
      sectionButtonIsOn: false,
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          Container(
            width: 300,
            height: 400,
            color: Colorz.bloodTest,
            child: const SuperVerse(
              verse: Verse(
                text: 'Second Notification Screen',
                translate: false,
              ),
            ),
          ),

        ],
      ),
    );

  }
}
