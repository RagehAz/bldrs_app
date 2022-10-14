import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/d_user/e_user_fcm_topics_screen/bz_fcm_user_topics.dart';
import 'package:bldrs/b_views/d_user/e_user_fcm_topics_screen/user_fcm_topics_screen_view.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:flutter/material.dart';

class FCMTopicsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FCMTopicsScreen({
    @required this.partyType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PartyType partyType;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Verse _title =
    partyType == PartyType.user ?
    const Verse(
        text: 'phid_notifications_settings',
        translate: true
    )
        :
    const Verse(
        text: 'phid_bz_notifications_settings',
        translate: true
    );
    // --------------------
    return MainLayout(
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      pageTitleVerse: _title,
      pyramidsAreOn: true,
      appBarRowWidgets: <Widget>[

        if (partyType == PartyType.bz)
          const Expander(),

        if (partyType == PartyType.bz)
        BzLogo(
          width: 40,
          image: BzzProvider.proGetActiveBzModel(context: context, listen: true).logo,
          zeroCornerIsOn: false,
          margins: const EdgeInsets.symmetric(horizontal: 5),
          corners: BldrsAppBar.clearCorners,
        ),

      ],
      layoutWidget:

      partyType == PartyType.bz ?
      const BzFCMTopicsScreenView()
          :
      const UserFCMTopicsScreenView(),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}