import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/flyer/nano_flyer.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';

// -----------------------------------------------------------------------------
class TinyFlyer with ChangeNotifier{
  final String flyerID;
  final FlyerType flyerType;
  final TinyBz tinyBz;
  final String authorID;
  final int slideIndex;
  final String slidePic;
  final Zone flyerZone;
  final BoxFit picFit;
  final Color midColor;
  final List<dynamic> keywords;

  TinyFlyer({
    @required this.flyerID,
    @required this.flyerType,
    this.tinyBz,
    @required this.authorID,
    @required this.slideIndex,
    @required this.slidePic,
    @required this.flyerZone,
    @required this.midColor,
    this.keywords, /// TASK : integrate keywords in tiny flyers
    this.picFit, /// TASK : integrate this in all below methods
  });
// -----------------------------------------------------------------------------
  Map<String,dynamic> toMap (){
    return {
      'flyerID' : flyerID,
      'flyerType' : FlyerTypeClass.cipherFlyerType(flyerType),
      'tinyBz' : tinyBz.toMap(),
      'authorID' : authorID,
      'slideIndex' : slideIndex,
      'slidePic' : slidePic,
      'flyerZone' : flyerZone.toMap(),
      'midColor' : Colorizer.cipherColor(midColor),
    };
  }
// -----------------------------------------------------------------------------
  static bool tinyFlyersAreTheSame(FlyerModel finalFlyer, FlyerModel originalFlyer){
    bool tinyFlyersAreTheSame = true;

    if (finalFlyer.flyerType != originalFlyer.flyerType) {tinyFlyersAreTheSame = false;}
    else if (TinyBz.tinyBzzAreTheSame(finalFlyer.tinyBz, originalFlyer.tinyBz) == false) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.slides[0].pic != originalFlyer.slides[0].pic) {tinyFlyersAreTheSame = false;}

    else if (finalFlyer.flyerZone.countryID != originalFlyer.flyerZone.countryID) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.flyerZone.cityID != originalFlyer.flyerZone.cityID) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.flyerZone.districtID != originalFlyer.flyerZone.districtID) {tinyFlyersAreTheSame = false;}

    else {tinyFlyersAreTheSame = true;}

    return tinyFlyersAreTheSame;
  }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> decipherTinyFlyersMaps(List<dynamic> tinyFlyersMaps){
    List<TinyFlyer> _tinyFlyers = new List();
    tinyFlyersMaps.forEach((map) {
      _tinyFlyers.add(decipherTinyFlyerMap(map));
    });
    return _tinyFlyers;
  }
// -----------------------------------------------------------------------------
  static TinyFlyer decipherTinyFlyerMap(dynamic map){
    return TinyFlyer(
      flyerID: map['flyerID'],
      flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
      tinyBz: TinyBz.decipherTinyBzMap(map['tinyBz']),
      authorID: map['authorID'],
      slideIndex: map['slideIndex'],
      slidePic: map['slidePic'],
      flyerZone: Zone.decipherZoneMap(map['flyerZone']),
      midColor: Colorizer.decipherColor(map['midColor']),
      // keywords: Keyword.de
    );
  }
// -----------------------------------------------------------------------------
  static TinyFlyer getTinyFlyerFromFlyerModel(FlyerModel flyerModel){
    return TinyFlyer(
      flyerID: flyerModel?.flyerID,
      flyerType: flyerModel?.flyerType,
      authorID: flyerModel?.tinyAuthor?.userID,
      slideIndex: 0,
      slidePic: flyerModel == null ? null : flyerModel?.slides[0]?.pic,
      midColor: flyerModel == null ? null : flyerModel?.slides[0]?.midColor,
      picFit: flyerModel == null ? null : flyerModel?.slides[0]?.picFit,
      tinyBz: flyerModel?.tinyBz,
      flyerZone: flyerModel?.flyerZone,
      keywords: flyerModel?.keywords,
    );
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherTinyFlyers (List<TinyFlyer> tinyFlyers){
    List<dynamic> _tinyFlyersMaps = new List();

    tinyFlyers.forEach((f) {
      _tinyFlyersMaps.add(f.toMap());
    });

    return _tinyFlyersMaps;
  }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> getTinyFlyersFromBzModel(BzModel bzModel){
    List<TinyFlyer> _tinyFlyers = new List();

    List<NanoFlyer> _nanoFlyers = bzModel.nanoFlyers;

    if (_nanoFlyers != null){
      for (var nano in _nanoFlyers){
        _tinyFlyers.add(
            TinyFlyer(
              flyerID: nano.flyerID,
              flyerType: nano.flyerType,
              authorID: nano.authorID,
              slideIndex: 0,
              slidePic: nano.slidePic,
              tinyBz: TinyBz.getTinyBzFromBzModel(bzModel),
              flyerZone: nano.flyerZone,
              midColor: nano.midColor,
            )
        );
      }

    }

    return _tinyFlyers;
  }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> getTinyFlyersFromFlyersModels(List<FlyerModel> flyers){
    List<TinyFlyer> _tinyFlyers = new List();

    for (var flyer in flyers){
      TinyFlyer _tinyFlyer = getTinyFlyerFromFlyerModel(flyer);
      _tinyFlyers.add(_tinyFlyer);
    }

    return _tinyFlyers;
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfFlyerIDsFromTinyFlyers(List<TinyFlyer> tinyFlyers){
    List<String> _flyerIDs = new List();

    tinyFlyers?.forEach((flyer) {
      _flyerIDs.add(flyer.flyerID);
    });

    return _flyerIDs;
  }
// -----------------------------------------------------------------------------
  static TinyFlyer getTinyFlyerFromTinyFlyers({List<TinyFlyer> tinyFlyers, String flyerID}){
    TinyFlyer _tinyFlyer = tinyFlyers.singleWhere((tinyFlyer) => tinyFlyer.flyerID == flyerID, orElse: () => null);
    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------
  static TinyFlyer dummyTinyFlyer(String id){
    return TinyFlyer(
      flyerID: id,
      flyerType: FlyerType.Property,
      authorID: 'dummyAuthor',
      slideIndex: 0,
      slidePic: Iconz.DumSlide1,
      flyerZone: Zone(countryID: 'egy', cityID: 'cairo', districtID: 'heliopolis'),
      tinyBz: TinyBz.dummyTinyBz('bzID'),
      picFit: BoxFit.cover,
      midColor: Colorz.Black255,
      keywords: List(),
    );
  }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> dummyTinyFlyers(){
    return
        <TinyFlyer>[
          TinyFlyer.dummyTinyFlyer('1'),
          TinyFlyer.dummyTinyFlyer('2'),
          TinyFlyer.dummyTinyFlyer('3'),
          TinyFlyer.dummyTinyFlyer('4'),
          TinyFlyer.dummyTinyFlyer('5'),
        ];
  }
// -----------------------------------------------------------------------------
  static TinyFlyer getTinyFlyerFromSuperFlyer(SuperFlyer superFlyer){
    TinyFlyer _tinyFlyer = TinyFlyer(
      flyerID: superFlyer.flyerID,
      flyerType: superFlyer.flyerType,
      authorID: superFlyer.authorID,
      slideIndex: superFlyer.currentSlideIndex,
      slidePic: superFlyer.mSlides[superFlyer.currentSlideIndex].picURL,
      flyerZone: superFlyer.flyerZone,
      tinyBz: TinyBz.getTinyBzFromSuperFlyer(superFlyer),
      picFit: superFlyer.mSlides[superFlyer.currentSlideIndex].picFit,
      keywords: superFlyer.keywords,
      midColor: superFlyer.mSlides[superFlyer.currentSlideIndex].midColor,
    );

    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------
}


