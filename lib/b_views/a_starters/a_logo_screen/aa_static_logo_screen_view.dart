import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/z_components/texting/customs/leading_verse.dart';
import 'package:flutter/material.dart';

class LogoScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LogoScreenView({
    this.scaleController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Animation<double>? scaleController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _shortest = Scale.screenShortestSide(context);
    final double _logoWidth = _shortest * 0.5;

    return SizedBox(
      width: Scale.screenWidth(context),
      height: Scale.screenHeight(context),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Opacity(
                opacity: 0,
                child: SizedBox(
                  width: _logoWidth,
                  child: const LoadingVerse(
                    verseColor: Colorz.nothing,
                  ),
                ),
              ),

              if (scaleController != null)
                ScaleTransition(
                  scale: scaleController!,
                  child: const LogoSlogan(
                    showTagLine: true,
                    showSlogan: true,
                  ),
                ),

              if (scaleController == null)
                const LogoSlogan(
                  showTagLine: true,
                  showSlogan: true,
                ),

              SizedBox(
                width: _logoWidth,
                child: const LoadingVerse(),
              ),

            ],
      ),
    );
  }
// -----------------------------------------------------------------------------
}
