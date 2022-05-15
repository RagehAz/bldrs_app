import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DashboardUserButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DashboardUserButton({
    @required this.width,
    @required this.userModel,
    @required this.index,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double width;
  final UserModel userModel;
  final int index;
  final Function onTap;

  /// --------------------------------------------------------------------------
  static double height() {
    return 60;
  }

// -----------------------------------------------------------------------------
  static SuperVerse _titleVerse(String title) {
    return SuperVerse(
      verse: title,
      size: 0,
      color: Colorz.grey80,
    );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return DreamBox(
      height: height(),
      width: width,
      icon: userModel.pic,
      color: Colorz.white20,
      verse: userModel.name,
      secondLine: '$index : ${userModel.id}',
      verseScaleFactor: 0.6,
      verseCentered: false,
      secondLineScaleFactor: 0.9,
      margins: const EdgeInsets.symmetric(vertical: 5),
      onTap: onTap,
    );
  }
}
