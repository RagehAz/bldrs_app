import 'dart:ui';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/helpers/image_size.dart';
import 'package:bldrs/views/screens/i_flyer/x_3_slide_full_screen.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/slide_headline.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';

class SingleSlide extends StatelessWidget {
  final double flyerBoxWidth;
  final dynamic picture;
  final String headline;
  final int shares;
  final int views;
  final int saves;
  final int slideIndex;
  final BoxFit boxFit;
  final TextEditingController titleController;
  final Function textFieldOnChanged;
  final Function onTextFieldSubmitted;
  final Color slideColor;
  final String flyerID;
  final ImageSize imageSize;
  final bool autoFocus;
  final Function onTap;
  final SuperFlyer superFlyer;

  SingleSlide({

    @required this.flyerBoxWidth,
    @required this.superFlyer,
    @required this.slideIndex,
    this.picture,
    this.headline,
    this.shares = 0,
    this.views = 0,
    this.saves = 0,
    this.boxFit = BoxFit.cover,
    this.titleController,
    this.textFieldOnChanged,
    this.onTextFieldSubmitted,
    @required this.slideColor,
    @required this.flyerID,
    @required this.imageSize,
    this.autoFocus,
    @required this.onTap,
  });
// -----------------------------------------------------------------------------
  void _onBehindSlideImageTap(BuildContext context, bool tinyMode){

    if (tinyMode == true){
    print('tapping slide behind image while tinyMode is $tinyMode');
    superFlyer.nav.onTinyFlyerTap();
    }

    else {
      print('tapping slide behind image while tinyMode is $tinyMode');

    }

  }
// -----------------------------------------------------------------------------
  void _onSingleSlideTapCancel(BuildContext context){
      print('tap cancel single slide');

      if (Keyboarders.keyboardIsOn(context)){
        Keyboarders.minimizeKeyboardOnTapOutSide(context);
      }

  }
// -----------------------------------------------------------------------------
  Future<void> _onImageDoubleTap(BuildContext context) async {

    bool _keyboardIsOn = Keyboarders.keyboardIsOn(context);

    if (_keyboardIsOn){
      Keyboarders.closeKeyboard(context);
    }
    else {
      await Nav.goToNewScreen(context,
          SlideFullScreen(
            image: picture,
            imageSize: imageSize,
          )
      );
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // print('single slide title is : $title and controller is : ${titleController?.text}');
// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
// -----------------------------------------------------------------------------
    bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    int _slideTitleSize =
    flyerBoxWidth <= _screenWidth && flyerBoxWidth > (_screenWidth*0.75) ? 4 :
    flyerBoxWidth <= (_screenWidth*0.75) && flyerBoxWidth > (_screenWidth*0.5) ? 3 :
        flyerBoxWidth <= (_screenWidth*0.5) && flyerBoxWidth > (_screenWidth*0.25) ? 2 :
        flyerBoxWidth <= (_screenWidth*0.25) && flyerBoxWidth > (_screenWidth*0.1) ? 1 : 0
    ;
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
    String _titleVerse = headline != null ? headline :
        titleController != null ? titleController.text : null;
// -----------------------------------------------------------------------------
    dynamic _slidePic =
    picture == null || ObjectChecker.objectIsURL(picture) == true || ObjectChecker.objectIsFile(picture) == true ?
    null
        :
    Imagers.superImage(picture, boxFit);
// -----------------------------------------------------------------------------

    double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);

    return GestureDetector(
      onTap: () => _onBehindSlideImageTap(context, _tinyMode), // listening to taps from inside the zoomable pic widget
      onTapCancel: () => _onSingleSlideTapCancel(context),
      onDoubleTap: _tinyMode == true ? null : () => _onImageDoubleTap(context),

      child: Container(
        width: flyerBoxWidth,
        height: FlyerBox.height(context, flyerBoxWidth),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: Borderers.superFlyerCorners(context, flyerBoxWidth),
          color: slideColor,
          image: _slidePic,
        ),

        child: ClipRRect(
          borderRadius: Borderers.superFlyerCorners(context, flyerBoxWidth),

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
                      height: FlyerBox.height(context, flyerBoxWidth),
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
                    borderRadius: Borderers.superHeaderShadowCorners(context, flyerBoxWidth),
                    gradient: Colorizer.superSlideGradient(), /// TASK : can optimize this by adding svg instead
                ),
              ),

              if (superFlyer.edit.editMode == false) //&& title != null && title != '')
                SlideHeadline(
                  flyerBoxWidth: flyerBoxWidth,
                  verse: _titleVerse,
                  verseSize: _slideTitleSize,
                  verseColor: Colorz.White255,
                  tappingVerse: () {
                    print('Flyer Title clicked');
                    },
                ),

              if (superFlyer.edit.editMode == true)
                SuperTextField(
                  key: ValueKey('slide${slideIndex}'),
                  hintText: 'T i t l e',
                  width: flyerBoxWidth,
                  // height: flyerBoxWidth * 0.15,
                  fieldColor: Colorz.Black80,
                  margin: EdgeInsets.only(top: (flyerBoxWidth * 0.3), left: 5, right: 5),
                  maxLines: 4,
                  keyboardTextInputType: TextInputType.text,
                  designMode: false,
                  counterIsOn: false,
                  inputSize: 3,
                  centered: true,
                  textController: superFlyer.mSlides[slideIndex].headlineController,
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
