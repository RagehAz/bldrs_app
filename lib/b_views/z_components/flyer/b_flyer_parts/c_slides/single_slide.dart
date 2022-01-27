import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/widgets/general/images/super_image.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/slide_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/x_3_slide_full_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SingleSlide extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SingleSlide({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.slideModel,
    @required this.tinyMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final SlideModel slideModel;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  void _onBehindSlideImageTap(BuildContext context) {

      blog('tapping slide behind image while tinyMode is $tinyMode');

    // if (tinyMode == true) {
    //   // superFlyer.nav.onTinyFlyerTap();
    // }
    //
    // else {
    //   blog('tapping slide behind image while tinyMode is $tinyMode');
    // }

  }
// -----------------------------------------------------------------------------
  void _onSingleSlideTapCancel(BuildContext context) {
    blog('tap cancel single slide');

    if (Keyboarders.keyboardIsOn(context)) {
      Keyboarders.minimizeKeyboardOnTapOutSide(context);
    }
  }
// -----------------------------------------------------------------------------
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
  bool _canTapSlide(){
    bool _canTap = false;

    if (tinyMode == false){
      _canTap = true;
    }

    return _canTap;
  }

  int _getSlideTitleSize(BuildContext context){
    final double _screenWidth = Scale.superScreenWidth(context);

    final int _slideTitleSize = flyerBoxWidth <= _screenWidth && flyerBoxWidth > (_screenWidth * 0.75) ? 4
        :
    flyerBoxWidth <= (_screenWidth * 0.75) && flyerBoxWidth > (_screenWidth * 0.5) ? 3
        :
    flyerBoxWidth <= (_screenWidth * 0.5) && flyerBoxWidth > (_screenWidth * 0.25) ? 2
        :
    flyerBoxWidth <= (_screenWidth * 0.25) && flyerBoxWidth > (_screenWidth * 0.1) ? 1
        :
    0;

    return _slideTitleSize;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    blog('single slide title is : ${slideModel?.headline} and tinyMode is : ${tinyMode}');
// -----------------------------------------------------------------------------
    final int _slideTitleSize = _getSlideTitleSize(context);
// -----------------------------------------------------------------------------
//     double _blurImageScale = 1.5;
    // -----------------------------o
    // bool _blurLayerIsActive = true;
    // Imagers().slideBlurIsOn(
    //   pic: picture,
    //   boxFit: boxFit,
    //   flyerBoxWidth: flyerBoxWidth,
    //   imageSize: imageSize,
    // );
// -----------------------------------------------------------------------------
//     final String _titleVerse = slideModel.headline;
// -----------------------------------------------------------------------------
//     final DecorationImage _slidePic = picture == null ||
//         ObjectChecker.objectIsURL(picture) == true ||
//         ObjectChecker.objectIsFile(picture) == true
//         ?
//     null
//         :
//     SuperImage.decorationImage(
//       picture: picture,
//       boxFit: boxFit,
//     );
// -----------------------------------------------------------------------------

    return AbsorbPointer(
      absorbing: !_canTapSlide(),
      child: Container(
        width: flyerBoxWidth,
        height: flyerBoxHeight,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: FlyerBox.corners(context, flyerBoxWidth),
          color: slideModel.midColor,
          // image: slideModel.pic,
        ),
        child: ClipRRect(
          borderRadius: FlyerBox.corners(context, flyerBoxWidth),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

              /// --- IMAGE NETWORK
              if (ObjectChecker.objectIsURL(slideModel.pic))
                ZoomablePicture(
                  isOn: !tinyMode,
                  // onTap: (){blog('image of single slide is tapped');},
                  child: Image.network(
                    slideModel.pic,
                    fit: slideModel.picFit,
                    width: flyerBoxWidth,
                    height: flyerBoxHeight,
                  ),
                ),

              /// --- SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
              Container(
                width: flyerBoxWidth,
                height: flyerBoxWidth * 0.6,
                decoration: BoxDecoration(
                  borderRadius: Borderers.superHeaderShadowCorners(context, flyerBoxWidth),
                  gradient: Colorizer.superSlideGradient(),

                  /// TASK : can optimize this by adding svg instead
                ),
              ),

                SlideHeadline(
                  flyerBoxWidth: flyerBoxWidth,
                  verse: slideModel.headline,
                  verseSize: _slideTitleSize,
                  verseColor: Colorz.white255,
                  tappingVerse: () {
                    blog('Flyer Title clicked');
                  },
                ),

            ],
          ),
        ),
      ),
    );

  }
}
