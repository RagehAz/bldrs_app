import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;

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
  DraftFlyerModel copyWith({
    String id,
    TextEditingController title,
    FlyerTypeClass.FlyerType flyerType,
    FlyerState flyerState,
    List<String> keywordsIDs,
    bool showsAuthor,
    ZoneModel zone,
    String authorID,
    String bzID,
    GeoPoint position,
    List<MutableSlide> mutableSlides,
    bool isBanned,
    List<SpecModel> specs,
    TextEditingController info,
    List<PublishTime> times,
    bool priceTagIsOn,
  }) => DraftFlyerModel(
    id: id ?? this.id,
    title: title ?? this.title,
    flyerType: flyerType ?? this.flyerType,
    flyerState: flyerState ?? this.flyerState,
    keywordsIDs: keywordsIDs ?? this.keywordsIDs,
    showsAuthor: showsAuthor ?? this.showsAuthor,
    zone: zone ?? this.zone,
    authorID: authorID ?? this.authorID,
    bzID: bzID ?? this.bzID,
    position: position ?? this.position,
    mutableSlides: mutableSlides ?? this.mutableSlides,
    isBanned: isBanned ?? this.isBanned,
    specs: specs ?? this.specs,
    info: info ?? this.info,
    times: times ?? this.times,
    priceTagIsOn: priceTagIsOn ?? this.priceTagIsOn,
  );
// -------------------------------------
  static DraftFlyerModel createNewDraft({
    @required BzModel bzModel,
    @required String authorID,
}){

    final List<FlyerType> _possibleFlyerType = concludePossibleFlyerTypesByBzTypes(
      bzTypes: bzModel.bzTypes,
    );

    final FlyerType _flyerType =
    _possibleFlyerType.length == 1 ?
    _possibleFlyerType.first
        :
    null;

    final DraftFlyerModel _draft = DraftFlyerModel(
      id: createUniqueID().toString(),
      title: TextEditingController(),
      flyerType: _flyerType,
      flyerState: FlyerState.draft,
      keywordsIDs: <String>[],
      showsAuthor: FlyerModel.canShowFlyerAuthor(
          bzModel: bzModel,
          flyerModel: null,
      ),
      zone: bzModel.zone,
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

/// GENERATORS

// -------------------------------------
  static String _generateStateTimeString({
    @required BuildContext context,
    @required PublishTime publishTime,
}){

    final String _timeString = Timers.generateString_hh_i_mm_ampm_day_dd_month_yyyy(
      context: context,
      time: publishTime?.time,
    );
    final String _stateString = FlyerModel.translateFlyerState(
        context: context,
        state: publishTime?.state
    );

    return '$_stateString @ $_timeString';
  }
// -------------------------------------
  static String generateShelfTitle({
    @required BuildContext context,
    @required FlyerState flyerState,
    @required List<PublishTime> times,
    @required int shelfNumber,
}){

    final PublishTime _publishTime = PublishTime.getPublishTimeFromTimes(
      state: FlyerState.banned,
      times: times,
    );

    final String _stateTimeString = _publishTime == null ? '' :
    _generateStateTimeString(
      context: context,
      publishTime: _publishTime,
    );

    final String _shelfTitle = '$shelfNumber . $_stateTimeString';

    return _shelfTitle;
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// -------------------------------------
  DraftFlyerModel replaceSlides(List<MutableSlide> newSlides){
    return
        DraftFlyerModel(
            id: id,
            title: title,
            flyerType: flyerType,
            flyerState: flyerState,
            keywordsIDs: keywordsIDs,
            showsAuthor: showsAuthor,
            zone: zone,
            authorID: authorID,
            bzID: bzID,
            position: position,
            mutableSlides: newSlides,
            isBanned: isBanned,
            specs: specs,
            info: info,
            times: times,
            priceTagIsOn: priceTagIsOn,
        );
  }
// -------------------------------------
  static DraftFlyerModel updateHeadline({
    @required TextEditingController controller,
    @required DraftFlyerModel draft,
}){

    DraftFlyerModel _draft = draft;

    if (draft != null){

      if (Mapper.canLoopList(_draft.mutableSlides) == true){

        final MutableSlide _newSlide = _draft.mutableSlides.first.copyWith(
          headline: controller,
        );

        final List<MutableSlide> _newSlides = MutableSlide.replaceSlide(
          slides: _draft.mutableSlides,
          slide: _newSlide,
        );

        _draft = draft.copyWith(
          mutableSlides: _newSlides,
          title: controller,
        );
      }

    }

    return _draft;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static TextEditingController getDraftHeadlineController(DraftFlyerModel draft){
    return Mapper.canLoopList(draft?.mutableSlides) == true ?
    draft.mutableSlides[0].headline
        :
    null;
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

//
  void blogDraft(){

    blog('BLOGGIND DRAFT FLYER MODEL ---------------------------------------- START');

    blog('id : $id');
    blog('title : $title');
    blog('flyerType : $flyerType');
    blog('flyerState : $flyerState');
    blog('keywordsIDs : $keywordsIDs');
    blog('showsAuthor : $showsAuthor');
    blog('zone : $zone');
    blog('authorID : $authorID');
    blog('bzID : $bzID');
    blog('position : $position');
    blog('mutableSlides : ${mutableSlides.length} slides');
    blog('isBanned : $isBanned');
    blog('specs : $specs');
    blog('info : $info');
    blog('times : $times');
    blog('priceTagIsOn : $priceTagIsOn');

    MutableSlide.blogSlides(mutableSlides);

    blog('BLOGGIND DRAFT FLYER MODEL ---------------------------------------- END');
  }
}
