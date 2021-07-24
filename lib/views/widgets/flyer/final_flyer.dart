import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/tiny_flyer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*

1 - user view random published flyer
2 - user view saved published flyer
3 - author view random published flyer
4 - author view owned published flyer
5 - author edit owned published flyer
6 - author edit owned draft flyer

A - flyer is saved flyers
B - flyer in walls
C - flyer in MyBzScreen
D - flyer in editor
E - flyer in bzGallery

 */

enum FlyerMode {
  tiny,
  tinyWithID,
  normal,
  normalWithID,
  empty,
  draft,

}

/// TASK : delete this and below comments when FinalFlyer is done
/// this should be universal and eliminate all other versions TinyFlyerWidget - Flyer - AFlyer
class FinalFlyer extends StatefulWidget {
  final double flyerSizeFactor;
  final FlyerModel flyerModel;
  final TinyFlyer tinyFlyer;
  final String flyerID;
  final int initialSlideIndex;
  final Function onSwipeFlyer;

  const FinalFlyer({
    this.flyerSizeFactor = 1,
    this.flyerModel,
    this.tinyFlyer,
    this.flyerID,
    this.initialSlideIndex = 0,
    this.onSwipeFlyer,
    Key key
  }) : super(key: key);

  @override
  _FinalFlyerState createState() => _FinalFlyerState();

}



class _FinalFlyerState extends State<FinalFlyer> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  FlyersProvider _prof;

// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading() async {
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _prof = Provider.of<FlyersProvider>(context, listen: false);

    _flyerMode = concludeFlyerMode(
      flyerModel:  widget.flyerModel,
      tinyFlyer: widget.tinyFlyer,
      flyerID: widget.flyerID,
    );

    super.initState();
  }
// -----------------------------------------------------------------------------
  FlyerMode _flyerMode;
  static FlyerMode concludeFlyerMode({
    BuildContext context,
    double flyerSizeFactor,
    FlyerModel flyerModel,
    TinyFlyer tinyFlyer,
    String flyerID,
  }){
    FlyerMode _flyerMode;

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, flyerSizeFactor);
    bool _microMode = Scale.superFlyerMicroMode(context, _flyerZoneWidth);

    /// A - when flyerModel is provided
    if (flyerModel != null){
        _flyerMode = FlyerMode.normal;
    }

    /// A - when flyerModel is absent but tinyFlyer is provided
    else if (tinyFlyer != null){
        _flyerMode = FlyerMode.tiny;
    }

    /// A - when flyerID is solely provided and in small size
    else if (flyerID != null && _microMode == true){
      _flyerMode = FlyerMode.tinyWithID;
    }

    /// A - when flyerID is solely provided and in small size
    else if (flyerID != null && _microMode == false){
      _flyerMode = FlyerMode.normalWithID;
    }

    /// A - when flyerModel & tinyFlyer are absent but flyerID is 'draft'
    else if (flyerID == DraftFlyerModel.draftID){
      _flyerMode = FlyerMode.draft;
    }

    /// A - when no flyerModel not tinyFlyer provided
    else {
        _flyerMode = FlyerMode.empty;
    }

    return _flyerMode;
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {


        if (_flyerMode == FlyerMode.tiny){
          // no loading needed
          _tinyFlyer = widget.tinyFlyer;
        }

        else if (_flyerMode == FlyerMode.tinyWithID){
          await fetchAndSetTinyFlyerFromID();
        }

        else if (_flyerMode == FlyerMode.normal){
          await fetchAndSetNormalFlyerFromID();
        }

        else if (_flyerMode == FlyerMode.normalWithID){
          // no loading needed
          _flyerModel = widget.flyerModel;
        }

        else if (_flyerMode == FlyerMode.draft){

        }

        else if (_flyerMode == FlyerMode.empty){

        }

        else {

        }

        // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
          // bool _ankhIsOn = _prof.checkAnkh(widget.flyerID);
          // /// B - search in local saved flyers
          // if (_ankhIsOn == true){
          //   TinyFlyer _tinyFlyer = _prof.getSavedTinyFlyerByFlyerID(flyerID);
          // }
          // /// B - if not found in saved flyers
          // else {
          //   FlyerModel _flyer = await FlyerOps().readFlyerOps(context: context, flyerID: widget.flyerID);
          // }



      });

      _triggerLoading();
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  TinyFlyer _tinyFlyer;
  Future<void> fetchAndSetTinyFlyerFromID() async {

    /// A - check saved tiny flyers
    TinyFlyer _savedTinyFlyer = _prof.getSavedTinyFlyerByFlyerID(widget.flyerID);

    /// A - if id found in saved tinyFlyers
    if (_savedTinyFlyer != null){
      setState(() {
        _tinyFlyer = _savedTinyFlyer;
      });
    }

    /// A - if not found locally, get it from database
    else {
      TinyFlyer _tinyFlyerFromDB = await FlyerOps().readTinyFlyerOps(context: context, flyerID: widget.flyerID);

      /// B - if found on database
      if (_tinyFlyerFromDB != null){
        setState(() {
          _tinyFlyer = _tinyFlyerFromDB;
        });
      }

      /// B - if not found on database
      // do nothing and let _tinyFlyer be null
    }

  }
// -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
  Future<void> fetchAndSetNormalFlyerFromID() async {

    /// A - get it from database directly
    FlyerModel _flyerModelFromDB = await FlyerOps().readFlyerOps(context: context, flyerID: widget.flyerID);

      /// B - if found on database
      if (_flyerModelFromDB != null){
        setState(() {
          _flyerModel = _flyerModelFromDB;
        });

      /// B - if not found on database
      // do nothing and let _flyerModel be null
    }

  }
// -----------------------------------------------------------------------------
  void _tappingFlyerZone(){
    print('Final flyer zone tapped');
  }
// -----------------------------------------------------------------------------
  void _onFlyerZoneLongPress(){
    print('Final flyer zone long pressed');
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
    bool _ankhIsOn = _prof.checkAnkh(widget.flyerID);

    return

      _flyerMode == FlyerMode.tiny ?
      TinyFlyerWidget(
        flyerSizeFactor: widget.flyerSizeFactor,
        tinyFlyer: widget.tinyFlyer,
        onTap: _tappingFlyerZone,
      )

          :

      _flyerMode == FlyerMode.tinyWithID ?
      TinyFlyerWidget(
        flyerSizeFactor: widget.flyerSizeFactor,
        tinyFlyer: _tinyFlyer,
        onTap: _tappingFlyerZone,
      )

          :

      _flyerMode == FlyerMode.normal ?
      NormalFlyerWidget(
        flyerSizeFactor: widget.flyerSizeFactor,
        flyer: widget.flyerModel,
        onSwipeFlyer: widget.onSwipeFlyer,
      )

          :

      _flyerMode == FlyerMode.normalWithID ?
      NormalFlyerWidget(
        flyerSizeFactor: widget.flyerSizeFactor,
        flyer: _flyerModel,
        onSwipeFlyer: widget.onSwipeFlyer,
      )

          :

      _flyerMode == FlyerMode.draft ?
          Container()
          :

      FlyerZone(
       flyerSizeFactor: widget.flyerSizeFactor,
        tappingFlyerZone: _tappingFlyerZone,
        onLongPress: _onFlyerZoneLongPress,
        stackWidgets: <Widget>[



        ],
      );
  }
}
