import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/super_image/super_image.dart';

class CreateNewBzButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CreateNewBzButton({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
    final bool _userIsOnline = Authing.userIsSignedUp(_userModel?.signInMethod);
    final double _buttonWidth = Scale.superWidth(context, 0.7);

    return SizedBox(
      width: _buttonWidth,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// BACKGROUND GRAPHIC
          const Positioned(
            left: -60,
            top: -(130 / 2) - 30,
            child: SuperImage(
              width: 300,
              height: 300,
              pic: Iconz.bz,
              iconColor: Colorz.yellow20,
              loading: false,
            ),
          ),

          /// TEXT
          Positioned(
            top: 0,
            child: Opacity(
              opacity: _userIsOnline == true ? 1 : 0.5,
              child: BldrsText(
                width: _buttonWidth - 20,
                verse: const Verse(
                  id: 'phid_createBzAccount',
                  translate: true,
                  casing: Casing.upperCase,
                ),
                italic: true,
                size: 3,
                maxLines: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                weight: VerseWeight.black,
                shadow: true,
              ),
            ),
          ),

          /// BULLETS
          Positioned(
            bottom: 0,
            child: BldrsBulletPoints(
              bubbleWidth: _buttonWidth,
              centered: true,
              showBottomLine: false,
              verseSizeFactor: 0.7,
              showDots: false,
              bulletPoints: const <Verse>[

                Verse(id: 'phid_free_account_no_commissions', translate: true),

                // Verse(id: 'phid_no_deal_commissions', translate: true),

                Verse(id: 'phid_account_addons_are_purchasable', translate: true),

              ],
            ),
          ),

          /// TAP LAYER
          BldrsBox(
            width: _buttonWidth,
            height: 130,
            color: Colorz.yellow50,
            isDisabled: !_userIsOnline,
            onTap: () => onCreateNewBzTap(),
            onDisabledTap: () async {
              await Dialogs.youNeedToBeSignedUpDialog(
                afterHomeRouteName: RouteName.appSettings,
                afterHomeRouteArgument: null,
              );
            },
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
