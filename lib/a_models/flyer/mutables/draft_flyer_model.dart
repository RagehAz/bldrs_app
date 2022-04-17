import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;

class DraftFlyerModel{
  /// --------------------------------------------------------------------------
  DraftFlyerModel({
    @required this.id,
    @required this.title,
    @required this.flyerType,
    @required this.flyerState,
    @required this.keywordsIDs,
    @required this.showsAuthor,
    @required this.zone,
    @required this.authorID,
    @required this.bzID,
    @required this.position,
    @required this.mutableSlides,
    @required this.isBanned,
    @required this.specs,
    @required this.info,
    @required this.times,
    @required this.priceTagIsOn,
  });
  /// --------------------------------------------------------------------------
  String id;
  TextEditingController title;
  // -------------------------
  FlyerTypeClass.FlyerType flyerType;
  FlyerState flyerState;
  List<String> keywordsIDs;
  bool showsAuthor;
  ZoneModel zone;
  // -------------------------
  String authorID;
  String bzID;
  // -------------------------
  GeoPoint position;
  // -------------------------
  List<MutableSlide> mutableSlides;
  // -------------------------
  bool isBanned;
  List<SpecModel> specs;
  TextEditingController info;
  List<PublishTime> times;
  bool priceTagIsOn;
// -----------------------------------------------------------------------------

  /// CREATORS

// -------------------------------------
  static DraftFlyerModel createNewDraft({
    @required BzModel bzModel,
    @required String authorID,
}){

    final DraftFlyerModel _draft = DraftFlyerModel(
      id: createUniqueID().toString(),
      title: TextEditingController(),
      flyerType: null,
      flyerState: FlyerState.draft,
      keywordsIDs: <String>[],
      showsAuthor: FlyerModel.canShowFlyerAuthor(
          bzModel: bzModel,
          flyerModel: null,
      ),
      zone: ZoneModel(),
      authorID: authorID,
      bzID: bzModel.id,
      position: null,
      mutableSlides: <MutableSlide>[],
      isBanned: false,
      specs: <SpecModel>[],
      info: TextEditingController(),
      times: <PublishTime>[],
      priceTagIsOn: false,
    );

    return _draft;
  }
// -----------------------------------------------------------------------------
  static Future<DraftFlyerModel> createDraftFromFlyer(FlyerModel flyerModel) async {

    DraftFlyerModel _draft;

    if (flyerModel != null){

      _draft = DraftFlyerModel(
        id: flyerModel.id,
        title: TextEditingController(text: flyerModel.title),
        flyerType: flyerModel.flyerType,
        flyerState: flyerModel.flyerState,
        keywordsIDs: flyerModel.keywordsIDs,
        showsAuthor: flyerModel.showsAuthor,
        zone: flyerModel.zone,
        authorID: flyerModel.authorID,
        bzID: flyerModel.bzID,
        position: flyerModel.position,
        mutableSlides: await MutableSlide.createMutableSlidesFromSlides(
            slides: flyerModel.slides
        ),
        isBanned: flyerModel.isBanned,
        specs: flyerModel.specs,
        info: TextEditingController(text: flyerModel.info),
        times: flyerModel.times,
        priceTagIsOn: flyerModel.priceTagIsOn,
      );

    }

    return _draft;
  }
// -----------------------------------------------------------------------------

/// DISPOSING

// -------------------------------------
  static void disposeDraftControllers({
  @required DraftFlyerModel draft,
}){

    disposeControllerIfPossible(draft.title);
    disposeControllerIfPossible(draft.info);
    MutableSlide.disposeMutableSlidesTextControllers(
        mutableSlides: draft.mutableSlides
    );

  }
// -----------------------------------------------------------------------------
}
