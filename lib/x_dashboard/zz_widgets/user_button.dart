import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DashboardUserButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DashboardUserButton({
    @required this.width,
    @required this.userModel,
    @required this.index,
    @required this.onTap,
    this.margins,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final UserModel userModel;
  final int index;
  final Function onTap;
  final dynamic margins;
  /// --------------------------------------------------------------------------
  static const double height = 60;
  // -----------------------------------------------------------------------------
  /*
  static SuperVerse _titleVerse(String title) {
    return SuperVerse(
      verse: title,
      size: 0,
      color: Colorz.grey80,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: width,
      icon: userModel.pic,
      color: Colorz.white20,
      verse: Verse.plain(userModel.name),
      secondLine: Verse.plain('$index : ${userModel.id}'),
      verseScaleFactor: 0.6,
      verseCentered: false,
      secondLineScaleFactor: 0.9,
      margins: Scale.superMargins(margins: margins),
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
