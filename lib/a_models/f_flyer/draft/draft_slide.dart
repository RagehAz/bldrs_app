import 'dart:typed_data';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:fire/super_fire.dart';
import 'package:basics/helpers/classes/colors/colorizer.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:mediators/models/dimension_model.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/super_image/super_image.dart';

/// => TAMAM
@immutable
class DraftSlide {
  // --------------------------------------------------------------------------
  const DraftSlide({
    required this.flyerID,
    required this.slideIndex,
    required this.picModel,
    required this.picFit,
    required this.headline,
    required this.description,
    required this.midColor,
    required this.opacity,
    required this.matrix,
    required this.filter,
    required this.animationCurve,
  });
  // --------------------------------------------------------------------------
  final String? flyerID;
  final int slideIndex;
  final PicModel? picModel;
  final BoxFit? picFit;
  final String? headline;
  final String? description;
  final Color? midColor;
  final double? opacity;
  final Matrix4? matrix;
  final ImageFilterModel? filter;
  final Curve? animationCurve;
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DraftSlide>> createDrafts({
    required List<Uint8List>? bytezz,
    required List<DraftSlide> existingDrafts,
    required String? headline,
    required String? flyerID,
    required String? bzID,
  }) async {
    final List<DraftSlide> _output = <DraftSlide>[];

    if (Mapper.checkCanLoopList(bytezz) == true){

      for (int i = 0; i < bytezz!.length; i++){

        final Uint8List _bytes = bytezz[i];

        final int _newSlideIndex = i + existingDrafts.length;

        /// B1 - CREATE NEW DRAFT SLIDE
        final DraftSlide? _newSlide = await createDraft(
          bytes: _bytes,
          index: _newSlideIndex,
          headline: _newSlideIndex  == 0 ? headline : null,
          flyerID: flyerID,
          bzID: bzID,
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
    required Uint8List? bytes,
    required int index,
    required String? headline,
    required String? flyerID,
    required String? bzID,
  }) async {
    DraftSlide? _slide;

    if (bytes != null){

      final Dimensions? _dimensions = await Dimensions.superDimensions(bytes);
      final Color? _midColor = await Colorizer.getAverageColor(bytes);

      _slide = DraftSlide(
        flyerID: flyerID,
        picModel: PicModel(
          bytes: bytes,
          path: StoragePath.flyers_flyerID_slideIndex(flyerID: flyerID, slideIndex: index),
          meta: StorageMetaModel(
            width: _dimensions?.width,
            height: _dimensions?.height,
            ownersIDs: await FlyerModel.generateFlyerOwners(
                bzID: bzID,
            ),
          ),
        ),
        headline: '',
        description: '',
        midColor: _midColor,
        opacity: 1,
        slideIndex: index,
        picFit: Dimensions.concludeBoxFit(
          picWidth: _dimensions?.width ?? 1,
          picHeight: _dimensions?.height ?? 0,
          viewWidth: FlyerDim.flyerWidthByFactor(
            gridWidth: Scale.screenWidth(getMainContext()),
            flyerSizeFactor: 1,
          ),
          viewHeight: FlyerDim.heightBySizeFactor(
            flyerSizeFactor: 1,
            gridWidth: Scale.screenWidth(getMainContext()),
          ),
        ),
        matrix: Matrix4.identity(),
        animationCurve: null,
        filter: ImageFilterModel.noFilter(),
      );

    }

    return _slide;
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS - SLIDE MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<SlideModel?> draftToSlide(DraftSlide? draft) async {
    SlideModel? slide;

    if (draft != null){

      slide = SlideModel(
        flyerID: draft.flyerID,
        slideIndex: draft.slideIndex,
        headline: draft.headline,
        description: draft.description,
        picFit: draft.picFit,
        midColor: draft.midColor,
        matrix: draft.matrix,
        animationCurve: draft.animationCurve,
        filterID: draft.filter?.id,
        picPath: draft.picModel?.path,
        dimensions: Dimensions(
          width: draft.picModel?.meta?.width,
          height: draft.picModel?.meta?.height,
        ),
        uiImage: await Floaters.getUiImageFromUint8List(draft.picModel?.bytes),
      );

    }

    return slide;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<SlideModel>> draftsToSlides(List<DraftSlide>? drafts) async {
    final List<SlideModel> _slides = <SlideModel>[];

    if (Mapper.checkCanLoopList(drafts) == true){

      for (final DraftSlide draft in drafts!){
        final SlideModel? _slide = await draftToSlide(draft);
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
        picModel: await PicProtocols.fetchPic(slide.picPath),
        picFit: slide.picFit,
        headline: slide.headline,
        description: slide.description,
        midColor: slide.midColor,
        opacity: 1,
        matrix: slide.matrix,
        animationCurve: slide.animationCurve,
        filter: ImageFilterModel.getFilterByID(slide.filterID),
      );
    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DraftSlide>> draftsFromSlides(List<SlideModel>? slides) async {
    final List<DraftSlide> _output = <DraftSlide>[];

    if (Mapper.checkCanLoopList(slides) == true){

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
        'picModel': PicModel.cipherToLDB(draft.picModel),
        'picFit': Dimensions.cipherBoxFit(draft.picFit),
        'headline': draft.headline,
        'description': draft.description,
        'midColor': Colorizer.cipherColor(draft.midColor),
        'opacity': draft.opacity,
        'matrix' : Trinity.cipherMatrix(draft.matrix),
        'animationCurve' : Trinity.cipherAnimationCurve(draft.animationCurve),
        'filterID' : draft.filter?.id,
      };
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> draftsToLDB(List<DraftSlide>? drafts){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(drafts) == true){

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
        picModel: PicModel.decipherFromLDB(map['picModel']),
        picFit: Dimensions.decipherBoxFit(map['picFit']),
        headline: map['headline'],
        description: map['description'],
        midColor: Colorizer.decipherColor(map['midColor']),
        opacity: map['opacity'],
        matrix: Trinity.decipherMatrix(map['matrix']),
        animationCurve: Trinity.decipherAnimationCurve(map['animationCurve']),
        filter: ImageFilterModel.getFilterByID(map['filterID']),
      );
    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DraftSlide> draftsFromLDB(List<dynamic>? maps){
    final List<DraftSlide> drafts = <DraftSlide>[];

    if (Mapper.checkCanLoopList(maps) == true){

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
    PicModel? picModel,
    BoxFit? picFit,
    String? headline,
    String? description,
    Color? midColor,
    double? opacity,
    Matrix4? matrix,
    ImageFilterModel? filter,
    Curve? animationCurve,
  }){
    return DraftSlide(
      flyerID: flyerID ?? this.flyerID,
      slideIndex: slideIndex ?? this.slideIndex,
      picModel: picModel ?? this.picModel,
      picFit: picFit ?? this.picFit,
      headline: headline ?? this.headline,
      description: description ?? this.description,
      midColor: midColor ?? this.midColor,
      opacity: opacity ?? this.opacity,
      matrix: matrix ?? this.matrix,
      filter: filter ?? this.filter,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  DraftSlide nullifyField({
    bool flyerID = false,
    // bool slideIndex = false,
    bool picModel = false,
    bool picFit = false,
    bool headline = false,
    bool description = false,
    bool midColor = false,
    bool opacity = false,
    bool matrix = false,
    bool filter = false,
    bool animationCurve = false,
  }){
    return DraftSlide(
      flyerID: flyerID == true ? null : this.flyerID,
      slideIndex: slideIndex, // == true ? null : this.slideIndex,
      picModel: picModel == true ? null : this.picModel,
      picFit: picFit == true ? null : this.picFit,
      headline: headline == true ? null : this.headline,
      description: description == true ? null : this.description,
      midColor: midColor == true ? null : this.midColor,
      opacity: opacity == true ? null : this.opacity,
      matrix: matrix == true ? null : this.matrix,
      filter: filter == true ? null : this.filter,
      animationCurve: animationCurve == true ? null : this.animationCurve,
    );
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Uint8List> getBytezzFromDraftSlides({
    required List<DraftSlide> drafts,
  }) {

    final List<Uint8List> _output = <Uint8List>[];

    for (final DraftSlide draft in drafts) {
      if (draft.picModel?.bytes != null) {
        _output.add(draft.picModel!.bytes!);
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PicModel> getPicModels(List<DraftSlide>? drafts){
    final List<PicModel> _output = <PicModel>[];

    if (Mapper.checkCanLoopList(drafts) == true){

      for (final DraftSlide draft in drafts!){
        if (draft.picModel != null){
          _output.add(draft.picModel!);
        }
      }

    }

    return _output;
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

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDraft({required String invoker}){

    blog('[$invoker] : ($slideIndex)=> DraftSlide : flyerID : $flyerID : index : $slideIndex');
    blog('headline : $headline : description : $description');
    blog('midColor : $midColor : opacity : $opacity : picFit : $picFit : filter : ${filter?.id} :'
        ' hasCustomMatrix : ${matrix != Matrix4.identity()} : animationCurve L $animationCurve');
    picModel?.blogPic();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSlides({
    required List<DraftSlide>? slides,
    required String invoker,
  }){

    blog('BLOGGING SLIDES [$invoker] -------- START');

    if (Mapper.checkCanLoopList(slides) == true) {
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
    if (PicModel.checkPicsAreIdentical(pic1: slide1?.picModel, pic2: slide2?.picModel) == false){
      blog('MutableSlidesDifferences : picModels are not Identical');
    }
    if (slide1?.picFit != slide2?.picFit){
      blog('MutableSlidesDifferences : picFits are not Identical');
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
    if (slide1?.opacity != slide2?.opacity){
      blog('MutableSlidesDifferences : opacities are not Identical');
    }
    if (Trinity.checkMatrixesAreIdentical(matrix1: slide1?.matrix, matrixReloaded: slide2?.matrix) == false){
      blog('MutableSlidesDifferences : matrixes are not Identical');
    }
    if (ImageFilterModel.checkFiltersAreIdentical(filter1: slide1?.filter, filter2: slide2?.filter) == false){
      blog('MutableSlidesDifferences : filters are not Identical');
    }
    if (slide1?.animationCurve != slide2?.animationCurve){
      blog('MutableSlidesDifferences : animationCurves are not Identical');
    }
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DraftSlide> replaceSlide({
    required List<DraftSlide>? drafts,
    required DraftSlide? draft,
  }){
    List<DraftSlide> _output = <DraftSlide>[];

    if (Mapper.checkCanLoopList(drafts) == true){

      _output = [...drafts!];
      _output.removeAt(draft!.slideIndex);
      _output.insert(draft.slideIndex, draft);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DraftSlide> removeDraftFromDrafts({
    required List<DraftSlide> drafts,
    required DraftSlide draft,
  }){
    List<DraftSlide> _output = <DraftSlide>[];

    if (Mapper.checkCanLoopList(drafts) == true){

      final List<DraftSlide> _list = [...drafts];
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

    if (Mapper.checkCanLoopList(drafts) == true && flyerID != null){

      for (final DraftSlide draft in drafts!){

        final DraftSlide _updated = draft.copyWith(
          flyerID: flyerID,
          picModel: draft.picModel?.copyWith(
            path: StoragePath.flyers_flyerID_slideIndex(
                flyerID: flyerID,
                slideIndex: draft.slideIndex,
            ),
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

    if (Mapper.checkCanLoopList(drafts) == true){

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

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSlidesAreIdentical({
    required DraftSlide? slide1,
    required DraftSlide? slide2,
  }){
    bool _identical = false;

    if (slide1 == null && slide2 == null){
      _identical = true;
    }

    else if (slide1 != null && slide2 != null){

      blog('${slide1.headline} == ${slide2.headline}');

      if (
          slide1.flyerID == slide2.flyerID &&
          slide1.slideIndex == slide2.slideIndex &&
          PicModel.checkPicsAreIdentical(pic1: slide1.picModel, pic2: slide2.picModel) == true &&
          slide1.picFit == slide2.picFit &&
          slide1.headline == slide2.headline &&
          slide1.description == slide2.description &&
          Colorizer.checkColorsAreIdentical(slide1.midColor, slide2.midColor) == true &&
          slide1.opacity == slide2.opacity &&
          Trinity.checkMatrixesAreIdentical(matrix1: slide1.matrix, matrixReloaded: slide2.matrix) == true &&
          slide1.animationCurve == slide2.animationCurve &&
          ImageFilterModel.checkFiltersAreIdentical(filter1: slide1.filter, filter2: slide2.filter) == true
      ){
        _identical = true;
      }

      if (_identical == false){
        blogDraftSlidesDifferences(
          slide1: slide1,
          slide2: slide2,
        );
      }

    }

    blog('checkSlidesAreIdentical => $_identical');

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
      blog('checkSlidesListsAreIdentical : both are null');
    }
    else if (slides1 != null && slides1.isEmpty == true && slides2 != null && slides2.isEmpty == true){
      _listsAreIdentical = true;
      blog('checkSlidesListsAreIdentical : both are empty');
    }
    else if (Mapper.checkCanLoopList(slides1) == true && Mapper.checkCanLoopList(slides2) == true){

      if (slides1!.length != slides2!.length){
        _listsAreIdentical = false;
        blog('checkSlidesListsAreIdentical : lists are not the same length');
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

            blog('checkSlidesListsAreIdentical : slides at index [$i] ARE INDEED IDENTICAL');

            /// ON LAST SLIDE
            if ( i + 1 == slides1.length){
              blog('checkSlidesListsAreIdentical : All slides are identical');
              _listsAreIdentical = true;
            }

          }

          /// ARE ARE NOT IDENTICAL
          else {
            _listsAreIdentical = false;
            blog('checkSlidesListsAreIdentical : slides at index [$i] are not identical');
            break;
          }


        }

      }

    }

    blog('_listsAreIdentical : $_listsAreIdentical');
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
      picModel.hashCode^
      picFit.hashCode^
      headline.hashCode^
      description.hashCode^
      midColor.hashCode^
      opacity.hashCode^
      matrix.hashCode^
      animationCurve.hashCode^
      filter.hashCode;
  // -----------------------------------------------------------------------------
}
