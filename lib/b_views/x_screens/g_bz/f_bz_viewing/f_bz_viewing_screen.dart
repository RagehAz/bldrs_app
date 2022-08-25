import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aaa2_bz_about_page.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:flutter/material.dart';

class BzViewingScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzViewingScreen({
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
      pageTitleVerse: bzModel.name,
      appBarType: AppBarType.basic,
      layoutWidget: BzAboutPage(
        bzModel: bzModel,
        showGallery: true,
      ),
    );

  }
}
