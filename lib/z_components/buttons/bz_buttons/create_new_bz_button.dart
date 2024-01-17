import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/e_app_settings_page/x_app_settings_controllers.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/super_image/super_image.dart';

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
    const double _buttonHeight = 130;

    return SizedBox(
      width: _buttonWidth,
      height: _buttonHeight,
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

          /// TEXTS
          SizedBox(
            width: _buttonWidth,
            height: _buttonHeight,
            child: Column(
              children: <Widget>[

                SizedBox(
                  width: _buttonWidth,
                  height: _buttonHeight * 0.7,
                  child: FittedBox(
                    child: BldrsText(
                      width: _buttonWidth - 20,
                      verse: const Verse(
                        id: 'phid_createBzAccount',
                        translate: true,
                        casing: Casing.upperCase,
                      ),
                      italic: true,
                      size: 3,
                      maxLines: 2,
                      scaleFactor: _buttonWidth * 0.0045,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      weight: VerseWeight.black,
                      shadow: true,
                      color: Colorz.yellow255,
                    ),
                  ),
                ),


                SizedBox(
                  width: _buttonWidth,
                  height: _buttonHeight * 0.15,
                  child: const FittedBox(
                    child: BldrsText(
                      // width: _buttonWidth,
                      verse: Verse(
                        id: 'phid_free_account_no_commissions',
                        translate: true,
                      ),
                      italic: true,
                      size: 3,
                      // maxLines: 1,
                      // scaleFactor: _buttonWidth * 0.0045,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      weight: VerseWeight.thin,
                      shadow: true,
                      color: Colorz.blue255,
                    ),
                  ),
                ),

                SizedBox(
                  width: _buttonWidth,
                  height: _buttonHeight * 0.15,
                  child: const FittedBox(
                    child: BldrsText(
                      // width: _buttonWidth,
                      verse: Verse(
                        id: 'phid_account_addons_are_purchasable',
                        translate: true,
                      ),
                      italic: true,
                      size: 3,
                      // maxLines: 1,
                      // scaleFactor: _buttonWidth * 0.0045,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      weight: VerseWeight.thin,
                      shadow: true,
                      color: Colorz.blue255,
                    ),
                  ),
                ),

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
