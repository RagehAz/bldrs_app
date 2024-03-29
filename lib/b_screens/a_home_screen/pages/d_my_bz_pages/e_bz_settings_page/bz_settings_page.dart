import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_pages/e_bz_settings_page/bz_settings_page_controller.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/z_components/buttons/general_buttons/settings_wide_button.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class BzSettingsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzSettingsPage({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BzModel? _bzModel = HomeProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );
    final bool _userIsCreator = AuthorModel.checkUserIsCreatorAuthor(
      userID: Authing.getUserID(),
      bzModel: _bzModel,
    );
    // --------------------
    return BldrsFloatingList(
      mainAxisAlignment: MainAxisAlignment.center,
      boxAlignment: Alignment.center,
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        SettingsWideButton(
          verse: const Verse(
            id: 'phid_edit_bz_account',
            translate: true,
          ),
          icon: Iconz.gears,
          onTap: () => onEditBzButtonTap(
            bzModel: _bzModel,
          ),
        ),

        SettingsWideButton(
          verse: const Verse(
            id: 'phid_notifications_settings',
            translate: true,
          ),
          icon: Iconz.notification,
          onTap: () => onGoToBzFCMSettings(),
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
            ),
          ),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
