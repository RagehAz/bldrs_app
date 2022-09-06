import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';

enum BldrPhase {
  searchingProperties,
  preConstruction,
  inConstruction,
  finishing,
  furnishing,
  living,
}

@immutable
class CustomerStatus {
  /// --------------------------------------------------------------------------
  const CustomerStatus({
    @required this.bldrPhase,
    @required this.neededBzz,
    @required this.lookingFor,
    @required this.specs,
    @required this.zoneModel,
    @required this.location,
  });
  /// --------------------------------------------------------------------------
  final BldrPhase bldrPhase;
  final List<BzType> neededBzz;
  final List<FlyerType> lookingFor;
  final List<String> specs;
  final ZoneModel zoneModel;
  final GeoPoint location;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  CustomerStatus copyWith({
    BldrPhase bldrPhase,
    List<BzType> neededBzz,
    List<FlyerType> lookingFor,
    List<String> specs,
    ZoneModel zoneModel,
    GeoPoint location,
  }){
    return CustomerStatus(
      bldrPhase: bldrPhase ?? this.bldrPhase,
      neededBzz: neededBzz ?? this.neededBzz,
      lookingFor: lookingFor ?? this.lookingFor,
      specs: specs ?? this.specs,
      zoneModel: zoneModel ?? this.zoneModel,
      location: location ?? this.location,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return {
      'bldrPhase' : cipherBldrPhase(bldrPhase),
      'neededBzz' : BzModel.cipherBzTypes(neededBzz),
      'lookingFor' : FlyerTyper.cipherFlyersTypes(lookingFor),
      'specs' : specs,
      'zoneModel' : zoneModel.toMap(),
      'location' : Atlas.cipherGeoPoint(
          point: location,
          toJSON: toJSON
      )
    };
  }
  // --------------------
  static CustomerStatus decipherCustomerStatus(Map<String, dynamic> map){

    CustomerStatus _status;

    if (map != null){
      _status = CustomerStatus(
        bldrPhase: decipherBldrPhase(map['bldrPhase']),
        neededBzz: BzModel.decipherBzTypes(map['neededBzz']) ,
        lookingFor: FlyerTyper.decipherFlyersTypes(map['lookingFor']),
        specs: Stringer.getStringsFromDynamics(dynamics: map['specs']),
        zoneModel: ZoneModel.decipherZoneMap(map['zoneModel']),
        location: Atlas.decipherGeoPoint(
          point: map['location'],
          fromJSON: false,
        ),
      );
    }

    return _status;
  }
  // -----------------------------------------------------------------------------

  /// BLDR PHASE CYPHERS

  // --------------------
  static String cipherBldrPhase(BldrPhase phase){
    switch (phase){
      case BldrPhase.searchingProperties: return 'searchingProperties';     break;
      case BldrPhase.preConstruction:     return 'preConstruction';         break;
      case BldrPhase.inConstruction:      return 'inConstruction';          break;
      case BldrPhase.finishing:           return 'finishing';               break;
      case BldrPhase.furnishing:          return 'furnishing';              break;
      case BldrPhase.living:              return 'living';                  break;
      default: return null;
    }
  }
  // --------------------
  static BldrPhase decipherBldrPhase(String phase){
    switch (phase){
      case 'searchingProperties':   return BldrPhase.searchingProperties; break;
      case 'preConstruction':       return BldrPhase.preConstruction;     break;
      case 'inConstruction':        return BldrPhase.inConstruction;      break;
      case 'finishing':             return BldrPhase.finishing;           break;
      case 'furnishing':            return BldrPhase.furnishing;          break;
      case 'living':                return BldrPhase.living;              break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  void blogCustomerStatus({
    String methodName = 'CUSTOMER STATUS BLOG',
  }){
    blog('$methodName ---------------------------- START');

    blog('bldrPhase : ${bldrPhase.toString()}');
    blog('neededBzz : ${neededBzz.toString()}');
    blog('lookingFor : ${lookingFor.toString()}');
    blog('specs : ${specs.toString()}');
    blog('zoneModel : ${zoneModel.toString()}');
    blog('location : ${location.toString()}');

    blog('$methodName ---------------------------- END');
  }
  // --------------------
  static void blogCustomerStatuses({
    @required List<CustomerStatus> statuses,
    String methodName,
  }){

    if (Mapper.checkCanLoopList(statuses) == true){

      for (final CustomerStatus status in statuses){
        status.blogCustomerStatus(
          methodName: methodName,
        );
      }

    }
    else {
      blog('no customer statuses found to blog');
    }

  }
  // -----------------------------------------------------------------------------
}
