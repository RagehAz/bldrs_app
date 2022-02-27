import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';

class TermsAndRegulationsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TermsAndRegulationsScreen({Key key}) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      historyButtonIsOn: false,
      pageTitle: 'Terms & Regulations',
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          SuperVerse(
            verse: 'Behave yourself',
            size: 4,
            onTap: (){},
          ),

        ],
      ),
    );
  }
}
