import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/handlers/pull_to_refresh.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/z_components/bubbles/b_variants/bz_bubbles/bz_about_bubbles.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class BzAboutPage extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzAboutPage({
    this.bzModel,
    this.showGallery = false,
    this.showContacts = true,
    this.showAuthors = false,
    this.appBarType = AppBarType.basic,
    super.key
  });
  // --------------------------------------------------------------------------
  final BzModel? bzModel;
  final bool showGallery;
  final bool showContacts;
  final bool showAuthors;
  final AppBarType appBarType;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel? _bzModel = bzModel ?? HomeProvider.proGetActiveBzModel(
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

          HomeProvider.proSetActiveBzModel(
              bzModel: _bz,
              context: context,
              notify: true
          );

        },
        child: AboutBzBubbles(
          bzModel: _bzModel,
          showContacts: showContacts,
          showGallery: showGallery,
          showAuthors: showAuthors,
          appBarType: appBarType,
        ),
      );
    }

    else {
      return AboutBzBubbles(
        bzModel: _bzModel,
        showContacts: showContacts,
        showGallery: showGallery,
        showAuthors: showAuthors,
        appBarType: appBarType,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
