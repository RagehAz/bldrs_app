import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class UserTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserTileButton({
    required this.userModel,
    this.height,
    this.width,
    this.color,
    this.onTap,
    this.secondLine,
    this.margins,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? height;
  final double? width;
  final Color? color;
  final Function? onTap;
  final UserModel userModel;
  final Verse? secondLine;
  final dynamic margins;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TileButton(
      width: width,
      height: height,
      color: color,
      onTap: onTap,
      icon: userModel?.picPath,
      verse: Verse.plain(userModel?.name),
      secondLine: secondLine,
      margins: margins,
    );

  }
/// --------------------------------------------------------------------------
}
