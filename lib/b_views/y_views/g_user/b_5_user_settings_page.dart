import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_screen_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserSettingsPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel userModel = UsersProvider.proGetMyUserModel(context, listen: true);
    const double _buttonHeight = 50;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        const InviteBzzButton(),

        /// EDIT PROFILE
        BottomDialog.wideButton(
          context: context,
          height: _buttonHeight,
          verse: superPhrase(context, 'phid_editProfile'),
          icon: Iconz.gears,
          onTap: () => onEditProfileTap(context),
        ),

        /// DELETE MY ACCOUNT
        BottomDialog.wideButton(
          context: context,
          height: _buttonHeight,
          verse: superPhrase(context, 'phid_delete_my_account'),
          icon: Iconz.xSmall,
          onTap: () => onDeleteMyAccount(context),
        ),

        /// SIGN OUT
        BottomDialog.wideButton(
          context: context,
          height: _buttonHeight,
          verse: superPhrase(context, 'phid_signOut'),
          icon: Iconz.exit,
          onTap: () => onSignOut(context),
        ),

      ],
    );

  }
}

class InviteBzzButton extends StatelessWidget {

  const InviteBzzButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Aligners.superBottomAlignment(context),
      child: DreamBox(
        height: 50,
        margins: const EdgeInsets.all(Ratioz.appBarMargin),
        // width: Scale.appBarWidth(context),
        color: Colorz.yellow255,
        verse: 'Invite Businesses you know',
        secondLine: 'To join Bldrs.net',
        secondLineColor: Colorz.black255,
        secondLineScaleFactor: 1.2,
        verseColor: Colorz.black255,
        verseCentered: false,
        icon: Iconz.bz,
        iconColor: Colorz.black255,
        iconSizeFactor: 0.7,
        onTap: () => onInviteBusinessesTap(context),
      ),
    );
  }
}
