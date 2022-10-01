import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x8_bz_settings_page_controller.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

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
      userID: AuthFireOps.superUserID(),
      bzModel: _bzModel,
    );
    // --------------------
    return FloatingCenteredList(
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        SettingsWideButton(
          verse: const Verse(
            text: 'phid_edit_bz_account',
            translate: true,
          ),
          icon: Iconz.gears,
          onTap: () => onEditBzButtonTap(
            context: context,
            bzModel: _bzModel,
          ),
        ),

        if (_userIsCreator == true)
          const DotSeparator(),

        if (_userIsCreator == true)
          SettingsWideButton(
            verse: const Verse(
              text: 'phid_delete_bz_account',
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
