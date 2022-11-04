import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
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
    @required this.headline,
    @required this.headlineNode,
    @required this.description,
    @required this.descriptionNode,
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
    @required this.bzModel,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String headline;
  final FocusNode headlineNode;
  final String description;
  final FocusNode descriptionNode;
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
  final BzModel bzModel;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  ///
  static DraftFlyerModel initializeDraftForEditing({
    @required FlyerModel oldFlyer,
    @required BzModel bzModel,
    @required String currentAuthorID,
  }){

    DraftFlyerModel _draft;

    /// IS CREATING NEW FLYER
    if (oldFlyer == null){

      final List<FlyerType> _possibleFlyerType = FlyerTyper.concludePossibleFlyerTypesByBzTypes(
        bzTypes: bzModel.bzTypes,
      );

      final FlyerType _flyerType = _possibleFlyerType.length == 1 ?
      _possibleFlyerType.first
          :
      null;

      _draft = DraftFlyerModel(
        bzModel: bzModel,
        id: 'newFlyer',
        headline: '',
        headlineNode: FocusNode(),
        description: '',
        descriptionNode: FocusNode(),
        flyerType: _flyerType,
        publishState: PublishState.draft,
        auditState: null,
        keywordsIDs: const <String>[],
        showsAuthor: FlyerModel.canShowFlyerAuthor(
          bzModel: bzModel,
          flyerModel: null,
        ),
        zone: bzModel.zone,
        authorID: currentAuthorID,
        bzID: bzModel.id,
        position: null,
        mutableSlides: const <MutableSlide>[],
        specs: const <SpecModel>[],
        times: const <PublishTime>[],
        priceTagIsOn: false,
        score: 0,
        pdf: null,
      );

    }

    /// IS EDITING EXISTING FLYER
    else {

      _draft = DraftFlyerModel(
        bzModel: bzModel,
        id: oldFlyer.id,
        headline: oldFlyer.headline,
        headlineNode: FocusNode(),
        description: oldFlyer.description,
        descriptionNode: FocusNode(),
        flyerType: oldFlyer.flyerType,
        publishState: oldFlyer.publishState,
        auditState: oldFlyer.auditState,
        keywordsIDs: oldFlyer.keywordsIDs,
        showsAuthor: oldFlyer.showsAuthor,
        zone: oldFlyer.zone,
        authorID: oldFlyer.authorID,
        bzID: oldFlyer.bzID,
        position: oldFlyer.position,
        mutableSlides: const [],
        specs: oldFlyer.specs,
        times: oldFlyer.times,
        priceTagIsOn: oldFlyer.priceTagIsOn,
        score: oldFlyer.score,
        pdf: oldFlyer.pdf,
      );

    }

    return _draft;
  }
  // --------------------
  ///
  static Future<FlyerModel> bakeDraftToUpload({
    @required DraftFlyerModel draft,
    @required bool toLDB,
    PublishState overridePublishState,
  }) async {

    return FlyerModel(
      id: draft.id,
      headline: draft.headline,
      trigram: Stringer.createTrigram(input: draft.headline),
      description: draft.description,
      flyerType: draft.flyerType,
      publishState: overridePublishState ?? draft.publishState,
      auditState: draft.bzModel.isVerified == true ? AuditState.verified : AuditState.pending,
      keywordsIDs: draft.keywordsIDs,
      showsAuthor: draft.showsAuthor,
      zone: draft.zone,
      authorID: draft.authorID,
      bzID: draft.bzID,
      position: draft.position,
      slides: SlideModel.getSlidesFromMutableSlides(
        mSlides: draft.mutableSlides,
        forLDB: toLDB,
      ),
      specs: draft.specs,
      times: draft.times,
      priceTagIsOn: draft.priceTagIsOn,
      score: draft.score,
      pdf: toLDB == true ? FileModel.bakeFileForLDB(draft.pdf) : draft.pdf,

    );
  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  DraftFlyerModel copyWith({
    String id,
    String headline,
    FocusNode headlineNode,
    String description,
    FocusNode descriptionNode,
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
    List<PublishTime> times,
    bool priceTagIsOn,
    int score,
    FileModel pdf,
    BzModel bzModel,
  }) => DraftFlyerModel(
    bzModel: bzModel ?? this.bzModel,
    id: id ?? this.id,
    headline: headline ?? this.headline,
    headlineNode: headlineNode ?? this.headlineNode,
    description: description ?? this.description,
    descriptionNode: descriptionNode ?? this.descriptionNode,
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
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void disposeDraftNodes({
    @required DraftFlyerModel draft,
  }){


    draft.headlineNode.dispose();
    draft.descriptionNode.dispose();

  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
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
  // --------------------
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


  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftFlyerModel updateHeadline({
    @required String newHeadline,
    @required DraftFlyerModel draft,
  }){

    DraftFlyerModel _draft = draft;

    if (draft != null){

      if (Mapper.checkCanLoopList(draft.mutableSlides) == true){
        final MutableSlide _newSlide = draft.mutableSlides.first.copyWith(
          headline: newHeadline,
        );
        final List<MutableSlide> _newSlides = MutableSlide.replaceSlide(
          slides: draft.mutableSlides,
          slide: _newSlide,
        );
        _draft = draft.copyWith(
          mutableSlides: _newSlides,
        );
      }

      _draft = draft.copyWith(
        headline: newHeadline,
      );

    }

    return _draft;
  }
  // --------------------
  ///
  static DraftFlyerModel removePDF(DraftFlyerModel draft){

    return DraftFlyerModel(
      bzModel: draft.bzModel,
      id: draft.id,
      headline: draft.headline,
      description: draft.description,
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
      descriptionNode: draft.descriptionNode,
      headlineNode: draft.headlineNode,
    );
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static String getFirstSlideHeadline(DraftFlyerModel draft){
    return Mapper.checkCanLoopList(draft?.mutableSlides) == true ?
    draft.mutableSlides[0].headline
        :
    null;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDraft(){

    blog('BLOGGING DRAFT FLYER MODEL ---------------------------------------- START');

    blog('id : $id');
    blog('headline : $headline');
    blog('description : $description');
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
    bzModel.blogBz(methodName: 'BLOGGING DRAFT');

    blog('BLOGGING DRAFT FLYER MODEL ---------------------------------------- END');
  }
  // --------------------
  static void _blogDraftsDifferences({
    @required DraftFlyerModel draft1,
    @required DraftFlyerModel draft2,
  }){

    blog('_blogDraftsDifferences : ------------------------ START');

    if (draft1 == null){
      blog('draft1 is null');
    }

    if (draft2 == null){
      blog('draft2 is null');
    }

    if (draft1 != null && draft2 != null){

      if (draft1.id != draft2.id){
        blog('ids are not identical');
      }
      if (draft1.headline != draft2.headline){
        blog('headlines are not identical');
      }
      if (draft1.description != draft2.description){
        blog('descriptions are not identical');
      }
      if (draft1.flyerType != draft2.flyerType){
        blog('flyerTypes are not identical');
      }
      if (draft1.publishState != draft2.publishState){
        blog('publishStates are not identical');
      }
      if (draft1.auditState != draft2.auditState){
        blog('auditStates are not identical');
      }
      if (Mapper.checkListsAreIdentical(list1: draft1.keywordsIDs, list2: draft2.keywordsIDs) == false){
        blog('keywordsIDs are not identical');
      }
      if (draft1.showsAuthor != draft2.showsAuthor){
        blog('showsAuthors are not identical');
      }
      if (ZoneModel.checkZonesAreIdentical(zone1: draft1.zone, zone2: draft2.zone) == false){
        blog('zones are not identical');
      }
      if (draft1.authorID != draft2.authorID){
        blog('authorIDs are not identical');
      }
      if (draft1.bzID != draft2.bzID){
        blog('bzIDs are not identical');
      }
      if (Atlas.checkPointsAreIdentical(point1: draft1.position, point2: draft2.position) == false){
        blog('positions are not identical');
      }
      if (MutableSlide.checkSlidesListsAreIdentical(slides1: draft1.mutableSlides, slides2: draft2.mutableSlides) == false){
        blog('mutableSlides are not identical');
      }
      if (SpecModel.checkSpecsListsAreIdentical(draft1.specs, draft2.specs) == false){
        blog('specss are not identical');
      }
      if (PublishTime.checkTimesListsAreIdentical(times1: draft1.times, times2: draft2.times) == false){
        blog('times are not identical');
      }
      if (draft1.priceTagIsOn != draft2.priceTagIsOn){
        blog('priceTagIsOns are not identical');
      }
      if (draft1.score != draft2.score){
        blog('scores are not identical');
      }
      if (FileModel.checkFileModelsAreIdentical(model1: draft1.pdf, model2: draft2.pdf) == false){
        blog('pdfs are not identical');
      }
      if (BzModel.checkBzzAreIdentical(bz1: draft1.bzModel, bz2: draft2.bzModel) == false){
        blog('bzzModels are not identical');
      }


      // FocusNode headlineNode,
      // FocusNode descriptionNode,

    }

    blog('_blogDraftsDifferences : ------------------------ END');

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
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
  // --------------------
  static bool checkDraftsAreIdentical({
    @required DraftFlyerModel draft1,
    @required DraftFlyerModel draft2,
  }){
    bool _areIdentical = false;

    if (draft1 == null && draft2 == null){
      _areIdentical = true;
    }
    else if (draft1 != null && draft2 != null){

      if (
      draft1.id == draft2.id &&
          draft1.headline == draft2.headline &&
          // FocusNode headlineNode,
          draft1.description == draft2.description &&
          // FocusNode descriptionNode,
          draft1.flyerType == draft2.flyerType &&
          draft1.publishState == draft2.publishState &&
          draft1.auditState == draft2.auditState &&
          Mapper.checkListsAreIdentical(list1: draft1.keywordsIDs, list2: draft2.keywordsIDs) == true &&
          draft1.showsAuthor == draft2.showsAuthor &&
          ZoneModel.checkZonesAreIdentical(zone1: draft1.zone, zone2: draft2.zone) == true &&
          draft1.authorID == draft2.authorID &&
          draft1.bzID == draft2.bzID &&
          Atlas.checkPointsAreIdentical(point1: draft1.position, point2: draft2.position) == true &&
          MutableSlide.checkSlidesListsAreIdentical(slides1: draft1.mutableSlides, slides2: draft2.mutableSlides) == true &&
          SpecModel.checkSpecsListsAreIdentical(draft1.specs, draft2.specs) == true &&
          PublishTime.checkTimesListsAreIdentical(times1: draft1.times, times2: draft2.times) == true &&
          draft1.priceTagIsOn == draft2.priceTagIsOn &&
          draft1.score == draft2.score &&
          FileModel.checkFileModelsAreIdentical(model1: draft1.pdf, model2: draft2.pdf) == true &&
          BzModel.checkBzzAreIdentical(bz1: draft1.bzModel, bz2: draft2.bzModel) == true
      ){
        _areIdentical = true;
      }

    }

    if (_areIdentical == false){
      _blogDraftsDifferences(
        draft1: draft1,
        draft2: draft2,
      );
    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

// ----------------------------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
// ----------------------------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is DraftFlyerModel){
      _areIdentical = checkDraftsAreIdentical(
        draft1: this,
        draft2: other,
      );
    }

    return _areIdentical;
  }
// ----------------------------------------
  @override
  int get hashCode =>
      id.hashCode^
      headline.hashCode^
      headlineNode.hashCode^
      description.hashCode^
      descriptionNode.hashCode^
      flyerType.hashCode^
      publishState.hashCode^
      auditState.hashCode^
      keywordsIDs.hashCode^
      showsAuthor.hashCode^
      zone.hashCode^
      authorID.hashCode^
      bzID.hashCode^
      position.hashCode^
      mutableSlides.hashCode^
      specs.hashCode^
      times.hashCode^
      priceTagIsOn.hashCode^
      score.hashCode^
      pdf.hashCode;
// -----------------------------------------------------------------------------
}
// --------------------
/*
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
  */
// --------------------
/*
//   /// TESTED : WORKS PERFECT
//   static DraftFlyerModel createNewDraft({
//     @required BzModel bzModel,
//     @required String authorID,
// }){
//
//     final List<FlyerType> _possibleFlyerType = FlyerTyper.concludePossibleFlyerTypesByBzTypes(
//       bzTypes: bzModel.bzTypes,
//     );
//
//     final FlyerType _flyerType =
//     _possibleFlyerType.length == 1 ?
//     _possibleFlyerType.first
//         :
//     null;
//
//     final DraftFlyerModel _draft = DraftFlyerModel(
//       id: Numeric.createUniqueID().toString(),
//       headlineController: TextEditingController(),
//       headlineNode: FocusNode(),
//       descriptionController: TextEditingController(),
//       descriptionNode: FocusNode(),
//       flyerType: _flyerType,
//       publishState: PublishState.draft,
//       auditState: null,
//       keywordsIDs: const <String>[],
//       showsAuthor: FlyerModel.canShowFlyerAuthor(
//           bzModel: bzModel,
//           flyerModel: null,
//       ),
//       zone: bzModel.zone,
//       authorID: authorID,
//       bzID: bzModel.id,
//       position: null,
//       mutableSlides: const <MutableSlide>[],
//       specs: const <SpecModel>[],
//       times: const <PublishTime>[],
//       priceTagIsOn: false,
//       score: 0,
//       pdf: null,
//     );
//
//     return _draft;
//   }
  // -----------------------------------------------------------------------------
//   /// TESTED : WORKS PERFECT
//   static Future<DraftFlyerModel> createDraftFromFlyer(FlyerModel flyerModel) async {
//
//     DraftFlyerModel _draft;
//
//     if (flyerModel != null){
//
//       _draft = DraftFlyerModel(
//         id: flyerModel.id,
//         headlineController: TextEditingController(text: flyerModel.headline),
//         headlineNode: FocusNode(),
//         descriptionController: TextEditingController(text: flyerModel.description),
//         descriptionNode: FocusNode(),
//         flyerType: flyerModel.flyerType,
//         publishState: flyerModel.publishState,
//         auditState: flyerModel.auditState,
//         keywordsIDs: flyerModel.keywordsIDs,
//         showsAuthor: flyerModel.showsAuthor,
//         zone: flyerModel.zone,
//         authorID: flyerModel.authorID,
//         bzID: flyerModel.bzID,
//         position: flyerModel.position,
//         mutableSlides: await MutableSlide.createMutableSlidesFromSlides(
//           slides: flyerModel.slides,
//           flyerID: flyerModel.id,
//         ),
//         specs: flyerModel.specs,
//         times: flyerModel.times,
//         priceTagIsOn: flyerModel.priceTagIsOn,
//         score: flyerModel.score,
//         pdf: flyerModel.pdf,
//       );
//
//     }
//
//     return _draft;
//   }
   */
// --------------------
