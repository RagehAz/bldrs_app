import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:basics/components/layers/blur_layer.dart';
import 'package:flutter/material.dart';

class SlideBlurredBackgroundWidget extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SlideBlurredBackgroundWidget({
    required this.bigPic,
    this.width = 1000,
    super.key
  });
  // -----------------------------
  final MediaModel bigPic;
  final double width;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _height = FlyerDim.flyerHeightByFlyerWidth(flyerBoxWidth: width);
    // --------------------
    return SizedBox(
      width: width,
      height: _height,
      child: Stack(
        children: <Widget>[

          SuperImage(
            width: width,
            height: _height,
            pic: bigPic,
            loading: false,
          ),

          BlurLayer(
            width: width,
            height: _height,
            borders: BorderRadius.zero,
            blurIsOn: true,
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
