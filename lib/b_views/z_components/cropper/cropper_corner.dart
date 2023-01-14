import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class CropperCorner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CropperCorner({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colorz.black20,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: const BldrsImage(
        width: 10,
        height: 10,
        pic: Iconz.plus,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
