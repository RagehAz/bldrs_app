import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:flutter/material.dart';

class UserTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserTileButton({
    @required this.userModel,
    this.height,
    this.width,
    this.color,
    this.onTap,
    this.secondLine,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final double width;
  final Color color;
  final Function onTap;
  final UserModel userModel;
  final Verse secondLine;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TileButton(
      width: width,
      height: height,
      color: color,
      onTap: onTap,
      icon: userModel?.pic,
      verse: Verse.plain(userModel?.name),
      secondLine: secondLine,
    );

  }
/// --------------------------------------------------------------------------
}
