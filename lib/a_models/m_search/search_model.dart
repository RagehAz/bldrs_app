import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/m_search/bz_search_model.dart';
import 'package:bldrs/a_models/m_search/flyer_search_model.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

@immutable
class SearchModel {
  // -----------------------------------------------------------------------------
  const SearchModel({
    @required this.id,
    @required this.userID,
    @required this.text,
    @required this.zone,
    @required this.flyerSearchModel,
    @required this.bzSearchModel,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final String userID;
  final String text;
  final ZoneModel zone;
  final FlyerSearchModel flyerSearchModel;
  final BzSearchModel bzSearchModel;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  SearchModel copyWith({
    String id,
    String userID,
    String text,
    ZoneModel zone,
    FlyerSearchModel flyerSearchModel,
    BzSearchModel bzSearchModel,
  }){
    return SearchModel(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      text: text ?? this.text,
      zone: zone ?? this.zone,
      flyerSearchModel: flyerSearchModel ?? this.flyerSearchModel,
      bzSearchModel: bzSearchModel ?? this.bzSearchModel,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  SearchModel nullifyField({
    bool id = false,
    bool userID = false,
    bool text = false,
    bool zone = false,
    bool flyerSearchModel = false,
    bool bzSearchModel = false,
  }){

    return SearchModel(
      id: id == true ? null : this.id,
      userID: userID == true ? null : this.userID,
      text: text == true ? null : this.text,
      zone: zone == true ? null : this.zone,
      flyerSearchModel: flyerSearchModel == true ? null : this.flyerSearchModel,
      bzSearchModel: bzSearchModel == true ? null : this.bzSearchModel,
    );

  }
  // -----------------------------------------------------------------------------

  /// CIPHER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipher(SearchModel searchModel){
    Map<String, dynamic> _output;

    if (searchModel != null) {
      _output = {
        'id': searchModel.id,
        'userID': searchModel.userID,
        'text': searchModel.text,
        'zone': searchModel.zone?.toMap(),
        'flyerSearchModel': FlyerSearchModel.cipher(searchModel.flyerSearchModel),
        'bzSearchModel': BzSearchModel.cipher(searchModel.bzSearchModel),
      };
    }

    return Mapper.cleanNullPairs(map: _output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SearchModel decipher(Map<String, dynamic> map){
    SearchModel _output;

    if (map != null){

      _output = SearchModel(
        id: map['id'],
        userID: map['userID'],
        text: map['text'],
        zone: ZoneModel.decipherZone(map['zone']),
        flyerSearchModel: FlyerSearchModel.decipher(map['flyerSearchModel']),
        bzSearchModel: BzSearchModel.decipher(map['bzSearchModel']),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool areIdentical({
    @required SearchModel model1,
    @required SearchModel model2,
  }){
    bool _output = false;

    if (model1 == null && model2 == null){
      _output = true;
    }
    else if (model1 == null || model2 == null){
      _output = false;
    }
    else {
      _output =
              model1.id == model2.id &&
              model1.userID == model2.userID &&
              model1.text == model2.text &&
              ZoneModel.checkZonesIDsAreIdentical(zone1: model1.zone, zone2: model2.zone) &&
              FlyerSearchModel.areIdentical(model1: model1.flyerSearchModel, model2: model2.flyerSearchModel) &&
              BzSearchModel.areIdentical(model1: model1.bzSearchModel, model2: model2.bzSearchModel);
    }


    return _output;
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
    if (other is SearchModel){
      _areIdentical = areIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
    id.hashCode^
    userID.hashCode^
    text.hashCode^
    zone.hashCode^
    flyerSearchModel.hashCode^
    bzSearchModel.hashCode;
  // -----------------------------------------------------------------------------
}
