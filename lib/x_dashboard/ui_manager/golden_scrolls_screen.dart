import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
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
      title: Verse.plain('Golden Scrolls'),
      child: Column(
        children: const <Widget>[

          Stratosphere(),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
