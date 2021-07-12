import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/flyer_sliders.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/buttons/panel_button.dart';
import 'package:bldrs/views/widgets/buttons/publish_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:bldrs/views/screens/x1_flyers_publisher_screen.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:bldrs/controllers/theme/colorz.dart';

class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Dont't forget this
    super.build(context);

    return widget.child;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class FlyerEditorScreen extends StatefulWidget {
  final DraftFlyerModel draftFlyerModel;
  final int index;
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;
  final double flyerZoneWidth;
  final Function onDeleteImage;

  FlyerEditorScreen({
    @required this.draftFlyerModel,
    @required this.index,
    @required this.bzModel,
    @required this.firstTimer,
    this.flyerModel,
    @required this.flyerZoneWidth,
    @required this.onDeleteImage,
  });

  @override
  _FlyerEditorScreenState createState() => _FlyerEditorScreenState();
}

class _FlyerEditorScreenState extends State<FlyerEditorScreen> with TickerProviderStateMixin{
  // /// to keep out of screen objects alive when using [with AutomaticKeepAliveClientMixin]
  // @override
  // bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  PageController _pageController;
  ScrollController _scrollController;
  TransformationController _transformationController;
  AnimationController _zoomAnimationController;
  double _buttonSize = 50;
  List<bool> _slidesVisibility;
  List<TextEditingController> _titleControllers;
// -----------------------------------------------------------------------------
//   FlyersProvider _prof;
//   CountryProvider _countryPro;
  BzModel _bz;
  FlyerModel _flyer; // will be used when editing already published flyers
  // FlyerModel _originalFlyer;
  // -------------------------

  bool _showAuthor;

  List<Asset> _assets;
  List<File> _assetsAsFiles;
  List<BoxFit> _picsFits;

  List<Matrix4> _matrixes = new List();
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  /// SLIDING BLOCK
  /// usage :  onPageChanged: (i) => _onPageChanged(i),
  bool _slidingNext;
  int _currentSlideIndex; /// in init : _currentSlideIndex = widget.index;
  int numberOfSlides; /// in init : numberOfSlides = _assets.length;
  void _onPageChanged (int newIndex){
    _slidingNext = Animators.slidingNext(newIndex: newIndex, currentIndex: _currentSlideIndex,);
    setState(() {_currentSlideIndex = newIndex;})
    ;}
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index, viewportFraction: 1, keepPage: true);
    _scrollController = ScrollController(initialScrollOffset: ( widget.flyerZoneWidth * (widget.index) ),keepScrollOffset: true, );
    _transformationController = TransformationController();
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: Ratioz.fadingDuration,
      animationBehavior: AnimationBehavior.normal,
    );


    _transformationController.addListener(() {
      if(_transformationController.value.getMaxScaleOnAxis() > 1.5){
        print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX its bigger than 1.5 now');
      }
    });

    // _prof = Provider.of<FlyersProvider>(context, listen: false);
    // _countryPro = Provider.of<CountryProvider>(context, listen: false);
    // _originalFlyer = widget.firstTimer ? null : widget.flyerModel.clone();
    _bz = widget.bzModel;
    // _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();

    _currentSlideIndex = widget.index;
    _assets = widget.draftFlyerModel.assets;
    _picsFits = widget.draftFlyerModel.boxesFits;
    _assetsAsFiles = widget.draftFlyerModel.assetsAsFiles;

    numberOfSlides = _assets.length;

    _slidesVisibility = _createSlidesVisibilityList(); //widget.firstTimer == true ? new List() : _createSlidesVisibilityList();
    _titleControllers = widget.draftFlyerModel.titlesControllers;

    _showAuthor = widget.firstTimer ? true : widget.flyerModel.flyerShowsAuthor;

    _matrixes.addAll([...List.generate(numberOfSlides, (index) => Matrix4.identity())]);

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    _transformationController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void resetZoom(){
    final _reset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_zoomAnimationController);

    _zoomAnimationController.addListener(() {
      _transformationController.value = _reset.value;
    });

    _zoomAnimationController.reset();
    _zoomAnimationController.forward();
  }
// -----------------------------------------------------------------------------
  Future<void> _cropImage(File file) async {

    _triggerLoading();

    /// flyer ratio is : (1 x 1.74)
    double _flyerWidthRatio = 1;
    double _flyerHeightRatio = Ratioz.xxflyerZoneHeight; // 1.74

    double _maxWidth = 1000;

    List<CropAspectRatioPreset> _androidRatios = <CropAspectRatioPreset>[
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
    ];


    List<CropAspectRatioPreset> _notAndroidRatios = <CropAspectRatioPreset>[
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9,
    ];


    File croppedFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: Ratioz.xxflyerZoneHeight),
      aspectRatioPresets: Platform.isAndroid ? _androidRatios : _notAndroidRatios,
      maxWidth: _maxWidth.toInt(),
      compressFormat: ImageCompressFormat.jpg, /// TASK : need to test png vs jpg storage sizes on firebase
      compressQuality: 100, // max
      cropStyle: CropStyle.rectangle,
      maxHeight: (_maxWidth * _flyerHeightRatio).toInt(),
      androidUiSettings: AndroidUiSettings(
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: false,

        statusBarColor: Colorz.Black255,
        backgroundColor: Colorz.Black230,
        dimmedLayerColor: Colorz.Black200,

        toolbarTitle: 'Crop Image',//'Crop flyer Aspect Ratio 1:${Ratioz.xxflyerZoneHeight}',
        toolbarColor: Colorz.Black255,
        toolbarWidgetColor: Colorz.White225, // color of : cancel, title, confirm widgets

        activeControlsWidgetColor: Colorz.Yellow255,
        hideBottomControls: false,

        cropFrameColor: Colorz.Grey80,
        cropFrameStrokeWidth: 5,

        showCropGrid: true,
        cropGridColumnCount: 3,
        cropGridRowCount: 6,
        cropGridColor: Colorz.Grey80,
        cropGridStrokeWidth: 2,

      ),

      /// TASK : check cropper in ios
      // iosUiSettings: IOSUiSettings(
      //   title: 'Crop flyer Aspect Ratio 1 : ${Ratioz.xxflyerZoneHeight}',
      //   doneButtonTitle: 'Done babe',
      //   aspectRatioLockDimensionSwapEnabled: ,
      //   aspectRatioLockEnabled: ,
      //   aspectRatioPickerButtonHidden: ,
      //   cancelButtonTitle: ,
      //   hidesNavigationBar: ,
      //   minimumAspectRatio: ,
      //   rectHeight: ,
      //   rectWidth: ,
      //   rectX: ,
      //   rectY: ,
      //   resetAspectRatioEnabled: ,
      //   resetButtonHidden: ,
      //   rotateButtonsHidden: ,
      //   rotateClockwiseButtonHidden: ,
      //   showActivitySheetOnDone: ,
      //   showCancelConfirmationDialog: ,
      // ),
    );

    if (croppedFile != null) {
      setState(() {
        _assetsAsFiles[_currentSlideIndex] = croppedFile;
        // state = AppState.cropped;
      });
    }

    _triggerLoading();
  }
// -----------------------------------------------------------------------------
  List<TextEditingController> _createTitlesControllersList(){
    List<TextEditingController> _controllers = new List();

    widget.draftFlyerModel.assetsAsFiles.forEach((asset) {
      TextEditingController _controller = new TextEditingController();
      // _controller.text = slide.headline;
      _controllers.add(_controller);
    });

    return _controllers;
  }
// -----------------------------------------------------------------------------
  List<bool> _createSlidesVisibilityList(){
    int _listLength = widget.draftFlyerModel.assetsAsFiles.length;
    List<bool> _visibilityList = new List();

    for (int i = 0; i<_listLength; i++){
      _visibilityList.add(true);
    }

    return _visibilityList;
  }
// -----------------------------------------------------------------------------
  void _decreaseProgressBar(){
    setState(() {
      numberOfSlides > 0 ?
      numberOfSlides = numberOfSlides - 1 : print('can not decrease progressBar');
    });
  }
// -----------------------------------------------------------------------------
  void _triggerVisibility(int currentSlide)  {
    setState(() {
      _slidesVisibility[currentSlide] = !_slidesVisibility[currentSlide];
    });
  }
// -----------------------------------------------------------------------------
  void _simpleDelete(int currentSlide){
    List<File> _currentSlides = _assetsAsFiles;
    if (_currentSlides.isNotEmpty)
    {
      if(currentSlide == 0){
        _currentSlides.removeAt(currentSlide);
        // currentSlide=0;
      }else{_currentSlides.removeAt(currentSlide);}
      _slidesVisibility.removeAt(currentSlide);
      // slidesModes.removeAt(currentSlide);
      _titleControllers.removeAt(currentSlide);
    } else { print('no Slide to delete'); }
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _simpleDelete');
  }
// -----------------------------------------------------------------------------
  void _currentSlideMinus(){
    if (_currentSlideIndex == 0){_currentSlideIndex = 0;}
    else {
      setState(() {
        _currentSlideIndex = _currentSlideIndex - 1;
      });
    }
  }
// -----------------------------------------------------------------------------
  void _deleteSlide (int numberOfSlides, int currentSlide) {
    if (_assetsAsFiles.isNotEmpty)
    {
      _decreaseProgressBar();
      // onPageChangedIsOn = false;
      _triggerVisibility(currentSlide);
      Future.delayed(Ratioz.fadingDuration, (){
        if(numberOfSlides != 0){
        slidingAction(_pageController, numberOfSlides, currentSlide);
        }
      });
      _currentSlideMinus();
      numberOfSlides <= 1 ?
      _simpleDelete(currentSlide) :
      Future.delayed(
          Ratioz.slidingAndFadingDuration,
              (){
            if(currentSlide == 0){_simpleDelete(currentSlide);snapTo(_pageController, 0);}
            else{_simpleDelete(currentSlide);}
            setState(() {
              // onPageChangedIsOn = true;
              // numberOfSlides = _currentSlides.length;
            });
          }
      );
      // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _deleteSlide ------------ last shit');
    }
    else
    {print('no slide to delete');}
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // /// when using with AutomaticKeepAliveClientMixin
    // super.build(context);

    // print('draft picture screen');

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    double _panelWidth = _buttonSize + (Ratioz.appBarMargin * 2);

    double _flyerZoneWidth = _screenWidth - _panelWidth - Ratioz.appBarMargin;
    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerZoneWidth);
    double _flyerSizeFactor = Scale.superFlyerSizeFactorByWidth(context, _flyerZoneWidth);

    double _panelHeight = _flyerZoneHeight;

    AuthorModel _author = widget.firstTimer ?
    AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID()) :
    AuthorModel.getAuthorFromBzByAuthorID(_bz, _flyer.tinyAuthor.userID);

// ------------------------------
    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        Expanded(child: Container(),),

        PublishButton(firstTimer: widget.firstTimer),

      ],

      layoutWidget:
      ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[

          Stratosphere(),

          /// FLYER & PANEL ZONES
          Container(
            width: _screenWidth,
            height: _panelHeight,
            child: Row(
              children: <Widget>[

                /// PANEL
                Container(
                  width: _panelWidth,
                  height: _panelHeight,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      /// SHOW AUTHOR
                      PanelButton(
                        size: _buttonSize,
                        verse: _showAuthor == true ? 'Author Shown' : 'Author Hidden',
                        icon: _author.authorPic,
                        iconSizeFactor: 1,
                        blackAndWhite: _showAuthor == true ? false : true,
                        onTap: (){
                          setState(() {
                            _showAuthor = !_showAuthor;
                          });
                        },
                      ),

                      /// CHANGE SLIDE BOX FIT
                      PanelButton(
                        size: _buttonSize,
                        verse: _picsFits[_currentSlideIndex] == BoxFit.fitWidth ? 'Full width' : 'Full Height',
                        icon: _picsFits[_currentSlideIndex] == BoxFit.fitWidth ? Iconz.ArrowRight : Iconz.ArrowUp,
                        onTap: (){

                          if(_picsFits[_currentSlideIndex] == BoxFit.fitWidth) {
                            setState(() {
                              _picsFits[_currentSlideIndex] = BoxFit.fitHeight;
                            });
                          }

                          else {
                            setState(() {
                              _picsFits[_currentSlideIndex] = BoxFit.fitWidth;
                            });
                          }

                          // print('fit is : ${_picsFits[currentSlide]}');

                        },
                      ),

                      /// CROP IMAGE
                      PanelButton(
                        size: _buttonSize,
                        icon:  Iconz.BxDesignsOff,
                        verse: 'Crop Image',
                        onTap: () async {
                          await _cropImage(_assetsAsFiles[_currentSlideIndex]);
                          },
                      ),

                      /// DELETE IMAGE
                      PanelButton(
                        size: _buttonSize,
                        icon:  Iconz.XSmall,
                        verse: 'Delete Image',
                        onTap: () async {
                          // widget.onDeleteImage(_currentSlideIndex);

                          _deleteSlide(numberOfSlides, _currentSlideIndex);

                        },
                      ),

                    ],
                  ),
                ),

                /// FLYER
                _assetsAsFiles.length == 0 ? Loading(loading: _loading) :
                Container(
                  width: _flyerZoneWidth,
                  height: _flyerZoneHeight,
                  child: ClipRRect(
                    borderRadius: Borderers.superFlyerCorners(context, _flyerZoneWidth),
                    child: Stack(
                      children: <Widget>[

                        /// SLIDES
                        NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification notification){
                            // if (notification is ScrollUpdateNotification){
                            //   print('bommm');
                            // }
                            return true;
                            },
                          child: PageView.builder(
                              pageSnapping: true,
                              controller: _pageController,
                              physics: AlwaysScrollableScrollPhysics(),
                              allowImplicitScrolling: true,
                              itemCount: numberOfSlides,
                              onPageChanged: (i) => _onPageChanged(i),
                              itemBuilder: (ctx, i){

                                // print('Width : ${_asset.originalWidth}, Height : ${_asset.originalHeight}');
                                // print('isPortrait : ${_asset.isPortrait}, isLandscape : ${_asset.isLandscape}');
                                File _file = _assetsAsFiles[i];//_assetsAsFiles.length > 0 ? _assetsAsFiles[i] : null;

                                return
                                  AnimatedOpacity(
                                    key: ObjectKey(widget.draftFlyerModel.key.value + i),
                                    opacity: _slidesVisibility[_currentSlideIndex] == true ? 1 : 0,
                                    duration: Ratioz.fadingDuration,
                                    child: KeepAlivePage(
                                      key: PageStorageKey(widget.draftFlyerModel.key.value + i),
                                      child: FlyerZone(
                                        flyerSizeFactor: _flyerSizeFactor,
                                        tappingFlyerZone: (){},
                                        onLongPress: (){},
                                        stackWidgets: <Widget>[

                                          /// BACK GROUND IMAGE
                                          Container(
                                            width: _flyerZoneWidth,
                                            height: _flyerZoneHeight,
                                            child: superImageWidget(
                                              _file,
                                              width: (_flyerZoneWidth).toInt(),
                                              height: (_flyerZoneHeight).toInt(),
                                              scale: 1.8,
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                          /// BLUR LAYER
                                          BlurLayer(
                                            width: _flyerZoneWidth,
                                            height: _flyerZoneHeight,
                                            blur: Ratioz.blur2,
                                            borders: Borderers.superFlyerCorners(context, _flyerZoneWidth),
                                            blurIsOn: true,
                                            color: Colorz.Black80,
                                          ),

                                          /// FRONT IMAGE
                                          GestureDetector(
                                            onTapUp: (TapUpDetails details){
                                              dynamic _childWasTappedAt = _transformationController.toScene(details.localPosition);

                                              // print('_childWasTappedAt : $_childWasTappedAt');

                                              },
                                            child: InteractiveViewer(
                                              transformationController: _transformationController,
                                              panEnabled: true,
                                              scaleEnabled: true,
                                              constrained: false,
                                              alignPanAxis: false,
                                              boundaryMargin: EdgeInsets.zero,
                                              key: PageStorageKey(widget.draftFlyerModel.key.value + i),
                                              maxScale: 10,
                                              minScale: 0.5,
                                              onInteractionEnd: (ScaleEndDetails scaleEndDetails){
                                                // print('scaleEndDetails : $scaleEndDetails');
                                                // setState(() {
                                                //   _transformationController.value = new Matrix4.identity();
                                                //   print('should toScene');
                                                // });

                                                // Offset _pixelPerSecond = scaleEndDetails.velocity.pixelsPerSecond;
                                                // Offset _pixelTranslate = scaleEndDetails.velocity.pixelsPerSecond.translate(1, 1);
                                                // Offset _pixelScale = scaleEndDetails.velocity.pixelsPerSecond.scale(0, 0);
                                                // double _direction = scaleEndDetails.velocity.pixelsPerSecond.direction;
                                                // double _distance = scaleEndDetails.velocity.pixelsPerSecond.distance;
                                                // bool _isFinite = scaleEndDetails.velocity.pixelsPerSecond.isFinite;
                                                // Offset _clampingPixelPerSecond = scaleEndDetails.velocity.clampMagnitude(0, 10).pixelsPerSecond;
                                                //
                                                // print('_pixelPerSecond : $_pixelPerSecond');
                                                // print('_pixelTranslate : $_pixelTranslate');
                                                // print('_pixelScale : $_pixelScale');
                                                // print('_direction : $_direction');
                                                // print('_distance : $_distance');
                                                // print('_isFinite : $_isFinite');
                                                // print('_clampingPixelPerSecond : $_clampingPixelPerSecond');

                                                // _transformationController.toScene(_pixelScale);
                                                resetZoom();
                                                },
                                              // onInteractionStart: (ScaleStartDetails scaleStartDetails){
                                              //   print('scaleStartDetails : $scaleStartDetails');
                                              //   },
                                              // onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails){
                                              //   print('scaleUpdateDetails : $scaleUpdateDetails');
                                              //   },
                                              child: Container(
                                                width: _flyerZoneWidth,
                                                height: _flyerZoneHeight,
                                                child: superImageWidget(
                                                  _file,
                                                  width: _flyerZoneWidth.toInt(),
                                                  height: _flyerZoneHeight.toInt(),
                                                  fit: _picsFits[i],
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  );

                              }
                          ),
                        ),

                        /// FLYER HEADER
                        AbsorbPointer(
                          absorbing: true,
                          child: Header(
                            tinyBz: TinyBz.getTinyBzFromBzModel(_bz),
                            tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(_author),
                            flyerShowsAuthor: _showAuthor,
                            followIsOn: false,
                            flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
                            bzPageIsOn: false,
                            tappingHeader: (){},
                            onFollowTap: (){},
                            onCallTap: (){
                              print('call');
                            },
                          ),
                        ),

                        /// --- PROGRESS BAR
                        ProgressBar(
                          flyerZoneWidth: _flyerZoneWidth,
                          numberOfSlides: numberOfSlides,
                          currentSlide: _currentSlideIndex,
                          slidingNext: _slidingNext,
                        ),

                      ],


                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
