import 'dart:io';

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

class FlyerEditorScreen extends StatefulWidget {
  final DraftFlyerModel draftFlyerModel;
  final int index;
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  FlyerEditorScreen({
    @required this.draftFlyerModel,
    @required this.index,
    @required this.bzModel,
    @required this.firstTimer,
    this.flyerModel,
  });

  @override
  _FlyerEditorScreenState createState() => _FlyerEditorScreenState();
}

class _FlyerEditorScreenState extends State<FlyerEditorScreen> with AutomaticKeepAliveClientMixin{
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  bool _isInit = true;
// -----------------------------------------------------------------------------
  PageController _pageController;
  bool _canZoom = false;
  double _buttonSize = 50;
// -----------------------------------------------------------------------------
  FlyersProvider _prof;
  CountryProvider _countryPro;
  BzModel _bz;
  FlyerModel _flyer;
  FlyerModel _originalFlyer;
  // -------------------------
  int numberOfSlides;
  int currentSlide;

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
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);

    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _countryPro = Provider.of<CountryProvider>(context, listen: false);
    _originalFlyer = widget.firstTimer ? null : widget.flyerModel.clone();

    _bz = widget.bzModel;
    // _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();
    currentSlide = widget.index;
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
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    print('draft picture screen');

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

                      /// CHANGE SLIDE FIT
                      PanelButton(
                        size: _buttonSize,
                        verse: _picsFits[currentSlide] == BoxFit.fitWidth ? 'Full width' : 'Full Height',
                        icon: _picsFits[currentSlide] == BoxFit.fitWidth ? Iconz.ArrowRight : Iconz.ArrowUp,
                        onTap: (){

                          if(_picsFits[currentSlide] == BoxFit.fitWidth) {
                            setState(() {
                              _picsFits[currentSlide] = BoxFit.fitHeight;
                            });
                          }

                          else {
                            setState(() {
                              _picsFits[currentSlide] = BoxFit.fitWidth;
                            });
                          }

                          print('fit is : ${_picsFits[currentSlide]}');

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

                        /// SLIDES
                        PageView.builder(
                            pageSnapping: true,
                            controller: _pageController,
                            physics: _canZoom ? NeverScrollableScrollPhysics() : ClampingScrollPhysics(),
                            allowImplicitScrolling: true,
                            itemCount: numberOfSlides,
                            onPageChanged: (i){setState(() {currentSlide = i;});},
                            itemBuilder: (ctx, i){

                              Asset _asset = _assets[i];

                              print('Width : ${_asset.originalWidth}, Height : ${_asset.originalHeight}');
                              print('isPortrait : ${_asset.isPortrait}, isLandscape : ${_asset.isLandscape}');

                              File _file = _assetsAsFiles.length > 0 ? _assetsAsFiles[i] : null;

                              return
                                FlyerZone(
                                  flyerSizeFactor: _flyerSizeFactor,
                                  tappingFlyerZone: (){},
                                  onLongPress: (){},
                                  stackWidgets: <Widget>[

                                    StatelessZoomableWidget(
                                      onDoubleTap: (){},
                                      key: ValueKey(widget.draftFlyerModel.key.value + i),
                                      matrix: _matrixes[currentSlide],
                                      shouldRotate: true,
                                      onMatrixUpdate: (matrix) async {
                                        setState(() {
                                        _canZoom = true;
                                          _matrixes[currentSlide] = matrix;
                                        });

                                        await Future.delayed(Duration(seconds: 1), ()  {
                                             _canZoom = false;
                                        });
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
                                  ],
                                );

                            }
                        ),

                        /// FLYER HEADER
                        AbsorbPointer(
                          absorbing: _canZoom ? true : false,
                          child: Opacity(
                            opacity: _canZoom ? 0.5 : 1,
                            child: Header(
                              tinyBz: TinyBz.getTinyBzFromBzModel(_bz),
                              tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(_author),
                              flyerShowsAuthor: _showAuthor,
                              followIsOn: false,
                              flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
                              bzPageIsOn: false,
                              tappingHeader: (){},
                              onFollowTap: (){},
                              onCallTap: (){},
                            ),
                          ),
                        ),

                        /// --- PROGRESS BAR
                        Opacity(
                          opacity: _canZoom ? 0.5 : 1,
                          child: ProgressBar(
                            flyerZoneWidth: _flyerZoneWidth,
                            numberOfSlides: numberOfSlides,
                            currentSlide: currentSlide,
                          ),
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
