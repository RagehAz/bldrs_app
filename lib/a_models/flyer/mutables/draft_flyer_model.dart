import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class DraftFlyerModel{
  /// --------------------------------------------------------------------------
  const DraftFlyerModel({
    @required this.id,
    @required this.headlineController,
    @required this.descriptionController,
    @required this.flyerType,
    @required this.publishState,
    @required this.auditState,
    @required this.keywordsIDs,
    @required this.showsAuthor,
    @required this.zone,
    @required this.authorID,
    @required this.bzID,
    @required this.position,
    @required this.mutableSlides,
    @required this.specs,
    @required this.times,
    @required this.priceTagIsOn,
    @required this.score,
    @required this.pdf,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final TextEditingController headlineController;
  final TextEditingController descriptionController;
  final FlyerType flyerType;
  final PublishState publishState;
  final AuditState auditState;
  final List<String> keywordsIDs;
  final bool showsAuthor;
  final ZoneModel zone;
  final String authorID;
  final String bzID;
  final GeoPoint position;
  final List<MutableSlide> mutableSlides;
  final List<SpecModel> specs;
  final List<PublishTime> times;
  final bool priceTagIsOn;
  final int score;
  final FileModel pdf;
// -----------------------------------------------------------------------------

  /// CREATORS

// -------------------------------------
  DraftFlyerModel copyWith({
    String id,
    TextEditingController headlineController,
    TextEditingController descriptionController,
    FlyerType flyerType,
    PublishState publishState,
    AuditState auditState,
    List<String> keywordsIDs,
    bool showsAuthor,
    ZoneModel zone,
    String authorID,
    String bzID,
    GeoPoint position,
    List<MutableSlide> mutableSlides,
    List<SpecModel> specs,
    TextEditingController info,
    List<PublishTime> times,
    bool priceTagIsOn,
    int score,
    FileModel pdf,
  }) => DraftFlyerModel(
    id: id ?? this.id,
    headlineController: headlineController ?? this.headlineController,
    descriptionController: descriptionController ?? this.descriptionController,
    flyerType: flyerType ?? this.flyerType,
    publishState: publishState ?? this.publishState,
    auditState: auditState ?? this.auditState,
    keywordsIDs: keywordsIDs ?? this.keywordsIDs,
    showsAuthor: showsAuthor ?? this.showsAuthor,
    zone: zone ?? this.zone,
    authorID: authorID ?? this.authorID,
    bzID: bzID ?? this.bzID,
    position: position ?? this.position,
    mutableSlides: mutableSlides ?? this.mutableSlides,
    specs: specs ?? this.specs,
    times: times ?? this.times,
    priceTagIsOn: priceTagIsOn ?? this.priceTagIsOn,
    score: score ?? this.score,
    pdf: pdf ?? this.pdf,
  );
// -------------------------------------
  /// TESTED : WORKS PERFECT
  FlyerModel toFlyerModel(){
    return FlyerModel(
      id: id,
      headline: headlineController.text,
      trigram: Stringer.createTrigram(input: headlineController.text),
      description: descriptionController.text,
      flyerType: flyerType,
      publishState: publishState,
      auditState: auditState,
      keywordsIDs: keywordsIDs,
      showsAuthor: showsAuthor,
      zone: zone,
      authorID: authorID,
      bzID: bzID,
      position: position,
      slides: SlideModel.getSlidesFromMutableSlides(mutableSlides),
      specs: specs,
      times: times,
      priceTagIsOn: priceTagIsOn,
      score: score,
      pdf: pdf,

    );
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static DraftFlyerModel createNewDraft({
    @required BzModel bzModel,
    @required String authorID,
}){

    final List<FlyerType> _possibleFlyerType = FlyerTyper.concludePossibleFlyerTypesByBzTypes(
      bzTypes: bzModel.bzTypes,
    );

    final FlyerType _flyerType =
    _possibleFlyerType.length == 1 ?
    _possibleFlyerType.first
        :
    null;

    final DraftFlyerModel _draft = DraftFlyerModel(
      id: Numeric.createUniqueID().toString(),
      headlineController: TextEditingController(),
      descriptionController: TextEditingController(),
      flyerType: _flyerType,
      publishState: PublishState.draft,
      auditState: null,
      keywordsIDs: const <String>[],
      showsAuthor: FlyerModel.canShowFlyerAuthor(
          bzModel: bzModel,
          flyerModel: null,
      ),
      zone: bzModel.zone,
      authorID: authorID,
      bzID: bzModel.id,
      position: null,
      mutableSlides: const <MutableSlide>[],
      specs: const <SpecModel>[],
      times: const <PublishTime>[],
      priceTagIsOn: false,
      score: 0,
      pdf: null,
    );

    return _draft;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftFlyerModel> createDraftFromFlyer(FlyerModel flyerModel) async {

    DraftFlyerModel _draft;

    if (flyerModel != null){

      _draft = DraftFlyerModel(
        id: flyerModel.id,
        headlineController: TextEditingController(text: flyerModel.headline),
        descriptionController: TextEditingController(text: flyerModel.description),
        flyerType: flyerModel.flyerType,
        publishState: flyerModel.publishState,
        auditState: flyerModel.auditState,
        keywordsIDs: flyerModel.keywordsIDs,
        showsAuthor: flyerModel.showsAuthor,
        zone: flyerModel.zone,
        authorID: flyerModel.authorID,
        bzID: flyerModel.bzID,
        position: flyerModel.position,
        mutableSlides: await MutableSlide.createMutableSlidesFromSlides(
          slides: flyerModel.slides,
          flyerID: flyerModel.id,
        ),
        specs: flyerModel.specs,
        times: flyerModel.times,
        priceTagIsOn: flyerModel.priceTagIsOn,
        score: flyerModel.score,
        pdf: flyerModel.pdf,
      );

    }

    return _draft;
  }
// -----------------------------------------------------------------------------

/// DISPOSING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static void disposeDraftControllers({
  @required DraftFlyerModel draft,
}){

    TextChecker.disposeControllerIfPossible(draft.headlineController);
    TextChecker.disposeControllerIfPossible(draft.descriptionController);
    MutableSlide.disposeMutableSlidesTextControllers(
        mutableSlides: draft.mutableSlides,
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
    final String _stateString = FlyerModel.translatePublishState(
        context: context,
        state: publishTime?.state
    );

    return '$_stateString @ $_timeString';
  }
// -------------------------------------
  static String generateShelfTitle({
    @required BuildContext context,
    @required PublishState publishState,
    @required List<PublishTime> times,
    @required int shelfNumber,
}){

    final PublishTime _publishTime = PublishTime.getPublishTimeFromTimes(
      state: publishState,
      times: times,
    );

    final String _stateTimeString = _publishTime == null ?
    ''
        :
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
  /// TESTED : WORKS PERFECT
  static DraftFlyerModel updateHeadline({
    @required TextEditingController controller,
    @required DraftFlyerModel draft,
}){

    DraftFlyerModel _draft = draft;

    if (draft != null){

      if (Mapper.checkCanLoopList(_draft.mutableSlides) == true){

        final MutableSlide _newSlide = _draft.mutableSlides.first.copyWith(
          headline: controller,
        );

        final List<MutableSlide> _newSlides = MutableSlide.replaceSlide(
          slides: _draft.mutableSlides,
          slide: _newSlide,
        );

        _draft = draft.copyWith(
          mutableSlides: _newSlides,
          headlineController: controller,
        );
      }

    }

    return _draft;
  }
// -------------------------------------

  static DraftFlyerModel removePDF(DraftFlyerModel draft){
    return DraftFlyerModel(
      id: draft.id,
      headlineController: draft.headlineController,
      descriptionController: draft.descriptionController,
      flyerType: draft.flyerType,
      publishState: draft.publishState,
      auditState: draft.auditState,
      keywordsIDs: draft.keywordsIDs,
      showsAuthor: draft.showsAuthor,
      zone: draft.zone,
      authorID: draft.authorID,
      bzID: draft.bzID,
      position: draft.position,
      mutableSlides: draft.mutableSlides,
      specs: draft.specs,
      times: draft.times,
      priceTagIsOn: draft.priceTagIsOn,
      score: draft.score,
      pdf: null,
    );
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static TextEditingController getDraftHeadlineController(DraftFlyerModel draft){
    return Mapper.checkCanLoopList(draft?.mutableSlides) == true ?
    draft.mutableSlides[0].headline
        :
    null;
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  void blogDraft(){

    blog('BLOGGING DRAFT FLYER MODEL ---------------------------------------- START');

    blog('id : $id');
    blog('headline : ${headlineController.text}');
    blog('description : ${descriptionController.text}');
    blog('flyerType : $flyerType');
    blog('publishState : $publishState');
    blog('auditState : auditState');
    blog('keywordsIDs : $keywordsIDs');
    blog('showsAuthor : $showsAuthor');
    zone.blogZone();
    blog('authorID : $authorID');
    blog('bzID : $bzID');
    blog('position : $position');
    blog('mutableSlides : ${mutableSlides.length} slides');
    blog('priceTagIsOn : $priceTagIsOn');
    FileModel.blogFlyerPDF(pdf);
    blog('score : $score');
    PublishTime.blogTimes(times);
    SpecModel.blogSpecs(specs);
    MutableSlide.blogSlides(mutableSlides);

    blog('BLOGGING DRAFT FLYER MODEL ---------------------------------------- END');
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanPublishDraft({
    @required DraftFlyerModel draft,
    @required TextEditingController headlineController,
  }){
    bool _canPublish = false;

    if (draft != null){

      if (
      draft.mutableSlides.isNotEmpty == true
      &&
      headlineController.text.length >= Standards.flyerHeadlineMinLength
      ){

        _canPublish = true;
      }

    }

    return _canPublish;
  }
// -----------------------------------------------------------------------------
}
