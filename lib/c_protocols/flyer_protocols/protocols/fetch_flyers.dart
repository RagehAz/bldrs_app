import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/media_protocols/protocols/media_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';

/// => TAMAM
class FetchFlyerProtocols {
  // -----------------------------------------------------------------------------

  const FetchFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel?> fetchFlyer({
    required String? flyerID,
  }) async {

    // blog('A. fetchFlyerByID : ($flyerID) START');
    FlyerModel? _flyer = await FlyerLDBOps.readFlyer(flyerID);

    // blog('B. fetchFlyerByID : ($flyerID) FlyerModel FOUND in LDB : ${_flyer != null}');
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

      final BzModel? _bzModel = await BzProtocols.fetchBz(
        bzID: _flyer.bzID,
      );

      _flyer = _flyer.copyWith(
        zone: await ZoneProtocols.completeZoneModel(
          invoker: 'fetchFlyer',
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
    required List<String>? flyersIDs,
  }) async {
    // blog('FetchFlyerProtocol.fetchFlyersByIDs : START');

    final List<FlyerModel> _flyers = <FlyerModel>[];

    if (Lister.checkCanLoop(flyersIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(flyersIDs!.length, (index){

          return fetchFlyer(
            flyerID: flyersIDs[index],
          ).then((FlyerModel? flyer){

            if (flyer != null){
              _flyers.add(flyer);
            }

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
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel?> refetch({
    required String? flyerID,
  }) async {

    FlyerModel? _output;

    if (flyerID != null){

      final FlyerModel? _flyerModel = await fetchFlyer(
        flyerID: flyerID,
      );

      await Future.wait(<Future>[

        FlyerLDBOps.deleteFlyers(<String>[flyerID]),

        MediaProtocols.refetchMedias(FlyerModel.getPicsPaths(
          flyer: _flyerModel,
          type: SlidePicType.med,
        )),

        MediaProtocols.refetchMedias(FlyerModel.getPicsPaths(
          flyer: _flyerModel,
          type: SlidePicType.small,
        )),

        MediaProtocols.refetchMedias(FlyerModel.getPicsPaths(
          flyer: _flyerModel,
          type: SlidePicType.back,
        )),

      ]);

      _output = await fetchFlyer(flyerID: flyerID);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BZ FLYERS COMBINATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel?> fetchAndCombineBzSlidesInOneFlyer({
    required String? bzID,
    required int? maxSlides,
  }) async {
    FlyerModel? _flyer;

    if (bzID != null && maxSlides != null && maxSlides != 0){

      final BzModel? bzModel = await BzProtocols.fetchBz(
          bzID: bzID,
      );

      if (bzModel != null){

        final List<String>? _ids = bzModel.publication.published;

        if (Lister.checkCanLoop(_ids) == true){

          final List<SlideModel> _bzSlides = <SlideModel>[];

          for (int i = 0; i < _ids!.length; i++){

            final String _flyerID = _ids[i];

            final FlyerModel? _flyer = await fetchFlyer(
              flyerID: _flyerID,
            );

            if (Lister.checkCanLoop(_flyer?.slides) == true){

              for (final SlideModel _slide in _flyer!.slides!) {
                _bzSlides.add(_slide);

                blog('added slide with index ${_slide.slideIndex}');

                if (_bzSlides.length >= maxSlides) {
                  blog('breaking _bzSlides.length ${_bzSlides.length} : maxSlides $maxSlides : ${_bzSlides.length >= maxSlides}');
                  break;
                }
              }

              if (_bzSlides.length >= maxSlides) {
                break;
              }

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
              phids: const [],
              zone: bzModel.zone,
              authorID: null,
              bzID: bzModel.id,
              position: null,
              slides: _bzSlides,
              // specs: const [],
              times: const [],
              hasPriceTag: false,
              hasPDF: false,
              shareLink: null,
              isAmazonFlyer: false,
              showsAuthor: false,
              score: null,
              pdfPath: null,
              price: null,
            );

            _flyer = await FlyerProtocols.renderBigFlyer(
                flyerModel: _flyer,
                slidePicType: SlidePicType.small,
                onRenderEachSlide: (FlyerModel flyer){}
            );

          }

        }

      }

    }

    return _flyer;
  }
  // -----------------------------------------------------------------------------
}
