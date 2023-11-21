import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';

class FloatingLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FloatingLayout({
    required this.columnChildren,
    required this.canSwipeBack,
    this.skyType = SkyType.black,
    this.pyramidType = PyramidType.crystalYellow,
    this.titleVerse,
    this.pyramidButtons,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final SkyType skyType;
  final PyramidType pyramidType;
  final Verse? titleVerse;
  final List<Widget>? pyramidButtons;
  final bool canSwipeBack;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canSwipeBack: canSwipeBack,
      title: titleVerse,
      appBarType: AppBarType.basic,
      pyramidType: pyramidType,
      skyType: skyType,
      pyramidsAreOn: true,
      pyramidButtons: pyramidButtons,
      child: BldrsFloatingList(
        columnChildren: columnChildren,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
