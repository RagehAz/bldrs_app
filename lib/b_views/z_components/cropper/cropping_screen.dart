import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/b_views/z_components/cropper/cropper_footer.dart';
import 'package:bldrs/b_views/z_components/cropper/cropper_pages.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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
    @required this.files,
    @required this.filesName,
    this.aspectRatio = 1,
    Key key
  }) : super(key: key);
  /// -----------------------------------------------------------------------------
  final List<File> files;
  final String filesName;
  final double aspectRatio;
  /// -----------------------------------------------------------------------------
  @override
  _CroppingScreenState createState() => _CroppingScreenState();
  /// -----------------------------------------------------------------------------
  static double getFooterHeight(){
    return Ratioz.horizon;
  }
// -----------------------------------------------------------------------------
  static double getImagesZoneHeight({
  @required double screenHeight,
}){
    final double _imagesFooterHeight = CroppingScreen.getFooterHeight();
    final double _imageSpaceHeight = screenHeight - Ratioz.stratosphere - _imagesFooterHeight;
    return _imageSpaceHeight;
  }
// -----------------------------------------------------------------------------

}

class _CroppingScreenState extends State<CroppingScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<List<Uint8List>> _imagesData = ValueNotifier(null);
  final ValueNotifier<List<Uint8List>> _croppedImages = ValueNotifier(null);
  final ValueNotifier<int> _currentImageIndex = ValueNotifier(0);
  final List<CropController> _controllers = <CropController>[];
  final PageController _pageController = PageController();
  /// ON CROP TAP : ALL CONTROLLERS CROP, TAKE TIME THEN END AND ADD A CropStatus.ready to this list
  /// when it reaches the length of the given files,, goes back with new cropped files
  ValueNotifier<List<CropStatus>> _statuses;
  bool _canGoBack = false;
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
    _statuses.addListener(() async {

      /// CHECK IF STATUSES ARE ALL READY
      final bool _allImagesCropped = Mapper.checkListsAreIdentical(
          list1: _statuses.value,
          list2: List.filled(widget.files.length, CropStatus.ready),
      );

      if (_allImagesCropped == true && _canGoBack == true){

        /// GENERATE CROPPED FILES
        final List<File> _files = await Filers.getFilesFromUint8Lists(
          uInt8Lists: _croppedImages.value,
          fileName: createUniqueID().toString(),//widget.filesName,
        );

        await _triggerLoading(setTo: false);

        /// GO BACK AND PASS THE FILES
        Nav.goBack(context, passedData: _files);

      }

    });
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
        _croppedImages.value = _imagesData.value;
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
    _pageController.dispose();
    _currentImageIndex.dispose();
    _statuses.dispose();
    _croppedImages.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _initializeControllers(){

    for (int i = 0; i < widget.files.length; i++){
      final CropController _controller = CropController();
      _controllers.add(_controller);
    }

    final List<CropStatus> _statusesList =  List.filled(widget.files.length, CropStatus.nothing);
    _statuses = ValueNotifier(_statusesList);

  }
// -----------------------------------------------------------------------------
  Future<void> _cropImages() async {

    await _triggerLoading(setTo: true);

    for (final CropController controller in _controllers){
      controller.crop();
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      pageTitle: 'Crop Images',
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarType: AppBarType.basic,
      // pyramidsAreOn: false,
      skyType: SkyType.black,
      loading: _loading,
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

                /// CROPPER PAGES
                CropperPages(
                  currentImageIndex: _currentImageIndex,
                  aspectRatio: widget.aspectRatio,
                  screenHeight: _screenHeight,
                  controllers: _controllers,
                  croppedImages: _croppedImages,
                  files: widget.files,
                  imagesData: imagesData,
                  pageController: _pageController,
                  statuses: _statuses,
                ),

                /// CROPPER FOOTER
                CropperFooter(
                  screenHeight: _screenHeight,
                  aspectRatio: widget.aspectRatio,
                  currentImageIndex: _currentImageIndex,
                  files: widget.files,
                  onCropImages: () async {

                    await _cropImages();
                    _canGoBack = true;

                  },
                  onImageTap: (int index) async {

                    _currentImageIndex.value = index;
                    await _pageController.animateToPage(index,
                      duration: Ratioz.durationFading200,
                      curve: Curves.easeInOut,
                    );

                  },
                ),

              ],
            );

          }

        },
      ),
    );

  }


}