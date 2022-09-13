import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
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
    return SizedBox(
      width: boxWidth,
      height: boxHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DreamBox(
            width: _userButtonWidth,
            height: buttonHeight,
            icon: userModel.pic,
            verse: Verse(text: userModel.name,translate: false),
            verseCentered: false,
            secondLine: UserModel.generateUserJobLine(userModel),
            secondLineScaleFactor: 1.2,
            verseScaleFactor: 0.8,
            secondVerseMaxLines: 1,
            bubble: bubble,
            color: color,
            onTap: onUserTap,
          ),

          if (sideButtonVerse == null)
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

class FutureUserTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FutureUserTileButton({
    @required this.boxWidth,
    @required this.userID,
    this.sideButtonVerse,
    this.onSideButtonTap,
    this.onUserTap,
    this.bubble = true,
    this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String userID;
  final double boxWidth;
  final Verse sideButtonVerse;
  final Function onUserTap;
  final Function onSideButtonTap;
  final bool bubble;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        key: const ValueKey('FutureUserTileButton'),
        future: UserProtocols.fetchUser(context: context, userID: userID),
        builder: (_, AsyncSnapshot<Object> snapshot){

          final UserModel _userModel = snapshot.data;

          if (_userModel == null){
            return const SizedBox();
          }

          else {
            return UserTileButton(
              boxWidth: boxWidth,
              userModel: _userModel,
              sideButtonVerse: sideButtonVerse,
              onSideButtonTap: onSideButtonTap,
              onUserTap: onUserTap,
              bubble: bubble,
              color: color,
            );
          }

        }
    );

  }
  /// --------------------------------------------------------------------------
}
