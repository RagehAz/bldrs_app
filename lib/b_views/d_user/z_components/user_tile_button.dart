import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class UserTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserTileButton({
    @required this.boxWidth,
    @required this.userModel,
    this.sideButtonVerse,
    this.onSideButtonTap,
    this.onUserTap,
    this.bubble = true,
    this.color,
    this.sideButtonDeactivated,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final double boxWidth;
  final Verse sideButtonVerse;
  final Function onUserTap;
  final Function onSideButtonTap;
  final bool bubble;
  final Color color;
  final bool sideButtonDeactivated;
  /// --------------------------------------------------------------------------
  static const double boxHeight = 80;
  static const double inviteButtonWidth = 80;
  static const double boxPadding = Ratioz.appBarMargin;
  static const double buttonHeight = boxHeight - (2 * boxPadding);
  // --------------------
  static double getBoxWidth({
    @required BuildContext context,
    double boxWidthOverride,
  }){
    return boxWidthOverride ?? Scale.superScreenWidth(context);
  }
  // --------------------
  static double getUserButtonWidth({
    @required BuildContext context,
    @required bool inviteButtonIsOn,
    @required double boxWidth,
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
    return Container(
      width: boxWidth,
      height: buttonHeight,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DreamBox(
            width: _userButtonWidth,
            height: buttonHeight,
            icon: userModel?.pic,
            verse: Verse(text: userModel?.name,translate: false),
            verseCentered: false,
            secondLine: UserModel.generateUserJobLine(userModel),
            secondLineScaleFactor: 1.2,
            verseScaleFactor: 0.8,
            secondVerseMaxLines: 1,
            bubble: bubble,
            color: color,
            onTap: onUserTap,
          ),

          if (sideButtonVerse != null)
            const SizedBox(width: boxPadding,),

          if (sideButtonVerse != null)
            DreamBox(
              width: inviteButtonWidth,
              height: buttonHeight,
              verse: sideButtonVerse,
              verseScaleFactor: 0.7,
              verseMaxLines: 2,
              onTap: onSideButtonTap,
              isDeactivated: sideButtonDeactivated,
            ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
