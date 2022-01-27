import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/x_3_slide_full_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/single_slide_tap_area.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SingleSlideImagePart extends StatelessWidget {

  const SingleSlideImagePart({
    @required this.tinyMode,
    @required this.slideModel,
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final SlideModel slideModel;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  /// --------------------------------------------------------------------------
  Future<void> _onImageDoubleTap(BuildContext context) async {
    final bool _keyboardIsOn = Keyboarders.keyboardIsOn(context);

    if (_keyboardIsOn) {
      Keyboarders.closeKeyboard(context);
    } else {
      await Nav.goToNewScreen(
          context,
          SlideFullScreen(
            image: slideModel.pic,
            imageSize: slideModel.imageSize,
          ));
    }
  }
// -----------------------------------------------------------------------------
  /// Function(BuildContext, Widget, ImageChunkEvent
  Widget _imageLoadingBuilder(BuildContext context, Widget image, ImageChunkEvent chunkEvent){

    final double flyerWidthFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);
    final Widget _widget = FlyerLoading(
      flyerWidthFactor: flyerWidthFactor,
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
            SingleSlideTapAreas(
              key: const ValueKey<String>('SlideTapAreas'),
              flyerBoxWidth: flyerBoxWidth,
              flyerBoxHeight: flyerBoxHeight,
              onTapNext: onSlideNextTap,
              onTapBack: onSlideBackTap,
            ),

        ],
      ),
    );
  }
}
