import 'dart:io';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/views/widgets/appbar/app_bar_button.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/flyer/flyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class FlyerTestScreen extends StatefulWidget {

  @override
  _FlyerTestScreenState createState() => _FlyerTestScreenState();
}

class _FlyerTestScreenState extends State<FlyerTestScreen> {
  String _flyerID;
  String _newFlyerID;
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

        _flyerID = '3y5AXpheljSq8b0EaSYc';

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

        // _url = _dbTinyFlyer.slidePic;

        _triggerLoading(
            function: (){
              // _bzModel = _dbBzModel;
              _tinyFlyer = _dbTinyFlyer;
              // _flyerModel = _dbFlyerModel;
              // _flyerID = 'yx5oI0N5ECROleFGLxrc';
              // _flyerID = null;
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
  void didUpdateWidget(covariant FlyerTestScreen oldWidget) {
  print('didUpdate widget aho');

  if(_flyerID != _newFlyerID){
      setState(() {

      });
    }
    super.didUpdateWidget(oldWidget);
  }

  TinyFlyer _tinyFlyer;
  Future<void> changeFlyer(String newFlyerID) async {
    String _oldFlyerID = _flyerID;

    TinyFlyer _dbTinyFlyer = await FlyerOps().readTinyFlyerOps(
      flyerID: newFlyerID,
      context: context,
    );

    setState(() {
      _tinyFlyer = _dbTinyFlyer;
    });
  }
// -----------------------------------------------------------------------------
  Color _testColor;
void changeColor(Color color){
  setState(() {
    _testColor = color;
  });
}
// -----------------------------------------------------------------------------
  bool _someSizeMissing(FlyerModel flyer){
  bool _isMissing = false;

  if(flyer != null){
    if(flyer.slides != null && flyer.slides.length != 0){
      for (var slide in flyer.slides){
        if(slide.imageSize == null){
          _isMissing = true;
        }
      }
    }
  }

  return _isMissing;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, 0.8);

    print('----------> building flyer test screen flyerID : $_flyerID, tinyFlyer : $_tinyFlyer, FlyerModel : $_flyerModel, BzModel : $_bzModel');

    bool _canBuildFlyer = _flyerID != null || _tinyFlyer != null || _flyerModel != null || _bzModel != null ? true : false;
    bool _canFadeFlyer = _flyerOpacity != null ? true : false;

    return TestLayout(
      screenTitle: 'Flyer Test Screen',
      appbarButtonVerse: 'opacity',
      appbarButtonOnTap:
              () {
        print('thing');
        setState(() {
          _flyerOpacity = _flyerOpacity == 0 ? 1 : 0;
        });
      },

      listViewWidgets: [


        if(_canBuildFlyer == true)
          Flyer(
            flyerZoneWidth: Scale.superFlyerZoneWidth(context, 0.5),
            tinyFlyer: _tinyFlyer,
            initialSlideIndex: 0,
            goesToEditor: false,
            // flyerID: _flyerID,
          ),

        // DreamBox(
        //   height: 80,
        //   width: 300,
        //   verse: 'url : ${_url}',
        //   verseScaleFactor: 0.7,
        //   icon: _url,
        //   onTap: () async {
        //
        //     // _triggerLoading();
        //     //
        //     // File _theFile = await Imagers.urlToFile(_url);
        //     // // Asset _theAsset = await Imagers.urlToAsset(_url);
        //     // setState(() {
        //     //   _file = _theFile;
        //     //   // _asset = _theAsset;
        //     // });
        //     //
        //     //
        //     // ImageSize imageSize = await ImageSize.superImageSize(_file);
        //     //
        //     // print('file test : _theFile.path : ${_theFile.path}');
        //     // print('file test : _theFile.absolute : ${_theFile.absolute}');
        //     // print('file test : _theFile.uri : ${_theFile.uri}');
        //     // print('file test : _theFile.hashCode : ${_theFile.hashCode}');
        //     // print('file test : _theFile.parent : ${_theFile.parent}');
        //     // print('file test : _theFile.isAbsolute : ${_theFile.isAbsolute}');
        //     // print('file test : _theFile.statSync() : ${_theFile.statSync()}');
        //     //
        //     // String _fileNameWithExtension = TextMod.trimTextBeforeLastSpecialCharacter(_theFile.path, '/');
        //     // String _fileName = TextMod.trimTextAfterLastSpecialCharacter(_fileNameWithExtension, '.');
        //     //
        //     // print('file test : imageSize : ${imageSize.height} : ${imageSize.width}');
        //
        //     // _asset = Asset(
        //     //     // identifier
        //     //     _theFile.,
        //     //     // _name
        //     //     _theFile.fileNameWithExtension,
        //     //     // _originalWidth
        //     //       imageSize.width,
        //     //     // _originalHeight
        //     //     imageSize.height,
        //     //   );
        //
        //     // setState(() {
        //     //   _file = _theFile;
        //     //   // _asset = _theAsset;
        //     // });
        //
        //     // print('DON DON : _asset is : ${_asset.name}');
        //
        //     _triggerLoading();
        //
        //   },
        // ),
        //
        // DreamBox(
        //   height: 80,
        //   width: 300,
        //   verse: 'file : ${_file}',
        //   verseScaleFactor: 0.7,
        //   subChild: Imagers.superImageWidget(_file, ),
        // ),

        // DreamBox(
        //   height: 80,
        //   width: 300,
        //   verse: 'asset : ${_asset}',
        //   verseScaleFactor: 0.7,
        //   subChild: Imagers.superImageWidget(_asset, ),
        // ),

        // DreamBox(
        //   height: 80,
        //   width: 300,
        //   verse: 'picker',
        //   verseScaleFactor: 0.7,
        //   onTap: () async {
        //     List<Asset> _outputAssets;
        //     _outputAssets = await Imagers.getMultiImagesFromGallery(
        //       context: context,
        //       images: _assets,
        //       mounted: mounted,
        //       accountType: BzAccountType.Premium,
        //     );
        //
        //     if (_outputAssets != null){
        //       print('file test : _outputAssets[0].name : ${_outputAssets[0].name}');
        //       print('file test : _outputAssets[0].identifier : ${_outputAssets[0].identifier}');
        //       print('file test : _outputAssets[0].identifier : ${_outputAssets[0].metadata}');
        //
        //       setState(() {
        //         _asset = _outputAssets[0];
        //       });
        //
        //     }
        //
        //
        //   },
        // ),

        ///----------
        DreamBox(
          height: 80,
          width: 300,
          verse: 'firstID : 1ghM9LA8pkDxLcAHNyj2',
          secondLine: 'current ID : ${_tinyFlyer?.flyerID}',
          verseScaleFactor: 0.7,
          onTap: () => changeFlyer('1ghM9LA8pkDxLcAHNyj2'),
        ),
        DreamBox(
          height: 80,
          width: 300,
          verse: 'firstID : 2fDlDyF01sw8GEYPJ9GN',
          secondLine: 'current ID : ${_tinyFlyer?.flyerID}',
          verseScaleFactor: 0.7,
          onTap: () => changeFlyer('2fDlDyF01sw8GEYPJ9GN'),
        ),
        DreamBox(
          height: 80,
          width: 300,
          verse: 'do the thing',
          verseScaleFactor: 0.7,
          onTap: () async {

            List<dynamic> _flyerMaps = await Fire.readCollectionDocs(FireCollection.flyers);

            int _numberOfFlyers = _flyerMaps.length;

            print('_numberOfFlyers is : $_numberOfFlyers');

            int _currentFlyer = 0;

            for (var map in _flyerMaps){
              _currentFlyer++;

              FlyerModel _flyer = FlyerModel.decipherFlyerMap(map);
              print('Flyer : $_currentFlyer :: OOO - working on flyer ---> ${_flyer.flyerID}');

              if(_flyer != null){
                if(_flyer.flyerID != null){
                  TinyFlyer _tiny = TinyFlyer.getTinyFlyerFromFlyerModel(_flyer);
                  print('Flyer : $_currentFlyer :: OO1 - got tinyFlyer ---> ${_tiny.flyerID}');

                  setState(() {
                    _tinyFlyer = _tiny;
                  });
                  print('Flyer : $_currentFlyer :: OO2 - setState for db tinyFlyer to widget');

                  await Fire.updateDoc(
                    collName: FireCollection.tinyFlyers,
                    docName: _flyer.flyerID,
                    context: context,
                    input: _tiny.toMap(),
                  );
                  print('Flyer : $_currentFlyer :: OO3 - updated tinyFlyer in db');

                }
              }

            }

            },
        ),
        ///----------
      ],

    );



  }
}

class BOXXX extends StatefulWidget {
  final Color color;
  BOXXX({
    @required this.color,
  });
  @override
  _BOXXXState createState() => _BOXXXState();
}

class _BOXXXState extends State<BOXXX> {
  Color _color;
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

    if(widget.color == null){
      _color = Colorz.Red255;
    }
    else {
      _color = widget.color;
    }

    super.initState();
  }
// -----------------------------------------------------------------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       _triggerLoading().then((_) async {
//
//         Future.delayed(Duration(seconds: 5), () async {
//
//           setState(() {
//             _color = Colorz.Yellow200;
//           });
//
//         });
//
//
//         /// X - REBUILD
//         _triggerLoading(function: (){
//
//         });
//
//       });
//
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
// -----------------------------------------------------------------------------

  @override
  void didUpdateWidget(covariant BOXXX oldWidget) {
    if(_color != widget.color){
      setState(() {
        _color = widget.color;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DreamBox(
      height: 50,
      width: 50,
      color: _color,
      // color: widget.color,
    );
  }
}
