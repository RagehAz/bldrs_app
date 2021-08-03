import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/appbar/app_bar_button.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class FlyerTestScreen extends StatefulWidget {

  @override
  _FlyerTestScreenState createState() => _FlyerTestScreenState();
}

class _FlyerTestScreenState extends State<FlyerTestScreen> {
  String _flyerID;
  TinyFlyer _tinyFlyer;
  FlyerModel _flyerModel;
  BzModel _bzModel;
  double _flyerOpacity = 0;

  String _url;
  File _file;
  Asset _asset;
  List<Asset> _assets = new List();
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {

    // _flyerOpacity = 1;

    super.initState();
  }
  // -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      TinyFlyer _dbTinyFlyer;
      // FlyerModel _dbFlyerModel;
      // BzModel _dbBzModel;

      _triggerLoading(function: (){
        // _flyerOpacity = 0;
      }).then((_) async {
        /// ---------------------------------------------------------0

        _flyerID = 'yx5oI0N5ECROleFGLxrc';

        /// ---------------------------------------------------------0

        _dbTinyFlyer = await FlyerOps().readTinyFlyerOps(
          flyerID: _flyerID,
          context: context,
        );

        /// ---------------------------------------------------------0

        // FlyerModel _dbFlyerModel = await FlyerOps().readFlyerOps(
        //     context: context,
        //     flyerID: _flyerID);
        //
        //
        // if (_dbFlyerModel == null){
        //   print('FLYER TEST SCREEN : did not find tiny flyer $_flyerID');
        // }
        // else {
        //   print('FLYER TEST SCREEN : found $_flyerID for company : ${_dbFlyerModel.tinyBz.bzName}');
        // }

        /// ---------------------------------------------------------0

        // String _theFlyerID = 'yx5oI0N5ECROleFGLxrc';
        //
        // TinyFlyer _tinyFlyerForBz = await FlyerOps().readTinyFlyerOps(context: context, flyerID: _theFlyerID);
        // String _bzID = _tinyFlyerForBz.tinyBz.bzID;

        // // String _bzID = '4q5byHJEKfO5Y7SrAxEX';
        // //
        // _dbBzModel = await BzOps.readBzOps(context: context, bzID: _bzID);
        // //
        // if (_dbBzModel == null){
        //   print('FLYER TEST SCREEN : did not find bz :  $_bzID');
        // }
        // else {
        //   print('FLYER TEST SCREEN : found bzID : $_bzID for company : ${_dbBzModel.bzName}');
        // }

        /// ---------------------------------------------------------0

        _url = _dbTinyFlyer.slidePic;

        _triggerLoading(
            function: (){
              // _bzModel = _dbBzModel;
              _tinyFlyer = _dbTinyFlyer;
              // _flyerModel = _dbFlyerModel;
              // _flyerID = 'yx5oI0N5ECROleFGLxrc';
              _flyerID = null;
              _flyerOpacity = 1;
            }
        );

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, 0.8);

    print('----------> building flyer test screen flyerID : $_flyerID, tinyFlyer : $_tinyFlyer, FlyerModel : $_flyerModel, BzModel : $_bzModel');

    bool _canBuildFlyer = _flyerID != null || _tinyFlyer != null || _flyerModel != null || _bzModel != null ? true : false;
    bool _canFadeFlyer = _flyerOpacity != null ? true : false;

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      pageTitle: 'Flyer Test Screen',
      loading: _loading,
      appBarRowWidgets: [

        AppBarButton(
            verse: 'opacity',
            onTap: (){
              print('thing');
              setState(() {
                _flyerOpacity = _flyerOpacity == 0 ? 1 : 0;
              });
            },
        )
      ],
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          // if(_canFadeFlyer == true)
          // AnimatedOpacity(
          //   opacity: _flyerOpacity,
          //   duration: Ratioz.durationSliding400,
          //   child:
          //   _canBuildFlyer ?
          //   FinalFlyer(
          //     flyerZoneWidth: _flyerZoneWidth,
          //     tinyFlyer: _tinyFlyer,
          //     flyerID: _flyerID,
          //     flyerModel: _flyerModel,
          //     bzModel: _bzModel,
          //     goesToEditor: false,
          //     inEditor: true,
          //     initialSlideIndex: 0,
          //     onSwipeFlyer: null,
          //   )
          //
          //       :
          //
          //       Container(),
          // )

          DreamBox(
            height: 80,
            width: 300,
            verse: 'url : ${_url}',
            verseScaleFactor: 0.7,
            icon: _url,
            onTap: () async {

              _triggerLoading();

              File _theFile = await Imagers.urlToFile(_url);
              // Asset _theAsset = await Imagers.urlToAsset(_url);
              setState(() {
                _file = _theFile;
                // _asset = _theAsset;
              });


              ImageSize imageSize = await Imagers.superImageSize(_file);

              print('file test : _theFile.path : ${_theFile.path}');
              print('file test : _theFile.absolute : ${_theFile.absolute}');
              print('file test : _theFile.uri : ${_theFile.uri}');
              print('file test : _theFile.hashCode : ${_theFile.hashCode}');
              print('file test : _theFile.parent : ${_theFile.parent}');
              print('file test : _theFile.isAbsolute : ${_theFile.isAbsolute}');
              print('file test : _theFile.statSync() : ${_theFile.statSync()}');

              String _fileNameWithExtension = TextMod.trimTextBeforeLastSpecialCharacter(_theFile.path, '/');
              String _fileName = TextMod.trimTextAfterLastSpecialCharacter(_fileNameWithExtension, '.');

              print('file test : _fileName : ${_fileName}');

              // _asset = Asset(
              //     // identifier
              //     _theFile.,
              //     // _name
              //     _theFile.fileNameWithExtension,
              //     // _originalWidth
              //       imageSize.width,
              //     // _originalHeight
              //     imageSize.height,
              //   );

              // setState(() {
              //   _file = _theFile;
              //   // _asset = _theAsset;
              // });

              // print('DON DON : _asset is : ${_asset.name}');

              _triggerLoading();

            },
          ),

          DreamBox(
            height: 80,
            width: 300,
            verse: 'file : ${_file}',
            verseScaleFactor: 0.7,
            subChild: Imagers.superImageWidget(_file, ),
          ),

          DreamBox(
            height: 80,
            width: 300,
            verse: 'asset : ${_asset}',
            verseScaleFactor: 0.7,
            subChild: Imagers.superImageWidget(_asset, ),
          ),

          DreamBox(
            height: 80,
            width: 300,
            verse: 'picker',
            verseScaleFactor: 0.7,
            onTap: () async {
              List<Asset> _outputAssets;
              _outputAssets = await Imagers.getMultiImagesFromGallery(
                context: context,
                images: _assets,
                mounted: mounted,
                accountType: BzAccountType.Premium,
              );

              if (_outputAssets != null){
                print('file test : _outputAssets[0].name : ${_outputAssets[0].name}');
                print('file test : _outputAssets[0].identifier : ${_outputAssets[0].identifier}');
                print('file test : _outputAssets[0].identifier : ${_outputAssets[0].metadata}');

                setState(() {
                  _asset = _outputAssets[0];
                });

              }


            },
          ),

        ],
      ),
    );
  }
}
