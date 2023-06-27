import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/b_about_page/aaa2_bz_about_page.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:flutter/material.dart';

class BzPreviewScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPreviewScreen({
    required this.bzModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    bzModel?.blogBz(invoker: 'BzPreviewScreen');

    final bool _bzIsNotFound = bzModel == null || bzModel.id == null || bzModel.name == null;

    return MainLayout(
      skyType: SkyType.black,
      pyramidsAreOn: true,
      title: Verse(
        id: bzModel?.name,
        translate: false,
      ),
      appBarType: AppBarType.basic,
      // appBarRowWidgets: <Widget>[
      //
      //   const Expander(),
      //
      //   if (imAdmin(context) == true)
      //     AppBarButton(
      //       verse: Verse.plain('refetch'),
      //       onTap: () async {
      //
      //         await Nav.jumpToBzPreviewScreen(
      //             context: context,
      //             bzID: bzModel.id,
      //         );
      //
      //       },
      //     ),
      //
      // ],
      child: _bzIsNotFound == true ?
      const _NoBzFoundView()
          :
      BzAboutPage(
        bzModel: bzModel,
        showGallery: true,
        showAuthors: true,
        // showContacts: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class _NoBzFoundView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _NoBzFoundView({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: const <Widget>[

        BldrsBox(
          height: 400,
          width: 400,
          icon: Iconz.bz,
          bubble: false,
          opacity: 0.04,
        ),

        BldrsText(
        verse: Verse(
          id: 'phid_bz_account_not_found',
          translate: true,
        ),
        size: 3,
        maxLines: 2,
      ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
