import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:flutter/material.dart';

class CenteredListLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CenteredListLayout({
    @required this.columnChildren,
    this.skyType = SkyType.non,
    this.pyramidType = PyramidType.crystalYellow,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final SkyType skyType;
  final PyramidType pyramidType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeight(context);
    final double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      pageTitle: 'Edit Author Role',
      appBarType: AppBarType.basic,
      pyramidType: pyramidType,
      skyType: skyType,
      pyramidsAreOn: true,
      layoutWidget: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: _screenWidth,
          constraints: BoxConstraints(
            minHeight: _screenHeight,
          ),
          alignment: Alignment.center,
          padding: Stratosphere.stratosphereSandwich,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              ...columnChildren,

            ],
          ),
        ),
      ),
    );

  }
}
