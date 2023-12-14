import 'dart:typed_data';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/colors/colorizer.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:flutter/material.dart';

/// => TAMAM
@immutable
class DraftSlide {
  // --------------------------------------------------------------------------
  const DraftSlide({
    required this.flyerID,
    required this.slideIndex,
    required this.bigPic,
    required this.medPic,
    required this.smallPic,
    required this.backPic,
    required this.headline,
    required this.description,
    required this.midColor,
    required this.backColor,
    required this.opacity,
    required this.matrix,
    required this.matrixFrom,
    required this.animationCurve,
  });
  // --------------------------------------------------------------------------
  final String? flyerID;
  final int slideIndex;
  final PicModel? bigPic;
  final PicModel? medPic;
  final PicModel? smallPic;
  final PicModel? backPic;
  final String? headline;
  final String? description;
  final Color? midColor;
  final Color? backColor;
  final double? opacity;
  final Matrix4? matrix;
  final Matrix4? matrixFrom;
  final Curve? animationCurve;
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DraftSlide>> createDrafts({
    required List<PicModel>? bigPics,
    required List<DraftSlide> existingDrafts,
    required String? headline,
    required String? flyerID,
    required String? bzID,
    required double flyerBoxWidth,
  }) async {
    final List<DraftSlide> _output = <DraftSlide>[];

    if (Lister.checkCanLoop(bigPics) == true){

      for (int i = 0; i < bigPics!.length; i++){

        final PicModel _bigPic = bigPics[i];

        final int _newSlideIndex = i + existingDrafts.length;

        /// B1 - CREATE NEW DRAFT SLIDE
        final DraftSlide? _newSlide = await createDraft(
          bigPic: _bigPic,
          index: _newSlideIndex,
          headline: null,//_newSlideIndex  == 0 ? headline : null,
          flyerID: flyerID,
          bzID: bzID,
          flyerBoxWidth: flyerBoxWidth,
          overrideSolidColor: null,
        );

        /// B2 - ADD THIS NEW SLIDE
        if (_newSlide != null){
          _output.add(_newSlide);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftSlide?> createDraft({
    required PicModel? bigPic,
    required int index,
    required String? headline,
    required String? flyerID,
    required String? bzID,
    required double flyerBoxWidth,
    required Color? overrideSolidColor,
  }) async {
    DraftSlide? _slide;

    if (bigPic != null){

      final Color? _midColor = await Colorizer.getAverageColor(bigPic.bytes);
      final PicModel? _medPic = await SlidePicMaker.compressSlideBigPicTo(
        slidePic: bigPic,
        flyerID: flyerID,
        slideIndex: index,
        type: SlidePicType.med,
      );
      final PicModel? _smallPic = await SlidePicMaker.compressSlideBigPicTo(
        slidePic: bigPic,
        flyerID: flyerID,
        slideIndex: index,
        type: SlidePicType.small,
      );
      final PicModel? _backPic = await SlidePicMaker.createSlideBackground(
        bigPic: bigPic,
        flyerID: flyerID,
        slideIndex: index,
        overrideSolidColor: overrideSolidColor,
      );

      _slide = DraftSlide(
        flyerID: flyerID,
        bigPic: bigPic,
        medPic: _medPic,
        smallPic: _smallPic,
        backPic: _backPic,
        headline: '',
        description: '',
        midColor: _midColor,
        backColor: overrideSolidColor,
        opacity: 1,
        slideIndex: index,
        matrix: createInitialMatrix(
          isMatrixFrom: false,
          flyerBoxWidth: flyerBoxWidth,
        ),
        matrixFrom: createInitialMatrix(
          isMatrixFrom: true,
          flyerBoxWidth: flyerBoxWidth,
        ),
        animationCurve: null,
      );

    }

    return _slide;
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS - SLIDE MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<SlideModel?> draftToSlide({
    required DraftSlide? draft,
    required SlidePicType slidePicType,
  }) async {
    SlideModel? slide;

    if (draft != null){

      final PicModel? _picModel = getPicModel(
          draft: draft,
          slidePicType: slidePicType
      );
      final PicModel? _backPic = getPicModel(
          draft: draft,
          slidePicType: SlidePicType.back,
      );

      slide = SlideModel(
        flyerID: draft.flyerID,
        slideIndex: draft.slideIndex,
        headline: draft.headline,
        description: draft.description,
        midColor: draft.midColor,
        backColor: draft.backColor,
        matrix: draft.matrix,
        matrixFrom: draft.matrixFrom,
        animationCurve: draft.animationCurve,
        frontImage: await Floaters.getUiImageFromUint8List(_picModel?.bytes),
        backImage: await Floaters.getUiImageFromUint8List(_backPic?.bytes),
        frontPicPath: _picModel?.path,
      );

    }

    return slide;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<SlideModel>> draftsToSlides({
    required List<DraftSlide>? drafts,
    required SlidePicType slidePicType,
  }) async {
    final List<SlideModel> _slides = <SlideModel>[];

    if (Lister.checkCanLoop(drafts) == true){

      for (final DraftSlide draft in drafts!){

        final SlideModel? _slide = await draftToSlide(
          draft: draft,
          slidePicType: slidePicType,
        );

        if (_slide != null){
          _slides.add(_slide);
        }

      }

    }

    return SlideModel.sortSlidesByIndexes(_slides);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftSlide?> draftFromSlide(SlideModel? slide) async {
    DraftSlide? _draft;

    if (slide != null){
      _draft = DraftSlide(
        flyerID: slide.flyerID,
        slideIndex: slide.slideIndex,
        bigPic: await PicProtocols.fetchSlidePic(slide: slide, type: SlidePicType.big),
        medPic: await PicProtocols.fetchSlidePic(slide: slide, type: SlidePicType.med),
        smallPic: await PicProtocols.fetchSlidePic(slide: slide, type: SlidePicType.small),
        backPic: slide.backColor == null ?
        await PicProtocols.fetchSlidePic(slide: slide, type: SlidePicType.back)
            :
        null,
        headline: slide.headline,
        description: slide.description,
        midColor: slide.midColor,
        backColor: slide.backColor,
        opacity: 1,
        matrix: slide.matrix,
        matrixFrom: slide.matrixFrom,
        animationCurve: slide.animationCurve,
      );
    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DraftSlide>> draftsFromSlides(List<SlideModel>? slides) async {
    final List<DraftSlide> _output = <DraftSlide>[];

    if (Lister.checkCanLoop(slides) == true){

      await Future.wait(<Future>[

        ...List.generate(slides!.length, (index){

          return draftFromSlide(slides[index])
              .then((DraftSlide? draft){

                // blog('wadi one draft');
                // draft?.copyWith();

                if (draft != null){
                  _output.add(draft);
                }

          });

        }),

      ]);

    }

    _output.sort((a, b){

      final int _aIndex = a.slideIndex;
      final int _bIndex = b.slideIndex;

      return _aIndex.compareTo(_bIndex);
    });

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS - LDB

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? draftToLDB(DraftSlide? draft){
    Map<String, dynamic>? _map;

    if (draft != null){
      _map = {
        'flyerID': draft.flyerID,
        'slideIndex': draft.slideIndex,
        'bigPic': PicModel.cipherToLDB(draft.bigPic),
        'medPic': PicModel.cipherToLDB(draft.medPic),
        'smallPic': PicModel.cipherToLDB(draft.smallPic),
        'backPic': PicModel.cipherToLDB(draft.backPic),
        'headline': draft.headline,
        'description': draft.description,
        'midColor': Colorizer.cipherColor(draft.midColor),
        'backColor': Colorizer.cipherColor(draft.backColor),
        'opacity': draft.opacity,
        'matrix' : Trinity.cipherMatrix(draft.matrix),
        'matrixFrom' : Trinity.cipherMatrix(draft.matrixFrom),
        'animationCurve' : Trinity.cipherAnimationCurve(draft.animationCurve),
      };
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> draftsToLDB(List<DraftSlide>? drafts){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Lister.checkCanLoop(drafts) == true){

      for (final DraftSlide draft in drafts!){

        final Map<String, dynamic>? _map = draftToLDB(draft);
        if (_map != null){
          _maps.add(_map);
        }

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftSlide? draftFromLDB(Map<String, dynamic>? map){
    DraftSlide? _draft;

    if (map != null){
      _draft = DraftSlide(
        flyerID: map['flyerID'],
        slideIndex: map['slideIndex'],
        bigPic: PicModel.decipherFromLDB(map['bigPic']),
        medPic: PicModel.decipherFromLDB(map['medPic']),
        smallPic: PicModel.decipherFromLDB(map['smallPic']),
        backPic: PicModel.decipherFromLDB(map['backPic']),
        headline: map['headline'],
        description: map['description'],
        midColor: Colorizer.decipherColor(map['midColor']),
        backColor: Colorizer.decipherColor(map['backColor']),
        opacity: map['opacity'],
        matrix: Trinity.decipherMatrix(map['matrix']),
        matrixFrom: Trinity.decipherMatrix(map['matrixFrom']),
        animationCurve: Trinity.decipherAnimationCurve(map['animationCurve']),
      );
    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DraftSlide> draftsFromLDB(List<dynamic>? maps){
    final List<DraftSlide> drafts = <DraftSlide>[];

    if (Lister.checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final DraftSlide? _draft = draftFromLDB(map);
        if (_draft != null){
          drafts.add(_draft);
        }
      }

    }

    return drafts;
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  DraftSlide copyWith({
    String? flyerID,
    int? slideIndex,
    PicModel? bigPic,
    PicModel? medPic,
    PicModel? smallPic,
    PicModel? backPic,
    BoxFit? picFit,
    String? headline,
    String? description,
    Color? midColor,
    Color? backColor,
    double? opacity,
    Matrix4? matrix,
    Matrix4? matrixFrom,
    Curve? animationCurve,
  }){
    return DraftSlide(
      flyerID: flyerID ?? this.flyerID,
      slideIndex: slideIndex ?? this.slideIndex,
      bigPic: bigPic ?? this.bigPic,
      medPic: medPic ?? this.medPic,
      smallPic: smallPic ?? this.smallPic,
      backPic: backPic ?? this.backPic,
      headline: headline ?? this.headline,
      description: description ?? this.description,
      midColor: midColor ?? this.midColor,
      backColor: backColor ?? this.backColor,
      opacity: opacity ?? this.opacity,
      matrix: matrix ?? this.matrix,
      matrixFrom: matrixFrom ?? this.matrixFrom,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  DraftSlide nullifyField({
    bool flyerID = false,
    // bool slideIndex = false,
    bool bigPic = false,
    bool medPic = false,
    bool smallPic = false,
    bool backPic = false,
    bool picFit = false,
    bool headline = false,
    bool description = false,
    bool midColor = false,
    bool backColor = false,
    bool opacity = false,
    bool matrix = false,
    bool matrixFrom = false,
    bool animationCurve = false,
  }){
    return DraftSlide(
      flyerID: flyerID == true ? null : this.flyerID,
      slideIndex: slideIndex, // == true ? null : this.slideIndex,
      bigPic: bigPic == true ? null : this.bigPic,
      medPic: medPic == true ? null : this.medPic,
      smallPic: smallPic == true ? null : this.smallPic,
      backPic: backPic == true ? null : this.backPic,
      headline: headline == true ? null : this.headline,
      description: description == true ? null : this.description,
      midColor: midColor == true ? null : this.midColor,
      backColor: backColor == true ? null : this.backColor,
      opacity: opacity == true ? null : this.opacity,
      matrix: matrix == true ? null : this.matrix,
      matrixFrom: matrixFrom == true ? null : this.matrixFrom,
      animationCurve: animationCurve == true ? null : this.animationCurve,
    );
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static PicModel? getPicModel({
    required DraftSlide? draft,
    required SlidePicType slidePicType,
  }){
    PicModel? _output;

    if (draft != null){
      switch (slidePicType){
        case SlidePicType.big:    _output = draft.bigPic; break;
        case SlidePicType.med:    _output = draft.medPic; break;
        case SlidePicType.small:  _output = draft.smallPic; break;
        case SlidePicType.back:    _output = draft.backPic; break;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Uint8List> getBytezzFromDraftSlides({
    required List<DraftSlide> drafts,
    required SlidePicType slidePicType,
  }) {

    final List<Uint8List> _output = <Uint8List>[];

    for (final DraftSlide draft in drafts) {

      switch (slidePicType){

        case SlidePicType.big:
          if (draft.bigPic?.bytes != null) {
            _output.add(draft.bigPic!.bytes!);
          } break;

        case SlidePicType.med:
          if (draft.medPic?.bytes != null) {
            _output.add(draft.medPic!.bytes!);
          } break;

        case SlidePicType.small:
          if (draft.smallPic?.bytes != null) {
            _output.add(draft.smallPic!.bytes!);
          } break;

        case SlidePicType.back:
          if (draft.backPic?.bytes != null) {
            _output.add(draft.backPic!.bytes!);
          } break;

      }


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PicModel> getPicModels({
    required List<DraftSlide>? drafts,
    required SlidePicType slidePicType,
  }){
    final List<PicModel> _output = <PicModel>[];

    if (Lister.checkCanLoop(drafts) == true){

      for (final DraftSlide draft in drafts!){

        final PicModel? _picModel = getPicModel(
            draft: draft,
            slidePicType: slidePicType,
        );

        if (_picModel != null){
          _output.add(_picModel);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MATRIXES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 createInitialMatrix({
    required bool isMatrixFrom,
    required double flyerBoxWidth,
  }){

    if (isMatrixFrom == true){
      return Trinity.slightlyZoomed(
        flyerBoxWidth: flyerBoxWidth,
        flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
          flyerBoxWidth: flyerBoxWidth,
        ),
      );
    }

    else {
      return Matrix4.identity();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanResetMatrixes({
    required Matrix4? matrixFrom,
    required Matrix4? matrix,
    required double flyerBoxWidth,
  }){

    /// MATRIX
    final Matrix4 _matrixShould = createInitialMatrix(
      flyerBoxWidth: flyerBoxWidth,
      isMatrixFrom: false,
    );
    // Trinity.blogMatrix(matrix: _matrixShould, invoker: 'matrixShould');

    // final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
    //   flyerBoxWidth: flyerBoxWidth,
    // );

    final bool _matrixIsGood = _matrixShould == matrix;
    // Trinity.checkMatrixesAreIdentical(
    //   matrix1: _matrixShould,
    //   matrixReloaded: matrix,
    // );
    // Trinity.blogMatrix(matrix: matrix, invoker: 'matrix');

    /// MATRIX FROM
    Matrix4? _matrixFromShould = createInitialMatrix(
      flyerBoxWidth: flyerBoxWidth,
      isMatrixFrom: true,
    );

    _matrixFromShould = Trinity.roundTranslation(
        matrix: _matrixFromShould,
        fractions: 1,
    );

    final Matrix4? _from = Trinity.roundTranslation(
        matrix: matrixFrom,
        fractions: 1,
    );

    // Trinity.blogMatrix(
    //   matrix: _matrixFromShould,
    //   invoker: 'matrixFromShould',
    //   roundDigits: 16,
    // );
    final bool _matrixFromIsGood = _from == _matrixFromShould;

    // Trinity.checkMatrixesAreIdentical(
    //   matrix1: _matrixFromShould,
    //   matrixReloaded: matrixFrom,
    // );

    // Trinity.blogMatrix(
    //   matrix: matrixFrom,
    //   invoker: 'matrixFrom',
    //   roundDigits: 16,
    // );

    // blog('checkCanResetMatrixes => _matrixIsGood : $_matrixIsGood : _matrixFromIsGood : $_matrixFromIsGood');

    return _matrixIsGood == false || _matrixFromIsGood == false;
  }
  // -----------------------------------------------------------------------------

  /// INDEXES

  // --------------------
  /*
  ///
  static int getFileTrueIndexFromMutableSlides({
    required List<DraftSlide> mutableSlides,
    required int slideIndex,
  }) {

    /// mutable slides pics object types will look like [File, File, File, Asset, Asset, Asset]
    /// while assets list can't include null values or empty assets, so its list would be [Asset, Asset, Asset]
    /// so
    /// when deleting slide index 4, we need to figure that asset true index is 1
    /// by saying : trueIndex = ( 4 - 3 ) = ( slideIndex - numberOfFiles )
    /// A - search for first slide where its picture of object type asset
    /// B - when found
    ///   C - get number of slides with files
    ///   C - conclude true index
    /// B - when not found, return null

    int _trueIndex;

    /// A - search for first slide where its picture of object type asset
    final DraftSlide _firstSlideWithAssetPicture = mutableSlides.firstWhere(
            (DraftSlide slide) =>
        ObjectCheck.objectIsFile(slide.picURL) == true,
        orElse: () => null);

    /// B - when found
    if (_firstSlideWithAssetPicture != null) {
      /// C - get number of slides with files
      final int _firstAssetIndex = _firstSlideWithAssetPicture.slideIndex;
      final int _numberOfFiles = _firstAssetIndex;

      /// C - conclude true index
      _trueIndex = slideIndex - _numberOfFiles;
    }

    /// B - when not found, return null
    return _trueIndex;
  }
   */
  // --------------------
  /*
  ///
  static int getMutableSlideIndexThatContainsThisFile({
    required List<DraftSlide> mSlides,
    required File fileToSearchFor,
  }) {

    int _assetIndexInAssets = -1;

    if (mSlides != null && mSlides.isNotEmpty && fileToSearchFor != null) {
      _assetIndexInAssets = mSlides.indexWhere(
            (DraftSlide mSlide) =>
        Filers.checkFilesAreIdentical(file1: mSlide?.picModel?.bytes, file2: fileToSearchFor) == true,
      );
    }

    return _assetIndexInAssets;
  }
   */
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DraftSlide> replaceSlide({
    required List<DraftSlide>? drafts,
    required DraftSlide? draft,
  }){
    List<DraftSlide> _output = <DraftSlide>[];

    if (Lister.checkCanLoop(drafts) == true){

      _output = [...drafts!];
      _output.removeAt(draft!.slideIndex);
      _output.insert(draft.slideIndex, draft);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DraftSlide> removeDraftFromDrafts({
    required List<DraftSlide>? drafts,
    required DraftSlide draft,
  }){
    List<DraftSlide> _output = <DraftSlide>[];

    if (Lister.checkCanLoop(drafts) == true){

      final List<DraftSlide> _list = [...drafts!];
      _list.removeAt(draft.slideIndex);


      _output =  overrideDraftsSlideIndexes(
        drafts: _list,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DraftSlide> overrideDraftsFlyerID({
    required List<DraftSlide>? drafts,
    required String? flyerID,
  }){
    final List<DraftSlide> _output = <DraftSlide>[];

    if (Lister.checkCanLoop(drafts) == true && flyerID != null){

      for (final DraftSlide draft in drafts!){

        final DraftSlide _updated = draft.copyWith(
          flyerID: flyerID,

          bigPic: draft.bigPic?.copyWith(
            meta: draft.bigPic?.meta?.copyWith(name: SlideModel.generateSlideID(flyerID: flyerID, slideIndex: draft.slideIndex, type: SlidePicType.big)),
            path: SlideModel.generateSlidePicPath(type: SlidePicType.big, flyerID: flyerID, slideIndex: draft.slideIndex,),
          ),

          medPic: draft.medPic?.copyWith(
            meta: draft.medPic?.meta?.copyWith(name: SlideModel.generateSlideID(flyerID: flyerID, slideIndex: draft.slideIndex, type: SlidePicType.med)),
            path: SlideModel.generateSlidePicPath(type: SlidePicType.med, flyerID: flyerID, slideIndex: draft.slideIndex,),
          ),

          smallPic: draft.smallPic?.copyWith(
            meta: draft.smallPic?.meta?.copyWith(name: SlideModel.generateSlideID(flyerID: flyerID, slideIndex: draft.slideIndex, type: SlidePicType.small)),
            path: SlideModel.generateSlidePicPath(type: SlidePicType.small, flyerID: flyerID, slideIndex: draft.slideIndex,),
          ),

          backPic: draft.backPic?.copyWith(
            meta: draft.backPic?.meta?.copyWith(name: SlideModel.generateSlideID(flyerID: flyerID, slideIndex: draft.slideIndex, type: SlidePicType.back)),
            path: SlideModel.generateSlidePicPath(type: SlidePicType.back, flyerID: flyerID, slideIndex: draft.slideIndex,),
          ),

        );

        _output.add(_updated);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DraftSlide> overrideDraftsSlideIndexes({
    required List<DraftSlide> drafts,
  }){
    final List<DraftSlide> _output = <DraftSlide>[];

    if (Lister.checkCanLoop(drafts) == true){

      for (int i = 0; i < drafts.length; i++){

        final DraftSlide _updated = drafts[i].copyWith(
          slideIndex: i,
        );

        _output.add(_updated);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDraft({required String invoker}){

    blog('[$invoker] : ($slideIndex)=> DraftSlide : flyerID : $flyerID : index : $slideIndex');
    blog('headline : $headline : description : $description');
    blog('midColor : $midColor : backColor : $backColor : opacity : $opacity');
    blog('hasCustomMatrix : ${matrix != null} : '
        'hasCustomMatrixFrom : ${matrixFrom != null} : '
        'animationCurve L $animationCurve');
    bigPic?.blogPic(invoker: 'draftSlide big pic');
    medPic?.blogPic(invoker: 'draftSlide med pic');
    smallPic?.blogPic(invoker: 'draftSlide small pic');
    backPic?.blogPic(invoker: 'draftSlide back pic');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSlides({
    required List<DraftSlide>? slides,
    required String invoker,
  }){

    blog('BLOGGING SLIDES [$invoker] -------- START');

    if (Lister.checkCanLoop(slides) == true) {
      for (final DraftSlide slide in slides!) {
        slide.blogDraft(
          invoker: invoker,
        );
      }
    }

    blog('BLOGGING SLIDES [$invoker] -------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogDraftSlidesDifferences({
    required DraftSlide? slide1,
    required DraftSlide? slide2,
  }){

    if (slide1 == null){
      blog('MutableSlidesDifferences : slide1 is null');
    }
    if (slide2 == null){
      blog('MutableSlidesDifferences : slide2 is null');
    }
    if (slide1?.flyerID != slide2?.flyerID){
      blog('MutableSlidesDifferences : flyerIDs are not Identical');
    }
    if (slide1?.slideIndex != slide2?.slideIndex){
      blog('MutableSlidesDifferences : slideIndexes are not Identical');
    }
    if (PicModel.checkPicsAreIdentical(pic1: slide1?.bigPic, pic2: slide2?.bigPic) == false){
      blog('MutableSlidesDifferences : bigPics are not Identical');
    }
    if (PicModel.checkPicsAreIdentical(pic1: slide1?.medPic, pic2: slide2?.medPic) == false){
      blog('MutableSlidesDifferences : medPics are not Identical');
    }
    if (PicModel.checkPicsAreIdentical(pic1: slide1?.smallPic, pic2: slide2?.smallPic) == false){
      blog('MutableSlidesDifferences : smallPics are not Identical');
    }
    if (PicModel.checkPicsAreIdentical(pic1: slide1?.backPic, pic2: slide2?.backPic) == false){
      blog('MutableSlidesDifferences : backPics are not Identical');
    }
    if (slide1?.headline != slide2?.headline){
      blog('MutableSlidesDifferences : headlines are not Identical');
    }
    if (slide1?.description != slide2?.description){
      blog('MutableSlidesDifferences : descriptions are not Identical');
    }
    if (Colorizer.checkColorsAreIdentical(slide1?.midColor, slide2?.midColor) == false){
      blog('MutableSlidesDifferences : midColors are not Identical');
    }
    if (Colorizer.checkColorsAreIdentical(slide1?.backColor, slide2?.backColor) == false){
      blog('MutableSlidesDifferences : backColors are not Identical');
    }
    if (slide1?.opacity != slide2?.opacity){
      blog('MutableSlidesDifferences : opacities are not Identical');
    }
    if (Trinity.checkMatrixesAreIdentical(matrix1: slide1?.matrix, matrixReloaded: slide2?.matrix) == false){
      blog('MutableSlidesDifferences : matrixes are not Identical');
    }
    if (Trinity.checkMatrixesAreIdentical(matrix1: slide1?.matrixFrom, matrixReloaded: slide2?.matrixFrom) == false){
      blog('MutableSlidesDifferences : matrixFroms are not Identical');
    }
    if (slide1?.animationCurve != slide2?.animationCurve){
      blog('MutableSlidesDifferences : animationCurves are not Identical');
    }
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSlidesAreIdentical({
    required DraftSlide? slide1,
    required DraftSlide? slide2,
    bool blogDifferences = false,
  }){
    bool _identical = false;

    if (slide1 == null && slide2 == null){
      _identical = true;
    }

    else if (slide1 != null && slide2 != null){

      // blog('${slide1.headline} == ${slide2.headline}');

      if (
          slide1.flyerID == slide2.flyerID &&
          slide1.slideIndex == slide2.slideIndex &&
          PicModel.checkPicsAreIdentical(pic1: slide1.bigPic, pic2: slide2.bigPic) == true &&
          PicModel.checkPicsAreIdentical(pic1: slide1.medPic, pic2: slide2.medPic) == true &&
          PicModel.checkPicsAreIdentical(pic1: slide1.smallPic, pic2: slide2.smallPic) == true &&
          PicModel.checkPicsAreIdentical(pic1: slide1.backPic, pic2: slide2.backPic) == true &&
          slide1.headline == slide2.headline &&
          slide1.description == slide2.description &&
          Colorizer.checkColorsAreIdentical(slide1.midColor, slide2.midColor) == true &&
          Colorizer.checkColorsAreIdentical(slide1.backColor, slide2.backColor) == true &&
          slide1.opacity == slide2.opacity &&
          Trinity.checkMatrixesAreIdentical(matrix1: slide1.matrix, matrixReloaded: slide2.matrix) == true &&
          Trinity.checkMatrixesAreIdentical(matrix1: slide1.matrixFrom, matrixReloaded: slide2.matrixFrom) == true &&
          slide1.animationCurve == slide2.animationCurve
      ){
        _identical = true;
      }

      if (_identical == false && blogDifferences == true){
        blogDraftSlidesDifferences(
          slide1: slide1,
          slide2: slide2,
        );
      }
      else if (_identical == true && blogDifferences == true){
        blog('checkSlidesAreIdentical : Draft Slides Are Identical');
      }

    }

    // blog('checkSlidesAreIdentical => $_identical');

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSlidesListsAreIdentical({
    required List<DraftSlide>? slides1,
    required List<DraftSlide>? slides2,
  }){
    bool _listsAreIdentical = false;

    if (slides1 == null && slides2 == null){
      _listsAreIdentical = true;
      // blog('checkSlidesListsAreIdentical : both are null');
    }
    else if (slides1 != null && slides1.isEmpty == true && slides2 != null && slides2.isEmpty == true){
      _listsAreIdentical = true;
      // blog('checkSlidesListsAreIdentical : both are empty');
    }
    else if (Lister.checkCanLoop(slides1) == true && Lister.checkCanLoop(slides2) == true){

      if (slides1!.length != slides2!.length){
        _listsAreIdentical = false;
        // blog('checkSlidesListsAreIdentical : lists are not the same length');
      }
      else {

        for (int i = 0; i < slides1.length; i++){

          final DraftSlide _slide1 = slides1[i];
          final DraftSlide _slide2 = slides2[i];

          final bool _areIdentical = checkSlidesAreIdentical(
            slide1: _slide1,
            slide2: _slide2,
          );

          /// PAIR ARE IDENTICAL
          if (_areIdentical == true){

            // blog('checkSlidesListsAreIdentical : slides at index [$i] ARE INDEED IDENTICAL');

            /// ON LAST SLIDE
            if ( i + 1 == slides1.length){
              // blog('checkSlidesListsAreIdentical : All slides are identical');
              _listsAreIdentical = true;
            }

          }

          /// ARE ARE NOT IDENTICAL
          else {
            _listsAreIdentical = false;
            // blog('checkSlidesListsAreIdentical : slides at index [$i] are not identical');
            break;
          }


        }

      }

    }

    // blog('_listsAreIdentical : $_listsAreIdentical');
    return _listsAreIdentical;
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
    if (other is DraftSlide){
      _areIdentical = checkSlidesAreIdentical(
        slide1: this,
        slide2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      flyerID.hashCode^
      slideIndex.hashCode^
      bigPic.hashCode^
      medPic.hashCode^
      smallPic.hashCode^
      backPic.hashCode^
      headline.hashCode^
      description.hashCode^
      midColor.hashCode^
      backColor.hashCode^
      opacity.hashCode^
      matrix.hashCode^
      matrixFrom.hashCode^
      animationCurve.hashCode;
  // -----------------------------------------------------------------------------
}
