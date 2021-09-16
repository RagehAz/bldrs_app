import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';

enum FlyerMode {
  tinyModeByFlyerID,
  tinyModeByTinyFlyer,
  tinyModeByFlyerModel,
  tinyModeByBzModel,
  tinyModeByNull,

  bigModeByFlyerID,
  bigModeByTinyFlyer,
  bigModeByFlyerModel,
  bigModeByBzModel,
  bigModeByNull,

  editorModeByFlyerID,
  editorModeByTinyFlyer,
  editorModeByFlyerModel,
  editorModeByBzModel,
  editorModeByNull,
}

enum FlyerSourceType {
  empty,
  flyerID,
  tinyFlyer,
  flyerModel,
  bzModel,
}

class FlyerMethod{
// -----------------------------------------------------------------------------
  static FlyerSourceType checkSuperFlyerSource(dynamic input){

    FlyerSourceType _source;

    if (input == null){
      _source = FlyerSourceType.empty;
    }

    else if (input.runtimeType == String){
      _source = FlyerSourceType.flyerID;
    }

    else if (input.runtimeType == TinyFlyer){
      _source = FlyerSourceType.tinyFlyer;
    }

    else if (input.runtimeType == FlyerModel){
      _source = FlyerSourceType.flyerModel;
    }

    else if (input.runtimeType == BzModel){
      _source = FlyerSourceType.bzModel;
    }

    else {
      _source = FlyerSourceType.empty;
    }

    return _source;
  }
// -----------------------------------------------------------------------------
  static FlyerMode flyerModeSelector({BuildContext context, double flyerBoxWidth, bool inEditor, dynamic flyerSource}){

    bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
    bool _editMode = inEditor;
    FlyerSourceType _source = checkSuperFlyerSource(flyerSource);

    FlyerMode _flyerMode;

    /// A - in EDITOR
    if (_editMode == true){

      /// B - EDITOR + TINY MODE
      if(_tinyMode == true){
        print('no flyer mode assigned for flyers in editor while in tinyMode');
      }

      /// B - EDITOR + BIG MODE
      else {

        /// c - editor + bigMode + flyerID
        if (_source == FlyerSourceType.flyerID){
          _flyerMode = FlyerMode.editorModeByFlyerID;
        }

        /// c - editor + bigMode + tinyFlyer
        else if (_source == FlyerSourceType.tinyFlyer){
          _flyerMode = FlyerMode.editorModeByTinyFlyer;
        }

        /// c - editor + bigMode + flyerModel
        else if (_source == FlyerSourceType.flyerModel){
          _flyerMode = FlyerMode.editorModeByFlyerModel;
        }

        /// c - editor + bigMode + bzModel
        else if (_source == FlyerSourceType.bzModel){
          _flyerMode = FlyerMode.editorModeByBzModel;
        }

        /// c - editor + bigMode + emptyFlyer
        else if (_source == FlyerSourceType.empty){
          _flyerMode = FlyerMode.editorModeByNull;
        }

        /// c- else
        else {
          // nothing
        }

      }

    }

    /// A - in VIEW
    else{

      /// B - VIEWER + TINY MODE
      if (_tinyMode == true) {

        /// c - editor + bigMode + flyerID
        if (_source == FlyerSourceType.flyerID){
          _flyerMode = FlyerMode.tinyModeByFlyerID;
        }

        /// c - editor + bigMode + tinyFlyer
        else if (_source == FlyerSourceType.tinyFlyer){
          _flyerMode = FlyerMode.tinyModeByTinyFlyer;
        }

        /// c - editor + bigMode + flyerModel
        else if (_source == FlyerSourceType.flyerModel){
          _flyerMode = FlyerMode.tinyModeByFlyerModel;
        }

        /// c - editor + bigMode + bzModel
        else if (_source == FlyerSourceType.bzModel){
          _flyerMode = FlyerMode.tinyModeByBzModel;
        }

        /// c - editor + bigMode + emptyFlyer
        else if (_source == FlyerSourceType.empty){
          _flyerMode = FlyerMode.tinyModeByNull;

        }

        /// c- else
        else {
          // nothing
        }

      }

      /// B - VIEWER - BIG MODE
      else {

        /// c - editor + bigMode + flyerID
        if (_source == FlyerSourceType.flyerID){
          _flyerMode = FlyerMode.bigModeByFlyerID;
        }

        /// c - editor + bigMode + tinyFlyer
        else if (_source == FlyerSourceType.tinyFlyer){
          _flyerMode = FlyerMode.bigModeByTinyFlyer;
        }

        /// c - editor + bigMode + flyerModel
        else if (_source == FlyerSourceType.flyerModel){
          _flyerMode = FlyerMode.bigModeByFlyerModel;
        }

        /// c - editor + bigMode + bzModel
        else if (_source == FlyerSourceType.bzModel){
          _flyerMode = FlyerMode.bigModeByBzModel;
        }

        /// c - editor + bigMode + emptyFlyer
        else if (_source == FlyerSourceType.empty){
          _flyerMode = FlyerMode.bigModeByNull;
        }

        /// c- else
        else {
          // nothing
        }

      }

    }

    // print('FlyerMethod.flyerModeSelector : _tinyMode : $_tinyMode');
    // print('FlyerMethod.flyerModeSelector : _editMode : $_editMode');
    // print('FlyerMethod.flyerModeSelector : _flyerMode : $_flyerMode');

    return _flyerMode;
  }
// -----------------------------------------------------------------------------
  static dynamic selectFlyerSource({String flyerID, BzModel bzModel, FlyerModel flyerModel, TinyFlyer tinyFlyer,}) {
    dynamic _flyerSource;

    bool _byFlyerModel = flyerModel != null;
    bool _byTinyFlyer = tinyFlyer != null && flyerModel == null;
    bool _byFlyerID = flyerID != null && flyerModel == null && tinyFlyer == null;
    bool _byBzModel = bzModel != null && flyerID == null && flyerModel == null && tinyFlyer == null;

    if (_byFlyerModel == true){
      _flyerSource = flyerModel;
    }

    else if (_byTinyFlyer == true){
      _flyerSource = tinyFlyer;
    }

    else if (_byFlyerID == true){
      _flyerSource = flyerID;
    }

    else if (_byBzModel == true){
      _flyerSource = bzModel;
    }

    // else {
    //   _flyerSource = null;
    // }

    // print('FlyerMethod.selectFlyerSource : _flyerSource : $_flyerSource');

    return _flyerSource;
  }
// -----------------------------------------------------------------------------
  static bool flyerHasMoreThanOneSlide(SuperFlyer superFlyer){
    bool _hasMoreThanOneSlide = false;

    if (superFlyer != null){

      if(superFlyer.mSlides != null){

        if(superFlyer.mSlides.length > 1){

          _hasMoreThanOneSlide = true;

        }

      }

    }

    return _hasMoreThanOneSlide;
  }
// -----------------------------------------------------------------------------
  static int unNullIndexIfNull(int slideIndex){
    return slideIndex == null ? 0 : slideIndex;
  }
// -----------------------------------------------------------------------------
  static bool maxSlidesReached({SuperFlyer superFlyer}){
    int _maxLength = Standards.getMaxSlidesCount(superFlyer.bz.accountType);
    bool _reachedMaxSlides = _maxLength <= superFlyer.numberOfSlides;
    return _reachedMaxSlides;
  }
// -----------------------------------------------------------------------------
  static BoxFit getCurrentBoxFitFromSuperFlyer({SuperFlyer superFlyer}){
    BoxFit _fit;

    if (superFlyer.mSlides != null){
      if(superFlyer.mSlides.length != 0){
        if(superFlyer.currentSlideIndex != null){
          _fit = superFlyer.mSlides[superFlyer.currentSlideIndex].picFit;
        }
      }
    }

    return _fit;
  }
// -----------------------------------------------------------------------------
}

