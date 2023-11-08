import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

enum UserSearchType {
  byName,
  byEmail,
  byPhone,
  byJobTitle,
  byCompanyName,
  byDeviceID,
}
/// => TAMAM
@immutable
class UserSearchModel {
  // -----------------------------------------------------------------------------
  const UserSearchModel({
    required this.signInMethod,
    required this.needType,
    required this.searchType,
    required this.gender,
    required this.language,
    required this.onlyWithPublicContacts,
    required this.onlyBzAuthors,
    required this.onlyBldrsAdmins,
    required this.onlyCanReceiveNotification,
    required this.devicePlatform,
    required this.onlyVerifiedEmails,
    required this.zone,
  });
  // --------------------
  final SignInMethod? signInMethod;
  final NeedType? needType;
  final UserSearchType? searchType;
  final Gender? gender;
  final String? language;
  final bool? onlyWithPublicContacts;
  final bool? onlyBzAuthors;
  final bool? onlyBldrsAdmins;
  final bool? onlyCanReceiveNotification;
  final String? devicePlatform;
  final bool? onlyVerifiedEmails;
  final ZoneModel? zone;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const List<UserSearchType> userSearchTypes = <UserSearchType>[
    UserSearchType.byName,
    UserSearchType.byEmail,
    UserSearchType.byPhone,
    UserSearchType.byJobTitle,
    UserSearchType.byCompanyName,
    UserSearchType.byDeviceID,
  ];
  // --------------------
  static const UserSearchModel initialModel = UserSearchModel(
    signInMethod: null,
    needType: null,
    searchType: UserSearchType.byName,
    gender: null,
    language: null,
    onlyWithPublicContacts: false,
    onlyBzAuthors: false,
    onlyBldrsAdmins: false,
    onlyCanReceiveNotification: false,
    devicePlatform: null,
    onlyVerifiedEmails: false,
    zone: null,
    );
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  UserSearchModel copyWith({
    SignInMethod? signInMethod,
    NeedType? needType,
    UserSearchType? searchType,
    Gender? gender,
    String? language,
    bool? onlyWithPublicContacts,
    bool? onlyBzAuthors,
    bool? onlyBldrsAdmins,
    bool? onlyCanReceiveNotification,
    String? devicePlatform,
    bool? onlyVerifiedEmails,
    ZoneModel? zone,
  }){
    return UserSearchModel(
      signInMethod: signInMethod ?? this.signInMethod,
      needType: needType ?? this.needType,
      searchType: searchType ?? this.searchType,
      gender: gender ?? this.gender,
      language: language ?? this.language,
      onlyWithPublicContacts: onlyWithPublicContacts ?? this.onlyWithPublicContacts,
      onlyBzAuthors: onlyBzAuthors ?? this.onlyBzAuthors,
      onlyBldrsAdmins: onlyBldrsAdmins ?? this.onlyBldrsAdmins,
      onlyCanReceiveNotification: onlyCanReceiveNotification ?? this.onlyCanReceiveNotification,
      devicePlatform: devicePlatform ?? this.devicePlatform,
      onlyVerifiedEmails: onlyVerifiedEmails ?? this.onlyVerifiedEmails,
      zone: zone ?? this.zone,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  UserSearchModel nullifyField({
    bool signInMethod = false,
    bool needType = false,
    bool searchType = false,
    bool gender = false,
    bool language = false,
    bool onlyWithPublicContacts = false,
    bool onlyBzAuthors = false,
    bool onlyBldrsAdmins = false,
    bool onlyCanReceiveNotification = false,
    bool devicePlatform = false,
    bool onlyVerifiedEmails = false,
    bool zone = false,
  }){

    return UserSearchModel(
      signInMethod: signInMethod == true ? null : this.signInMethod,
      needType: needType == true ? null : this.needType,
      searchType: searchType == true ? null : this.searchType,
      gender: gender == true ? null : this.gender,
      language: language == true ? null : this.language,
      onlyWithPublicContacts: onlyWithPublicContacts == true ? null : this.onlyWithPublicContacts,
      onlyBzAuthors: onlyBzAuthors == true ? null : this.onlyBzAuthors,
      onlyBldrsAdmins: onlyBldrsAdmins == true ? null : this.onlyBldrsAdmins,
      onlyCanReceiveNotification: onlyCanReceiveNotification == true ? null : this.onlyCanReceiveNotification,
      devicePlatform: devicePlatform == true ? null : this.devicePlatform,
      onlyVerifiedEmails: onlyVerifiedEmails == true ? null : this.onlyVerifiedEmails,
      zone: zone == true ? null : this.zone,
    );

  }
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// NO NEED TO CIPHER NOW : WON'T BE SAVED IN DB OR TRACKED ON LDB
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool areIdentical({
    required UserSearchModel? model1,
    required UserSearchModel? model2,
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
          model1.signInMethod == model2.signInMethod &&
          model1.needType == model2.needType &&
          model1.searchType == model2.searchType &&
          model1.gender == model2.gender &&
          model1.language == model2.language &&
          model1.onlyWithPublicContacts == model2.onlyWithPublicContacts &&
          model1.onlyBzAuthors == model2.onlyBzAuthors &&
          model1.onlyBldrsAdmins == model2.onlyBldrsAdmins &&
          model1.onlyCanReceiveNotification == model2.onlyCanReceiveNotification &&
          model1.devicePlatform == model2.devicePlatform &&
          model1.zone == model2.zone &&
          model1.onlyVerifiedEmails == model2.onlyVerifiedEmails;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString(){
    return
    '''
    UserSearchModel(
      signInMethod: $signInMethod,
      needType: $needType,
      searchType: $searchType,
      gender: $gender,
      language: $language,
      onlyWithPublicContacts: $onlyWithPublicContacts,
      onlyBzAuthors: $onlyBzAuthors,
      onlyBldrsAdmins: $onlyBldrsAdmins,
      onlyCanReceiveNotification: $onlyCanReceiveNotification,
      devicePlatform: $devicePlatform,
      onlyVerifiedEmails: $onlyVerifiedEmails,
      zoneModel: $zone,
    )
    ''';
   }
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is UserSearchModel){
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
      signInMethod.hashCode^
      needType.hashCode^
      searchType.hashCode^
      gender.hashCode^
      language.hashCode^
      onlyWithPublicContacts.hashCode^
      onlyBzAuthors.hashCode^
      onlyBldrsAdmins.hashCode^
      onlyCanReceiveNotification.hashCode^
      devicePlatform.hashCode^
      zone.hashCode^
      onlyVerifiedEmails.hashCode;
  // -----------------------------------------------------------------------------
}
