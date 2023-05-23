import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:mapper/mapper.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

class FetchFlyerProtocols {
  // -----------------------------------------------------------------------------

  const FetchFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> fetchFlyer({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    FlyerModel _flyer = await FlyerLDBOps.readFlyer(flyerID);

    if (_flyer != null){
      // blog('fetchFlyerByID : ($flyerID) FlyerModel FOUND in LDB');
    }

    else {

      _flyer = await FlyerFireOps.readFlyer(
        flyerID: flyerID,
      );

      if (_flyer != null){
        // blog('fetchFlyerByID : ($flyerID) FlyerModel FOUND in FIRESTORE and inserted in LDB');
        await FlyerLDBOps.insertFlyer(_flyer);
      }

    }

    // if (_flyer == null){
    // blog('fetchFlyerByID : ($flyerID) FlyerModel NOT FOUND');
    // }

    if (_flyer != null){

      final BzModel _bzModel = await BzProtocols.fetchBz(
        bzID: _flyer.bzID,
      );

      _flyer = _flyer.copyWith(
        zone: await ZoneProtocols.completeZoneModel(
            incompleteZoneModel: _flyer.zone,
        ),
        bzModel: _bzModel,
      );
    }

    return _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> fetchFlyers({
    @required BuildContext context,
    @required List<String> flyersIDs,
  }) async {
    // blog('FetchFlyerProtocol.fetchFlyersByIDs : START');

    final List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(flyersIDs)){

      await Future.wait(<Future>[

        ...List.generate(flyersIDs.length, (index){

          return fetchFlyer(
            context: context,
            flyerID: flyersIDs[index],
          ).then((FlyerModel flyer){

            _flyers.add(flyer);

          });

      }),

      ]);

    }

    // blog('FetchFlyerProtocol.fetchFlyersByIDs : END');
    return _flyers;
  }
  // -----------------------------------------------------------------------------

  /// RE-FETCH

  // --------------------
  /// TASK : TEST ME
  static Future<FlyerModel> refetch({
    @required BuildContext context,
    @required  String flyerID,
  }) async {

    FlyerModel _output;

    if (flyerID != null){

      final FlyerModel _flyerModel = await fetchFlyer(
        context: context,
        flyerID: flyerID,
      );

      await Future.wait(<Future>[

        FlyerLDBOps.deleteFlyers(<String>[flyerID]),

        PicProtocols.refetchPics(FlyerModel.getPicsPaths(_flyerModel)),

      ]);

      _output = await fetchFlyer(
          context: context,
          flyerID: flyerID
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BZ FLYERS COMBINATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> fetchAndCombineBzSlidesInOneFlyer({
    @required BuildContext context,
    @required String bzID,
    @required int maxSlides,
  }) async {
    FlyerModel _flyer;

    if (bzID != null && maxSlides != null && maxSlides != 0){

      final BzModel bzModel = await BzProtocols.fetchBz(
          bzID: bzID,
      );

      if (bzModel != null){

        final List<SlideModel> _bzSlides = <SlideModel>[];

        for (int i = 0; i < bzModel.flyersIDs.length; i++){

          final String _flyerID = bzModel.flyersIDs[i];

          final FlyerModel _flyer = await fetchFlyer(
            context: context,
            flyerID: _flyerID,
          );

          for (final SlideModel _slide in _flyer.slides){

            _bzSlides.add(_slide);

            blog('added slide with index ${_slide.slideIndex}');

            if (_bzSlides.length >= maxSlides){
              blog('breaking _bzSlides.length ${_bzSlides.length} : maxSlides $maxSlides : ${_bzSlides.length >= maxSlides}');
              break;
            }

          }

          if (_bzSlides.length >= maxSlides){
            break;
          }

        }

        if (_bzSlides.isNotEmpty == true){

          _flyer = FlyerModel(
            id: 'combinedSlidesInOneFlyer_${bzModel.id}',
            headline: _bzSlides[0].headline,
            trigram: const [],
            description: null,
            flyerType: null,
            publishState: PublishState.published,
            auditState: AuditState.verified,
            phids: const [],
            zone: bzModel.zone,
            authorID: null,
            bzID: bzModel.id,
            position: null,
            slides: _bzSlides,
            specs: const [],
            times: const [],
            hasPriceTag: false,
            hasPDF: false,
            isAmazonFlyer: false,
            showsAuthor: false,
            score: null,
            pdfPath: null,
          );

          _flyer = await FlyerProtocols.renderBigFlyer(
            context: context,
            flyerModel: _flyer,
          );

        }

      }


    }

    return _flyer;
  }
  // -----------------------------------------------------------------------------
}
