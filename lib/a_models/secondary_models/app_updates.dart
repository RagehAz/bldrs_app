import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';

class AppState {
  /// --------------------------------------------------------------------------
  AppState({
    @required this.appUpdateRequired,
    @required this.wordzUpdateRequired,
    @required this.languageUpdateRequired,
    @required this.termsUpdateRequired,
    @required this.aboutBldrsUpdateRequired,
    @required this.notificationsUpdateRequired,
    @required this.sponsors,
    @required this.activeSections,
    @required this.keywordsUpdateRequired,
    @required this.numberOfKeywords,
    @required this.zonesUpdateRequired,
  });
  /// --------------------------------------------------------------------------
  /// app update
  final bool appUpdateRequired;

  /// translations
  final bool wordzUpdateRequired;
  final bool languageUpdateRequired;

  /// literature
  final bool termsUpdateRequired;
  final bool aboutBldrsUpdateRequired;

  /// notifications
  final bool notificationsUpdateRequired;

  /// sponsors
  final List<String> sponsors;

  /// keywords
  final List<FlyerType> activeSections;
  final bool keywordsUpdateRequired;
  final int numberOfKeywords;

  /// zones
  final bool zonesUpdateRequired;

  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appUpdateRequired': appUpdateRequired,
      'wordzUpdateRequired': wordzUpdateRequired,
      'languageUpdateRequired': languageUpdateRequired,
      'termsUpdateRequired': termsUpdateRequired,
      'aboutBldrsUpdateRequired': aboutBldrsUpdateRequired,
      'notificationsUpdateRequired': notificationsUpdateRequired,
      'sponsors': sponsors,
      'activeSections': cipherFlyersTypes(activeSections),
      'keywordsUpdateRequired': keywordsUpdateRequired,
      'numberOfKeywords': numberOfKeywords,
      'zonesUpdateRequired': zonesUpdateRequired,
    };
  }

// -----------------------------------------------------------------------------
  static AppState fromMap(Map<String, dynamic> map) {
    return AppState(
      appUpdateRequired: map['appUpdateRequired'],
      wordzUpdateRequired: map['wordzUpdateRequired'],
      languageUpdateRequired: map['languageUpdateRequired'],
      termsUpdateRequired: map['termsUpdateRequired'],
      aboutBldrsUpdateRequired: map['aboutBldrsUpdateRequired'],
      notificationsUpdateRequired: map['notificationsUpdateRequired'],
      sponsors: Mapper.getStringsFromDynamics(dynamics: map['sponsors']),
      activeSections: decipherFlyersTypes(map['activeSections']),
      keywordsUpdateRequired: map['keywordsUpdateRequired'],
      numberOfKeywords: map['numberOfKeywords'],
      zonesUpdateRequired: map['zonesUpdateRequired'],
    );
  }

// -----------------------------------------------------------------------------
  /// no sponsors and no updates required
  static AppState initialState() {
    return AppState(
      appUpdateRequired: false,
      wordzUpdateRequired: false,
      languageUpdateRequired: false,
      termsUpdateRequired: false,
      aboutBldrsUpdateRequired: false,
      notificationsUpdateRequired: false,
      sponsors: <String>[],
      activeSections: <FlyerType>[],
      keywordsUpdateRequired: false,
      numberOfKeywords: 0,
      zonesUpdateRequired: false,
    );
  }
// -----------------------------------------------------------------------------
}
