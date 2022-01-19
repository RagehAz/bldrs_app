import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/widgets/general/images/super_image.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/slide_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/x_3_slide_full_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field.dart';
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
    @required this.superFlyer,
    @required this.slideIndex,
    @required this.slideColor,
    @required this.flyerID,
    @required this.imageSize,
    @required this.onTap,
    this.picture,
    this.headline,
    this.shares = 0,
    this.views = 0,
    this.saves = 0,
    this.boxFit = BoxFit.cover,
    this.titleController,
    this.textFieldOnChanged,
    this.onTextFieldSubmitted,
    this.autoFocus,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final dynamic picture;
  final String headline;
  final int shares;
  final int views;
  final int saves;
  final int slideIndex;
  final BoxFit boxFit;
  final TextEditingController titleController;
  final ValueChanged<String> textFieldOnChanged;
  final ValueChanged<String> onTextFieldSubmitted;
  final Color slideColor;
  final String flyerID;
  final ImageSize imageSize;
  final bool autoFocus;
  final Function onTap;
  final SuperFlyer superFlyer;

  /// --------------------------------------------------------------------------
  void _onBehindSlideImageTap(BuildContext context, bool tinyMode) {
    if (tinyMode == true) {
      blog('tapping slide behind image while tinyMode is $tinyMode');
      superFlyer.nav.onTinyFlyerTap();
    } else {
      blog('tapping slide behind image while tinyMode is $tinyMode');
    }
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
            image: picture,
            imageSize: imageSize,
          ));
    }
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // blog('single slide title is : $title and controller is : ${titleController?.text}');
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
// -----------------------------------------------------------------------------
    final bool _tinyMode = OldFlyerBox.isTinyMode(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    final int _slideTitleSize =
        flyerBoxWidth <= _screenWidth && flyerBoxWidth > (_screenWidth * 0.75)
            ? 4
            : flyerBoxWidth <= (_screenWidth * 0.75) &&
                    flyerBoxWidth > (_screenWidth * 0.5)
                ? 3
                : flyerBoxWidth <= (_screenWidth * 0.5) &&
                        flyerBoxWidth > (_screenWidth * 0.25)
                    ? 2
                    : flyerBoxWidth <= (_screenWidth * 0.25) &&
                            flyerBoxWidth > (_screenWidth * 0.1)
                        ? 1
                        : 0;
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
    final String _titleVerse = headline ?? titleController?.text;
// -----------------------------------------------------------------------------
    final DecorationImage _slidePic = picture == null ||
            ObjectChecker.objectIsURL(picture) == true ||
            ObjectChecker.objectIsFile(picture) == true
        ? null
        : SuperImage.decorationImage(
            picture: picture,
            boxFit: boxFit,
          );
// -----------------------------------------------------------------------------

    final double _flyerZoneHeight = OldFlyerBox.height(context, flyerBoxWidth);

    return GestureDetector(
      onTap: () => _onBehindSlideImageTap(context,
          _tinyMode), // listening to taps from inside the zoomable pic widget
      onTapCancel: () => _onSingleSlideTapCancel(context),
      onDoubleTap: _tinyMode == true ? null : () => _onImageDoubleTap(context),

      child: Container(
        width: flyerBoxWidth,
        height: OldFlyerBox.height(context, flyerBoxWidth),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: FlyerBox.corners(context, flyerBoxWidth),
          color: slideColor,
          image: _slidePic,
        ),
        child: ClipRRect(
          borderRadius: FlyerBox.corners(context, flyerBoxWidth),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              // /// --- IMAGE FILE FULL HEIGHT
              // if (ObjectChecker.objectIsFile(picture) && _blurLayerIsActive)
              //   Image.file(
              //     picture,
              //     fit: BoxFit.cover,
              //     width: flyerBoxWidth * _blurImageScale,
              //     height: Scale.superFlyerZoneHeight(context, flyerBoxWidth*1.2),
              //     // colorBlendMode: BlendMode.overlay,
              //     // color: Colorz.WhiteAir,
              //   ),
              //
              // /// --- IMAGE URL FULL HEIGHT
              // if (ObjectChecker.objectIsURL(picture) && _blurLayerIsActive)
              //   Image.network(
              //     picture,
              //     fit: BoxFit.cover,
              //     width: flyerBoxWidth * _blurImageScale,
              //     height: Scale.superFlyerZoneHeight(context, flyerBoxWidth*1.2),
              //   ),

              // /// --- IMAGE FILE BLUR LAYER
              // if (_blurLayerIsActive)
              // BlurLayer(
              //   width: flyerBoxWidth,
              //   height: Scale.superFlyerZoneHeight(context, flyerBoxWidth),
              //   blur: Ratioz.blur4,
              //   borders: Borderers.superFlyerCorners(context, flyerBoxWidth),
              //   color: Colorz.Nothing,
              //   blurIsOn: _blurLayerIsActive,
              // ),

              // FutureBuilder(
              //     future: _getAverageColor(),
              //     builder: (_, snapshot){
              //
              //       Color _color = snapshot.data;
              //
              //       if(connectionIsWaiting(snapshot) == true){
              //         return Container();
              //       } else {
              //         return
              //           BlurLayer(
              //             width: flyerBoxWidth,
              //             height: Scale.superFlyerZoneHeight(context, flyerBoxWidth),
              //             blur: 0,
              //             borders: Borderers.superFlyerCorners(context, flyerBoxWidth),
              //             color: _color,
              //             blurIsOn: _blurLayerIsActive,
              //           );
              //       }
              //     }
              //     ),

              /// --- IMAGE FILE
              if (ObjectChecker.objectIsFile(picture))
                ZoomablePicture(
                  isOn: !_tinyMode,
                  onTap: onTap,
                  child: Image.file(
                    picture,
                    fit: boxFit,
                    width: flyerBoxWidth,
                    height: OldFlyerBox.height(context, flyerBoxWidth),
                  ),
                ),

              /// --- IMAGE NETWORK
              if (ObjectChecker.objectIsURL(picture))
                ZoomablePicture(
                  isOn: !_tinyMode,
                  onTap: onTap,
                  child: Image.network(
                    picture,
                    fit: BoxFit.fitWidth,
                    width: flyerBoxWidth,
                    height: _flyerZoneHeight,
                  ),
                ),

              /// --- SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
              Container(
                width: flyerBoxWidth,
                height: flyerBoxWidth * 0.6,
                decoration: BoxDecoration(
                  borderRadius: Borderers.superHeaderShadowCorners(
                      context, flyerBoxWidth),
                  gradient: Colorizer.superSlideGradient(),

                  /// TASK : can optimize this by adding svg instead
                ),
              ),

              if (superFlyer.edit.editMode ==
                  false) //&& title != null && title != '')
                SlideHeadline(
                  flyerBoxWidth: flyerBoxWidth,
                  verse: _titleVerse,
                  verseSize: _slideTitleSize,
                  verseColor: Colorz.white255,
                  tappingVerse: () {
                    blog('Flyer Title clicked');
                  },
                ),

              if (superFlyer.edit.editMode == true)
                SuperTextField(
                  key: ValueKey<String>('slide$slideIndex'),
                  hintText: 'T i t l e',
                  width: flyerBoxWidth,
                  // height: flyerBoxWidth * 0.15,
                  fieldColor: Colorz.black80,
                  margin: EdgeInsets.only(
                      top: flyerBoxWidth * 0.3, left: 5, right: 5),
                  maxLines: 4,
                  counterIsOn: false,
                  inputSize: 3,
                  centered: true,
                  textController:
                      superFlyer.mSlides[slideIndex].headlineController,
                  onChanged: textFieldOnChanged,
                  inputWeight: VerseWeight.bold,
                  inputShadow: true,
                  autofocus: autoFocus,
                  // fieldIsFormField: true,
                  onSubmitted: onTextFieldSubmitted,
                  keyboardTextInputAction: TextInputAction.done,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
