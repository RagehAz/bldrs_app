import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/maps/mapper.dart';

@immutable
class BzSearchModel {
  // -----------------------------------------------------------------------------
  const BzSearchModel({
    required this.bzType,
    required this.bzForm,
    required this.bzAccountType,
    required this.scopePhid,
    required this.onlyShowingTeams,
    required this.onlyVerified,
  });
  // -----------------------------------------------------------------------------
  final BzType? bzType;
  final BzForm? bzForm;
  final BzAccountType? bzAccountType;
  final String? scopePhid;
  final bool? onlyShowingTeams;
  final bool? onlyVerified;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  BzSearchModel copyWith({
    BzType? bzType,
    BzForm? bzForm,
    BzAccountType? bzAccountType,
    String? scopePhid,
    bool? onlyShowingTeams,
    bool? onlyVerified,
  }){
    return BzSearchModel(
      bzType: bzType ?? this.bzType,
      bzForm: bzForm ?? this.bzForm,
      bzAccountType: bzAccountType ?? this.bzAccountType,
      scopePhid: scopePhid ?? this.scopePhid,
      onlyShowingTeams: onlyShowingTeams ?? this.onlyShowingTeams,
      onlyVerified: onlyVerified ?? this.onlyVerified,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  BzSearchModel nullifyField({
    bool bzType = false,
    bool bzForm = false,
    bool bzAccountType = false,
    bool scopePhid = false,
    bool onlyShowingTeams = false,
    bool onlyVerified = false,
  }){

    return BzSearchModel(
      bzType: bzType == true ? null : this.bzType,
      bzForm: bzForm == true ? null : this.bzForm,
      bzAccountType: bzAccountType == true ? null : this.bzAccountType,
      scopePhid: scopePhid == true ? null : this.scopePhid,
      onlyShowingTeams: onlyShowingTeams == true ? null : this.onlyShowingTeams,
      onlyVerified: onlyVerified == true ? null : this.onlyVerified,
    );

  }
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipher(BzSearchModel? bzSearchModel){
    Map<String, dynamic>? _output;

    if (bzSearchModel != null) {
      _output = {
        'bzType': BzTyper.cipherBzType(bzSearchModel.bzType),
        'bzForm': BzTyper.cipherBzForm(bzSearchModel.bzForm),
        'bzAccountType': BzTyper.cipherBzAccountType(bzSearchModel.bzAccountType),
        'scopePhid': bzSearchModel.scopePhid,
        'onlyShowingTeams': bzSearchModel.onlyShowingTeams,
        'onlyVerified': bzSearchModel.onlyVerified,
      };
    }

    return Mapper.cleanNullPairs(map: _output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzSearchModel? decipher(Map<String, dynamic>? map){
    BzSearchModel? _output;

    if (map != null){
      _output = BzSearchModel(
        bzType: BzTyper.decipherBzType(map['bzType']),
        bzForm: BzTyper.decipherBzForm(map['bzForm']),
        bzAccountType: BzTyper.decipherBzAccountType(map['bzAccountType']),
        scopePhid: map['scopePhid'],
        onlyShowingTeams: map['onlyShowingTeams'],
        onlyVerified: map['onlyVerified'],
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool areIdentical({
    required BzSearchModel? model1,
    required BzSearchModel? model2,
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
          model1.bzType == model2.bzType &&
          model1.bzForm == model2.bzForm &&
          model1.bzAccountType == model2.bzAccountType &&
          model1.scopePhid == model2.scopePhid &&
          model1.onlyShowingTeams == model2.onlyShowingTeams &&
          model1.onlyVerified == model2.onlyVerified;
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
    if (other is BzSearchModel){
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
      bzType.hashCode^
      bzForm.hashCode^
      bzAccountType.hashCode^
      scopePhid.hashCode^
      onlyShowingTeams.hashCode^
      onlyVerified.hashCode;
  // -----------------------------------------------------------------------------
}
