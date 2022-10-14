import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/d_user/e_user_fcm_topics_screen/fcm_topics_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
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
    return MainLayout(
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      pageTitleVerse: const Verse(text: 'phid_updateProfile', translate: true),
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain('blog'),
          onTap: (){

          },
        ),


      ],
      layoutWidget: FCMTopicsScreenView(
        partyType: partyType,
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
