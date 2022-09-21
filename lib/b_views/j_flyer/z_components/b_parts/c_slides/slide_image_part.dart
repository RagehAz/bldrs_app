import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/zoomable_pic.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/slide_tap_area.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SlideImagePart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideImagePart({
    @required this.tinyMode,
    @required this.slideModel,
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    @required this.onDoubleTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final SlideModel slideModel;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
  /// --------------------------------------------------------------------------
  // Future<void> _onImageDoubleTap(BuildContext context) async {
  //   final bool _keyboardIsOn = Keyboarders.keyboardIsOn(context);
  //
  //   if (_keyboardIsOn) {
  //     Keyboarders.closeKeyboard(context);
  //   } else {
  //     await Nav.goToNewScreen(
  //         context,
  //         SlideFullScreen(
  //           image: slideModel.pic,
  //           imageSize: slideModel.imageSize,
  //         ));
  //   }
  // }
// -----------------------------------------------------------------------------
  /// Function(BuildContext, Widget, ImageChunkEvent
  Widget _imageLoadingBuilder(BuildContext context, Widget image, ImageChunkEvent chunkEvent){

    final Widget _widget = FlyerLoading(
      flyerBoxWidth: flyerBoxWidth,
      loadingColor: Colorz.white30,
      boxColor: Colorz.nothing,
    );

    bool _isLoading = true;

    if (chunkEvent?.cumulativeBytesLoaded == chunkEvent?.expectedTotalBytes){
      _isLoading = false;
    }

    return _isLoading ? _widget : image;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ZoomablePicture(
      isOn: !tinyMode,
      // onTap: (){blog('image of single slide is tapped');},
      child: Stack(
        children: <Widget>[

          /// IMAGE
          Image.network(
            slideModel.pic,
            fit: slideModel.picFit,
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            loadingBuilder: _imageLoadingBuilder,
          ),

          /// TAP AREAS
          if (tinyMode == false)
            SlideTapAreas(
              key: const ValueKey<String>('SlideTapAreas'),
              flyerBoxWidth: flyerBoxWidth,
              flyerBoxHeight: flyerBoxHeight,
              onTapNext: onSlideNextTap,
              onTapBack: onSlideBackTap,
              onDoubleTap: onDoubleTap,
            ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
