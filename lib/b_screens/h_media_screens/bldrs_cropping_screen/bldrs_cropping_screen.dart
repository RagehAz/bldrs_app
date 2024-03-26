import 'dart:typed_data';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/layouts/layouts/basic_layout.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/b_screens/h_media_screens/bldrs_cropping_screen/bldrs_cropper_footer.dart';
import 'package:bldrs/b_screens/h_media_screens/bldrs_cropping_screen/bldrs_cropper_pages.dart';
import 'package:bldrs/b_screens/h_media_screens/bldrs_cropping_screen/bldrs_cropper_panel.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class BldrsCroppingScreen extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const BldrsCroppingScreen({
    required this.mediaModels,
    this.aspectRatio = 1,
    super.key
  });
  // --------------------
  final List<MediaModel> mediaModels;
  final double aspectRatio;
  // --------------------
  @override
  _BldrsCroppingScreenState createState() => _BldrsCroppingScreenState();
  // -----------------------------------------------------------------------------

  /// ON CROP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> onCropSinglePic({
    required MediaModel? media,
    required double aspectRatio,
  }) async {
    MediaModel? _output;

    if (media != null){

      final MediaModel? _media = await PicMaker.resizePic(
        mediaModel: media,
        resizeToWidth: PicMaker.maxPicWidthBeforeCrop,
      );

      if (_media != null){

        final List<MediaModel>? _received = await BldrsNav.goToNewScreen(
          screen: BldrsCroppingScreen(
            mediaModels: [_media],
            aspectRatio: aspectRatio,
          ),
        );

        _output = _received?.firstOrNull;

      }



    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> onCropMultiplePics({
    required List<MediaModel> medias,
    required double aspectRatio,
  }) async {
    List<MediaModel> _output = <MediaModel>[];

    if (Lister.checkCanLoop(medias) == true){

      _output = await PicMaker.resizePics(
        mediaModels: medias,
        resizeToWidth: PicMaker.maxPicWidthBeforeCrop,
      );

      _output = await BldrsNav.goToNewScreen(
        screen: BldrsCroppingScreen(
          mediaModels: _output,
          aspectRatio: aspectRatio,
        ),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  static double getFooterHeight(){
    return Ratioz.horizon;
  }
  // --------------------
  static double getImagesZoneHeight({
    required double screenHeight,
  }){
    final double _imagesFooterHeight = BldrsCroppingScreen.getFooterHeight();
    final double _imageSpaceHeight = screenHeight - Ratioz.stratosphere - _imagesFooterHeight;
    return _imageSpaceHeight;
  }
  // -----------------------------------------------------------------------------
}

class _BldrsCroppingScreenState extends State<BldrsCroppingScreen> {
  // -----------------------------------------------------------------------------
  List<Uint8List> _originalBytezz = [];
  // --------------------
  final ValueNotifier<List<Uint8List>?> _croppedBytezz = ValueNotifier(null);
  final ValueNotifier<int> _currentImageIndex = ValueNotifier(0);
  final List<CropController> _controllers = <CropController>[];
  final PageController _pageController = PageController();
  // --------------------
  /// ON CROP TAP : ALL CONTROLLERS CROP, TAKE TIME THEN END AND ADD A CropStatus.ready to this list
  // --------------------
  /// when it reaches the length of the given files,, goes back with new cropped files
  // --------------------
  ValueNotifier<List<CropStatus>>? _statuses;
  bool _canGoBack = false;
  // -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();


    _initializeControllers();

    /// REMOVED
    _statuses?.addListener(_statusesListener);
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        final List<Uint8List> _bytezz = Byter.fromMediaModels(widget.mediaModels);

        setNotifier(
          notifier: _croppedBytezz,
          mounted: mounted,
          value: _bytezz,
        );

        setState(() {
          _originalBytezz = _bytezz;
        });

      });

      // _triggerLoading(setTo: true).then((_) async {
      //
      //   await _triggerLoading(setTo: false);
      // });
    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _statuses?.removeListener(_statusesListener);
    _loading.dispose();
    _pageController.dispose();
    _currentImageIndex.dispose();
    _statuses?.dispose();
    _croppedBytezz.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeControllers(){

    for (int i = 0; i < widget.mediaModels.length; i++){
      final CropController _controller = CropController();
      _controllers.add(_controller);
    }

    final List<CropStatus> _statusesList =  List.filled(widget.mediaModels.length, CropStatus.nothing);
    _statuses = ValueNotifier(_statusesList);

  }
  // -----------------------------------------------------------------------------

  /// LISTENER

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _statusesListener() async {

    /// CHECK IF STATUSES ARE ALL READY
    final bool _allImagesCropped = Lister.checkListsAreIdentical(
      list1: _statuses?.value,
      list2: List.filled(widget.mediaModels.length, CropStatus.ready),
    );

    if (_allImagesCropped == true && _canGoBack == true){

      final List<MediaModel> _mediaModels = await MediaModel.replaceBytezzInMediaModels(
        mediaModels: widget.mediaModels,
        bytezz: _croppedBytezz.value,
      );

      await _triggerLoading(setTo: false);

      /// GO BACK AND PASS THE FILES
      await Nav.goBack(
        context: context,
        invoker: 'CroppingScreen',
        passedData: _mediaModels,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// CROP

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _cropImages() async {

    await _triggerLoading(setTo: true);

    for (final CropController controller in _controllers){
      controller.crop();
    }

    _canGoBack = true;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onImageTap(int index) async {

    setNotifier(
      notifier: _currentImageIndex,
      mounted: mounted,
      value: index,
    );

    await _pageController.animateToPage(index,
      duration: Ratioz.durationFading200,
      curve: Curves.easeInOut,
    );

  }
  // -----------------------------------------------------------------------------

  /// EXIT

  // --------------------
  Future<void> _onBack() async {
    await Nav.goBack(
      context: context,
    );
  }
  // -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final bool _panelIsOn = Lister.superLength(_originalBytezz) > 1;

    return BasicLayout(
      safeAreaIsOn: true,
      // backgroundColor: Colorz.red255,
      body:  Column(
        children: <Widget>[

          /// CROPPER PAGES
          BldrsCropperPages(
            panelIsOn: _panelIsOn,
            currentImageIndex: _currentImageIndex,
            aspectRatio: widget.aspectRatio,
            controllers: _controllers,
            croppedImages: _croppedBytezz,
            originalBytezz: _originalBytezz,
            pageController: _pageController,
            statuses: _statuses!,
            mounted: mounted,
          ),

          /// CROPPER PANEL
          BldrsCropperPanel(
            panelIsOn: _panelIsOn,
            aspectRatio: widget.aspectRatio,
            bytezz: _originalBytezz,
            currentImageIndex: _currentImageIndex,
            onImageTap: _onImageTap,
          ),

          /// CROPPER FOOTER
          BldrsCropperFooter(
            loading: _loading,
            onCropImages: _cropImages,
            onBack: _onBack,
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
