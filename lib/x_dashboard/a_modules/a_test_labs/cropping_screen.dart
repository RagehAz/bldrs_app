import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class CroppingScreen extends StatefulWidget {
  /// -----------------------------------------------------------------------------
  const CroppingScreen({
    @required this.files,
    @required this.filesName,
    Key key
  }) : super(key: key);
  /// -----------------------------------------------------------------------------
  final List<File> files;
  final String filesName;
  /// -----------------------------------------------------------------------------
  @override
  _CroppingScreenState createState() => _CroppingScreenState();
  /// -----------------------------------------------------------------------------
}

class _CroppingScreenState extends State<CroppingScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<List<Uint8List>> _imagesData = ValueNotifier(null);
  final ValueNotifier<int> _currentImageIndex = ValueNotifier(0);
  final List<CropController> _controllers = <CropController>[];
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
    _initializeControllers();
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _triggerLoading(setTo: true).then((_) async {
        _imagesData.value = await Floaters.getUint8ListsFromFiles(widget.files);
        await _triggerLoading(setTo: false);
      });
    }
    _isInit = false;
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _imagesData.dispose();
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _initializeControllers(){
    for (int i = 0; i < widget.files.length; i++){
      final CropController _controller = CropController();
      _controllers.add(_controller);
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _imageSpaceHeight = _screenHeight - Ratioz.stratosphere - Ratioz.horizon;

    return MainLayout(
      pageTitle: 'Cropp',
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarType: AppBarType.basic,
      // pyramidsAreOn: false,
      skyType: SkyType.black,
      onBack: () async {

        final List<File> _files = await Filers.getFilesFromUint8Lists(
          uInt8Lists: _imagesData.value,
          fileName: widget.filesName,
        );
        Nav.goBack(context, passedData: _files);

      },
      layoutWidget: ValueListenableBuilder(
        valueListenable: _imagesData,
        builder: (_, List<Uint8List> imagesData, Widget child){

          if (imagesData == null){
            return Container();
          }

          else {

            return Column(
              children: <Widget>[

                const Stratosphere(),

                ValueListenableBuilder(
                    valueListenable: _currentImageIndex,
                    builder: (_, int index, Widget child){

                      final Uint8List _imageData = imagesData[index];
                      final CropController _controller = _controllers[index];

                      return Container(
                        width: _screenWidth,
                        height: _imageSpaceHeight,
                        color: Colorz.black255,
                        child: Crop(
                          image: _imageData,
                          controller: _controller,
                          onCropped: (Uint8List image) async {

                            final File _file = await Filers.getFileFromUint8List(
                              uInt8List: image,
                              fileName: createUniqueID().toString(),
                            );

                            Nav.goBack(context, passedData: _file);

                          },
                          aspectRatio: 1,
                          // fixArea: false,
                          // withCircleUi: false,
                          // initialSize: 0.5,
                          // initialArea: Rect.fromLTWH(240, 212, 800, 600),
                          // initialAreaBuilder: (rect) => Rect.fromLTRB(
                          //     rect.left + 24, rect.top + 32, rect.right - 24, rect.bottom - 32
                          // ),
                          baseColor: Colorz.black255,
                          maskColor: Colorz.black125,
                          // radius: 0,
                          onMoved: (newRect) {
                            // do something with current cropping area.
                          },
                          onStatusChanged: (status) {
                            // do something with current CropStatus
                          },
                          cornerDotBuilder: (double size, EdgeAlignment edgeAlignment){
                            return Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colorz.black20,
                                borderRadius: superBorderAll(context, 16),
                              ),
                              child: const SuperImage(
                                width: 10,
                                height: 10,
                                pic: Iconz.plus,
                              ),
                            );
                          },
                          // interactive: false,
                          // fixArea: true,

                        ),
                      );

                    }
                ),

                Container(
                  width: _screenWidth,
                  height: Ratioz.horizon,
                  alignment: Alignment.bottomLeft,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[

                      EditorConfirmButton(
                        firstLine: 'Crop',
                        onTap: () async {

                          // _controller.crop();

                        },
                      ),

                      if (widget.files.length > 1)
                        ...List.generate(5, (index){

                          return Center(
                            child: Container(
                              width: Ratioz.horizon - 10,
                              height: Ratioz.horizon - 10,
                              margin: Scale.superInsets(context: context, enRight: 5),
                              color: Colorz.bloodTest,
                            ),
                          );

                        }),

                    ],
                  ),
                ),

              ],
            );

          }

        },
      ),
    );

  }


}
