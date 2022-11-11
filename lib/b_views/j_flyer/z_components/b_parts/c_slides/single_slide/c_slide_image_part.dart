import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/cc_slide_tap_area.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/images/cc_zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
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
  // --------------------------------------------------------------------------
  ///DEPRECATED
  /*
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
   */
  // -----------------------------------------------------------------------------
  ///DEPRECATED
  /*
  /// Function(BuildContext, Widget, ImageChunkEvent
  Widget _imageLoadingBuilder(BuildContext context, Widget image, ImageChunkEvent chunkEvent){

    final Widget _widget = FlyerLoading(
      flyerBoxWidth: flyerBoxWidth,
      loadingColor: Colorz.white30,
      boxColor: Colorz.nothing,
      animate: true,
    );

    bool _isLoading = true;

    if (chunkEvent?.cumulativeBytesLoaded == chunkEvent?.expectedTotalBytes){
      _isLoading = false;
    }

    return _isLoading ? _widget : image;
  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('SlideImagePart : slideModel.pic : ${slideModel.pic}');

    return ZoomablePicture(
      isOn: !tinyMode,
      // onTap: (){blog('image of single slide is tapped');},
      child: Stack(
        children: <Widget>[

          /// IMAGE
          if (slideModel.uiImage != null)
          SuperImage(
            pic: slideModel.uiImage ?? slideModel.picPath,
            fit: slideModel.picFit,
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            // loadingBuilder: _imageLoadingBuilder,
            backgroundColor: slideModel.midColor,
            // loading: ,
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
