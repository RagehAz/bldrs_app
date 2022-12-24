import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class FloatingLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FloatingLayout({
    @required this.columnChildren,
    this.skyType = SkyType.non,
    this.pyramidType = PyramidType.crystalYellow,
    this.titleVerse,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final SkyType skyType;
  final PyramidType pyramidType;
  final Verse titleVerse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      title: titleVerse,
      appBarType: AppBarType.basic,
      pyramidType: pyramidType,
      skyType: skyType,
      pyramidsAreOn: true,
      child: FloatingList(
        columnChildren: columnChildren,
      ),
    );

  }
/// --------------------------------------------------------------------------
}

class FloatingList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FloatingList({
    @required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: Scale.screenWidth(context),
        constraints: BoxConstraints(
          minHeight: Scale.screenHeight(context),
        ),
        alignment: Alignment.center,
        padding: Stratosphere.stratosphereSandwich,
        child: Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: <Widget>[

            ...columnChildren,

          ],
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
