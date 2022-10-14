import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/x_dashboard/z_widgets/the_golden_scroll.dart';
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
      pageTitleVerse: Verse.plain('Golden Scrolls'),
      layoutWidget: Column(
        children: const <Widget>[

          Stratosphere(),

          GoldenScroll(
            headline: 'To run on my Note3 mobile',
            text: 'flutter run --release -d 4d00c32746ba80bf',
          ),
          GoldenScroll(
            headline: 'To run on all emulators',
            text: 'flutter run -d all',
          ),
          GoldenScroll(
            headline: 'Google Maps API key',
            text: 'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI',
          ),
          GoldenScroll(
            headline: 'Google Maps Platform API key',
            text:
            'AIzaSyDp6MMLw2LJflspqJ0x2uZCmQuZ32vS3XU', // AIzaSyD5CBTWvMaL6gU0X7gfdcnkpFmo-aNfgx4
          ),
        ],
      ),
    );
  }
}
