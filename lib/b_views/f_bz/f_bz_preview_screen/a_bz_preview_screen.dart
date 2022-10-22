import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/aaa2_bz_about_page.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
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

    bzModel?.blogBz(methodName: 'BzPreviewScreen');

    return MainLayout(
      skyType: SkyType.black,
      pyramidsAreOn: true,
      pageTitleVerse: Verse(
        text: bzModel?.name,
        translate: false,
      ),
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        if (imAdmin(context) == true)
          AppBarButton(
            verse: Verse.plain('refetch'),
            onTap: () async {

              final BzModel _bzModel = await BzProtocols.refetch(context: context, bzID: bzModel.id);

              await Nav.replaceScreen(
                  context: context,
                  screen: BzPreviewScreen(
                    bzModel: _bzModel,
                  ),
              );

            },
          ),

      ],
      layoutWidget: BzAboutPage(
        bzModel: bzModel,
        showGallery: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
