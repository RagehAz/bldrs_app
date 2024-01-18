import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/e_my_settings_page/user_fcm_topics_screen_view.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/e_bz_settings_page/bz_fcm_topics_screen_view.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:flutter/material.dart';

class FCMTopicsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FCMTopicsScreen({
    required this.partyType,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PartyType partyType;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Verse _title =
    partyType == PartyType.user ?
    const Verse(
        id: 'phid_notifications_settings',
        translate: true
    )
        :
    const Verse(
        id: 'phid_bz_notifications_settings',
        translate: true
    );
    // --------------------
    /*
    final BzModel? _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );
     */
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      skyType: SkyType.grey,
      searchButtonIsOn: false,
      appBarType: AppBarType.basic,
      title: _title,
      pyramidsAreOn: true,
      // appBarRowWidgets: <Widget>[
      //
      //   if (partyType == PartyType.bz)
      //     const Expander(),
      //
      //   if (partyType == PartyType.bz)
      //   BzLogo(
      //     width: 40,
      //     image: _bzModel.logoPath,
      //     isVerified: _bzModel.isVerified,
      //     zeroCornerIsOn: false,
      //     margins: const EdgeInsets.symmetric(horizontal: 5),
      //     corners: BldrsAppBar.clearCorners,
      //   ),
      //
      // ],
      child:

      partyType == PartyType.bz ?
      const BzFCMTopicsScreenView()
          :
      const UserFCMTopicsScreenView(),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
