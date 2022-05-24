

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;

class UserTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserTileButton({
    @required this.userModel,
    this.boxWidth,
    this.inviteButtonIsOn = false,
    this.onInviteTap,
    this.onUserTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final double boxWidth;
  final bool inviteButtonIsOn;
  final Function onUserTap;
  final Function onInviteTap;
  /// --------------------------------------------------------------------------
  static const double boxHeight = 80;
  static const double inviteButtonWidth = 80;
  static const double boxPadding = Ratioz.appBarMargin;
  static const double buttonHeight = boxHeight - (2 * boxPadding);
  // -----------------------------------------------------------------------------
  static double getBoxWidth({
    @required BuildContext context,
    double boxWidthOverride,
  }){
    return boxWidthOverride ?? Scale.superScreenWidth(context);
  }
  // -----------------------------------------------------------------------------
  static double getUserButtonWidth({
    @required BuildContext context,
    @required bool inviteButtonIsOn,
    @required double boxWidthOverride,
  }){

    double _width;
    final double _boxWidth = getBoxWidth(
      context: context,
      boxWidthOverride: boxWidthOverride,
    );

    if (inviteButtonIsOn == true){
      _width = _boxWidth - (boxPadding * 3) - inviteButtonWidth;
    }
    else {
      _width = _boxWidth - (boxPadding * 2);

    }

    return _width;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxWidth = boxWidth ?? Scale.superScreenWidth(context);
    final double _userButtonWidth = getUserButtonWidth(
        context: context,
        inviteButtonIsOn: inviteButtonIsOn,
        boxWidthOverride: boxWidth,
    );

    return Container(
      width: _boxWidth,
      height: boxHeight,
      padding: Scale.superMargins(margins: boxPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          DreamBox(
            width: _userButtonWidth,
            height: buttonHeight,
            icon: userModel.pic,
            verse: userModel.name,
            verseCentered: false,
            secondLine: UserModel.getUserJobLine(userModel),
            secondLineScaleFactor: 1.2,
            verseScaleFactor: 0.8,
            onTap: onUserTap,
          ),

          if (inviteButtonIsOn == true)
          DreamBox(
            width: inviteButtonWidth,
            height: buttonHeight,
            verse: superPhrase(context, 'phid_invite'),
            verseScaleFactor: 0.7,
            verseMaxLines: 2,
            onTap: onInviteTap,
          ),

        ],
      ),
    );

  }
}
