import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/flyer_sliders.dart' show SwipeDirection, Sliders;
import 'package:bldrs/controllers/drafters/imagers.dart' ;
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
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'dart:math';

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
  // usage :  onPageChanged: (i) => _onPageChanged(i),
  SwipeDirection _swipeDirection;
  int _currentSlideIndex; /// in init : _currentSlideIndex = widget.index;
  int _numberOfSlides; /// in init : numberOfSlides = _assets.length;
  bool onPageChangedIsOn = true; /// onPageChanged: onPageChangedIsOn ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
  int _numberOfStrips ;
  void _onPageChanged (int newIndex){
    print('on page is changed new index is : $newIndex');
    SwipeDirection _direction = Animators.getSwipeDirection(newIndex: newIndex, oldIndex: _currentSlideIndex,);
    setState(() {
      _swipeDirection = _direction;
      _currentSlideIndex = newIndex;
    });
    }
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
    _numberOfStrips = _numberOfSlides;
    _swipeDirection = SwipeDirection.next;

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
// ---------------------------------------------------o
  Duration _fadingDuration = Ratioz.durationFading200;
  Duration _fadingDurationX = Ratioz.durationFading210;
  Duration _slidingDuration = Ratioz.durationSliding400;
  Duration _slidingDurationX = Ratioz.durationSliding410;
// ---------------------------------------------------o
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

      _currentSlideIndex = _currentSlideIndex == null ? 0 : _currentSlideIndex;

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
              _newFits.add(Imagers.concludeBoxFit(asset: newAsset, flyerZoneWidth: widget.flyerZoneWidth));
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
            _numberOfStrips = _numberOfSlides;
          });

          await _pageController.animateToPage(
              _newAssets.length - 1,
              duration: Ratioz.duration1000ms, curve: Curves.easeInOut
          );

          // print(_assets.toString());
          // print(_picsFits.toString());
          // print(_assetsAsFiles.toString());
          // print(_titleControllers.toString());
          // print(_matrixes.toString());
          // print(_slidesVisibility.toString());
        }

      }

    }

    _triggerLoading();

  }
// -----------------------------------------------------------------------------
  List<Widget> _buildSlides(){
    // print('========= BUILDING PROGRESS BAR FOR ||| index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

    BoxFit _currentPicFit = _picsFits.length == 0 ? null : _picsFits[_currentSlideIndex];

    ImageSize _originalAssetSize =
    _numberOfSlides == 0 ? null :
    _assets.length == 0 ? null :
    ImageSize(
      width: _assets[_currentSlideIndex].originalWidth,
      height: _assets[_currentSlideIndex].originalHeight,
    );

    return
        <Widget>[
          ...List.generate(_numberOfSlides, (i){

            return
            _numberOfSlides == 0 ? Container() :
              AnimatedOpacity(
                key: ObjectKey(widget.draftFlyerModel.key.value + i),
                opacity: _slidesVisibility[i] == true ? 1 : 0,
                duration: _fadingDuration,
                child: SingleSlide(
                  key: ObjectKey(widget.draftFlyerModel.key.value + i),
                  flyerZoneWidth: widget.flyerZoneWidth,
                  flyerID: null, //_flyer.flyerID,
                  picture: _assetsAsFiles[i],//_currentSlides[index].picture,
                  slideMode: SlideMode.Editor,//slidesModes[index],
                  boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                  titleController: _titleControllers[i],
                  imageSize: _originalAssetSize,
                  textFieldOnChanged: (text){
                    print('text is : $text');
                  },
                ),
              );

          }),
        ];
  }
// -----------------------------------------------------------------------------
  Future<void> _deleteSlide() async {

    /// A - if slides are empty
    if (_numberOfSlides == 0){
      print('nothing can be done');
    }

    /// A - if slides are not empty
    else {

      /// B - if at (FIRST) slide
      if (_currentSlideIndex == 0){
        await _deleteFirstSlide();
      }

      /// B - if at (LAST) slide
      else if (_currentSlideIndex + 1 == _numberOfSlides){
        _deleteMiddleOrLastSlide();
      }

      /// B - if at (Middle) slide
      else {
        _deleteMiddleOrLastSlide();
      }

    }

  }
// ------------------------------------------------o
  Future<void> _deleteFirstSlide() async {
    print('DELETING STARTS AT (FIRST) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides ------------------------------------');

    /// 1 - if only one slide remaining
    if(_numberOfSlides == 1){

      print('_slidesVisibility : ${_slidesVisibility.toString()}, _numberOfSlides : $_numberOfSlides');

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerVisibility(_currentSlideIndex);
        _numberOfStrips = 0;
      });

      /// B - wait fading to start deleting + update index to null
      await Future.delayed(_fadingDurationX, () async {

        /// Dx - delete data
        setState(() {
          _statelessDelete(_currentSlideIndex);
          _currentSlideIndex = null;
        });

      });

    }

    /// 2 - if two slides remaining
    else if(_numberOfSlides == 2){

      /// A - decrease progress bar and trigger visibility
      setState(() {
        onPageChangedIsOn = false;
        _statelessTriggerVisibility(_currentSlideIndex);
        _numberOfStrips = _numberOfSlides - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(_fadingDurationX, () async {

        /// C - slide
        await Sliders.slideToNext(_pageController, _numberOfSlides, _currentSlideIndex);


        /// D - delete when one slide remaining
        /// E - wait for sliding to end
        await Future.delayed(_fadingDurationX, () async {


          // /// F - snap to index 0
          // await Sliders.snapTo(_pageController, 0);
          //
          // print('now i can swipe again');
          //
          // /// G - trigger progress bar listener (onPageChangedIsOn)
          setState(() {
            /// Dx - delete data
            _statelessDelete(_currentSlideIndex);
            _currentSlideIndex = 0;
            // _numberOfSlides = 1;
            onPageChangedIsOn = true;
          });

        });


      });
    }

    /// 2 - if more than two slides
    else {

      int _originalNumberOfSlides = _numberOfSlides;
      int _decreasedNumberOfSlides =  _numberOfSlides - 1;
      // int _originalIndex = 0;
      // int _decreasedIndex = 0;

      /// A - decrease progress bar and trigger visibility
      setState(() {
        onPageChangedIsOn = false;
        _statelessTriggerVisibility(_currentSlideIndex);
        _numberOfSlides = _decreasedNumberOfSlides;
        _numberOfStrips = _numberOfSlides;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(_fadingDurationX, () async {

        /// C - slide
        await  Sliders.slideToNext(_pageController, _numberOfSlides, _currentSlideIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfSlides <= 1){

          setState(() {
            /// Dx - delte data
            _statelessDelete(_currentSlideIndex);
            onPageChangedIsOn = true;
          });

        }

        /// D - delete when at many slides remaining
        else {

          /// E - wait for sliding to end
          await Future.delayed(_fadingDurationX, () async {

            /// Dx - delete data
            _statelessDelete(_currentSlideIndex);
            /// F - snap to index 0
            await Sliders.snapTo(_pageController, 0);

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
              onPageChangedIsOn = true;
            });

          });

        }

      });

    }

    print('DELETING ENDS AT (FIRST) : index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides ------------------------------------');
  }
// ------------------------------------------------o
  Future<void> _deleteMiddleOrLastSlide() async {
    print('XXXXX ----- DELETING STARTS AT (MIDDLE) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

    int _originalIndex = _currentSlideIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      onPageChangedIsOn = false;
      _currentSlideIndex = _currentSlideIndex - 1;
      _swipeDirection = SwipeDirection.freeze;
      _numberOfStrips = _numberOfSlides - 1;
      _statelessTriggerVisibility(_originalIndex);
    });

    // print('XXX after first rebuild AT (MIDDLE) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

    /// B - wait fading to start sliding
    await Future.delayed(_fadingDurationX, () async {

      // print('_currentIndex before slide : $_currentSlideIndex');

      /// C - slide
      await  Sliders.slideToBackFrom(_pageController, _originalIndex);
      // print('_currentIndex after slide : $_currentSlideIndex');

      /// E - wait for sliding to end
      await Future.delayed(_fadingDurationX, () async {

        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessDelete(_originalIndex);
          onPageChangedIsOn = true;
        });

        // print('XXX after second rebuild AT (MIDDLE) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

      });

      // print('XXX after third LAST rebuild AT (MIDDLE) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

    });

    print('XXXXX -------  DELETING ENDS AT (MIDDLE) : index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');
  }
// ------------------------------------------------o
  void _statelessTriggerVisibility(int index) {

    if (index != null){
      if(index >= 0 && _slidesVisibility.length != 0){
        print('_slidesVisibility[index] was ${_slidesVisibility[index]} for index : $index');
        _slidesVisibility[index] = !_slidesVisibility[index];
        print('_slidesVisibility[index] is ${_slidesVisibility[index]} for index : $index');
      }
      else {
        print('can not trigger visibility for index : $index');
      }
    }

  }
// ------------------------------------------------o
  void _statelessDelete(int index){
    print('before stateless delete index was $index, _numberOfSlides was : $_numberOfSlides');
    _assetsAsFiles.removeAt(index);
    _assets.removeAt(index);
    _slidesVisibility.removeAt(index);
    _titleControllers.removeAt(index);
    _picsFits.removeAt(index);
    _matrixes.removeAt(index);
    _numberOfSlides = _assets.length;
    print('after stateless delete index is $index, _numberOfSlides is : $_numberOfSlides');
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

    ImageSize _originalAssetSize = _assets.length == 0 || _assets == null ? null : ImageSize(
      width: _assets[_currentSlideIndex].originalWidth,
      height: _assets[_currentSlideIndex].originalHeight,
    );

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

            bool _blurLayerIsActive = Imagers().slideBlurIsOn(
              pic: _assetsAsFiles[_currentSlideIndex],
              boxFit: _picsFits[_currentSlideIndex],
              flyerZoneWidth: widget.flyerZoneWidth,
              imageSize: ImageSize(
                width: _assets[_currentSlideIndex].originalWidth,
                height: _assets[_currentSlideIndex].originalHeight,
              ),
            );

            print('_currentSlideIndex : $_currentSlideIndex');
            print('_blurLayerIsActive : $_blurLayerIsActive');

            setState(() {
              // onPageChangedIsOn = true;
              _numberOfSlides = _assets.length;
            });

            _triggerLoading();
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

                              else {
                                setState(() {
                                  _picsFits[_currentSlideIndex] = BoxFit.fitWidth;
                                });
                              }

                              // else {
                              //   setState(() {
                              //     _picsFits[_currentSlideIndex] = BoxFit.fitWidth;
                              //   });
                              // }

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

                              if (_assetsAsFiles.length != 0){
                                await _cropImage(_assetsAsFiles[_currentSlideIndex]);
                              }

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

                              await _deleteSlide(
                                // numberOfSlides: _numberOfSlides,
                                // currentSlide: _currentSlideIndex,
                              );

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
                              _statelessTriggerVisibility(_currentSlideIndex);
                            },
                          ),

                          /// Slide right
                          PanelButton(
                            size: _buttonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.DvDonaldDuck,
                            verse: 'direction',
                            onTap: () async {

                              setState(() {
                                _swipeDirection = SwipeDirection.freeze;
                              });

                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                /// FLYER
                // _assetsAsFiles.length == 0 ? Loading(loading: _loading) :
                Container(
                  width: _flyerZoneWidth,
                  height: _flyerZoneHeight,
                  decoration: BoxDecoration(
                    color: Colorz.White10,
                    borderRadius: Borderers.superFlyerCorners(context, _flyerZoneWidth),
                  ),
                  child: ClipRRect(
                    borderRadius: Borderers.superFlyerCorners(context, _flyerZoneWidth),
                    child: Stack(
                      children: <Widget>[

                        /// SLIDES
                        // NotificationListener<ScrollNotification>(
                        //   onNotification: (ScrollNotification notification){
                        // if (notification is ScrollUpdateNotification){
                        //   print('bommm');
                        // }
                        // return true;
                        // },
                        //
                        // /// slides if pageview.builder
                        // child: PageView.builder(
                        //     pageSnapping: true,
                        //     controller: _pageController,
                        //     physics: BouncingScrollPhysics(),
                        //     allowImplicitScrolling: true,
                        //     itemCount: _assets.length,
                        //     onPageChanged: onPageChangedIsOn ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
                        //     itemBuilder: (ctx, i){
                        //
                        //       double _ratio = _assets[i].originalWidth / _assets[i].originalHeight;
                        //
                        //       return
                        //
                        //         AnimatedOpacity(
                        //           key: ObjectKey(widget.draftFlyerModel.key.value + i),
                        //           opacity: _slidesVisibility[i] == true ? 1 : 0,
                        //           duration: Duration(milliseconds: 100),
                        //           child: SingleSlide(
                        //             key: ObjectKey(widget.draftFlyerModel.key.value + i),
                        //             flyerZoneWidth: _flyerZoneWidth,
                        //             flyerID: null, //_flyer.flyerID,
                        //             picture: _assetsAsFiles[i],//_currentSlides[index].picture,
                        //             slideMode: SlideMode.Editor,//slidesModes[index],
                        //             boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                        //             titleController: _titleControllers[i],
                        //             imageSize: _originalAssetSize,
                        //             textFieldOnChanged: (text){
                        //               print('text is : $text');
                        //             },
                        //           ),
                        //         );
                        //
                        //     }
                        // ),
                        // ),

                        /// slides as pageview
                        if(_currentSlideIndex != null)
                        PageView(
                          pageSnapping: true,
                          controller: _pageController,
                          physics: BouncingScrollPhysics(),
                          allowImplicitScrolling: false,
                          clipBehavior: Clip.antiAlias,
                          restorationId: '${widget.draftFlyerModel.key.value}',
                          onPageChanged: onPageChangedIsOn ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            ..._buildSlides(),
                          ],
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

                        /// PROGRESS BAR
                        if(_numberOfStrips != 0 && _currentSlideIndex != null)
                        ProgressBar(
                          flyerZoneWidth: _flyerZoneWidth,
                          numberOfStrips: _numberOfStrips,
                          slideIndex: _currentSlideIndex,
                          swipeDirection: _swipeDirection,
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
