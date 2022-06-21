import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';

class TermsAndRegulationsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TermsAndRegulationsScreen({
    Key key
  }) : super(key: key);
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
      skyType: SkyType.non,
      pyramidType: PyramidType.crystalYellow,
      layoutWidget: FloatingCenteredList(
        columnChildren: <Widget>[

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
