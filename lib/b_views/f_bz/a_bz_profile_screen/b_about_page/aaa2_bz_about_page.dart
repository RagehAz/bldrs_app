import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/handlers/pull_to_refresh.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/b_about_page/about_bz_bubbles.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzAboutPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAboutPage({
    this.bzModel,
    this.showGallery = false,
    this.showContacts = true,
    this.showAuthors = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel? bzModel;
  final bool showGallery;
  final bool showContacts;
  final bool showAuthors;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel? _bzModel = bzModel ?? BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    if (bzModel == null){
      return PullToRefresh(
        circleColor: Colorz.yellow255,
        fadeOnBuild: true,
        onRefresh: () async {

          final BzModel? _bz = await BzProtocols.refetch(
              bzID:_bzModel?.id,
          );

          final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
          _bzzProvider.setActiveBz(
              bzModel: _bz,
              notify: true,
          );

        },
        child: AboutBzBubbles(
          bzModel: _bzModel,
          showContacts: showContacts,
          showGallery: showGallery,
          showAuthors: showAuthors,
        ),
      );
    }

    else {
      return AboutBzBubbles(
        bzModel: _bzModel,
        showContacts: showContacts,
        showGallery: showGallery,
        showAuthors: showAuthors,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
