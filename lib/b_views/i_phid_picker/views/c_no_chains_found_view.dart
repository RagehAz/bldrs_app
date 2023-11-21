import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class NoChainsFoundView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoChainsFoundView({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return const MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: Verse(
        id: '',
        translate: false,
      ),
      skyType: SkyType.blackStars,
      child: Center(
        child: NoResultFound(),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
