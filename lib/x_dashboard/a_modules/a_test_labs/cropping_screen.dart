import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class CroppingScreen extends StatefulWidget {
  /// -----------------------------------------------------------------------------
  const CroppingScreen({
    @required this.imageData,
    Key key
  }) : super(key: key);
  /// -----------------------------------------------------------------------------
  final Uint8List imageData;
  /// -----------------------------------------------------------------------------
  @override
  _CroppingScreenState createState() => _CroppingScreenState();
  /// -----------------------------------------------------------------------------
}

class _CroppingScreenState extends State<CroppingScreen> {
// -----------------------------------------------------------------------------
//   Uint8List _imageData;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading({bool setTo}) async {

    if (setTo != null){
      _loading.value = setTo;
    }
    else {
      _loading.value = !_loading.value;
    }

    if (_loading.value == true) {
      blog('GallerySlide : LOADING --------------------------------------');
    } else {
      blog('GallerySlide : LOADING COMPLETE -----------------------------');
    }

  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _triggerLoading().then((_) async {
        // _imageData = await Floaters.getUint8ListFromFile(widget.file);
      });
    }
    _isInit = false;
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }
// -----------------------------------------------------------------------------
  final CropController _controller = CropController();
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    final double _imageSpaceHeight = _screenHeight - Ratioz.stratosphere;

    return MainLayout(
      pageTitle: 'Crop',
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          SizedBox(
            width: _screenWidth,
            height: _imageSpaceHeight,
            child: Crop(
              image: widget.imageData,
              controller: _controller,
              onCropped: (Uint8List image) async {

                final File _file = await Filers.getFileFromUint8List(
                  uInt8List: image,
                  fileName: createUniqueID().toString(),
                );

                Nav.goBack(context, passedData: _file);

              },
              aspectRatio: 1,
              // initialSize: 0.5,
              // initialArea: Rect.fromLTWH(240, 212, 800, 600),
              initialAreaBuilder: (rect) => Rect.fromLTRB(
                  rect.left + 24, rect.top + 32, rect.right - 24, rect.bottom - 32
              ),
              // withCircleUi: true,
              baseColor: Colors.blue.shade900,
              maskColor: Colors.white.withAlpha(100),
              radius: 20,
              onMoved: (newRect) {
                // do something with current cropping area.
              },
              onStatusChanged: (status) {
                // do something with current CropStatus
              },
              cornerDotBuilder: (size, edgeAlignment) => const DotControl(color: Colors.blue),
              interactive: true,
              // fixArea: true,

            ),
          ),

        ],
      ),
    );

  }


}
