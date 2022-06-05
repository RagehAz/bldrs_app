import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class NanoBzLogo extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NanoBzLogo({
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: NavBar.circleWidth * 0.47,
      width: NavBar.circleWidth * 0.47,
      child: DreamBox(
        height: NavBar.circleWidth * 0.47,
        width: NavBar.circleWidth * 0.47,
        corners: NavBar.circleWidth * 0.47 * 0.25,
        icon: bzModel.logo,
      ),
    );

  }
}
