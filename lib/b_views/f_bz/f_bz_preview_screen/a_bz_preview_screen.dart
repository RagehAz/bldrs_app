import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/aaa2_bz_about_page.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:flutter/material.dart';

class BzPreviewScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPreviewScreen({
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      pageTitleVerse: Verse(
        text: bzModel.name,
        translate: false,
      ),
      appBarType: AppBarType.basic,
      layoutWidget: BzAboutPage(
        bzModel: bzModel,
        showGallery: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
