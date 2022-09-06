import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/feedback_model.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/foundation/storage.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/fire/ops/bz_fire_ops.dart';
import 'package:bldrs/e_db/real/ops/app_feedback_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FlyerFireOps {
// -----------------------------------------------------------------------------

  const FlyerFireOps();

// -----------------------------------------------------------------------------

  /// CREATE

// -----------------------------------
  ///
  static Future<Map<String, dynamic>> createFlyerOps({
    @required BuildContext context,
    @required FlyerModel draftFlyer,
    @required BzModel bzModel,
  }) async {
    /// NOTE
    /// RETURNS
    /// {
    /// 'flyer' : _uploadedFlyerModel,
    /// 'bz' : _uploadedBzModel,
    /// }
    blog('FlyerFireOps.createFlyerOps : START');

    FlyerModel _finalFlyer;
    BzModel _finalBz;

    if (draftFlyer != null){

      final String _flyerID = await _createFlyerDoc(
        context: context,
        draftFlyer: draftFlyer,
      );

      if (_flyerID != null){

        final String _bzCreatorID = AuthorModel.getCreatorAuthorFromBz(bzModel).userID;
        final String _flyerAuthorID = AuthFireOps.superUserID();

        _finalFlyer = await _uploadImagesAndPDFsAndUpdateFlyer(
          context: context,
          flyerID: _flyerID,
          draftFlyer: draftFlyer,
          creatorAuthorID: _bzCreatorID,
          flyerAuthorID: _flyerAuthorID,
        );

        _finalBz = await _addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs(
          context: context,
          bzModel: bzModel,
          newFlyerToAdd: _finalFlyer,
        );

      }

    }

    blog('FlyerFireOps.createFlyerOps : END');
    return {
      'flyer' : _finalFlyer,
      'bz' : _finalBz,
    };
  }
// -----------------------------------
  /// TESTED : : returns Flyer ID
  static Future<String> _createFlyerDoc({
    @required BuildContext context,
    @required FlyerModel draftFlyer,
  }) async {

    blog('_createFlyerDoc : START');

    DocumentReference<Object> _docRef;

    if (draftFlyer != null){

      _docRef = await Fire.createDoc(
        context: context,
        collName: FireColl.flyers,
        input: draftFlyer.toMap(
          toJSON: false,
        ),
      );

    }

    blog('_createFlyerDoc : END');

    return _docRef?.id;
  }
// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> _uploadImagesAndPDFsAndUpdateFlyer({
    @required BuildContext context,
    @required FlyerModel draftFlyer,
    @required String flyerID,
    @required String creatorAuthorID,
    @required String flyerAuthorID,
  }) async {

    blog('_uploadImagesAndPDFsAndUpdateFlyer : START');

    FlyerModel _finalFlyer;

    if (draftFlyer != null){

      List<String> _picturesURLs;
      FileModel _pdf;

      await Future.wait(<Future>[

        Storage.createStorageSlidePicsAndGetURLs(
            context: context,
            slides: draftFlyer.slides,
            flyerID: flyerID,
            bzCreatorID: creatorAuthorID,
            flyerAuthorID: flyerAuthorID,
            onFinished: (List<String> _urls){
              _picturesURLs = _urls;
            }),

        Storage.uploadFlyerPDFAndGetFlyerPDF(
            context: context,
            flyerID: flyerID,
            pdf: draftFlyer.pdf,
            ownersIDs: <String>[creatorAuthorID, flyerAuthorID],
            onFinished: (FileModel flyerPDF){
              _pdf = flyerPDF ;
            }),

      ]);


      if (Mapper.checkCanLoopList(_picturesURLs) == true){

        final List<SlideModel> _updatedSlides = SlideModel.replaceSlidesPicturesWithNewURLs(
          newPicturesURLs: _picturesURLs,
          inputSlides: draftFlyer.slides,
        );

        final List<PublishTime> _updatedPublishTime = <PublishTime>[
          ...draftFlyer.times,
          PublishTime(
            state: PublishState.published,
            time: DateTime.now(),
          ),
        ];

        _finalFlyer = draftFlyer.copyWith(
          id: flyerID,
          slides: _updatedSlides,
          trigram: Stringer.createTrigram(input: draftFlyer.headline),
          times: _updatedPublishTime,
          pdf: _pdf,
        );

        await _updateFlyerDoc(
          context: context,
          finalFlyer: _finalFlyer,
        );


      }

    }

    blog('_uploadImagesAndPDFsAndUpdateFlyer : END');

    return _finalFlyer;
  }
// -----------------------------------
  static Future<BzModel> _addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs({
    @required BuildContext context,
    @required BzModel bzModel,
    @required FlyerModel newFlyerToAdd,
  }) async {

    blog('_addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : START');

    final List<String> _updatedBzFlyersIDs = Stringer.addStringToListIfDoesNotContainIt(
      strings: bzModel.flyersIDs,
      stringToAdd: newFlyerToAdd.id,
    );

    final List<AuthorModel> _updatedAuthors = AuthorModel.addFlyerIDToAuthor(
      flyerID: newFlyerToAdd.id,
      authorID: newFlyerToAdd.authorID,
      authors: bzModel.authors,
    );


    final BzModel _updatedBzModel = bzModel.copyWith(
      flyersIDs: _updatedBzFlyersIDs,
      authors: _updatedAuthors,
    );

    final BzModel _uploadedBzModel = await BzFireOps.updateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: bzModel,
        authorPicFile: null
    );

    blog('_addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : END');

    return _uploadedBzModel;
  }
// -----------------------------------------------------------------------------

  /// READ

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> readFlyerOps({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    final dynamic _flyerMap = await Fire.readDoc(
        context: context,
        collName: FireColl.flyers,
        docName: flyerID
    );

    final FlyerModel _flyer = FlyerModel.decipherFlyer(
        map: _flyerMap,
        fromJSON: false
    );

    return _flyer;
  }
// -----------------------------------
  static Future<List<FlyerModel>> readBzFlyers({
    @required BuildContext context,
    @required BzModel bzModel
  }) async {
    final List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(bzModel?.flyersIDs)) {
      for (final String id in bzModel.flyersIDs) {
        final FlyerModel _flyer = await readFlyerOps(
          context: context,
          flyerID: id,
        );

        if (_flyer != null) {
          _flyers.add(_flyer);
        }
      }
    }

    return _flyers;
  }
// -----------------------------------
  static Future<List<FlyerModel>> readBzzFlyers({
    @required BuildContext context,
    @required List<BzModel> bzzModels,
  }) async {
    final List<FlyerModel> _allFlyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(bzzModels)) {
      for (final BzModel bz in bzzModels) {
        final List<FlyerModel> _bzFlyers = await FlyerFireOps.readBzFlyers(
          context: context,
          bzModel: bz,
        );

        if (Mapper.checkCanLoopList(_bzFlyers)) {
          _allFlyers.addAll(_bzFlyers);
        }
      }
    }

    return _allFlyers;
  }
// -----------------------------------
  static Future<List<ReviewModel>> readAllReviews({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    // final List<dynamic> _maps = await Fire.readSubCollectionDocs(
    //   context: context,
    //   collName: FireColl.flyers,
    //   docName: flyerID,
    //   subCollName: FireSubColl.flyers_flyer_reviews,
    //   addDocsIDs: true,
    //   orderBy: 'reviewID',
    //   limit: 10,
    //
    //   /// task : paginate in flyer reviews
    // );
    //
    // final List<ReviewModel> _reviews = ReviewModel.decipherReviews(maps: _maps, fromJSON: false);
    // return _reviews;

    return null;
  }
// -----------------------------------
  static Future<List<FlyerModel>> paginateFlyers({
    @required BuildContext context,
    @required String countryID,
    @required String cityID,
    String districtID,
    int limit,
    FlyerType flyerType,
    PublishState publishState,
    AuditState auditState,
    String authorID,
    String bzID,
    bool priceTagIsOn,
    DocumentSnapshot<Object> startAfter,
    List<String> specs,
  }) async {

    final String _chainID = FlyerTyper.concludeChainIDByFlyerType(flyerType: flyerType);

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      context: context,
      collName: FireColl.flyers,
      orderBy: const QueryOrderBy(fieldName: 'score', descending: true),
      startAfter: startAfter,
      limit: limit,
      addDocSnapshotToEachMap: true,
      finders: <FireFinder>[

        // FireFinder(
        //   field: 'score',
        //   comparison: FireComparison.greaterOrEqualThan,
        //   value: 0,
        // ),

        if (flyerType != null)
          FireFinder(
            field: 'flyerType',
            comparison: FireComparison.equalTo,
            value: FlyerTyper.cipherFlyerType(flyerType),
          ),

        if (publishState != null)
          FireFinder(
            field: 'publishState',
            comparison: FireComparison.equalTo,
            value: FlyerModel.cipherPublishState(publishState),
          ),

        if (auditState != null)
          FireFinder(
            field: 'auditState',
            comparison: FireComparison.equalTo,
            value: FlyerModel.cipherAuditState(auditState),
          ),

        if (countryID != null)
          FireFinder(
            field: 'zone.countryID',
            comparison: FireComparison.equalTo,
            value: countryID,
          ),

        if (cityID != null)
          FireFinder(
            field: 'zone.cityID',
            comparison: FireComparison.equalTo,
            value: cityID,
          ),

        if (districtID != null)
          FireFinder(
            field: 'zone.districtID',
            comparison: FireComparison.equalTo,
            value: districtID,
          ),

        if (authorID != null)
          FireFinder(
            field: 'authorID',
            comparison: FireComparison.equalTo,
            value: authorID,
          ),

        if (bzID != null)
          FireFinder(
            field: 'bzID',
            comparison: FireComparison.equalTo,
            value: bzID,
          ),

        if (priceTagIsOn != null)

          const FireFinder(
            field: 'priceTagIsOn',
            comparison: FireComparison.equalTo,
            value: true,
          ),

        if (Mapper.checkCanLoopList(specs) == true && Mapper.checkListHasNullValue(specs) == false)
          FireFinder(
            field: 'specs.$_chainID',
            comparison: FireComparison.arrayContainsAny,
            value: specs,
          ),
      ],
    );

    final List<FlyerModel> _flyers = FlyerModel.decipherFlyers(
      maps: _maps,
      fromJSON: false,
    );

    return _flyers;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> updateFlyerOps({
    @required BuildContext context,
    @required FlyerModel newFlyer,
    @required FlyerModel oldFlyer,
    @required BzModel bzModel,
  }) async {

    blog('updateFlyerOps : START');

    FlyerModel _finalFlyer = await _updateSlides(
      context: context,
      oldFlyer: oldFlyer,
      newFlyer: newFlyer,
      bzModel: bzModel,
    );

    _finalFlyer = await _updateFlyerPDF(
      context: context,
      oldFlyer: oldFlyer,
      newFlyer: _finalFlyer,
    );

    await _deleteUnusedSlides(
      context: context,
      oldFlyer: oldFlyer,
      newFlyer: _finalFlyer,
    );

    await _updateFlyerDoc(
      context: context,
      finalFlyer: _finalFlyer,
    );

    blog('updateFlyerOps : END');

    return _finalFlyer;
  }
// -----------------------------------
  static Future<FlyerModel> _updateSlides({
    @required BuildContext context,
    @required FlyerModel oldFlyer,
    @required FlyerModel newFlyer,
    @required BzModel bzModel,
  }) async {

    blog('_updateSlides : START');

    FlyerModel _finalFlyer = newFlyer;

    final bool _slidesAreTheSame = SlideModel.allSlidesPicsAreIdentical(
      oldFlyer: oldFlyer,
      newFlyer: newFlyer,
    );

    if (_slidesAreTheSame == false) {

      /// loop each slide in updated slides to check which changed
      final List<SlideModel> _finalSlides = <SlideModel>[];

      await Future.wait(<Future>[

        ...List.generate(newFlyer.slides.length, (index) async {

          final SlideModel slide = newFlyer.slides[index];

          /// if slide pic changed
          if (ObjectCheck.objectIsFile(slide.pic) == true) {

            /// upload File to fireStorage/slidesPics/slideID and get URL
            final String _newPicURL = await Storage.createStoragePicAndGetURL(
              context: context,
              docName: StorageDoc.slides,
              inputFile: slide.pic,
              ownersIDs: <String>[
                AuthorModel.getCreatorAuthorFromBz(bzModel).userID,
                oldFlyer.authorID,
              ],
              fileName: SlideModel.generateSlideID(
                flyerID: newFlyer.id,
                slideIndex: slide.slideIndex,
              ),
            );

            final ImageSize _imageSize = await ImageSize.superImageSize(slide.pic);

            final SlideModel _updatedSlide = slide.copyWith(
              pic: _newPicURL,
              imageSize: _imageSize,
            );

            _finalSlides.add(_updatedSlide);

          }

          /// if slide pic did not change
          else {
            _finalSlides.add(slide);
          }


      }),

      ]);


      _finalFlyer = newFlyer.copyWith(
        slides: _finalSlides,
      );

    }

    blog('_updateSlides : END');

    return _finalFlyer;
  }
// -----------------------------------
  static Future<void> _deleteUnusedSlides({
    @required BuildContext context,
    @required FlyerModel oldFlyer,
    @required FlyerModel newFlyer,
  }) async {

    blog('_deleteUnusedSlides : START');

    /// Delete fire storage pictures if updatedFlyer.slides.length > originalFlyer.slides.length
    if (oldFlyer.slides.length > newFlyer.slides.length) {

      final List<String> _slidesIDsToBeDeleted = <String>[];

      /// get slides IDs which should be deleted starting first index after updatedFlyer.slides.length
      for (int i = newFlyer.slides.length; i < oldFlyer.slides.length; i++) {
        _slidesIDsToBeDeleted.add(
            SlideModel.generateSlideID(
                flyerID: newFlyer.id,
                slideIndex: i
            )
        );
      }

      /// delete pictures from fireStorage/slidesPics/slideID : slide ID is "flyerID_index"
      for (final String slideID in _slidesIDsToBeDeleted) {
        await Storage.deleteStoragePic(
          context: context,
          storageDocName: StorageDoc.slides,
          fileName: slideID,
        );
      }

    }

    blog('_deleteUnusedSlides : END');

  }
// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> _updateFlyerPDF({
    @required BuildContext context,
    @required FlyerModel oldFlyer,
    @required FlyerModel newFlyer,
  }) async {

    blog('_updateFlyerPDF : START');

    FlyerModel _output = newFlyer.copyWith();

    final bool _pdfsAreIdentical = FileModel.checkFileModelsAreIdentical(
        model1: oldFlyer.pdf,
        model2: newFlyer.pdf,
    );

    blog('_updateFlyerPDF : _pdfsAreIdentical : $_pdfsAreIdentical');

    if (_pdfsAreIdentical == false){
      // -----------------------------
      final bool _shouldDeleteOldFile = FileModel.checkShouldDeleteOldFlyerPDFFileModel(
        newFlyer: newFlyer,
        oldFlyer: oldFlyer,
      );
      blog('_updateFlyerPDF : _shouldDeleteOldFile : $_shouldDeleteOldFile');
      // -----------------------------
      final bool _shouldUploadNewFile = FileModel.checkShouldUploadNewPDFFileModel(
          oldFlyer: oldFlyer,
          newFlyer: newFlyer
      );
      blog('_updateFlyerPDF : _shouldUploadNewFile : $_shouldUploadNewFile');
      // -----------------------------

      /// UPLOAD NEW FILE IF : (it not null) && (name has changed or file has changed)
      if (_shouldUploadNewFile == true){

        final List<String> _flyerOwners = await FlyerModel.generateFlyerOwners(
          context: context,
          bzID: oldFlyer.bzID,
        );

        blog('_updateFlyerPDF : _ownersIDs : $_flyerOwners');

        final FileModel _newPDF = await Storage.uploadFlyerPDFAndGetFlyerPDF(
          context: context,
          pdf: newFlyer.pdf,
          flyerID: oldFlyer.id,
          ownersIDs: _flyerOwners,
        );

        blog('_updateFlyerPDF : _newPDF : $_newPDF');
        FileModel.blogFlyerPDF(_newPDF);


        _output = newFlyer.copyWith(
          pdf: _newPDF,
        );

        blog('_updateFlyerPDF : _output : $_output');

      }

      /// DELETE OLD PDF FILE IF : (PDF WAS REMOVED) OR (PDF FILE NAME CHANGED)
      if (_shouldDeleteOldFile == true){

        /// DELETE OLD PDF FILE
        await Storage.deleteStoragePic(
          context: context,
          storageDocName: StorageDoc.flyersPDFs,
          fileName: FileModel.generateFlyerPDFStorageName(
              pdfFileName: oldFlyer.pdf.fileName,
              flyerID: oldFlyer.id,
          ),
        );

        blog('_updateFlyerPDF : old file should be deleted');

      }

    }
    blog('_updateFlyerPDF : END');
    return _output;
  }
// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _updateFlyerDoc({
    @required BuildContext context,
    @required FlyerModel finalFlyer,
  }) async {

    blog('_updateFlyerDoc : START');

    await Fire.updateDoc(
      context: context,
      collName: FireColl.flyers,
      docName: finalFlyer.id,
      input: finalFlyer.toMap(toJSON: false),
    );

    blog('_updateFlyerDoc : END');

  }
// -----------------------------------
/*
//   Future<void> switchFlyerShowsAuthor({
//     @required BuildContext context,
//     @required String flyerID,
//     @required bool val
//   }) async {
//     await Fire.updateDocField(
//       context: context,
//       collName: FireColl.flyers,
//       docName: flyerID,
//       field: 'flyerShowsAuthor',
//       input: val,
//     );
//   }
 */
// -----------------------------------------------------------------------------

  /// DELETE

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> deleteFlyerOps({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
    /// to avoid frequent updates to bz fire doc in delete bz ops
    @required bool bzFireUpdateOps,
  }) async {

    /// NOTE : returns updated Bz Model
    BzModel _uploadedBz = bzModel;

    blog('deleteFlyerOps : START : ${flyerModel?.id}');

    if (flyerModel != null && flyerModel.id != null && bzModel != null) {

      /// DELETE FLYER ID FROM BZ FLYERS IDS
      if (bzFireUpdateOps == true) {

        _uploadedBz = await _deleteFlyerIDFromBzFlyersIDsAndAuthorIDs(
          context: context,
          flyer: flyerModel,
          bzModel: bzModel,
        );

      }

      /// DELETE FLYER STORAGE IMAGES
      await _deleteFlyerStorageImagesAndPDF(
        context: context,
        flyerModel: flyerModel,
      );

      /// I - delete firestore/flyers/flyerID
      await _deleteFlyerDoc(
        context: context,
        flyerID: flyerModel.id,
      );

    }

    else {
      blog('deleteFlyerOps : COULD NOT DELETE FLYER');
    }

    blog('deleteFlyerOps : END : ${flyerModel?.id}');

    return _uploadedBz;
  }
// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> _deleteFlyerIDFromBzFlyersIDsAndAuthorIDs({
    @required BuildContext context,
    @required FlyerModel flyer,
    @required BzModel bzModel,
  }) async {

    blog('_deleteFlyerIDFromBzFlyersIDs : START');

    BzModel _uploadedBzModel = bzModel;

    if (bzModel != null && flyer != null){

      final BzModel _updatedBzModel = BzModel.removeFlyerIDFromBzAndAuthor(
          bzModel: bzModel,
          flyer: flyer,
      );

      _uploadedBzModel = await BzFireOps.updateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: bzModel,
        authorPicFile: null,
      );

    }

    blog('_deleteFlyerIDFromBzFlyersIDs : END');

    return _uploadedBzModel;
  }
// -----------------------------------
  static Future<void> _deleteFlyerStorageImagesAndPDF({
    @required BuildContext context,
    @required FlyerModel flyerModel,
  }) async {

    blog('_deleteFlyerStorageImages : START');

    if (flyerModel != null){

      final List<String> _slidesIDs = SlideModel.generateSlidesIDs(
        flyerID: flyerModel.id,
        numberOfSlides: flyerModel.slides.length,
      );

      /// NOTE : IF THERE ARE NO SLIDE => NO PDF WILL BE ATTACHED
      if (Mapper.checkCanLoopList(_slidesIDs) == true){

        await Future.wait(<Future>[

          /// DELETE IMAGES
          ...List.generate(_slidesIDs.length, (index) async {

            return Storage.deleteStoragePic(
              context: context,
              fileName: _slidesIDs[index],
              storageDocName: StorageDoc.slides,
            );

          }),

          /// DELETE PDF
          if (flyerModel.pdf != null)
            Storage.deleteStoragePic(
              context: context,
              storageDocName: StorageDoc.flyersPDFs,
              fileName: FileModel.generateFlyerPDFStorageName(
                  pdfFileName: flyerModel.pdf.fileName,
                  flyerID: flyerModel.id,
              ),
            ),

        ]);

      }

    }

    blog('_deleteFlyerStorageImages : END');

  }
// -----------------------------------
  static Future<void> _deleteFlyerDoc({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    blog('_deleteFlyerDoc : START');

    if (flyerID != null){
      await Fire.deleteDoc(
        context: context,
        collName: FireColl.flyers,
        docName: flyerID,
      );
    }

    blog('_deleteFlyerDoc : END');

  }
// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> deleteMultipleBzFlyers({
    @required BuildContext context,
    @required List<FlyerModel> flyersToDelete,
    @required BzModel bzModel,
    @required bool updateBzFireOps,
  }) async {

    blog('deleteMultipleBzFlyers : start');

    /// NOTE : just in case, this filters flyers IDs and only delete those already in the bzModel.flyersIDs
    BzModel _bzModel = bzModel.copyWith();

    if (Mapper.checkCanLoopList(flyersToDelete) == true && bzModel != null){

      List<AuthorModel> _bzAuthors = <AuthorModel>[..._bzModel.authors];
      List<String> _bzFlyersIDs = <String>[..._bzModel.flyersIDs];

      await Future.wait(<Future>[

        ...List.generate(flyersToDelete.length, (index) async {

          final FlyerModel flyerModel = flyersToDelete[index];

          blog('deleteMultipleBzFlyers : deleting flyer : ${flyerModel.id}');

          final bool _canDelete = Stringer.checkStringsContainString(
            strings: bzModel.flyersIDs,
            string: flyerModel.id,
          );

          blog('deleteMultipleBzFlyers : deleting flyer : ${flyerModel.id} : can delete : $_canDelete');

          if (_canDelete == true){

            /// DELETE FLYER STORAGE IMAGES
            await _deleteFlyerStorageImagesAndPDF(
                context: context,
                flyerModel: flyerModel,
            );

            /// I - delete firestore/flyers/flyerID
            await _deleteFlyerDoc(
                context: context,
                flyerID: flyerModel.id,
            );

            _bzFlyersIDs = Stringer.removeStringsFromStrings(
              removeFrom: _bzFlyersIDs,
              removeThis: <String>[flyerModel.id],
            );

            _bzAuthors = AuthorModel.removeFlyerIDFromAuthors(
              authors: _bzAuthors,
              flyerID: flyerModel.id,
            );

          }


        }),

      ]);

      _bzModel = bzModel.copyWith(
        authors: _bzAuthors,
        flyersIDs: _bzFlyersIDs,
      );

      if (updateBzFireOps == true){
        _bzModel = await BzFireOps.updateBz(
          context: context,
          newBzModel: _bzModel,
          oldBzModel: bzModel,
          authorPicFile: null,
        );
      }

    }

    blog('deleteMultipleBzFlyers : end : updateBzFireOps : $updateBzFireOps');

    return _bzModel;
  }
// -----------------------------------------------------------------------------

  /// FLYER PROMOTIONS

// -----------------------------------
  static Future<void> promoteFlyerInCity({
    @required BuildContext context,
    @required FlyerPromotion flyerPromotion,
  }) async {

    final Error _error = ArgumentError('promoteFlyerInCity : COULD NOT PROMOTE FLYER [${flyerPromotion?.flyerID ?? '-'} IN CITY [${flyerPromotion?.cityID ?? '-'}]');

    if (flyerPromotion != null){

      await tryAndCatch(
          context: context,
          functions: () async {

            await Fire.createNamedDoc(
              context: context,
              collName: FireColl.flyersPromotions,
              docName: flyerPromotion.flyerID,
              input: flyerPromotion.toMap(
                toJSON: true,
              ),
            );

          },
          onError: (String error){
            throw _error;
          }
      );

    }

    else {
      throw _error;
    }

  }
// -----------------------------------
/*
// Future<void> demoteFlyerInCity({
//   @required BuildContext context,
//   @required CityModel cityModel,
//   @required String flyerID,
// }) async {
//
//   if (cityModel != null && flyerID != null){
//
//     cityModel.promotedFlyersIDs.remove(flyerID);
//
//     await Fire.updateSubDocField(
//       context: context,
//       collName: FireColl.zones,
//       docName: FireDoc.zones_cities,
//       subCollName: FireSubColl.zones_cities_cities,
//       subDocName: cityModel.cityID,
//       field: 'promotedFlyersIDs',
//       input: cityModel.promotedFlyersIDs,
//     );
//
//   }
//
// }
 */
// -----------------------------------------------------------------------------

  static Future<void> onReportFlyer({
    @required BuildContext context,
    @required FlyerModel flyer,
  }) async {

    String _feedback;

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 3,
      title: 'Report Flyer',
      builder: (_, PhraseProvider phrasePro){

        return <Widget>[

          /// INAPPROPRIATE CONTENT
          BottomDialog.wideButton(
            context: context,
            verse: '##Inappropriate content',
            onTap: (){
              _feedback = 'Inappropriate content';
              Nav.goBack(
                context: context,
                invoker: 'onReportFlyer.Inappropriate'
              );
            }
          ),

          /// CONTENT IS NOT RELEVANT TO BLDRS
          BottomDialog.wideButton(
              context: context,
              verse: '##Flyer content is not relevant to Bldrs.net',
              onTap: (){
                _feedback = 'Flyer content is not relevant to Bldrs.net';
                Nav.goBack(
                    context: context,
                    invoker: 'onReportFlyer.not relevant'
                );
              }
          ),

          /// COPY RIGHTS
          BottomDialog.wideButton(
              context: context,
              verse: '##content violates copyrights',
              onTap: (){
                _feedback = 'content violates copyrights';
                Nav.goBack(
                    context: context,
                    invoker: 'onReportFlyer.copyrights'
                );
              }
          ),

        ];

      }
    );

    if (_feedback != null){
      final FeedbackModel _model =  FeedbackModel(
        userID: AuthFireOps.superUserID(),
        timeStamp: DateTime.now(),
        feedback: _feedback,
        modelType: ModelType.flyer,
        modelID: flyer.id,
      );

      final FeedbackModel _docRef = await FeedbackRealOps.createFeedback(
        context: context,
        feedback: _model,
      );

      if (_docRef == null){
        await Dialogs.tryAgainDialog(context);
      }
      else {
        await CenterDialog.showCenterDialog(
          context: context,
          titleVerse:  '##Thanks a Million',
          bodyVerse:  '##We will look into this matter and take the necessary '
              'action as soon as possible\n Thank you for helping out',
          confirmButtonVerse:  '##Most Welcome',
        );
      }

    }


  }

}
