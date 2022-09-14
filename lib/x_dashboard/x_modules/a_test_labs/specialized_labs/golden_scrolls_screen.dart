import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/only_for_dev_widgets/the_golden_scroll.dart';
import 'package:flutter/material.dart';

class GoldenScrollsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GoldenScrollsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      skyType: SkyType.black,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      pageTitleVerse: Verse.plain('Golden Scrolls'),
      layoutWidget: Column(
        children: const <Widget>[

          Stratosphere(),

          GoldenScroll(
            scrollTitle: 'To run on my Note3 mobile',
            scrollScript: 'flutter run --release -d 4d00c32746ba80bf',
          ),
          GoldenScroll(
            scrollTitle: 'To run on all emulators',
            scrollScript: 'flutter run -d all',
          ),
          GoldenScroll(
            scrollTitle: 'Google Maps API key',
            scrollScript: 'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI',
          ),
          GoldenScroll(
            scrollTitle: 'Google Maps Platform API key',
            scrollScript:
            'AIzaSyDp6MMLw2LJflspqJ0x2uZCmQuZ32vS3XU', // AIzaSyD5CBTWvMaL6gU0X7gfdcnkpFmo-aNfgx4
          ),
        ],
      ),
    );
  }
}
