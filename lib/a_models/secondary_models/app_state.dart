import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';

class AppState {
  /// --------------------------------------------------------------------------
  AppState({
    @required this.keywordsChainVersion,
    @required this.specsChainVersion,
    @required this.phrasesVersion,

    @required this.appUpdateRequired,
    @required this.languageUpdateRequired,
    @required this.termsUpdateRequired,
    @required this.aboutBldrsUpdateRequired,
    @required this.notificationsUpdateRequired,
    @required this.sponsors,
    @required this.activeSections,
    @required this.numberOfKeywords,
    @required this.zonesUpdateRequired,
    @required this.activeCountries,
  });
  /// --------------------------------------------------------------------------
  /// chains
  final double keywordsChainVersion;
  final double specsChainVersion;
  /// phrases
  final double phrasesVersion;


  /// app update
  final bool appUpdateRequired;

  final bool languageUpdateRequired;

  /// literature
  final bool termsUpdateRequired;
  final bool aboutBldrsUpdateRequired;

  /// notifications
  final bool notificationsUpdateRequired;

  /// sponsors
  final List<String> sponsors;

  final List<FlyerType> activeSections;
  final int numberOfKeywords;

  /// zones
  final bool zonesUpdateRequired;
  final List<String> activeCountries;
  /// --------------------------------------------------------------------------
  AppState copyWith({
    double keywordsChainVersion,
    double specsChainVersion,
    double phrasesVersion,

    bool appUpdateRequired,
    bool wordzUpdateRequired,
    bool languageUpdateRequired,
    bool termsUpdateRequired,
    bool aboutBldrsUpdateRequired,
    bool notificationsUpdateRequired,
    List<String> sponsors,
    List<FlyerType> activeSections,
    int numberOfKeywords,
    bool zonesUpdateRequired,
    List<String> activeCountries,
}){
    return AppState(
        keywordsChainVersion: keywordsChainVersion ?? this.keywordsChainVersion,
        specsChainVersion: specsChainVersion ?? this.specsChainVersion,
        phrasesVersion: phrasesVersion ?? this.phrasesVersion,

        appUpdateRequired: appUpdateRequired ?? this.appUpdateRequired,
        languageUpdateRequired: languageUpdateRequired ?? this.languageUpdateRequired,
        termsUpdateRequired: termsUpdateRequired ?? this.termsUpdateRequired,
        aboutBldrsUpdateRequired: aboutBldrsUpdateRequired ?? this.aboutBldrsUpdateRequired,
        notificationsUpdateRequired: notificationsUpdateRequired ?? this.notificationsUpdateRequired,
        sponsors: sponsors ?? this.sponsors,
        activeSections: activeSections ?? this.activeSections,
        numberOfKeywords: numberOfKeywords ?? this.numberOfKeywords,
        zonesUpdateRequired: zonesUpdateRequired ?? this.zonesUpdateRequired,
        activeCountries: activeCountries ?? this.activeCountries,
    );
}
/// --------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keywordsChainVersion': keywordsChainVersion,
      'specsChainVersion': specsChainVersion,
      'phrasesVersion': phrasesVersion,

      'appUpdateRequired': appUpdateRequired,
      'languageUpdateRequired': languageUpdateRequired,
      'termsUpdateRequired': termsUpdateRequired,
      'aboutBldrsUpdateRequired': aboutBldrsUpdateRequired,
      'notificationsUpdateRequired': notificationsUpdateRequired,
      'sponsors': sponsors,
      'activeSections': cipherFlyersTypes(activeSections),
      'numberOfKeywords': numberOfKeywords,
      'zonesUpdateRequired': zonesUpdateRequired,
      'activeCountries' : activeCountries,
    };
  }
// -----------------------------------------------------------------------------
  static AppState fromMap(Map<String, dynamic> map) {
    return AppState(
      keywordsChainVersion: map['keywordsChainVersion'],
      specsChainVersion: map['specsChainVersion'],
      phrasesVersion: map['phrasesVersion'],

      appUpdateRequired: map['appUpdateRequired'],
      languageUpdateRequired: map['languageUpdateRequired'],
      termsUpdateRequired: map['termsUpdateRequired'],
      aboutBldrsUpdateRequired: map['aboutBldrsUpdateRequired'],
      notificationsUpdateRequired: map['notificationsUpdateRequired'],
      sponsors: Mapper.getStringsFromDynamics(dynamics: map['sponsors']),
      activeSections: decipherFlyersTypes(map['activeSections']),
      numberOfKeywords: map['numberOfKeywords'],
      zonesUpdateRequired: map['zonesUpdateRequired'],
      activeCountries: Mapper.getStringsFromDynamics(dynamics: map['activeCountries']),
    );
  }

// -----------------------------------------------------------------------------
  /// no sponsors and no updates required
  static AppState initialState() {
    return AppState(
      keywordsChainVersion: null,
      specsChainVersion: null,
      phrasesVersion: null,

      appUpdateRequired: false,
      languageUpdateRequired: false,
      termsUpdateRequired: false,
      aboutBldrsUpdateRequired: false,
      notificationsUpdateRequired: false,
      sponsors: <String>[],
      activeSections: <FlyerType>[],
      numberOfKeywords: 0,
      zonesUpdateRequired: false,
      activeCountries: ['egy'],
    );
  }
// -----------------------------------------------------------------------------
}
