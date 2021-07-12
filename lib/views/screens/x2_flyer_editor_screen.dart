import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/zoomable_widget.dart';
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

class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
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

  FlyerEditorScreen({
    @required this.draftFlyerModel,
    @required this.index,
    @required this.bzModel,
    @required this.firstTimer,
    this.flyerModel,
    @required this.flyerZoneWidth,
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
  bool _canZoom = true;
  double _buttonSize = 50;
// -----------------------------------------------------------------------------
  FlyersProvider _prof;
  CountryProvider _countryPro;
  BzModel _bz;
  FlyerModel _flyer;
  FlyerModel _originalFlyer;
  // -------------------------
  int numberOfSlides;
  int _currentSlideIndex;

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

    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _countryPro = Provider.of<CountryProvider>(context, listen: false);
    _originalFlyer = widget.firstTimer ? null : widget.flyerModel.clone();

    _bz = widget.bzModel;
    // _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();
    _currentSlideIndex = widget.index;
    _assets = widget.draftFlyerModel.assets;
    _picsFits = widget.draftFlyerModel.boxesFits;
    _assetsAsFiles = widget.draftFlyerModel.assetsAsFiles;

    numberOfSlides = _assets.length;

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

                      /// TRIGGER ZOOM MODE
                      PanelButton(
                        size: _buttonSize,
                        icon:  _canZoom ? Iconz.XLarge : Iconz.XSmall,
                        verse: _canZoom ? 'Zoom on' : 'Zoom off',
                        onTap: (){
                          setState(() {
                            _canZoom = !_canZoom;
                          });
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

                        /// SLIDES AS PAGEVIEW.BUILDER
                        NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification notification){
                            // print('${notification.toString()}');

                            // if (notification is ScrollUpdateNotification){
                            //   print('bommm');
                            // }

                            return
                                true;
                          },
                          child: PageView.builder(
                              pageSnapping: true,
                              controller: _pageController,
                              physics: _canZoom ? AlwaysScrollableScrollPhysics() : BouncingScrollPhysics(),
                              allowImplicitScrolling: true,
                              itemCount: numberOfSlides,
                              onPageChanged: (i) => _onPageChanged(i),
                              itemBuilder: (ctx, i){

                                Asset _asset = _assets[i];

                                // print('Width : ${_asset.originalWidth}, Height : ${_asset.originalHeight}');
                                // print('isPortrait : ${_asset.isPortrait}, isLandscape : ${_asset.isLandscape}');

                                File _file = _assetsAsFiles.length > 0 ? _assetsAsFiles[i] : null;

                                return
                                  KeepAlivePage(
                                    key: PageStorageKey(widget.draftFlyerModel.key.value + i),
                                    child: FlyerZone(
                                      flyerSizeFactor: _flyerSizeFactor,
                                      tappingFlyerZone: (){},
                                      onLongPress: (){},
                                      stackWidgets: <Widget>[

                                        /// if stateless zoomable widget
                                        // StatelessZoomableWidget(
                                        //   onDoubleTap: (){},
                                        //   key: PageStorageKey(widget.draftFlyerModel.key.value + i),
                                        //   matrix: _matrixes[currentSlide],
                                        //   shouldRotate: true,
                                        //   onMatrixUpdate: (matrix) {
                                        //
                                        //     print('${matrix.toString()}');
                                        //     print('neo index 0 is : ${_matrixes[0]}');
                                        //     print('neo index 1 is : ${_matrixes[1]}');
                                        //     print('neo index 2 is : ${_matrixes[2]}');
                                        //
                                        //     if(_canZoom){
                                        //     setState(() {
                                        //       _matrixes[currentSlide] = matrix;
                                        //     });
                                        //     }
                                        //
                                        //     },
                                        //
                                        //   child: Container(
                                        //     width: _flyerZoneWidth,
                                        //     height: _flyerZoneHeight,
                                        //     child: superImageWidget(
                                        //       _file,
                                        //       width: _flyerZoneWidth.toInt(),
                                        //       height: _flyerZoneHeight.toInt(),
                                        //       fit: _picsFits[i],
                                        //     ),
                                        //   ),
                                        // ),

                                        /// if interactive viewer
                                        GestureDetector(
                                          onTapUp: (TapUpDetails details){
                                            dynamic _childWasTappedAt = _transformationController.toScene(details.localPosition);

                                            print('_childWasTappedAt : $_childWasTappedAt');

                                          },
                                          child: InteractiveViewer(
                                            transformationController: _transformationController,
                                            panEnabled: _canZoom ? true : false,
                                            scaleEnabled: _canZoom ? true : false,
                                            constrained: false,
                                            alignPanAxis: false,
                                            boundaryMargin: EdgeInsets.zero,
                                            key: PageStorageKey(widget.draftFlyerModel.key.value + i),
                                            maxScale: 10,
                                            minScale: 0.5,
                                            onInteractionEnd: (ScaleEndDetails scaleEndDetails){
                                              print('scaleEndDetails : $scaleEndDetails');
                                              // setState(() {
                                              //   _transformationController.value = new Matrix4.identity();
                                              //   print('should toScene');
                                              // });

                                              Offset _pixelPerSecond = scaleEndDetails.velocity.pixelsPerSecond;
                                              Offset _pixelTranslate = scaleEndDetails.velocity.pixelsPerSecond.translate(1, 1);
                                              Offset _pixelScale = scaleEndDetails.velocity.pixelsPerSecond.scale(0, 0);
                                              double _direction = scaleEndDetails.velocity.pixelsPerSecond.direction;
                                              double _distance = scaleEndDetails.velocity.pixelsPerSecond.distance;
                                              bool _isFinite = scaleEndDetails.velocity.pixelsPerSecond.isFinite;
                                              Offset _clampingPixelPerSecond = scaleEndDetails.velocity.clampMagnitude(0, 10).pixelsPerSecond;

                                              print('_pixelPerSecond : $_pixelPerSecond');
                                              print('_pixelTranslate : $_pixelTranslate');
                                              print('_pixelScale : $_pixelScale');
                                              print('_direction : $_direction');
                                              print('_distance : $_distance');
                                              print('_isFinite : $_isFinite');
                                              print('_clampingPixelPerSecond : $_clampingPixelPerSecond');

                                              // _transformationController.toScene(_pixelScale);

                                              resetZoom();

                                            },
                                            onInteractionStart: (ScaleStartDetails scaleStartDetails){
                                              print('scaleStartDetails : $scaleStartDetails');
                                            },
                                            onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails){
                                              print('scaleUpdateDetails : $scaleUpdateDetails');
                                            },
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
