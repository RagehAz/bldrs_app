import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/user_tile_button.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

class FutureUserTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FutureUserTileButton({
    required this.boxWidth,
    required this.userID,
    this.sideButtonVerse,
    this.onSideButtonTap,
    this.onUserTap,
    this.bubble = true,
    this.color,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String userID;
  final double boxWidth;
  final Verse? sideButtonVerse;
  final Function? onUserTap;
  final Function? onSideButtonTap;
  final bool bubble;
  final Color? color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<UserModel?>(
        key: const ValueKey('FutureUserTileButton'),
        future: UserProtocols.fetch(userID: userID),
        builder: (_, AsyncSnapshot<UserModel?> snapshot){

          final UserModel? _userModel = snapshot.data;

          if (_userModel == null){
            return const SizedBox();
          }

          else {
            return UserTileButtonOld(
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
