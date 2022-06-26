import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/aaa8_bz_settings_page_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class BzSettingsPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzSettingsPage({
    Key key
  }) : super(key: key);

  @override
  State<BzSettingsPage> createState() => _BzSettingsPageState();
}

class _BzSettingsPageState extends State<BzSettingsPage> {
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true
    );

    return FloatingCenteredList(
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        SettingsWideButton(
          verse: 'Edit ${_bzModel.name} Business Account',
          icon: Iconz.gears,
          onTap: () => onEditBzButtonTap(
            context: context,
            bzModel: _bzModel,
          ),
        ),

        const DotSeparator(),

        SettingsWideButton(
          verse: 'Delete ${_bzModel.name} Business account',
          icon: Iconz.xSmall,
          onTap: () => onDeleteBzButtonTap(
            context: context,
            bzModel: _bzModel,
          ),
        ),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );

  }
}
