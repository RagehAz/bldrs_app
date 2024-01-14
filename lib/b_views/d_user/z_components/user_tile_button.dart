import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

class UserTileButtonOld extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserTileButtonOld({
    required this.boxWidth,
    required this.userModel,
    this.sideButtonVerse,
    this.onSideButtonTap,
    this.onUserTap,
    this.bubble = true,
    this.color,
    this.sideButtonDeactivated,
    super.key
  });
  /// --------------------------------------------------------------------------
  final UserModel? userModel;
  final double boxWidth;
  final Verse? sideButtonVerse;
  final Function? onUserTap;
  final Function? onSideButtonTap;
  final bool bubble;
  final Color? color;
  final bool? sideButtonDeactivated;
  /// --------------------------------------------------------------------------
  static const double boxHeight = 80;
  static const double inviteButtonWidth = 80;
  static const double boxPadding = Ratioz.appBarMargin;
  static const double buttonHeight = boxHeight - (2 * boxPadding);
  // --------------------
  static double getBoxWidth({
    required BuildContext context,
    double? boxWidthOverride,
  }){
    return boxWidthOverride ?? Scale.screenWidth(context);
  }
  // --------------------
  static double getUserButtonWidth({
    required BuildContext context,
    required bool inviteButtonIsOn,
    required double boxWidth,
  }){

    double _width;

    final double _boxWidth = getBoxWidth(
      context: context,
      boxWidthOverride: boxWidth,
    );

    if (inviteButtonIsOn == true){
      _width = _boxWidth - boxPadding - inviteButtonWidth;
    }
    else {
      _width = _boxWidth;

    }

    return _width;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _userButtonWidth = getUserButtonWidth(
      context: context,
      inviteButtonIsOn: sideButtonVerse != null,
      boxWidth: boxWidth,
    );
    // --------------------
    blog('fuck');

    return Container(
      width: boxWidth,
      height: buttonHeight,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          BldrsBox(
            width: _userButtonWidth,
            height: buttonHeight,
            icon: userModel?.picPath,
            verse: Verse(id: userModel?.name,translate: false),
            verseCentered: false,
            secondLine: UserModel.generateUserJobLine(userModel),
            secondLineScaleFactor: 0.7,
            verseScaleFactor: 0.6,
            secondVerseMaxLines: 1,
            bubble: bubble,
            color: color,
            onTap: onUserTap,
            verseWeight: VerseWeight.thin,
          ),

          if (sideButtonVerse != null)
            const SizedBox(width: boxPadding,),

          if (sideButtonVerse != null)
            BldrsBox(
              width: inviteButtonWidth,
              height: buttonHeight,
              verse: sideButtonVerse,
              verseScaleFactor: 0.6,
              verseMaxLines: 2,
              onTap: onSideButtonTap,
              isDisabled: sideButtonDeactivated,
            ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
