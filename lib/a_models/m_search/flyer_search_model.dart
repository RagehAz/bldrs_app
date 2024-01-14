import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/maps/mapper.dart';

@immutable
class FlyerSearchModel {
  // -----------------------------------------------------------------------------
  const FlyerSearchModel({
    this.flyerType,
    this.onlyShowingAuthors,
    this.onlyWithPrices,
    this.onlyWithPDF,
    this.onlyAmazonProducts,
    this.phid,
    this.publishState,
  });
  // -----------------------------------------------------------------------------
  final FlyerType? flyerType;
  final bool? onlyShowingAuthors;
  final bool? onlyWithPrices;
  final bool? onlyWithPDF;
  final bool? onlyAmazonProducts;
  final String? phid;
  final PublishState? publishState;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  FlyerSearchModel copyWith({
    FlyerType? flyerType,
    bool? onlyShowingAuthors,
    bool? onlyWithPrices,
    bool? onlyWithPDF,
    bool? onlyAmazonProducts,
    String? phid,
    PublishState? publishState,
  }){
    return FlyerSearchModel(
      flyerType: flyerType ?? this.flyerType,
      onlyShowingAuthors: onlyShowingAuthors ?? this.onlyShowingAuthors,
      onlyWithPrices: onlyWithPrices ?? this.onlyWithPrices,
      onlyWithPDF: onlyWithPDF ?? this.onlyWithPDF,
      onlyAmazonProducts: onlyAmazonProducts ?? this.onlyAmazonProducts,
      phid: phid ?? this.phid,
      publishState: publishState ?? this.publishState,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  FlyerSearchModel nullifyField({
    bool flyerType = false,
    bool onlyShowingAuthors = false,
    bool onlyWithPrices = false,
    bool onlyWithPDF = false,
    bool onlyAmazonProducts = false,
    bool phid = false,
    bool publishState = false,
  }){

    return FlyerSearchModel(
      flyerType: flyerType == true ? null : this.flyerType,
      onlyShowingAuthors: onlyShowingAuthors == true ? null : this.onlyShowingAuthors,
      onlyWithPrices: onlyWithPrices == true ? null : this.onlyWithPrices,
      onlyWithPDF: onlyWithPDF == true ? null : this.onlyWithPDF,
      onlyAmazonProducts: onlyAmazonProducts == true ? null : this.onlyAmazonProducts,
      phid: phid == true ? null : this.phid,
      publishState: publishState == true ? null : this.publishState,
    );

  }
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipher(FlyerSearchModel? flyerSearchModel){
    Map<String, dynamic>? _output;

    if (flyerSearchModel != null) {
      _output = {
        'flyerType': FlyerTyper.cipherFlyerType(flyerSearchModel.flyerType),
        'onlyShowingAuthors': flyerSearchModel.onlyShowingAuthors,
        'onlyWithPrices': flyerSearchModel.onlyWithPrices,
        'onlyWithPDF': flyerSearchModel.onlyWithPDF,
        'onlyAmazonProducts': flyerSearchModel.onlyAmazonProducts,
        'phid': flyerSearchModel.phid,
        'publishState': PublicationModel.cipherPublishState(flyerSearchModel.publishState),
      };
    }

    return Mapper.cleanNullPairs(map: _output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerSearchModel? decipher(Map<String, dynamic>? map){
    FlyerSearchModel? _output;

    if (map != null){
      _output = FlyerSearchModel(
        flyerType: FlyerTyper.decipherFlyerType(map['flyerType']),
        onlyShowingAuthors: map['onlyShowingAuthors'],
        onlyWithPrices: map['onlyWithPrices'],
        onlyWithPDF: map['onlyWithPDF'],
        onlyAmazonProducts: map['onlyAmazonProducts'],
        phid: map['phid'],
        publishState: PublicationModel.decipherPublishState(map['publishState'])
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool areIdentical({
    required FlyerSearchModel? model1,
    required FlyerSearchModel? model2,
  }){
    bool _output;

    if (model1 == null && model2 == null){
      _output = true;
    }
    else if (model1 == null || model2 == null){
      _output = false;
    }
    else {
      _output =
          model1.flyerType == model2.flyerType &&
          model1.onlyShowingAuthors == model2.onlyShowingAuthors &&
          model1.onlyWithPrices == model2.onlyWithPrices &&
          model1.onlyWithPDF == model2.onlyWithPDF &&
          model1.onlyAmazonProducts == model2.onlyAmazonProducts &&
          model1.phid == model2.phid &&
          model1.publishState == model2.publishState;
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
    if (other is FlyerSearchModel){
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
      flyerType.hashCode^
      onlyShowingAuthors.hashCode^
      onlyWithPrices.hashCode^
      onlyWithPDF.hashCode^
      onlyAmazonProducts.hashCode^
      phid.hashCode^
      publishState.hashCode;
  // -----------------------------------------------------------------------------
}
