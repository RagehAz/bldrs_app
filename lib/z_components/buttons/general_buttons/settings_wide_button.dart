import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/general_buttons/main_button.dart';
import 'package:bldrs/z_components/buttons/multi_button/a_multi_button.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class SettingsWideButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SettingsWideButton({
    required this.verse,
    required this.onTap,
    this.isOn = true,
    this.icon,
    this.color = Colorz.white20,
    this.verseColor = Colorz.white255,
    this.iconColor,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse verse;
  final String? icon;
  final Function? onTap;
  final bool isOn;
  final Color color;
  final Color verseColor;
  final Color? iconColor;
  /// --------------------------------------------------------------------------
  static double getWidth(){
    // return Bubble.bubbleWidth(context: getMainContext());
    // return Scale.adaptiveWidth(getMainContext(), 0.5);
    return MainButton.getButtonWidth(context: getMainContext());
  }
  // --------------------------------------------------------------------------
  static const double height = 50;
  static const double iconSizeFactor = 0.5;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainButton(
      verse: verse.copyWith(casing: Casing.upperCase),
      icon: icon,
      verseColor: verseColor,
      iconColor: iconColor,
      iconSizeFactor: iconSizeFactor,
      buttonColor: color,
      verseShadow: verseColor != Colorz.black255,
      onTap: onTap,
      isDisabled: !isOn,
      verseCentered: icon == null,
      verseItalic: true,
      verseScaleFactor: 0.55,
      // verseWeight: VerseWeight.bold,
      // splashColor: Colorz.yellow255,
    );

  }
// --------------------------------------------------------------------------
}

class SettingsToSettingsButtons extends StatelessWidget {

  const SettingsToSettingsButtons({
    super.key
  });

  @override
  Widget build(BuildContext context) {

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
    final bool _userIsSignedUp = Authing.userIsSignedUp(_userModel?.signInMethod);

    if (_userIsSignedUp == false){
      return const SizedBox();
    }
    else {

      final double _rowWidth = MainButton.getButtonWidth(context: context);
      const double _spacing = 10;
      final double _halfRowButtonWidth = (_rowWidth - _spacing) / 2;
      final bool _userHasBzz = Lister.checkCanLoop(_userModel?.myBzzIDs);

      final double _userButtonWidth = _userHasBzz == true ? _halfRowButtonWidth : _rowWidth;
      const double _buttonHeight = SettingsWideButton.height * 1;

      return Container(
        width: _rowWidth,
        height: SettingsWideButton.height,
        margin: const EdgeInsets.only(
          bottom: 10
        ),
        child: Row(
          children: <Widget>[

            /// USER SETTINGS BUTTON
            BldrsBox(
                height: _buttonHeight,
                width: _userButtonWidth,
                verse: const Verse(
                  id: 'phid_user_settings',
                  translate: true,
                  casing: Casing.upperCase,
                ),
                verseScaleFactor: 0.4,
                icon: _userModel?.picPath,
                verseMaxLines: 3,
                verseCentered: false,
                onTap: () async {

                  await Routing.goTo(route: TabName.bid_My_Settings);

                }
            ),

            if (_userHasBzz == true)
            const SizedBox(
              width: _spacing,
            ),

            /// BZZ SETTINGS BUTTONS
            if (_userHasBzz == true)
            FutureBuilder(
              future: BzProtocols.fetchBzz(
                bzzIDs: _userModel?.myBzzIDs,
              ),
              builder: (BuildContext context, AsyncSnapshot<List<BzModel>> snapshot) {

                final List<BzModel>? _bzz = snapshot.data;
                final List<String> _logos = BzModel.getBzzLogos(_bzz);

                return MultiButton(
                  height: _buttonHeight,
                  width: _halfRowButtonWidth,
                  verse: const Verse(
                    id: 'phid_bz_settings',
                    translate: true,
                    casing: Casing.upperCase,
                  ),
                  pics: _logos,
                  verseItalic: true,
                  verseScaleFactor: 0.4,
                  onTap: () async {

                    BzModel? _bzModel;

                    if (_bzz?.length == 1){
                      _bzModel = _bzz?.first;
                    }
                    else {

                      _bzModel = await Dialogs.selectBzBottomDialog(
                        bzzModels: _bzz,
                      );

                    }

                    if (_bzModel != null) {

                      await Routing.goTo(
                        route: TabName.bid_MyBz_Settings,
                        arg: _bzModel.id!,
                      );

                    }

                    },
                );
              }
            ),

          ],
        ),
      );
    }

  }

}
