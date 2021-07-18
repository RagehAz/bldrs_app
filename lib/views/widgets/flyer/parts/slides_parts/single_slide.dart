import 'dart:ui';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/record_ops.dart';
import 'package:bldrs/models/records/share_model.dart';
import 'package:bldrs/views/screens/x3_slide_full_screen.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/slide_headline.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';

enum SlideMode {
  View, // when viewing a slide as default
  MicroView, // when viewing slide in flyer micro mode
  Editor, // while editing or creating the flyer
  Map, // when the slide is a map slide
  Empty, // while editing the flyer and before picking slide content
}

class SingleSlide extends StatelessWidget {
  final double flyerZoneWidth;
  final dynamic picture;
  final String title;
  final int shares;
  final int views;
  final int saves;
  final int slideIndex;
  final SlideMode slideMode;
  final BoxFit boxFit;
  final TextEditingController titleController;
  final Function textFieldOnChanged;
  final Function onTextFieldSubmitted;
  final Color slideColor;
  final String flyerID;
  final ImageSize imageSize;
  final bool autoFocus;
  // Key key;

  SingleSlide({
    @required this.flyerZoneWidth,
    this.picture,
    this.title,
    this.shares = 0,
    this.views = 0,
    this.saves = 0,
    this.slideIndex,
    this.slideMode,
    this.boxFit = BoxFit.cover,
    this.titleController,
    this.textFieldOnChanged,
    this.onTextFieldSubmitted,
    this.slideColor,
    @required this.flyerID,
    this.imageSize,
    this.autoFocus,
    Key key,
  }) : super(key: key);
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
          )
      );
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
// -----------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, flyerZoneWidth);
// -----------------------------------------------------------------------------
    int _slideTitleSize =
    flyerZoneWidth <= _screenWidth && flyerZoneWidth > (_screenWidth*0.75) ? 4 :
    flyerZoneWidth <= (_screenWidth*0.75) && flyerZoneWidth > (_screenWidth*0.5) ? 3 :
        flyerZoneWidth <= (_screenWidth*0.5) && flyerZoneWidth > (_screenWidth*0.25) ? 2 :
        flyerZoneWidth <= (_screenWidth*0.25) && flyerZoneWidth > (_screenWidth*0.1) ? 1 : 0
    ;
// -----------------------------------------------------------------------------
    LinkModel _theFlyerLink = LinkModel(url: 'flyer @ index: ${slideIndex}', description: 'flyer to be shared aho');
// -----------------------------------------------------------------------------
    // int _imageWidth = getImageWidth();
    Future<void> _shareFlyer() async {
      await RecordOps.shareFlyerOPs(
        context: context,
        flyerID: flyerID,
        userID: superUserID(),
        slideIndex: slideIndex,
      );
      await ShareModel.shareFlyer(context, _theFlyerLink);
    }
// -----------------------------------------------------------------------------
    double _blurImageScale = 1.5;
    bool _blurLayerIsActive = Imagers().slideBlurIsOn(
      pic: picture,
      boxFit: boxFit,
      flyerZoneWidth: flyerZoneWidth,
      imageSize: imageSize,
    );
// -----------------------------------------------------------------------------
    return GestureDetector(
      onTap: (){},
      onDoubleTap: _microMode == true ? null : () => _onImageDoubleTap(context),
      child: Container(
        width: flyerZoneWidth,
        height: Scale.superFlyerZoneHeight(context, flyerZoneWidth),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: Borderers.superFlyerCorners(context, flyerZoneWidth),
          color: slideColor,
          image: picture == null ||
              slideMode == SlideMode.Empty ||
              ObjectChecker.objectIsURL(picture) == true ||
              ObjectChecker.objectIsFile(picture) == true ?
          null : Imagers.superImage(picture, boxFit),
        ),
        child: ClipRRect(
          borderRadius: Borderers.superFlyerCorners(context, flyerZoneWidth),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

              /// --- IMAGE FILE FULL HEIGHT
              if (ObjectChecker.objectIsFile(picture) && _blurLayerIsActive)
                Image.file(
                  picture,
                  fit: BoxFit.cover,
                  width: flyerZoneWidth * _blurImageScale,
                  height: Scale.superFlyerZoneHeight(context, flyerZoneWidth*1.2),
                  // colorBlendMode: BlendMode.overlay,
                  // color: Colorz.WhiteAir,
                ),

              /// --- IMAGE URL FULL HEIGHT
              if (ObjectChecker.objectIsURL(picture) && _blurLayerIsActive)
                Image.network(
                  picture,
                  fit: BoxFit.cover,
                  width: flyerZoneWidth * _blurImageScale,
                  height: Scale.superFlyerZoneHeight(context, flyerZoneWidth*1.2),
                ),

              /// --- IMAGE FILE BLUR LAYER
              if (_blurLayerIsActive)
                BlurLayer(
                  width: flyerZoneWidth,
                  height: Scale.superFlyerZoneHeight(context, flyerZoneWidth),
                  blur: Ratioz.blur4,
                  borders: Borderers.superFlyerCorners(context, flyerZoneWidth),
                  color: Colorz.Nothing,
                  blurIsOn: _blurLayerIsActive,
                ),


              if (picture == null || slideMode == SlideMode.Empty)
                Container(),

              /// --- IMAGE FILE
              if (ObjectChecker.objectIsFile(picture))
                ZoomablePicture(
                  isOn: !_microMode,
                  child: Image.file(
                      picture,
                      fit: boxFit,
                      width: flyerZoneWidth,
                      height: Scale.superFlyerZoneHeight(context, flyerZoneWidth)
                  ),
                ),

              /// --- IMAGE NETWORK
              if (ObjectChecker.objectIsURL(picture))
                ZoomablePicture(
                  isOn: !_microMode,
                  child: Image.network(
                      picture,
                      fit: BoxFit.fitWidth,
                      width: flyerZoneWidth,
                      height: Scale.superFlyerZoneHeight(context, flyerZoneWidth)
                  ),
                ),

              /// --- SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
              Container(
                width: flyerZoneWidth,
                height: flyerZoneWidth * 0.6,
                decoration: BoxDecoration(
                    borderRadius: Borderers.superHeaderShadowCorners(context, flyerZoneWidth),
                    gradient: Colorizer.superSlideGradient(),
                ),
              ),

              if (_microMode == false && title != null && title != '')
              SlideTitle(
                flyerZoneWidth: flyerZoneWidth,
                verse: title,
                verseSize: _slideTitleSize,
                verseColor: Colorz.White255,
                tappingVerse: () {
                  print('Flyer Title clicked');
                  },
              ),

              if (slideMode == SlideMode.Editor)
                  SuperTextField(
                    hintText: 'T i t l e',
                    width: flyerZoneWidth,
                    // height: flyerZoneWidth * 0.15,
                    fieldColor: Colorz.Black80,
                    margin: EdgeInsets.only(top: (flyerZoneWidth * 0.3), left: 5, right: 5),
                    maxLines: 4,
                    keyboardTextInputType: TextInputType.text,
                    designMode: false,
                    counterIsOn: false,
                    inputSize: 3,
                    centered: true,
                    textController: titleController,
                    onChanged: textFieldOnChanged,
                    inputWeight: VerseWeight.bold,
                    inputShadow: true,
                    autofocus: autoFocus,
                    // fieldIsFormField: true,
                    onSubmitted: onTextFieldSubmitted,
                    keyboardTextInputAction: TextInputAction.done,
                  ),

              slideMode != SlideMode.View ? Container() :
              FlyerFooter(
                flyerZoneWidth: flyerZoneWidth,
                views: views,
                shares: shares,
                saves: saves,
                onShareTap: _shareFlyer, // this will user slide index
                onCountersTap: (){},
              ),

            ],
          ),

        ),
      ),
    );

  }
}
