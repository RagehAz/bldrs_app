import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/flyer_sliders.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/screens/x2_super_flyer_editor.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/panel_button.dart';
import 'package:bldrs/views/widgets/buttons/publish_button.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
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

class _FlyerEditorScreenState extends State<FlyerEditorScreen> with AutomaticKeepAliveClientMixin{
  /// to keep out of screen objects alive when using [with AutomaticKeepAliveClientMixin]
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  PageController _pageController;
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
  int _numberOfSlides; /// in init : numberOfSlides = _assets.length;
  bool onPageChangedIsOn = true; /// onPageChanged: onPageChangedIsOn ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
  void _onPageChanged (int newIndex){
    _slidingNext = Animators.slidingNext(newIndex: newIndex, currentIndex: _currentSlideIndex,);
    setState(() {_currentSlideIndex = newIndex;})
    ;}
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index, viewportFraction: 1, keepPage: true);

    // _prof = Provider.of<FlyersProvider>(context, listen: false);
    // _countryPro = Provider.of<CountryProvider>(context, listen: false);
    // _originalFlyer = widget.firstTimer ? null : widget.flyerModel.clone();
    // _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();
    _bz = widget.bzModel;
    _showAuthor = widget.firstTimer ? true : widget.flyerModel.flyerShowsAuthor;

    _assets = widget.draftFlyerModel.assets;
    _currentSlideIndex = widget.index;
    _numberOfSlides = _assets.length;

    _assetsAsFiles = widget.draftFlyerModel.assetsAsFiles;
    _picsFits = widget.draftFlyerModel.boxesFits;
    _matrixes.addAll([...List.generate(_numberOfSlides, (index) => Matrix4.identity())]);
    _slidesVisibility = _createSlidesVisibilityList(); //widget.firstTimer == true ? new List() : _createSlidesVisibilityList();
    _titleControllers = widget.draftFlyerModel.titlesControllers;

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
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

    // /// A - If slides are not empty
    // if (_numberOfSlides > 0){
    //   setState(() {
    //     _numberOfSlides = _numberOfSlides - 1;
    //   });
    //
    // }
    // /// A - if slides are empty
    // else {
    //   print('can not decrease progressBar');
    // }

    setState(() {
      _numberOfSlides > 0 ?
      _numberOfSlides = _numberOfSlides - 1 : print('can not decrease progressBar');
    });


  }
// ---------------------------------------------------o
  void _triggerVisibility(int currentSlide)  {
    setState(() {
      _slidesVisibility[currentSlide] = !_slidesVisibility[currentSlide];
    });
  }
// ---------------------------------------------------o
  void _statelessDelete(int currentSlide){
    List<File> _currentSlides = _assetsAsFiles;

    /// **************
    /// A - if slides are not empty
    // if (_assetsAsFiles.isNotEmpty)
    // {
    //   // /// B1 - if at first slide
    //   // if(currentSlide == 0){
    //   //   _assetsAsFiles.removeAt(currentSlide);
    //   //   _assets.removeAt(currentSlide);
    //   //   // currentSlide=0;
    //   // }
    //   //
    //   // /// B1 - if at a middle or last slide
    //   // else{
    //   //   _assetsAsFiles.removeAt(currentSlide);
    //   //   _assets.removeAt(currentSlide);
    //   // }
    //   //
    //   // /// B2 - visibility - titles - fits - matrixes
    //   // _slidesVisibility.removeAt(currentSlide);
    //   // _titleControllers.removeAt(currentSlide);
    //   // _picsFits.removeAt(currentSlide);
    //   // _matrixes.removeAt(currentSlide);
    //
    //   // slidesModes.removeAt(currentSlide);
    //
    //   /// xxxxxxxxxxxxx
    //   _assetsAsFiles.removeAt(currentSlide);
    //   _assets.removeAt(currentSlide);
    //   _slidesVisibility.removeAt(currentSlide);
    //   _titleControllers.removeAt(currentSlide);
    //   _picsFits.removeAt(currentSlide);
    //   _matrixes.removeAt(currentSlide);
    //
    // }
    //
    // /// A - if slides are empty
    // else {
    //   print('no Slide to delete');
    // }
    /// *******************
    if (_assetsAsFiles.isNotEmpty)
    {
      if(currentSlide == 0){
        _assetsAsFiles.removeAt(currentSlide);
        // currentSlide=0;
      }

      else {
        _assetsAsFiles.removeAt(currentSlide);
      }

      _assets.removeAt(currentSlide);
      _slidesVisibility.removeAt(currentSlide);
      _titleControllers.removeAt(currentSlide);
      _picsFits.removeAt(currentSlide);
      _matrixes.removeAt(currentSlide);

    } else { print('no Slide to delete'); }
    /// *******************

  }
// ---------------------------------------------------o
  void _currentSlideMinus(){

    // /// A - if at first slide
    // if (_currentSlideIndex == 0){
    //   print('_currentSlideMinus : at first slide');
    //   // _currentSlideIndex = 0; // Nothing to do
    // }
    //
    // /// A - if at last slide
    // else if (_currentSlideIndex + 1 == _numberOfSlides){
    //   print('_currentSlideMinus : at last slide');
    //   setState(() {
    //     _currentSlideIndex = _currentSlideIndex - 1;
    //   });
    // }
    //
    // /// A - if at a middle
    // else {
    //   print('_currentSlideMinus : at middle slide');
    //   // setState(() {
    //   //   _currentSlideIndex = _currentSlideIndex - 1;
    //   // });
    // }

    if (_currentSlideIndex == 0){_currentSlideIndex = 0;}
    else {
      setState(() {
        _currentSlideIndex = _currentSlideIndex - 1;
      });
    }


  }
// -----------------------------------------------------------------------------
  Future<void> _deleteSlide (int numberOfSlides, int currentSlide) async {

    /// A - if slides are not empty
    if (_assetsAsFiles.isNotEmpty) {

      // // onPageChangedIsOn = false;
      /// B1 - progress bar
      _decreaseProgressBar();



      /// B2 - visibility
      _triggerVisibility(currentSlide);


      /// B3 - slide to
      Future.delayed(Ratioz.duration200ms, () async {
        if(numberOfSlides != 0){
        Sliders.slidingAction(_pageController, numberOfSlides, currentSlide);
        }
      });

      // /// B4 - currentSlideIndex
      _currentSlideMinus();

      // xxxxxxxxxxxxxxxxxxxxx
      numberOfSlides <= 1 ?
      _statelessDelete(currentSlide) :
      Future.delayed(
          Ratioz.duration750ms,
              () async {
            if(currentSlide == 0){_statelessDelete(currentSlide);await Sliders.snapTo(_pageController, 0);}
            else{_statelessDelete(currentSlide);}
            setState(() {
              // onPageChangedIsOn = true;
              // numberOfSlides = _currentSlides.length;
            });
          }
      );
      // xxxxxxxxxxxxxxxxxxxxxx

      // /// B5 - if  only zero or one slides left
      // if (numberOfSlides <= 1){
      //   /// C - delete slide
      //   _statelessDelete(currentSlide);
      // }
      //
      // /// B5 - if slides has more than 1 slide
      // else {
      //   Future.delayed(
      //       Ratioz.duration750ms, () async {
      //
      //     /// C - if at first slide
      //     if(currentSlide == 0){
      //       _statelessDelete(currentSlide);
      //       await Sliders.snapTo(_pageController, 0);
      //     }
      //
      //     /// C - if at a middle of last slide
      //     else{
      //       _statelessDelete(currentSlide);
      //     }
      //
      //     /// C - rebuild
      //     setState(() {
      //       // onPageChangedIsOn = true;
      //       // numberOfSlides = _assets.length;
      //     });
      //
      //   }
      //   );
      // }

    }

    /// A - if slides are empty
    else {
      print('no slide to delete');
    }


    // setState(() {
    //
    // });

  }
// -----------------------------------------------------------------------------
  Future<void> _cropImage(File file) async {

    _triggerLoading();

    File croppedFile = await Imagers.cropImage(context, file);

    if (croppedFile != null) {
      setState(() {
        _assetsAsFiles[_currentSlideIndex] = croppedFile;
      });
    }

    _triggerLoading();
  }
// -----------------------------------------------------------------------------
  Future<void> _getMultiImages({BzAccountType accountType}) async {

    _triggerLoading();

    List<Asset> _oldAssets = _assets;

    /// A - if flyer reached max slides
    if(Standards.getMaxFlyersSlidesByAccountType(accountType) <= _oldAssets.length ){
      await superDialog(
        context: context,
        title: 'Obbaaaa',
        body: 'Ta3alaaaaaaa ba2aaa ya 7abibi',
      );
    }

    /// A - if still picking images
    else {

      List<Asset> _newAssets;

      if(mounted){
        _newAssets = await Imagers.getMultiImagesFromGallery(
          context: context,
          images: _oldAssets,
          mounted: mounted,
          accountType: accountType,
        );

        /// B - if did not pick new assets
        if(_newAssets.length == 0){
          // will do nothing
          print('no new picks');
        }

        /// B - if picked new assets
        else {

          // for (Asset asset in _newAssets){
          //   File _file = await Imagers.getFileFromCropperAsset(asset);
          //   _assetsAsFiles.add(_file);
          //   _fits.add(Imagers.concludeBoxFit(asset));
          // }

          List<BoxFit> _newFits = new List();
          List<File> _newFiles = new List();
          List<TextEditingController> _newControllers = new List();
          List<Matrix4> _newMatrixes = new List();
          List<bool> _newVisibilities = new List();

          for (Asset newAsset in _newAssets){
            int _assetIndexInExistingAssets = _assets.indexWhere((existingAsset) => existingAsset.identifier == newAsset.identifier,);

            /// if no match found between new assets and existing assets
            // this asset is new
            if(_assetIndexInExistingAssets == -1){
              /// fit
              _newFits.add(Imagers.concludeBoxFit(newAsset));
              /// file
              File _newFile = await Imagers.getFileFromCropperAsset(newAsset);
              _newFiles.add(_newFile);
              /// controller
              _newControllers.add(new TextEditingController());
              /// matrixes
              _newMatrixes.add(new Matrix4.identity());
              /// visibilities
              _newVisibilities.add(true);
            }

            /// found the index of the unchanged asset
            // this asset is old
            else {
              /// fit
              _newFits.add(_picsFits[_assetIndexInExistingAssets]);
              /// file
              _newFiles.add(_assetsAsFiles[_assetIndexInExistingAssets]);
              /// controller
              _newControllers.add(_titleControllers[_assetIndexInExistingAssets]);
              /// matrixes
              _newMatrixes.add(_matrixes[_assetIndexInExistingAssets]);
              /// visibilities
              _newVisibilities.add(_slidesVisibility[_assetIndexInExistingAssets]);
            }

          }

          setState(() {
            widget.draftFlyerModel.assets = _newAssets;
            _assets = _newAssets;

            widget.draftFlyerModel.boxesFits = _newFits;
            _picsFits = _newFits;

            widget.draftFlyerModel.assetsAsFiles = _newFiles;
            _assetsAsFiles = _newFiles;

            widget.draftFlyerModel.titlesControllers = _newControllers;
            _titleControllers = _newControllers;

            _matrixes = _newMatrixes;
            _slidesVisibility = _newVisibilities;

            _numberOfSlides = _assets.length;
          });

          await _pageController.animateToPage(_newAssets.length - 1,
              duration: Ratioz.duration400ms, curve: Curves.easeInOutCirc);

          print(_assets.toString());
          print(_picsFits.toString());
          print(_assetsAsFiles.toString());
          print(_titleControllers.toString());
          print(_matrixes.toString());
          print(_slidesVisibility.toString());
        }

      }

    }

    _triggerLoading();

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

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

    BoxFit _currentPicFit = _picsFits.length == 0 ? null : _picsFits[_currentSlideIndex];

// ------------------------------
    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        DreamBox(
          height: Ratioz.appBarButtonSize,
          verse: 'super editor',
          verseScaleFactor: 0.6,
          color: Colorz.Red225,
          onTap: (){
            Nav.goToNewScreen(context,
                SuperFlyerEditorScreen(
                  bzModel: widget.bzModel,
                  firstTimer: true,
                  flyerModel: null,
                )
            );
            },
        ),

        Expanded(child: Container(),),

        PublishButton(
          firstTimer: widget.firstTimer,
          loading: _loading,
          onTap: (){
            print(_currentSlideIndex);
            // _triggerLoading();
          },
        ),

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
                  child: Container(
                    width: _panelWidth - Ratioz.appBarMargin,
                    height: _panelHeight,
                    padding: EdgeInsets.all(Ratioz.appBarPadding),
                    decoration: BoxDecoration(
                      borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
                      color: Colorz.White10,
                    ),
                    child: ClipRRect(
                      borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
                      child: ListView(
                        shrinkWrap: true,

                        children: <Widget>[

                          /// SHOW AUTHOR
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            verse: _showAuthor == true ? 'Author Shown' : 'Author Hidden',
                            icon: _author.authorPic,
                            iconSizeFactor: 1,
                            blackAndWhite: _showAuthor == true ? false : true,
                            isAuthorButton: true,
                            onTap: (){
                              setState(() {
                                _showAuthor = !_showAuthor;
                              });
                            },
                          ),

                          /// CHANGE SLIDE BOX FIT
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            verse: _currentPicFit == BoxFit.fitWidth ?  'Full Width' : _currentPicFit == BoxFit.fitHeight ? 'Full Height' : 'cover',
                            icon: _currentPicFit == BoxFit.fitWidth ? Iconz.ArrowRight : _currentPicFit == BoxFit.fitHeight ? Iconz.ArrowUp : Iconz.DashBoard,
                            isAuthorButton: false,
                            onTap: (){

                              if(_currentPicFit == BoxFit.fitWidth) {
                                setState(() {
                                  _picsFits[_currentSlideIndex] = BoxFit.fitHeight;
                                });
                              }

                              else if(_currentPicFit == BoxFit.fitHeight){
                                setState(() {
                                  _picsFits[_currentSlideIndex] = BoxFit.cover;
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
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.BxDesignsOff,
                            verse: 'Crop Image',
                            onTap: () async {
                              await _cropImage(_assetsAsFiles[_currentSlideIndex]);
                              },
                          ),

                          /// RELOAD
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.Clock,
                            verse: 'Reset Image',
                            onTap: () async {

                              File _file = await Imagers.getFileFromCropperAsset(_assets[_currentSlideIndex]);
                              setState(() {
                                _assetsAsFiles[_currentSlideIndex] = _file;
                              });

                            },
                          ),

                          /// DELETE IMAGE
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.XSmall,
                            verse: 'Delete Image',
                            onTap: () async {
                              // widget.onDeleteImage(_currentSlideIndex);

                              await _deleteSlide(_numberOfSlides, _currentSlideIndex);

                            },
                          ),

                          /// ADD IMAGE
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.Plus,
                            verse: 'Add Images',
                            onTap: () async {
                              print('adding Image');
                              await _getMultiImages(accountType: BzAccountType.Super);
                            },
                          ),

                          /// Trigger Visibility
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.FlyerScale,
                            verse: 'Visible',
                            onTap: () async {
                              print('Trigger visibility');
                              _triggerVisibility(_currentSlideIndex);
                            },
                          ),

                          /// Slide right
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.ArrowRight,
                            verse: '-->',
                            onTap: () async {
                              await Sliders.slideToNext(_pageController, _numberOfSlides, _currentSlideIndex);
                            },
                          ),

                          /// Slide left
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.ArrowLeft,
                            verse: '<--',
                            onTap: () async {
                              await Sliders.slideToBack(_pageController, _currentSlideIndex);
                            },
                          ),

                        ],
                      ),
                    ),
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
                              physics: BouncingScrollPhysics(),
                              allowImplicitScrolling: true,
                              itemCount: _assets.length,
                              onPageChanged: onPageChangedIsOn ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
                              itemBuilder: (ctx, i){

                                double _ratio = _assets[i].originalWidth / _assets[i].originalHeight;

                                ImageSize _imageSize = ImageSize(
                                  width: _currentPicFit == BoxFit.fitWidth ? _flyerZoneWidth.toInt() : (_flyerZoneHeight*_ratio).toInt(),
                                  height: _currentPicFit == BoxFit.fitWidth ? (_flyerZoneWidth~/_ratio).toInt() : _flyerZoneHeight.toInt(),
                                );

                                return

                                  AnimatedOpacity(
                                    key: ObjectKey(widget.draftFlyerModel.key.value + i),
                                    opacity: _slidesVisibility[i] == true ? 1 : 0,
                                    duration: Duration(milliseconds: 100),
                                    child: SingleSlide(
                                      key: ObjectKey(widget.draftFlyerModel.key.value + i),
                                      flyerZoneWidth: _flyerZoneWidth,
                                      flyerID: null, //_flyer.flyerID,
                                      picture: _assetsAsFiles[i],//_currentSlides[index].picture,
                                      slideMode: SlideMode.Editor,//slidesModes[index],
                                      boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                                      titleController: _titleControllers[i],
                                      imageSize: _imageSize,
                                      textFieldOnChanged: (text){
                                        print('text is : $text');
                                      },
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
                          numberOfSlides: _numberOfSlides,
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
