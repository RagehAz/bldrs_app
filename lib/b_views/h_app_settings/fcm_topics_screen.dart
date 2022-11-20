import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/h_bz_settings_page/bz_fcm_topics_screen_view.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/d_settings_page/aaa5_user_fcm_topics_screen_view.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
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
    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );
    // --------------------
    return MainLayout(
      skyType: SkyType.black,
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
          image: _bzModel.logoPath,
          isVerified: _bzModel.isVerified,
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