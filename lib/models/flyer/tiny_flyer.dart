import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/helpers/image_size.dart';
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
  final List<String> keywordsIDs;
  final ImageSize imageSize;
  final String headline;
  final bool priceTagIsOn;

  TinyFlyer({
    @required this.flyerID,
    @required this.flyerType,
    this.tinyBz,
    @required this.authorID,
    @required this.slideIndex,
    @required this.slidePic,
    @required this.flyerZone,
    @required this.midColor,
    @required this.keywordsIDs, /// TASK : integrate keywords in tiny flyers
    @required this.picFit, /// TASK : integrate this in all below methods
    @required this.imageSize,
    @required this.headline,
    @required this.priceTagIsOn,
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
      'keywordsIDs' : keywordsIDs,
      'picFit' : ImageSize.cipherBoxFit(picFit),
      'imageSize' : imageSize.toMap(),
      'headline' : headline,
      'priceTagIsOn' : priceTagIsOn,
    };
  }
// -----------------------------------------------------------------------------
  static bool tinyFlyersAreTheSame(FlyerModel finalFlyer, FlyerModel originalFlyer){
    bool tinyFlyersAreTheSame = true;

    if (finalFlyer.flyerType != originalFlyer.flyerType) {tinyFlyersAreTheSame = false;}
    else if (TinyBz.tinyBzzAreTheSame(finalFlyer.tinyBz, originalFlyer.tinyBz) == false) {tinyFlyersAreTheSame = false;}
    else if(Mapper.listsAreTheSame(list1: finalFlyer.keywordsIDs, list2: originalFlyer.keywordsIDs) == false) {tinyFlyersAreTheSame = false;}

    else if (finalFlyer.slides[0].pic != originalFlyer.slides[0].pic) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.slides[0].picFit != originalFlyer.slides[0].picFit) {tinyFlyersAreTheSame = false;}
    else if (Colorizer.colorsAreTheSame(finalFlyer.slides[0].midColor, originalFlyer.slides[0].midColor) == false) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.slides[0].headline != originalFlyer.slides[0].headline) {tinyFlyersAreTheSame = false;}

    else if (finalFlyer.slides[0].imageSize.width != originalFlyer.slides[0].imageSize.width) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.slides[0].imageSize.height != originalFlyer.slides[0].imageSize.height) {tinyFlyersAreTheSame = false;}

    else if (finalFlyer.flyerZone.countryID != originalFlyer.flyerZone.countryID) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.flyerZone.cityID != originalFlyer.flyerZone.cityID) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.flyerZone.districtID != originalFlyer.flyerZone.districtID) {tinyFlyersAreTheSame = false;}

    else if (finalFlyer.priceTagIsOn != originalFlyer.priceTagIsOn) {tinyFlyersAreTheSame = false;}

    else {tinyFlyersAreTheSame = true;}

    return tinyFlyersAreTheSame;
  }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> decipherTinyFlyersMaps(List<dynamic> tinyFlyersMaps){
    final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];

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
      keywordsIDs: Mapper.getStringsFromDynamics(dynamics: map['keywordsIDs']),
      picFit: ImageSize.decipherBoxFit(map['picFit']),
      imageSize: ImageSize.decipherImageSize(map['imageSize']),
      headline: map['headline'],
      priceTagIsOn: map['priceTagIsOn'],
      // keywords: Keyword.de
    );
  }
// -----------------------------------------------------------------------------
  static TinyFlyer getTinyFlyerFromFlyerModel(FlyerModel flyerModel){
    TinyFlyer _tinyFlyer;

    if(flyerModel != null){
      if(flyerModel.slides != null){
        if(flyerModel.slides.length != 0){
          _tinyFlyer = TinyFlyer(
            flyerID: flyerModel?.flyerID,
            flyerType: flyerModel?.flyerType,
            authorID: flyerModel?.tinyAuthor?.userID,
            slideIndex: 0,
            slidePic: flyerModel?.slides[0]?.pic,
            midColor: flyerModel?.slides[0]?.midColor,
            picFit: flyerModel?.slides[0]?.picFit,
            tinyBz: flyerModel?.tinyBz,
            flyerZone: flyerModel?.flyerZone,
            keywordsIDs: flyerModel?.keywordsIDs,
            imageSize: flyerModel?.slides[0]?.imageSize,
            headline: flyerModel?.slides[0]?.headline,
            priceTagIsOn: flyerModel?.priceTagIsOn,
          );
        }
      }
    }

    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherTinyFlyers (List<TinyFlyer> tinyFlyers){
    final List<dynamic> _tinyFlyersMaps = <dynamic>[];

    tinyFlyers.forEach((f) {
      _tinyFlyersMaps.add(f.toMap());
    });

    return _tinyFlyersMaps;
  }
// -----------------------------------------------------------------------------
//   static List<TinyFlyer> getTinyFlyersFromBzModel(BzModel bzModel){
//     final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];
//
//     final List<NanoFlyer> _nanoFlyers = bzModel.nanoFlyers;
//
//     if (_nanoFlyers != null){
//       for (var nano in _nanoFlyers){
//
//         final TinyFlyer _tinyFlyer = TinyFlyer.getTinyFlyerFromNanoFlyerAndBzModel(nano: nano, bzModel: bzModel);
//
//         _tinyFlyers.add(_tinyFlyer);
//       }
//
//     }
//
//     return _tinyFlyers;
//   }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> getTinyFlyersFromFlyersModels(List<FlyerModel> flyers){
    final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];

    for (var flyer in flyers){
      final TinyFlyer _tinyFlyer = getTinyFlyerFromFlyerModel(flyer);
      _tinyFlyers.add(_tinyFlyer);
    }

    return _tinyFlyers;
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfFlyerIDsFromTinyFlyers(List<TinyFlyer> tinyFlyers){
    final List<String> _flyerIDs = <String>[];

    tinyFlyers?.forEach((flyer) {
      _flyerIDs.add(flyer.flyerID);
    });

    return _flyerIDs;
  }
// -----------------------------------------------------------------------------
  static TinyFlyer getTinyFlyerFromTinyFlyers({List<TinyFlyer> tinyFlyers, String flyerID}){
    final TinyFlyer _tinyFlyer = tinyFlyers.singleWhere((tinyFlyer) => tinyFlyer.flyerID == flyerID, orElse: () => null);
    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------
  static TinyFlyer dummyTinyFlyer(String id){
    return TinyFlyer(
      flyerID: id,
      flyerType: FlyerType.rentalProperty,
      authorID: 'dummyAuthor',
      slideIndex: 0,
      slidePic: 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/slidesPics%2F0HHptUSLQI907nEYizpX_00.jpg?alt=media&token=976bae0a-04fe-44da-9f1a-3ee27522bc06',
      flyerZone: Zone(countryID: 'egy', cityID: 'cairo', districtID: 'heliopolis'),
      tinyBz: TinyBz.dummyTinyBz('bzID'),
      picFit: BoxFit.cover,
      midColor: Colorz.Black255,
      keywordsIDs: [Keyword.bldrsKeywords()[50].keywordID],
      imageSize: ImageSize(height: 630, width: 460),
      headline: 'Headline',
      priceTagIsOn: true,
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
      keywordsIDs: Keyword.getKeywordsIDsFromKeywords(superFlyer.keywords,),
      midColor: superFlyer.mSlides[superFlyer.currentSlideIndex].midColor,
      imageSize: superFlyer.mSlides[superFlyer.currentSlideIndex].imageSize,
      headline: superFlyer.mSlides[superFlyer.currentSlideIndex].headline,
      priceTagIsOn: superFlyer.priceTagIsOn,
    );

    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------
//   static TinyFlyer getTinyFlyerFromNanoFlyerAndBzModel({NanoFlyer nano, BzModel bzModel}){
//     TinyFlyer _tiny;
//     if(nano != null){
//       _tiny = TinyFlyer(
//         flyerID: nano.flyerID,
//         flyerType: nano.flyerType,
//         authorID: nano.authorID,
//         slideIndex: 0,
//         slidePic: nano.slidePic,
//         flyerZone: nano.flyerZone,
//         midColor: nano.midColor,
//         keywords: null, /// TASK : add keywords to tinyFlyers from nano flyers
//         picFit: null, /// TASK : add picFit to tinyFlyers from nano flyers
//         imageSize: null, /// TASK : add imageSize to tinyFlyers from nano flyers
//         headline: 'fix nano headline',
//         tinyBz: TinyBz.getTinyBzFromBzModel(bzModel),
//         priceTagIsOn: true,
//       );
//     }
//     return _tiny;
//   }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> filterTinyFlyersBySection({List<TinyFlyer> tinyFlyers, Section section}){
    List<TinyFlyer> _filteredTinyFlyers = <TinyFlyer>[];

    if (section == Section.All){
      _filteredTinyFlyers = tinyFlyers;
    }

    else {

      final FlyerType _flyerType = FlyerTypeClass.getFlyerTypeBySection(section: section);

      for (TinyFlyer tiny in tinyFlyers){
        if (tiny.flyerType == _flyerType){
          _filteredTinyFlyers.add(tiny);
        }
      }

    }

    return _filteredTinyFlyers;
  }
// -----------------------------------------------------------------------------
  static bool tinyFlyersContainThisID({String flyerID, List<TinyFlyer> tinyFlyers}){
    bool _hasTheID = false;

    if (flyerID != null && Mapper.canLoopList(tinyFlyers)){

      for (TinyFlyer tinyFlyer in tinyFlyers){

        if (tinyFlyer.flyerID == flyerID){
          _hasTheID = true;
          break;
        }

      }

    }

    return _hasTheID;
  }
}


