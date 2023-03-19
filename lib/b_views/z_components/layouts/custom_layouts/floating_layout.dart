import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
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
      child: BldrsFloatingList(
        columnChildren: columnChildren,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
