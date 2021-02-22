import 'dart:ui';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'footer.dart';
import 'slide_headline.dart';

enum SlideMode {
  View,
  MicroView,
  Editor,
  Creation,
  Map,
  Empty,
}

class SingleSlide extends StatefulWidget {
  final double flyerZoneWidth;
  final String picture;
  final String title;
  final int shares;
  final int views;
  final int saves;
  final int slideIndex;
  final SlideMode slideMode;
  final dynamic picFile; // was of Type File
  final BoxFit boxFit;
  final TextEditingController titleController;
  final Function textFieldOnChanged;
  final Color slideColor;

  SingleSlide({
    @required this.flyerZoneWidth,
    this.picture,
    this.title,
    this.shares,
    this.views,
    this.saves,
    this.slideIndex,
    this.slideMode,
    this.picFile,
    this.boxFit = BoxFit.cover,
    this.titleController,
    this.textFieldOnChanged,
    this.slideColor,
  });

  @override
  _SingleSlideState createState() => _SingleSlideState();
}

class _SingleSlideState extends State<SingleSlide> {
  // Completer<GoogleMapController> _controller = Completer();
  // Position loadedPosition;
  // Position currentUserPosition;
  // BitmapDescriptor customMarker;
  // LatLng aMarkerLatLng;
  // var aMarker;
  // ----------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // if (widget.slideMode == SlideMode.Map)
    // {
    //   getUserLocation();
    // }
  }
  // ----------------------------------------------------------------------
  // missingFunction()async{
  //   // int markerScale = 30;
  //   final Uint8List markerIcon = await getBytesFromCanvas(100,100, 'Za7ma');
  //   customMarker = BitmapDescriptor.fromBytes(markerIcon);
  // }
  // ----------------------------------------------------------------------
  // getUserLocation () async {
  //   currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  //   missingFunction();
  //   setState(() {
  //     loadedPosition = currentUserPosition;
  //     aMarkerLatLng = LatLng(loadedPosition.latitude, loadedPosition.longitude);
  //     aMarker = someMarker(customMarker, aMarkerLatLng.latitude , aMarkerLatLng.longitude);
  //   });
  // }
  // ----------------------------------------------------------------------
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  // // ----------------------------------------------------------------------
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------------------
    double _screenWidth = superScreenWidth(context);
    // ----------------------------------------------------------------------
    bool _microMode = superFlyerMicroMode(context, widget.flyerZoneWidth);
    // ----------------------------------------------------------------------
    int _slideTitleSize =
    widget.flyerZoneWidth <= _screenWidth && widget.flyerZoneWidth > (_screenWidth*0.75) ? 4 :
    widget.flyerZoneWidth <= (_screenWidth*0.75) && widget.flyerZoneWidth > (_screenWidth*0.5) ? 3 :
        widget.flyerZoneWidth <= (_screenWidth*0.5) && widget.flyerZoneWidth > (_screenWidth*0.25) ? 2 :
        widget.flyerZoneWidth <= (_screenWidth*0.25) && widget.flyerZoneWidth > (_screenWidth*0.1) ? 1 : 0
    ;
    // ----------------------------------------------------------------------
    FlyerLink _theFlyerLink = FlyerLink(flyerLink: 'flyer @ index: ${widget.slideIndex}', description: 'flyer to be shared aho');
    // ----------------------------------------------------------------------
    bool _dontBlur =
    widget.picFile == null ||
        (widget.boxFit != BoxFit.fitWidth &&
            widget.boxFit != BoxFit.contain &&
            widget.boxFit != BoxFit.scaleDown ) ?
    true : false;
    // ----------------------------------------------------------------------

    return Container(
      width: widget.flyerZoneWidth,
      height: superFlyerZoneHeight(context, widget.flyerZoneWidth),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: superFlyerCorners(context, widget.flyerZoneWidth),
        color: widget.slideColor,
        image: widget.picture == null ||
            widget.slideMode == SlideMode.Empty ||
            objectIsURL(widget.picFile) == true ||
            objectIsURL(widget.picture) == true ?
        null : superImage(widget.picture, widget.boxFit),
      ),

      child: ClipRRect(
        borderRadius: superFlyerCorners(context, widget.flyerZoneWidth),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            // --- IMAGE FILE FULL HEIGHT
            _dontBlur || widget.slideMode == SlideMode.Empty || objectIsURL(widget.picFile) == true ? Container() :
            Image.file(
              widget.picFile,
              fit: BoxFit.fitHeight,
              width: widget.flyerZoneWidth*1.2,
              height: superFlyerZoneHeight(context, widget.flyerZoneWidth*1.2),
              // colorBlendMode: BlendMode.overlay,
              // color: Colorz.WhiteAir,
            ),

            // --- IMAGE FILE BLUR LAYER
            // objectIsURL ? are you sure,, lets see about you later
            _dontBlur || widget.slideMode == SlideMode.Empty || objectIsURL(widget.picFile) == true ? Container() :
            ClipRRect( // this ClipRRect fixed a big blur issue,, never ever  delete
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  width: widget.flyerZoneWidth,
                  height: superFlyerZoneHeight(context, widget.flyerZoneWidth),
                  color: Colorz.Nothing,
                ),
              ),
            ),

            // --- IMAGE FILE
            // objectIsURL ? are you sure,, lets see about you later
            widget.picFile == null || widget.slideMode == SlideMode.Empty || objectIsURL(widget.picFile) == true ? Container() :
                Image.file(
                    widget.picFile,
                    fit: widget.boxFit,
                    width: widget.flyerZoneWidth,
                    height: superFlyerZoneHeight(context, widget.flyerZoneWidth)
                ),

            // --- IMAGE NETWORK
            objectIsURL(widget.picFile) == false ? Container() :
            Image.network(
                widget.picFile,
                fit: BoxFit.fitWidth,
                width: widget.flyerZoneWidth,
                height: superFlyerZoneHeight(context, widget.flyerZoneWidth)
            ),

            // --- SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
            Container(
              width: widget.flyerZoneWidth,
              height: widget.flyerZoneWidth * 0.6,
              decoration: BoxDecoration(
                  borderRadius: superHeaderShadowCorners(context, widget.flyerZoneWidth),
                  gradient: superSlideGradient(),
              ),
            ),

            _microMode == true || widget.title == null ? Container() :
            SlideTitle(
              flyerZoneWidth: widget.flyerZoneWidth,
              verse: widget.title,
              verseSize: _slideTitleSize,
              verseColor: Colorz.White,
              tappingVerse: () {
                print('Flyer Title clicked');
                },
            ),

            widget.slideMode != SlideMode.Editor ? Container() :
                SuperTextField(
                  hintText: 'T i t l e',

                  width: widget.flyerZoneWidth,
                  // height: widget.flyerZoneWidth * 0.15,
                  fieldColor: Colorz.BlackSmoke,
                  margin: EdgeInsets.only(top: (widget.flyerZoneWidth * 0.3), left: 5, right: 5),
                  maxLines: 4,
                  keyboardTextInputType: TextInputType.multiline,
                  designMode: false,
                  counterIsOn: false,
                  inputSize: 3,
                  centered: true,
                  textController: widget.titleController,
                  onChanged: widget.textFieldOnChanged,
                  inputWeight: VerseWeight.bold,
                  inputShadow: true,
                ),

            widget.slideMode != SlideMode.View ? Container() :
            FlyerFooter(
              flyerZoneWidth: widget.flyerZoneWidth,
              views: widget.views,
              shares: widget.shares,
              saves: widget.saves,
              tappingShare: () {shareFlyer(context, _theFlyerLink);}, // this will user slide index
            ),

          ],
        ),
      ),
    );
  }
}
