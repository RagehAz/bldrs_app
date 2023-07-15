import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/atlas.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/draft/gta_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:screenshot/screenshot.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
/// => TAMAM
@immutable
class DraftFlyer{
  /// --------------------------------------------------------------------------
  const DraftFlyer({
    required this.id,
    required this.headline,
    required this.trigram,
    required this.headlineNode,
    required this.description,
    required this.descriptionNode,
    required this.flyerType,
    required this.publishState,
    required this.auditState,
    required this.phids,
    required this.showsAuthor,
    required this.zone,
    required this.authorID,
    required this.bzID,
    required this.position,
    required this.draftSlides,
    required this.specs,
    required this.times,
    required this.hasPriceTag,
    required this.isAmazonFlyer,
    required this.hasPDF,
    required this.score,
    required this.pdfModel,
    required this.bzModel,
    required this.formKey,
    required this.canPickImage,
    required this.firstTimer,
    required this.posterController,
    required this.affiliateLink,
    required this.gtaLink,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final TextEditingController? headline;
  final List<String>? trigram;
  final FocusNode? headlineNode;
  final TextEditingController? description;
  final FocusNode? descriptionNode;
  final FlyerType? flyerType;
  final PublishState? publishState;
  final AuditState? auditState;
  final List<String>? phids;
  final bool? showsAuthor;
  final ZoneModel? zone;
  final String? authorID;
  final String? bzID;
  final GeoPoint? position;
  final List<DraftSlide>? draftSlides;
  final List<SpecModel>? specs;
  final List<PublishTime>? times;
  final bool? hasPriceTag;
  final bool? isAmazonFlyer;
  final bool? hasPDF;
  final int? score;
  final PDFModel? pdfModel;
  final BzModel? bzModel;
  final GlobalKey<FormState>? formKey;
  final bool? canPickImage;
  final bool? firstTimer;
  final ScreenshotController? posterController;
  final String? affiliateLink;
  final String? gtaLink;
  // -----------------------------------------------------------------------------
  static const String newDraftID = 'newDraft';
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftFlyer?> createDraft({
    required FlyerModel? oldFlyer,
  }) async {
    DraftFlyer? _draft;

    if (oldFlyer == null){
      _draft = await _createNewDraft();
    }

    else {
      _draft = await _createDraftFromFlyer(
        flyer: oldFlyer,
      );
    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftFlyer?> _createNewDraft() async {

    final BzModel? bzModel = BzzProvider.proGetActiveBzModel(
      context: getMainContext(),
      listen: false,
    );

    if (bzModel == null){
      return null;
    }

    else {

      final bool _bzIsVerified = bzModel.isVerified != null && bzModel.isVerified! == true;

      return DraftFlyer(
        bzModel: bzModel,
        id: newDraftID,
        headline: TextEditingController(),
        trigram: const [],
        headlineNode: FocusNode(),
        description: TextEditingController(),
        descriptionNode: FocusNode(),
        flyerType: getPossibleFlyerType(bzModel),
        publishState: PublishState.draft,
        auditState: _bzIsVerified == true ? AuditState.verified : AuditState.pending,
        phids: const <String>[],
        showsAuthor: FlyerModel.canShowFlyerAuthor(
          bzModel: bzModel,
          flyerModel: null,
        ),
        zone: bzModel.zone,
        authorID: Authing.getUserID(),
        bzID: bzModel.id,
        position: null,
        draftSlides: const <DraftSlide>[],
        specs: const <SpecModel>[],
        times: const <PublishTime>[],
        hasPriceTag: false,
        isAmazonFlyer: false,
        hasPDF: false,
        score: 0,
        pdfModel: null,
        canPickImage: true,
        formKey: GlobalKey<FormState>(),
        firstTimer: true,
        posterController: ScreenshotController(),
        affiliateLink: null,
        gtaLink: null,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerType? getPossibleFlyerType(BzModel? bzModel) {

    final List<FlyerType> _possibleFlyerType = FlyerTyper.concludePossibleFlyerTypesByBzTypes(
      bzTypes: bzModel?.bzTypes,
    );

    final FlyerType? _flyerType = _possibleFlyerType.length == 1 ?
    _possibleFlyerType.first
        :
    null;

    return _flyerType;
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS - FLYER MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftFlyer?> _createDraftFromFlyer({
    required FlyerModel? flyer,
  }) async {

    if (flyer == null) {
      return null;
    }

    else {
      return DraftFlyer(
        bzModel: await BzProtocols.fetchBz(bzID: flyer.bzID),
        id: flyer.id,
        headline: TextEditingController(text: flyer.headline),
        trigram: flyer.trigram,
        headlineNode: FocusNode(),
        description: TextEditingController(text: flyer.description),
        descriptionNode: FocusNode(),
        flyerType: flyer.flyerType,
        publishState: flyer.publishState,
        auditState: flyer.auditState,
        phids: flyer.phids,
        showsAuthor: flyer.showsAuthor,
        zone: flyer.zone,
        authorID: flyer.authorID,
        bzID: flyer.bzID,
        position: flyer.position,
        draftSlides: await DraftSlide.draftsFromSlides(flyer.slides),
        specs: flyer.specs,
        times: flyer.times,
        hasPriceTag: flyer.hasPriceTag,
        hasPDF: flyer.hasPDF,
        isAmazonFlyer: flyer.isAmazonFlyer,
        score: flyer.score,
        pdfModel: await PDFProtocols.fetch(flyer.pdfPath),
        firstTimer: false,
        formKey: GlobalKey<FormState>(),
        canPickImage: true,
        posterController: ScreenshotController(),
        affiliateLink: flyer.affiliateLink,
        gtaLink: flyer.gtaLink,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel?> draftToFlyer({
    required DraftFlyer? draft,
    required bool toLDB,
    /// CORRECTS PUBLISH STATE AND ADDS NEW PUBLISH TIME RECORD
    bool isPublishing = false,
  }) async {

    FlyerModel? _output;

    if (draft != null){

       final List<PublishTime> _publishTimes = <PublishTime>[];
    if (Mapper.checkCanLoopList(draft.times) == true){
      _publishTimes.addAll(draft.times!);
    }
    if (isPublishing == true){
      _publishTimes.add(PublishTime(
        state: PublishState.published,
        time: DateTime.now(),
      ));
    }

    final AuditState? _auditState =
    draft.auditState == AuditState.verified ? AuditState.verified
        :
    isPublishing == true ? AuditState.pending
        :
    draft.auditState;

    _output = FlyerModel(
      id: draft.id,
      headline: draft.headline?.text,
      trigram: Stringer.createTrigram(input: draft.headline?.text),
      description: draft.description?.text,
      flyerType: draft.flyerType,
      publishState: isPublishing == true ? PublishState.published : draft.publishState,
      auditState: _auditState,
      phids: draft.phids,
      showsAuthor: draft.showsAuthor,
      zone: draft.zone,
      authorID: draft.authorID,
      bzID: draft.bzID,
      position: draft.position,
      slides: await DraftSlide.draftsToSlides(draft.draftSlides),
      specs: draft.specs,
      times: _publishTimes,
      hasPriceTag: Speccer.checkSpecsHavePrice(draft.specs),
      isAmazonFlyer: GtaModel.isAmazonAffiliateLink(draft.affiliateLink),
      hasPDF: draft.pdfModel != null,
      score: draft.score,
      pdfPath: draft.pdfModel == null ? null : StoragePath.flyers_flyerID_pdf(draft.id),
      shareLink: null,
      affiliateLink: draft.affiliateLink,
      gtaLink: draft.gtaLink,
      bzModel: await BzProtocols.fetchBz(bzID: draft.bzID,),
      authorImage: await PicProtocols.fetchPicUiImage(
        path: StoragePath.bzz_bzID_authorID(
          bzID: draft.bzID,
          authorID: draft.authorID,
        ),
      ),
      bzLogoImage: await PicProtocols.fetchPicUiImage(
        path: StoragePath.bzz_bzID_logo(draft.bzID),
      ),
      // docSnapshot: ,
    );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS - LDB

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? draftToLDB(DraftFlyer? draft){
    Map<String, dynamic>? _map;

    if (draft != null){
      _map = {
        'id' : draft.id,
        'headline' : draft.headline?.text,
        'trigram' : Stringer.createTrigram(input: draft.headline?.text),
        'description' : draft.description?.text,
        'flyerType' : FlyerTyper.cipherFlyerType(draft.flyerType),
        'publishState' : FlyerModel.cipherPublishState(draft.publishState),
        'auditState' : FlyerModel.cipherAuditState(draft.auditState),
        'phids' : draft.phids,
        'showsAuthor' : draft.showsAuthor,
        'zone' : draft.zone?.toMap(),
        'authorID' : draft.authorID,
        'bzID' : draft.bzID,
        'position' : Atlas.cipherGeoPoint(point: draft.position, toJSON: true),
        'draftSlides': DraftSlide.draftsToLDB(draft.draftSlides),
        'specs' : SpecModel.cipherSpecs(draft.specs),
        'times' : PublishTime.cipherTimes(times: draft.times, toJSON: true),
        'hasPriceTag': Speccer.checkSpecsHavePrice(draft.specs),
        'isAmazonFlyer': GtaModel.isAmazonAffiliateLink(draft.affiliateLink),
        'hasPDF': draft.pdfModel != null,
        'score' : draft.score,
        'pdfModel': draft.pdfModel?.toMap(includeBytes: true),
        'bzModel': draft.bzModel?.toMap(toJSON: true),
        'canPickImage': draft.canPickImage,
        'firstTimer': draft.firstTimer,
        'headlineNode': null,
        'descriptionNode': null,
        'formKey': null,
        'affiliateLink': draft.affiliateLink,
        'gtaLink': draft.gtaLink,
      };
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftFlyer? draftFromLDB(Map<String, dynamic>? map){
    DraftFlyer? _draft;

    if (map != null){
      _draft = DraftFlyer(
        id: map['id'],
        headline: TextEditingController(text: map['headline']),
        trigram: Stringer.getStringsFromDynamics(dynamics: map['trigram']),
        description: TextEditingController(text: map['description']),
        flyerType: FlyerTyper.decipherFlyerType(map['flyerType']),
        publishState: FlyerModel.decipherPublishState(map['publishState']),
        auditState: FlyerModel.decipherAuditState(map['auditState']),
        phids: Stringer.getStringsFromDynamics(dynamics: map['phids']),
        showsAuthor: map['showsAuthor'],
        zone: ZoneModel.decipherZone(map['zone']),
        authorID: map['authorID'],
        bzID: map['bzID'],
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: true),
        draftSlides: DraftSlide.draftsFromLDB(map['draftSlides']),
        specs: SpecModel.decipherSpecs(map['specs']),
        times: PublishTime.decipherTimes(map: map['times'], fromJSON: true),
        hasPDF: map['hasPDF'],
        isAmazonFlyer: map['isAmazonFlyer'],
        hasPriceTag: map['hasPriceTag'],
        score: map['score'],
        pdfModel: PDFModel.decipherFromMap(map['pdfModel']),
        bzModel: BzModel.decipherBz(map: map['bzModel'], fromJSON: true),
        canPickImage: map['canPickImage'],
        firstTimer: map['firstTimer'],
        headlineNode: null,
        descriptionNode: null,
        formKey: null,
        posterController: ScreenshotController(),
        affiliateLink: map['affiliateLink'],
        gtaLink: map['gtaLink'],
      );
    }

    return _draft;
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  DraftFlyer copyWith({
    String? id,
    TextEditingController? headline,
    List<String>? trigram,
    FocusNode? headlineNode,
    TextEditingController? description,
    FocusNode? descriptionNode,
    FlyerType? flyerType,
    PublishState? publishState,
    AuditState? auditState,
    List<String>? phids,
    bool? showsAuthor,
    ZoneModel? zone,
    String? authorID,
    String? bzID,
    GeoPoint? position,
    List<DraftSlide>? draftSlides,
    List<SpecModel>? specs,
    List<PublishTime>? times,
    bool? hasPriceTag,
    bool? hasPDF,
    bool? isAmazonFlyer,
    int? score,
    PDFModel? pdfModel,
    BzModel? bzModel,
    bool? canPickImage,
    GlobalKey<FormState>? formKey,
    bool? firstTimer,
    ScreenshotController? posterController,
    String? affiliateLink,
    String? gtaLink,
  }){
    return DraftFlyer(
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
      phids: phids ?? this.phids,
      showsAuthor: showsAuthor ?? this.showsAuthor,
      zone: zone ?? this.zone,
      authorID: authorID ?? this.authorID,
      bzID: bzID ?? this.bzID,
      position: position ?? this.position,
      draftSlides: draftSlides ?? this.draftSlides,
      specs: specs ?? this.specs,
      times: times ?? this.times,
      hasPriceTag: hasPriceTag ?? this.hasPriceTag,
      isAmazonFlyer: isAmazonFlyer ?? this.isAmazonFlyer,
      hasPDF: hasPDF ?? this.hasPDF,
      score: score ?? this.score,
      pdfModel: pdfModel ?? this.pdfModel,
      canPickImage: canPickImage ?? this.canPickImage,
      formKey: formKey ?? this.formKey,
      firstTimer: firstTimer ?? this.firstTimer,
      posterController: posterController ?? this.posterController,
      affiliateLink: affiliateLink ?? this.affiliateLink,
      gtaLink: gtaLink ?? this.gtaLink,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  DraftFlyer nullifyField({
    bool id = false,
    bool headline = false,
    bool trigram = false,
    bool headlineNode = false,
    bool description = false,
    bool descriptionNode = false,
    bool flyerType = false,
    bool publishState = false,
    bool auditState = false,
    bool phids = false,
    bool showsAuthor = false,
    bool zone = false,
    bool authorID = false,
    bool bzID = false,
    bool position = false,
    bool draftSlides = false,
    bool specs = false,
    bool times = false,
    bool hasPriceTag = false,
    bool hasPDF = false,
    bool isAmazonFlyer = false,
    bool score = false,
    bool pdfModel = false,
    bool bzModel = false,
    bool formKey = false,
    bool canPickImage = false,
    bool firstTimer = false,
    bool posterController = false,
    bool affiliateLink = false,
    bool gtaLink = false,
  }){
    return DraftFlyer(
      id: id == true ? null : this.id,
      headline: headline == true ? null : this.headline,
      trigram: trigram == true ? null : this.trigram,
      headlineNode: headlineNode == true ? null : this.headlineNode,
      description: description == true ? null : this.description,
      descriptionNode: descriptionNode == true ? null : this.descriptionNode,
      flyerType: flyerType == true ? null : this.flyerType,
      publishState: publishState == true ? null : this.publishState,
      auditState: auditState == true ? null : this.auditState,
      phids: phids == true ? [] : this.phids,
      showsAuthor: showsAuthor == true ? null : this.showsAuthor,
      zone: zone == true ? null : this.zone,
      authorID: authorID == true ? null : this.authorID,
      bzID: bzID == true ? null : this.bzID,
      position: position == true ? null : this.position,
      draftSlides: draftSlides == true ? [] : this.draftSlides,
      specs: specs == true ? [] : this.specs,
      times: times == true ? [] : this.times,
      hasPriceTag: hasPriceTag == true ? null : this.hasPriceTag,
      isAmazonFlyer: isAmazonFlyer == true ? null : this.isAmazonFlyer,
      hasPDF: hasPDF == true ? null : this.hasPDF,
      score: score == true ? null : this.score,
      pdfModel: pdfModel == true ? null : this.pdfModel,
      bzModel: bzModel == true ? null : this.bzModel,
      formKey: formKey == true ? null : this.formKey,
      canPickImage: canPickImage == true ? null : this.canPickImage,
      firstTimer: firstTimer == true ? null : this.firstTimer,
      posterController: posterController == true ? null : this.posterController,
      affiliateLink: affiliateLink == true ? null : this.affiliateLink,
      gtaLink: gtaLink == true ? null : this.gtaLink,
    );
  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    headline?.dispose();
    headlineNode?.dispose();
    descriptionNode?.dispose();
    description?.dispose();
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _generateStateTimeString({
    required PublishTime? publishTime,
  }){

    final String? _timeString = BldrsTimers.generateString_hh_i_mm_ampm_day_dd_month_yyyy(
      time: publishTime?.time,
    );
    final String? _stateString = FlyerModel.getPublishStatePhid(publishTime?.state);

    return '$_stateString @ $_timeString';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateShelfTitle({
    required PublishState publishState,
    required List<PublishTime> times,
    required int shelfNumber,
  }){

    final PublishTime? _publishTime = PublishTime.getPublishTimeFromTimes(
      state: publishState,
      times: times,
    );

    final String? _stateTimeString = _publishTime == null ?
    ''
        :
    _generateStateTimeString(
      publishTime: _publishTime,
    );

    final String _shelfTitle = '$shelfNumber . $_stateTimeString';

    return _shelfTitle;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftFlyer? updateHeadline({
    required String? newHeadline,
    required DraftFlyer? draft,
    required int slideIndex,
  }){

    DraftFlyer? _draft = draft;

    if (draft != null){

      if (Mapper.checkCanLoopList(draft.draftSlides) == true){

        /// UPDATE HEADLINE IN SLIDE
        final DraftSlide _newSlide = draft.draftSlides![slideIndex].copyWith(
          headline: newHeadline,
        );

        /// REPLACE SLIDE IN SLIDES
        final List<DraftSlide> _newSlides = DraftSlide.replaceSlide(
          drafts: draft.draftSlides,
          draft: _newSlide,
        );

        /// UPDATE SLIDES IN DRAFT
        _draft = _draft?.copyWith(
          draftSlides: _newSlides,
        );


      }

      // /// UPDATE FLYER HEADLINE IF ZERO INDEX
      // if (slideIndex == 0){
      //   draft.headline.text = newHeadline;
      // }

    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftFlyer? overrideFlyerID({
    required DraftFlyer? draft,
    required String? flyerID,
  }){
    DraftFlyer? _output;

    if (draft != null && flyerID != null){

      _output = draft.copyWith(
        id: flyerID,
        draftSlides: DraftSlide.overrideDraftsFlyerID(
          drafts: draft.draftSlides,
          flyerID: flyerID,
        ),
        pdfModel: draft.pdfModel?.copyWith(
          path: StoragePath.flyers_flyerID_pdf(flyerID),
        ),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFirstSlideHeadline(DraftFlyer? draft){
    return Mapper.checkCanLoopList(draft?.draftSlides) == true ?
    draft!.draftSlides![0].headline
        :
    null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PicModel> getPics(DraftFlyer? draft){
    final List<PicModel> _output = [];

    if (Mapper.checkCanLoopList(draft?.draftSlides) == true){

      for (final DraftSlide _slide in draft!.draftSlides!){
        if (_slide.picModel != null){
          _output.add(_slide.picModel!);
        }
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDraft({
    required String invoker,
  }){

      blog('[$invoker] : BLOGGING DRAFT FLYER MODEL ---------------------------------------- START');

      blog('id : $id');
      blog('headline : $headline');
      blog('description : $description');
      blog('flyerType : $flyerType');
      blog('publishState : $publishState');
      blog('auditState : auditState');
      blog('keywordsIDs : $phids');
      blog('showsAuthor : $showsAuthor');
      zone?.blogZone();
      blog('authorID : $authorID');
      blog('bzID : $bzID');
      blog('position : $position');
      blog('hasPriceTag : $hasPriceTag');
      blog('isAmazonFlyer : $isAmazonFlyer');
      blog('hasPDF : $hasPDF');
      blog('score : $score');
      PublishTime.blogTimes(times);
      SpecModel.blogSpecs(specs);
      blog('draftSlides : ${draftSlides?.length} slides');
      blog('affiliateLink : $affiliateLink');
      blog('gtaLink : $gtaLink');
      DraftSlide.blogSlides(
        slides: draftSlides,
        invoker: 'the_draft-flyer-slides'
      );
      pdfModel?.blogPDFModel(invoker: 'BLOGGING DRAFT');
      bzModel?.blogBz(invoker: 'BLOGGING DRAFT');

      blog('[$invoker] : BLOGGING DRAFT FLYER MODEL ---------------------------------------- END');
    }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogDraftsDifferences({
    required DraftFlyer? draft1,
    required DraftFlyer? draft2,
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
      if (Mapper.checkListsAreIdentical(list1: draft1.phids, list2: draft2.phids) == false){
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
      if (DraftSlide.checkSlidesListsAreIdentical(slides1: draft1.draftSlides, slides2: draft2.draftSlides) == false){
        blog('draftSlides are not identical');
      }
      if (SpecModel.checkSpecsListsAreIdentical(draft1.specs, draft2.specs) == false){
        blog('specs are not identical');
      }
      if (PublishTime.checkTimesListsAreIdentical(times1: draft1.times, times2: draft2.times) == false){
        blog('times are not identical');
      }
      if (draft1.hasPriceTag != draft2.hasPriceTag){
        blog('hasPriceTags are not identical');
      }
      if (draft1.isAmazonFlyer != draft2.isAmazonFlyer){
        blog('isAmazonFlyers are not identical');
      }
      if (draft1.hasPDF != draft2.hasPDF){
        blog('hasPDFs are not identical');
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
      if (draft1.affiliateLink != draft2.affiliateLink){
        blog('affiliateLinks are not identical');
      }
      if (draft1.gtaLink != draft2.gtaLink){
        blog('gtaLinks are not identical');
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
    required DraftFlyer? draft,
    required TextEditingController headlineController,
  }){
    bool _canPublish = false;

    if (draft != null){

      if (
          draft.draftSlides != null
          &&
          draft.draftSlides!.isNotEmpty == true
          &&
          headlineController.text.length >= Standards.flyerHeadlineMinLength
      ){

        _canPublish = true;
      }

    }

    return _canPublish;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanAddMoreSlides(DraftFlyer? draft) {
    bool _canAddMoreSlides = false;

    if (draft != null){

      /// FIRST TIMER
      if (draft.firstTimer != null && draft.firstTimer! == true){
        _canAddMoreSlides = true;
      }

      /// UPDATING FLYER
      else {

        final PublishTime? _publishTime = PublishTime.getPublishTimeFromTimes(
          times: draft.times,
          state: PublishState.published,
        );

        final int _days = Timers.calculateTimeDifferenceInDays(
            from: _publishTime?.time,
            to: DateTime.now(),
        );

        if (_days > Standards.flyerMaxDaysToUpdate){
          _canAddMoreSlides = false;
        }

        else {
          _canAddMoreSlides = true;
        }

      }

    }

    return _canAddMoreSlides;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkPosterHasChanged({
    required DraftFlyer? draft,
    required FlyerModel? oldFlyer,
  }) async {
    bool _hasChanged = false;

    if (draft?.draftSlides?.length != oldFlyer?.slides?.length){
      _hasChanged = true;
    }

    else if (draft?.headline?.text != oldFlyer?.headline){
      _hasChanged = true;
    }

    else {

      final List<PicModel> _draftPics = getPics(draft);
      final List<PicModel> _oldPics = await PicProtocols.fetchFlyerPics(
        flyerModel: oldFlyer,
      );

      /// [identical = true] => [hasChanged = false] ya zaki
      _hasChanged = !PicModel.checkPicsListsAreIdentical(
        list1: _draftPics,
        list2: _oldPics,
      );

    }

    return _hasChanged;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkDraftsAreIdentical({
    required DraftFlyer? draft1,
    required DraftFlyer? draft2,
  }){
    bool _areIdentical = false;

    if (draft1 == null && draft2 == null){
      _areIdentical = true;
    }
    else if (draft1 == null || draft2 == null){
      _areIdentical = false;
    }
    else {

      if (
          draft1.id == draft2.id &&
          draft1.headline == draft2.headline &&
          // FocusNode headlineNode,
          draft1.description == draft2.description &&
          // FocusNode descriptionNode,
          draft1.flyerType == draft2.flyerType &&
          draft1.publishState == draft2.publishState &&
          draft1.auditState == draft2.auditState &&
          Mapper.checkListsAreIdentical(list1: draft1.phids, list2: draft2.phids) == true &&
          draft1.showsAuthor == draft2.showsAuthor &&
          ZoneModel.checkZonesAreIdentical(zone1: draft1.zone, zone2: draft2.zone) == true &&
          draft1.authorID == draft2.authorID &&
          draft1.bzID == draft2.bzID &&
          Atlas.checkPointsAreIdentical(point1: draft1.position, point2: draft2.position) == true &&
          DraftSlide.checkSlidesListsAreIdentical(slides1: draft1.draftSlides, slides2: draft2.draftSlides) == true &&
          SpecModel.checkSpecsListsAreIdentical(draft1.specs, draft2.specs) == true &&
          PublishTime.checkTimesListsAreIdentical(times1: draft1.times, times2: draft2.times) == true &&
          draft1.hasPriceTag == draft2.hasPriceTag &&
          draft1.hasPDF == draft2.hasPDF &&
          draft1.isAmazonFlyer == draft2.isAmazonFlyer &&
          draft1.score == draft2.score &&
          PDFModel.checkPDFModelsAreIdentical(pdf1: draft1.pdfModel, pdf2: draft2.pdfModel) == true &&
          BzModel.checkBzzAreIdentical(bz1: draft1.bzModel, bz2: draft2.bzModel) == true &&
          draft1.affiliateLink == draft2.affiliateLink &&
          draft1.gtaLink == draft2.gtaLink
      ){
        _areIdentical = true;
      }

    }

    // if (_areIdentical == false){
    //   _blogDraftsDifferences(
    //     draft1: draft1,
    //     draft2: draft2,
    //   );
    // }

    // blog('checkDraftsAreIdentical : _areIdentical = $_areIdentical');
    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is DraftFlyer){
      _areIdentical = checkDraftsAreIdentical(
        draft1: this,
        draft2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
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
      phids.hashCode^
      showsAuthor.hashCode^
      zone.hashCode^
      authorID.hashCode^
      bzID.hashCode^
      position.hashCode^
      draftSlides.hashCode^
      specs.hashCode^
      times.hashCode^
      hasPriceTag.hashCode^
      hasPDF.hashCode^
      isAmazonFlyer.hashCode^
      score.hashCode^
      posterController.hashCode^
      affiliateLink.hashCode^
      gtaLink.hashCode^
      pdfModel.hashCode;
  // -----------------------------------------------------------------------------
}
