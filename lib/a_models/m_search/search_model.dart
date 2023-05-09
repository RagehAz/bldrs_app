import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/a_models/m_search/bz_search_model.dart';
import 'package:bldrs/a_models/m_search/flyer_search_model.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:space_time/space_time.dart';
/// => TAMAM
@immutable
class SearchModel {
  // -----------------------------------------------------------------------------
  const SearchModel({
    @required this.id,
    @required this.userID,
    @required this.text,
    @required this.zone,
    @required this.time,
    @required this.flyerSearchModel,
    @required this.bzSearchModel,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final String userID;
  final String text;
  final ZoneModel zone;
  final DateTime time;
  final FlyerSearchModel flyerSearchModel;
  final BzSearchModel bzSearchModel;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static SearchModel createInitialModel({
    @required BuildContext context,
  }){

    return SearchModel(
      id: null,
      userID: Authing.getUserID(),
      text: null,
      zone: ZoneProvider.proGetCurrentZone(context: context, listen: false),
      time: DateTime.now(),
      flyerSearchModel: const FlyerSearchModel(
        onlyWithPrices: false,
        onlyWithPDF: false,
        onlyShowingAuthors: false,
        onlyAmazonProducts: false,
        phid: null,
        publishState: null,
        auditState: null,
        flyerType: null,
      ),
      bzSearchModel: const BzSearchModel(
        scopePhid: null,
        onlyVerified: false,
        onlyShowingTeams: false,
        bzAccountType: null,
        bzType: null,
        bzForm: null,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SearchModel createUploadModel({
    @required ModelType searchType,
    @required SearchModel searchModel,
    @required String text,
  }){

    SearchModel _searchModel = searchModel.copyWith(
      text: text,
      time: DateTime.now(),
    );

    if (searchType == ModelType.flyer){
      _searchModel = _searchModel.nullifyField(
        bzSearchModel: true,
      );
    }
    if (searchType == ModelType.bz){
      _searchModel = _searchModel.nullifyField(
        flyerSearchModel: true,
      );
    }

    return _searchModel;
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  SearchModel copyWith({
    String id,
    String userID,
    String text,
    ZoneModel zone,
    DateTime time,
    FlyerSearchModel flyerSearchModel,
    BzSearchModel bzSearchModel,
  }){
    return SearchModel(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      text: text ?? this.text,
      zone: zone ?? this.zone,
      time: time ?? this.time,
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
    bool time = false,
    bool flyerSearchModel = false,
    bool bzSearchModel = false,
  }){

    return SearchModel(
      id: id == true ? null : this.id,
      userID: userID == true ? null : this.userID,
      text: text == true ? null : this.text,
      zone: zone == true ? null : this.zone,
      time: time == true ? null : this.time,
      flyerSearchModel: flyerSearchModel == true ? null : this.flyerSearchModel,
      bzSearchModel: bzSearchModel == true ? null : this.bzSearchModel,
    );

  }
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipher({
    @required SearchModel searchModel,
}){
    Map<String, dynamic> _output;

    if (searchModel != null) {
      _output = {
        'id': searchModel.id,
        'userID': searchModel.userID,
        'text': searchModel.text,
        'zone': searchModel.zone?.toMap(),
        'time': Timers.cipherTime(time: searchModel.time, toJSON: true),
        'flyerSearchModel': FlyerSearchModel.cipher(searchModel.flyerSearchModel),
        'bzSearchModel': BzSearchModel.cipher(searchModel.bzSearchModel),
      };
    }

    return Mapper.cleanNullPairs(map: _output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherSearches({
    @required List<SearchModel> models,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (Mapper.checkCanLoopList(models) == true){

      for (final SearchModel model in models){

        final Map<String, dynamic> _map = cipher(
          searchModel: model,
        );
        _output.add(_map);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SearchModel decipher({
    @required Map<String, dynamic> map,
}){
    SearchModel _output;

    if (map != null){

      _output = SearchModel(
        id: map['id'],
        userID: map['userID'],
        text: map['text'],
        zone: ZoneModel.decipherZone(map['zone']),
        time: Timers.decipherTime(time: map['time'], fromJSON: true),
        flyerSearchModel: FlyerSearchModel.decipher(map['flyerSearchModel']),
        bzSearchModel: BzSearchModel.decipher(map['bzSearchModel']),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SearchModel> decipherSearches({
    @required List<Map<String, dynamic>> maps,
  }){
    final List<SearchModel> _output = [];

    if (Mapper.checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){

        final SearchModel _model = decipher(
          map: map,
        );
        _output.add(_model);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SearchModel> sortByDate({
    @required List<SearchModel> models,
  }){

    if (Mapper.checkCanLoopList(models) == true){
      final List<SearchModel> _models = [...models];
      _models.sort((a, b) => a.time.compareTo(b.time));
      return _models;
    }

    else {
      return <SearchModel>[];
    }

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool modelsAreIdentical({
    @required List<SearchModel> models1,
    @required List<SearchModel> models2,
  }){
    final List<Map<String, dynamic>> _maps1 = cipherSearches(models: models1);
    final List<Map<String, dynamic>> _maps2 = cipherSearches(models: models2);
    return Mapper.checkMapsListsAreIdentical(maps1: _maps1, maps2: _maps2);
  }
    // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString(){

    final String _blog =
    '''
    SearchModel(
      userID: $userID,
      id: $id,
      zone: ZoneModel(
        countryID: ${zone?.countryID},
        cityID: ${zone?.cityID},
      ),
      text: $text,
      time: $time,
      bzSearchModel: BzSearchModel(
        bzType: ${bzSearchModel?.bzType},
        bzForm: ${bzSearchModel?.bzForm},
        bzAccountType: ${bzSearchModel?.bzAccountType},
        scopePhid: ${bzSearchModel?.scopePhid},
        onlyShowingTeams: ${bzSearchModel?.onlyShowingTeams},
        onlyVerified: ${bzSearchModel?.onlyVerified},
      ),
      flyerSearchModel: FlyerSearchModel(
        flyerType: ${flyerSearchModel?.flyerType},
        auditState: ${flyerSearchModel?.auditState},
        publishState: ${flyerSearchModel?.publishState},
        phid: ${flyerSearchModel?.phid},
        onlyAmazonProducts: ${flyerSearchModel?.onlyAmazonProducts},
        onlyShowingAuthors: ${flyerSearchModel?.onlyShowingAuthors},
        onlyWithPDF: ${flyerSearchModel?.onlyWithPDF},
        onlyWithPrices: ${flyerSearchModel?.onlyWithPrices},
      ),
    );
    ''';

    return _blog;
   }
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
