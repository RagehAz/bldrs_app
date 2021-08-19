import 'dart:io';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_and_bzz/bz_streamer.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/new_header.dart';
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


        bzModelBuilder(
          context: context,
          bzID: '4q5byHJEKfO5Y7SrAxEX',
          builder: (ctx, bzModel){
            return
              NewHeader(
                  superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
                      onHeaderTap: null,
                      bzModel: bzModel
                  ),
                  flyerZoneWidth: Scale.superScreenWidth(context) * 0.8,
              );

          }
        ),

      ],

    );



  }
}
