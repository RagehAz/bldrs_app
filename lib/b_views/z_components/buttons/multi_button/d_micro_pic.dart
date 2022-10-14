import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class MicroPic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MicroPic({
    @required this.pic,
    @required this.size,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String pic;
  final double size;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox (
      width: size,
      height: size,
      icon: pic,
    );

  }
  /// --------------------------------------------------------------------------
}