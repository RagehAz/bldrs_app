import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:flutter/material.dart';

class LogoScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LogoScreenView({
    @required this.scaleController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Animation<double> scaleController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: scaleController,
        child: const LogoSlogan(
          showTagLine: true,
          showSlogan: true,
          sizeFactor: 0.8,
        ),
      ),
    );
  }

}
