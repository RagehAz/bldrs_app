import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/a_tile_button.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
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
    this.loading = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? height;
  final double? width;
  final Color? color;
  final Function? onTap;
  final UserModel? userModel;
  final Verse? secondLine;
  final dynamic margins;
  final bool loading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TileButton(
      width: width,
      height: height,
      color: color,
      onTap: onTap,
      loading: loading,
      icon: userModel?.picPath,
      verse: Verse.plain(userModel?.name),
      secondLine: secondLine,
      margins: margins,
    );

  }
/// --------------------------------------------------------------------------
}
