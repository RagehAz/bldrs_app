import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/h_bz_settings_page/bz_settings_page_controller.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class BzSettingsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzSettingsPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true
    );
    final bool _userIsCreator = AuthorModel.checkUserIsCreatorAuthor(
      userID: Authing.getUserID(),
      bzModel: _bzModel,
    );
    // --------------------
    return BldrsFloatingList(
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        SettingsWideButton(
          verse: const Verse(
            id: 'phid_edit_bz_account',
            translate: true,
          ),
          icon: Iconz.gears,
          onTap: () => onEditBzButtonTap(
            context: context,
            bzModel: _bzModel,
          ),
        ),

        SettingsWideButton(
          verse: const Verse(
            id: 'phid_notifications_settings',
            translate: true,
          ),
          icon: Iconz.notification,
          onTap: () => onGoToBzFCMSettings(
            context: context,
          ),
        ),

        if (_userIsCreator == true)
          const DotSeparator(),

        if (_userIsCreator == true)
          SettingsWideButton(
            verse: const Verse(
              id: 'phid_delete_bz_account',
              translate: true,
            ),
            color: Colorz.bloodTest,
            icon: Iconz.xSmall,
            onTap: () => onDeleteBzButtonTap(
              context: context,
              bzModel: _bzModel,
              showSuccessDialog: true,
            ),
          ),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
