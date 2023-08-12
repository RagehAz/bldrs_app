import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';

class MicroPic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MicroPic({
    required this.pic,
    required this.size,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String pic;
  final double size;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox (
      width: size,
      height: size,
      icon: pic,
    );

  }
  /// --------------------------------------------------------------------------
}
