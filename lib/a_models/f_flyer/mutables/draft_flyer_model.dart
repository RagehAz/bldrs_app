import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
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
    @required this.trigram,
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
    @required this.pdfModel,
    @required this.bzModel,
    @required this.formKey,
    @required this.canPickImage,
    @required this.firstTimer,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String headline;
  final List<String> trigram;
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
  final PDFModel pdfModel;
  final BzModel bzModel;
  final GlobalKey<FormState> formKey;
  final bool canPickImage;
  final bool firstTimer;
  // -----------------------------------------------------------------------------
  static const String newDraftID = 'newDraft';
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  ///
  static Future<DraftFlyerModel> createDraft({
    @required BuildContext context,
    @required FlyerModel oldFlyer,
  }) async {
    DraftFlyerModel _draft;

    if (oldFlyer == null){
      _draft = await _createNewDraft(
        context: context,
      );
    }

    else {
      _draft = await _createDraftFromFlyerModel(
        context: context,
        oldFlyer: oldFlyer,
      );
    }

    return _draft;
  }
  // --------------------
  ///
  static Future<DraftFlyerModel> _createNewDraft({
    @required BuildContext context,
  }) async {

    final BzModel bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

    final List<FlyerType> _possibleFlyerType = FlyerTyper.concludePossibleFlyerTypesByBzTypes(
      bzTypes: bzModel.bzTypes,
    );

    final FlyerType _flyerType = _possibleFlyerType.length == 1 ?
    _possibleFlyerType.first
        :
    null;

    return DraftFlyerModel(
      bzModel: bzModel,
      id: newDraftID,
      headline: '',
      trigram: const [],
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
      authorID: AuthFireOps.superUserID(),
      bzID: bzModel.id,
      position: null,
      mutableSlides: const <MutableSlide>[],
      specs: const <SpecModel>[],
      times: const <PublishTime>[],
      priceTagIsOn: false,
      score: 0,
      pdfModel: null,
      canPickImage: true,
      formKey: GlobalKey<FormState>(),
      firstTimer: true,
    );

  }
  // --------------------
  ///
  static Future<DraftFlyerModel> _createDraftFromFlyerModel({
    @required BuildContext context,
    @required FlyerModel oldFlyer,
  }) async {

    return DraftFlyerModel(
      bzModel: await BzProtocols.fetch(context: context, bzID: oldFlyer.bzID),
      id: oldFlyer.id,
      headline: oldFlyer.headline,
      trigram: oldFlyer.trigram,
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
      mutableSlides: await MutableSlide.createMutableSlidesFromSlides(
        slides: oldFlyer.slides,
        flyerID: oldFlyer.id,
      ),
      specs: oldFlyer.specs,
      times: oldFlyer.times,
      priceTagIsOn: oldFlyer.priceTagIsOn,
      score: oldFlyer.score,
      pdfModel: await PDFProtocols.fetch(oldFlyer.pdfPath),
      firstTimer: false,
      formKey: GlobalKey<FormState>(),
      canPickImage: true,
    );

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
      pdfPath: draft.pdfModel == null ? null : StorageColl.getFlyerPDFPath(draft.id),

    );
  }
  // --------------------
  ///
  void dispose(){
    headlineNode.dispose();
    descriptionNode.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  DraftFlyerModel copyWith({
    String id,
    String headline,
    List<String> trigram,
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
    PDFModel pdfModel,
    BzModel bzModel,
    bool canPickImage,
    GlobalKey<FormState> formKey,
    bool firstTimer,
  }){
    return DraftFlyerModel(
      bzModel: bzModel ?? this.bzModel,
      id: id ?? this.id,
      headline: headline ?? this.headline,
      trigram: trigram ?? this.trigram,
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
      pdfModel: pdfModel ?? this.pdfModel,
      canPickImage: canPickImage ?? this.canPickImage,
      formKey: formKey ?? this.formKey,
      firstTimer: firstTimer ?? this.firstTimer,
    );
  }
  // --------------------
  ///
  DraftFlyerModel nullifyField({
    bool id = false,
    bool headline = false,
    bool trigram = false,
    bool headlineNode = false,
    bool description = false,
    bool descriptionNode = false,
    bool flyerType = false,
    bool publishState = false,
    bool auditState = false,
    bool keywordsIDs = false,
    bool showsAuthor = false,
    bool zone = false,
    bool authorID = false,
    bool bzID = false,
    bool position = false,
    bool mutableSlides = false,
    bool specs = false,
    bool times = false,
    bool priceTagIsOn = false,
    bool score = false,
    bool pdfModel = false,
    bool bzModel = false,
    bool formKey = false,
    bool canPickImage = false,
    bool firstTimer = false,
  }){
    return DraftFlyerModel(
      id: id == true ? null : this.id,
      headline: headline == true ? null : this.headline,
      trigram: trigram == true ? null : this.trigram,
      headlineNode: headlineNode == true ? null : this.headlineNode,
      description: description == true ? null : this.description,
      descriptionNode: descriptionNode == true ? null : this.descriptionNode,
      flyerType: flyerType == true ? null : this.flyerType,
      publishState: publishState == true ? null : this.publishState,
      auditState: auditState == true ? null : this.auditState,
      keywordsIDs: keywordsIDs == true ? [] : this.keywordsIDs,
      showsAuthor: showsAuthor == true ? null : this.showsAuthor,
      zone: zone == true ? null : this.zone,
      authorID: authorID == true ? null : this.authorID,
      bzID: bzID == true ? null : this.bzID,
      position: position == true ? null : this.position,
      mutableSlides: mutableSlides == true ? [] : this.mutableSlides,
      specs: specs == true ? [] : this.specs,
      times: times == true ? [] : this.times,
      priceTagIsOn: priceTagIsOn == true ? null : this.priceTagIsOn,
      score: score == true ? null : this.score,
      pdfModel: pdfModel == true ? null : this.pdfModel,
      bzModel: bzModel == true ? null : this.bzModel,
      formKey: formKey == true ? null : this.formKey,
      canPickImage: canPickImage == true ? null : this.canPickImage,
      firstTimer: firstTimer == true ? null : this.firstTimer,
    );
}
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toLDB(){
    return {
      'id' : id,
      'headline' : headline,
      'trigram' : Stringer.createTrigram(input: headline),
      'description' : description,
      'flyerType' : FlyerTyper.cipherFlyerType(flyerType),
      'publishState' : FlyerModel.cipherPublishState(publishState),
      'auditState' : FlyerModel.cipherAuditState(auditState),
      'keywordsIDs' : keywordsIDs,
      'showsAuthor' : showsAuthor,
      'zone' : zone?.toMap(),
      'authorID' : authorID,
      'bzID' : bzID,
      'position' : Atlas.cipherGeoPoint(point: position, toJSON: true),
      'mutableSlides': MutableSlide.cipherSlidesToLDB(mutableSlides),
      'specs' : SpecModel.cipherSpecs(specs),
      'times' : PublishTime.cipherPublishTimesToMap(times: times, toJSON: true),
      'priceTagIsOn' : priceTagIsOn,
      'score' : score,
      'pdfModel': pdfModel.toMap(includeBytes: true),
      'bzModel': bzModel.toMap(toJSON: true),
      'canPickImage': canPickImage,
      'firstTimer': firstTimer,
      'headlineNode': null,
      'descriptionNode': null,
      'formKey': null,
    };
  }
  // --------------------
  ///
  static DraftFlyerModel fromLDB(Map<String, dynamic> map){
    DraftFlyerModel _draft;

    if (map != null){
      _draft = DraftFlyerModel(

        pdfPath: map['pdfPath'],


        id: map['id'],
        headline: map['headline'],
        trigram: Stringer.getStringsFromDynamics(dynamics: map['trigram']),
        description: map['description'],
        flyerType: FlyerTyper.decipherFlyerType(map['flyerType']),
        publishState: FlyerModel.decipherFlyerState(map['publishState']),
        auditState: FlyerModel.decipherAuditState(map['auditState']),
        keywordsIDs: Stringer.getStringsFromDynamics(dynamics: map['keywordsIDs']),
        showsAuthor: map['showsAuthor'],
        zone: ZoneModel.decipherZone(map['zone']),
        authorID: map['authorID'],
        bzID: map['bzID'],
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: true),
        mutableSlides: MutableSlide.decipherSlidesFromLDB(map['mutableSlides']),
        specs: SpecModel.decipherSpecs(map['specs']),
        times: PublishTime.decipherPublishTimesFromMap(map: map['times'], fromJSON: true),
        priceTagIsOn: map['priceTagIsOn'],
        score: map['score'],
        pdfModel: PDFModel.decipherFromMap(map['pdfModel']),
        bzModel: BzModel.decipherBz(map: map['bzModel'], fromJSON: true),
        canPickImage: map['canPickImage'],
        firstTimer: map['firstTimer'],
        headlineNode: null,
        descriptionNode: null,
        formKey: null,
      );
    }

    return _draft;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  ///
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
    blog('score : $score');
    PublishTime.blogTimes(times);
    SpecModel.blogSpecs(specs);
    MutableSlide.blogSlides(mutableSlides);
    pdfModel.blogPDFModel(invoker: 'BLOGGING DRAFT');
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
      if (PDFModel.checkPDFModelsAreIdentical(pdf1: draft1.pdfModel, pdf2: draft2.pdfModel) == false){
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
  ///
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
          PDFModel.checkPDFModelsAreIdentical(pdf1: draft1.pdfModel, pdf2: draft2.pdfModel) == true &&
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
      pdfModel.hashCode;
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
      pdfPath: pdfPath,

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
