// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
// import 'package:bldrs/xxx_lab/xxx_old_stuff/old_flyer_stuff/old_flyer_zone_box.dart';
// import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
// import 'package:flutter/material.dart';
//
// enum FlyerMode {
//   tinyModeByFlyerID,
//   tinyModeByFlyerModel,
//   tinyModeByBzModel,
//   tinyModeByNull,
//
//   bigModeByFlyerID,
//   bigModeByFlyerModel,
//   bigModeByBzModel,
//   bigModeByNull,
//
//   editorModeByFlyerID,
//   editorModeByFlyerModel,
//   editorModeByBzModel,
//   editorModeByNull,
// }
//
// enum FlyerSourceType {
//   empty,
//   flyerID,
//   flyerModel,
//   bzModel,
// }
//
// // -----------------------------------------------------------------------------
// FlyerSourceType checkSuperFlyerSource(dynamic input) {
//   FlyerSourceType _source;
//
//   if (input == null) {
//     _source = FlyerSourceType.empty;
//   } else if (input.runtimeType == String) {
//     _source = FlyerSourceType.flyerID;
//   } else if (input.runtimeType == FlyerModel) {
//     _source = FlyerSourceType.flyerModel;
//   } else if (input.runtimeType == BzModel) {
//     _source = FlyerSourceType.bzModel;
//   } else {
//     _source = FlyerSourceType.empty;
//   }
//
//   return _source;
// }
//
// // -----------------------------------------------------------------------------
// FlyerMode flyerModeSelector(
//     {BuildContext context,
//     double flyerBoxWidth,
//     bool inEditor,
//     dynamic flyerSource}) {
//   final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
//   final bool _editMode = inEditor;
//   final FlyerSourceType _source = checkSuperFlyerSource(flyerSource);
//
//   FlyerMode _flyerMode;
//
//   /// A - in EDITOR
//   if (_editMode == true) {
//     /// B - EDITOR + TINY MODE
//     if (_tinyMode == true) {
//       blog('no flyer mode assigned for flyers in editor while in tinyMode');
//     }
//
//     /// B - EDITOR + BIG MODE
//     else {
//       /// c - editor + bigMode + flyerID
//       if (_source == FlyerSourceType.flyerID) {
//         _flyerMode = FlyerMode.editorModeByFlyerID;
//       }
//
//       /// c - editor + bigMode + flyerModel
//       else if (_source == FlyerSourceType.flyerModel) {
//         _flyerMode = FlyerMode.editorModeByFlyerModel;
//       }
//
//       /// c - editor + bigMode + bzModel
//       else if (_source == FlyerSourceType.bzModel) {
//         _flyerMode = FlyerMode.editorModeByBzModel;
//       }
//
//       /// c - editor + bigMode + emptyFlyer
//       else if (_source == FlyerSourceType.empty) {
//         _flyerMode = FlyerMode.editorModeByNull;
//       }
//
//       /// c- else
//       else {
//         // nothing
//       }
//     }
//   }
//
//   /// A - in VIEW
//   else {
//     /// B - VIEWER + TINY MODE
//     if (_tinyMode == true) {
//       /// c - editor + bigMode + flyerID
//       if (_source == FlyerSourceType.flyerID) {
//         _flyerMode = FlyerMode.tinyModeByFlyerID;
//       }
//
//       /// c - editor + bigMode + flyerModel
//       else if (_source == FlyerSourceType.flyerModel) {
//         _flyerMode = FlyerMode.tinyModeByFlyerModel;
//       }
//
//       /// c - editor + bigMode + bzModel
//       else if (_source == FlyerSourceType.bzModel) {
//         _flyerMode = FlyerMode.tinyModeByBzModel;
//       }
//
//       /// c - editor + bigMode + emptyFlyer
//       else if (_source == FlyerSourceType.empty) {
//         _flyerMode = FlyerMode.tinyModeByNull;
//       }
//
//       /// c- else
//       else {
//         // nothing
//       }
//     }
//
//     /// B - VIEWER - BIG MODE
//     else {
//       /// c - editor + bigMode + flyerID
//       if (_source == FlyerSourceType.flyerID) {
//         _flyerMode = FlyerMode.bigModeByFlyerID;
//       }
//
//       /// c - editor + bigMode + flyerModel
//       else if (_source == FlyerSourceType.flyerModel) {
//         _flyerMode = FlyerMode.bigModeByFlyerModel;
//       }
//
//       /// c - editor + bigMode + bzModel
//       else if (_source == FlyerSourceType.bzModel) {
//         _flyerMode = FlyerMode.bigModeByBzModel;
//       }
//
//       /// c - editor + bigMode + emptyFlyer
//       else if (_source == FlyerSourceType.empty) {
//         _flyerMode = FlyerMode.bigModeByNull;
//       }
//
//       /// c- else
//       else {
//         // nothing
//       }
//     }
//   }
//
//   // blog('FlyerMethod.flyerModeSelector : _tinyMode : $_tinyMode');
//   // blog('FlyerMethod.flyerModeSelector : _editMode : $_editMode');
//   // blog('FlyerMethod.flyerModeSelector : _flyerMode : $_flyerMode');
//
//   return _flyerMode;
// }
//
// // -----------------------------------------------------------------------------
// dynamic selectFlyerSource({
//   String flyerID,
//   BzModel bzModel,
//   FlyerModel flyerModel,
// }) {
//   dynamic _flyerSource;
//
//   final bool _byFlyerModel = flyerModel != null;
//   final bool _byFlyerID = flyerID != null && flyerModel == null;
//   final bool _byBzModel =
//       bzModel != null && flyerID == null && flyerModel == null;
//
//   if (_byFlyerModel == true) {
//     _flyerSource = flyerModel;
//   } else if (_byFlyerID == true) {
//     _flyerSource = flyerID;
//   } else if (_byBzModel == true) {
//     _flyerSource = bzModel;
//   }
//
//   // else {
//   //   _flyerSource = null;
//   // }
//
//   // blog('FlyerMethod.selectFlyerSource : _flyerSource : $_flyerSource');
//
//   return _flyerSource;
// }
//
// // -----------------------------------------------------------------------------
// bool flyerHasMoreThanOneSlide(SuperFlyer superFlyer) {
//   bool _hasMoreThanOneSlide = false;
//
//   if (superFlyer != null) {
//     if (superFlyer.mSlides != null) {
//       if (superFlyer.mSlides.length > 1) {
//         _hasMoreThanOneSlide = true;
//       }
//     }
//   }
//
//   return _hasMoreThanOneSlide;
// }
//
// // -----------------------------------------------------------------------------
// int unNullIndexIfNull(int slideIndex) {
//   return slideIndex ?? 0;
// }
//
// // -----------------------------------------------------------------------------
// bool maxSlidesReached({SuperFlyer superFlyer}) {
//   final int _maxLength = Standards.getMaxSlidesCount(superFlyer.bz.accountType);
//   final bool _reachedMaxSlides = _maxLength <= superFlyer.numberOfSlides;
//   return _reachedMaxSlides;
// }
//
// // -----------------------------------------------------------------------------
// BoxFit getCurrentBoxFitFromSuperFlyer({SuperFlyer superFlyer}) {
//   BoxFit _fit;
//
//   if (superFlyer.mSlides != null) {
//     if (superFlyer.mSlides.isNotEmpty) {
//       if (superFlyer.currentSlideIndex != null) {
//         _fit = superFlyer.mSlides[superFlyer.currentSlideIndex].picFit;
//       }
//     }
//   }
//
//   return _fit;
// }
// // -----------------------------------------------------------------------------
