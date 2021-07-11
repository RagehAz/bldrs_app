import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/stacks/slides_stack.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class DraftFlyerModel{
  TextEditingController titleController;
  List<Asset> assets;
  List<File> assetsAsFiles;
  List<BoxFit> boxesFits;
  ValueKey key;

  DraftFlyerModel({
    @required this.titleController,
    @required this.assets,
    @required this.assetsAsFiles,
    @required this.boxesFits,
    @required this.key,
});

  static List<ValueKey> getKeysOfDrafts(List<DraftFlyerModel> drafts){
    List<ValueKey> _keys = new List();

    if(drafts != null){
      drafts.forEach((draft) {
        _keys.add(draft.key);
      });

    }

    return _keys;
  }

}

class FlyerPublisherScreen extends StatefulWidget {
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  FlyerPublisherScreen({
    @required this.bzModel,
    this.firstTimer = false,
    this.flyerModel,
  });

  @override
  _FlyerPublisherScreenState createState() => _FlyerPublisherScreenState();
}

class _FlyerPublisherScreenState extends State<FlyerPublisherScreen> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  ScrollController _scrollController = new ScrollController();
  Curve _animationCurve = Curves.easeOut;
  Duration _animationDuration = Ratioz.fadingDuration;
// -----------------------------------------------------------------------------
  List<DraftFlyerModel> _draftFlyers = new List();
// -----------------------------------------------------------------------------
  List<double> _draftsOpacities = new List();
  List<double> _draftsHeightsList = new List();
  double _draftMaxHeight = 340;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){

    _draftFlyers.forEach((draft) {
      TextEditingController _controller = draft.titleController;
      if (TextChecker.textControllerHasNoValue(_controller))_controller.dispose();
    });

    _scrollController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  double _getDraftPosition(int index){
    double _draftYOffsetFromScreenTop = ( (_draftMaxHeight * (index)) + Ratioz.appBarMargin);
    return _draftYOffsetFromScreenTop;
  }
// -----------------------------------------------------------------------------
  Future <void> _scrollToDraft(int index) async {

    double _position = _getDraftPosition(index);

    await _scrollController.animateTo(
      _position,
        duration: Ratioz.slidingTransitionDuration,
        curve: _animationCurve,
    );
  }
// -----------------------------------------------------------------------------
  int _createKeyValue(List<ValueKey> keys){
    Random _random = new Random();
    int _randomNumber = _random.nextInt(100000); // from 0 upto 99 included

    if(keys.contains(ValueKey(_randomNumber))){
      _randomNumber = _createKeyValue(keys);
    }

    return _randomNumber;
  }
// -----------------------------------------------------------------------------
  void _printAfter(bool after){

    if(after == true){
      print('---This line is AFTER EVENTS ----------------------------------------');
    } else {
      print('---This line is BEFORE EVENTS ----------------------------------------');
    }

    print('_stackHeightsList : ${_draftsHeightsList.toString()}');
    print('_stacksOpacities : ${_draftsOpacities.toString()}');
    print('_keys : ${_draftFlyers.toString()}');

    if(after == true){
      print('--- EVENTS & CHECK PRINT ENDED ----------------------------------------');
    } else {
      print('---EVENTS START HERE ----------------------------------------');
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _addFlyer() async {

    /// A - if less than 5 drafts
    if (_draftFlyers.length < 5){
      _printAfter(false);
      int _newIndex = _draftFlyers.length;

      setState(() {

        _draftsHeightsList.add(0);
        _draftsOpacities.add(0);

        _draftFlyers.add(
            DraftFlyerModel(
              titleController: new TextEditingController(),
              assets: new List(),
              assetsAsFiles: new List(),
              boxesFits: new List(),
              key: ValueKey(_createKeyValue(DraftFlyerModel.getKeysOfDrafts(_draftFlyers))),
            )
        );

      });

      await _fadeInAndExpandStack(_newIndex);
      await _scrollToBottom();
      _printAfter(true);

    }

    /// A - if 5 drafts reached
    else {

      await superDialog(
        context: context,
        title: 'Too many Draft flyers',
        body: 'Please Publish or remove any of the previous draft flyers to be able to add a new flyer',
        boolDialog: false,
      );

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _deleteFlyer({int index}) async {

    _printAfter(false);

    await _fadeOutAndShrinkStack(index);

    await Future.delayed(_animationDuration, () async {

      if (index != 0 ){
        await _scrollToDraft(index - 1);
      }

      setState(() {
        _draftFlyers.removeAt(index);
        _draftsOpacities.removeAt(index);
        _draftsHeightsList.removeAt(index);
      });
    });


    _printAfter(true);

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeOutAndShrinkStack(int index) async {
    await Future.delayed( _animationDuration, () async {
      setState(() {
      _draftsOpacities[index] = 0;
      });
    });

    setState(() {
      _draftsHeightsList[index] = 0;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeInAndExpandStack(int index) async {

    await Future.delayed(Ratioz.slidingTransitionDuration, () async {
      setState(() {
        _draftsOpacities[index] = 1;

      });
    });

    setState(() {
      _draftsHeightsList[index] = _draftMaxHeight;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _scrollToBottom() async {

    await Future.delayed(Ratioz.slidingTransitionDuration, () async {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: _animationDuration,
        curve: _animationCurve,
      );
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _getMultiImages({BzAccountType accountType, int draftIndex}) async {

    _triggerLoading();

      List<Asset> _inputAssets = _draftFlyers[draftIndex].assets;

      /// if flyer reached max slides
      if(Standards.getMaxFlyersSlidesByAccountType(accountType) <= _inputAssets.length ){
        await superDialog(
          context: context,
          title: 'Obbaaaa',
          body: 'Ta3alaaaaaaa ba2aaa ya 7abibi',
        );
      }

      /// if still picking images
      else {

        List<Asset> _outputAssets;

        if(mounted){
          _outputAssets = await getMultiImagesFromGallery(
            context: context,
            images: _inputAssets,
            mounted: mounted,
            accountType: accountType,
          );

          if(_outputAssets.length == 0){
            // will do nothing
          } else {

            List<BoxFit> _fits = new List();
            List<File> _assetsAsFiles = new List();

            for (Asset asset in _outputAssets){
              File _file = await getFileFromCropperAsset(asset);
              _assetsAsFiles.add(_file);

              if(asset.isPortrait){
                _fits.add(BoxFit.fitHeight);
              } else {
                _fits.add(BoxFit.fitWidth);
              }

            }

            setState(() {
              _draftFlyers[draftIndex].assets = _outputAssets;
              _draftFlyers[draftIndex].boxesFits = _fits;
              _draftFlyers[draftIndex].assetsAsFiles = _assetsAsFiles;
            });
            
          }

        }

        if(_outputAssets.length == _inputAssets.length){
          print('lengths are the same, length ${_outputAssets.length}');
        } else {
          print('lengths are not the same , length ${_outputAssets.length}');
        }


      }

      _triggerLoading();

  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: 'Add multiple flyers',
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      loading: _loading,
      appBarRowWidgets: <Widget>[

      ],
      layoutWidget: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        reverse: false,
        addAutomaticKeepAlives: true,
        children: <Widget>[

          /// STRATOSPHERE
          Stratosphere(),

          /// Initial Paragraph
          // Container(
          //   width: Scale.superScreenWidth(context),
          //   height: Ratioz.appBarSmallHeight,
          //   padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
          //   child: SuperVerse(
          //     verse: 'Add a flyer',
          //     centered: false,
          //     labelColor: Colorz.WhiteAir,
          //   ),
          // ),

          /// SPREAD FLYERS
          ...List.generate(
              _draftFlyers.length,
                  (_draftIndex) => AnimatedContainer(
                    duration: _animationDuration,
                    curve: _animationCurve,
                    height: _draftsHeightsList[_draftIndex],
                    child: AnimatedOpacity(
                      key: _draftFlyers[_draftIndex].key,
                      curve: _animationCurve,
                      duration: _animationDuration,
                      opacity: _draftsOpacities[_draftIndex],
                      child: SlidesStack(
                        bzModel: widget.bzModel,
                        firstTimer: widget.firstTimer,
                        draftFlyerModel: _draftFlyers[_draftIndex],
                        draftIndex: _draftIndex,
                        stackHeight: _draftMaxHeight,
                        onDeleteDraft: () => _deleteFlyer(index: _draftIndex),
                        onAddPics: () => _getMultiImages(
                          accountType: BzAccountType.Premium,
                          draftIndex: _draftIndex,

                        ),
          ),
                    ),
                  )
          ),

          /// ADD NEW FLYER BUTTON
          Container(
            width: Scale.superScreenWidth(context),
            height: 100,
            alignment: Alignment.center,
            color: Colorz.White10,
            margin: EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
            child: DreamBox(
              height: 70,
              icon: Iconz.AddFlyer,
              iconSizeFactor: 0.7,
              verse: 'Add a new Flyer',
              color: Colorz.White10,
              bubble: false,
              onTap: _addFlyer,
              inActiveMode: _draftFlyers.length < Standards.maxDraftsAtOnce ? false : true,
            ),
          ),

          /// HORIZON
          SizedBox(
            width: Scale.superScreenWidth(context),
            height: (Scale.superScreenHeight(context) - (Ratioz.stratosphere + _draftMaxHeight + 100 + (Ratioz.appBarMargin * 4))),
          ),

          /// GIF THING
          // check this
          // https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
          // https://pub.dev/packages/file_picker
          // Container(
          //   width: 200,
          //   height: 200,
          //   margin: EdgeInsets.all(30),
          //   color: Colorz.BloodTest,
          //   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
          // ),


        ],
      ),
    );
  }
}