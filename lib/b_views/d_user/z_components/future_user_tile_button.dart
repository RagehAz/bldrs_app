import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/user_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

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
