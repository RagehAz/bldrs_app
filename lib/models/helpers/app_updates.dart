import 'package:flutter/material.dart';

class AppState {
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
  final bool sectionsUpdateRequired; // sequences and groups
  final bool keywordsUpdateRequired;
  final int numberOfKeywords;

  /// zones
  final bool zonesUpdateRequired;

  AppState({
    @required this.appUpdateRequired,
    @required this.wordzUpdateRequired,
    @required this.languageUpdateRequired,
    @required this.termsUpdateRequired,
    @required this.aboutBldrsUpdateRequired,
    @required this.notificationsUpdateRequired,
    @required this.sponsors,
    @required this.sectionsUpdateRequired,
    @required this.keywordsUpdateRequired,
    @required this.numberOfKeywords,
    @required this.zonesUpdateRequired,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return
      {
        'appUpdateRequired' : appUpdateRequired,

        'wordzUpdateRequired' : wordzUpdateRequired,
        'languageUpdateRequired' : languageUpdateRequired,

        'termsUpdateRequired' : termsUpdateRequired,
        'aboutBldrsUpdateRequired' : aboutBldrsUpdateRequired,

        'notificationsUpdateRequired' : notificationsUpdateRequired,

        'sponsors' : sponsors,

        'sectionsUpdateRequired' : sectionsUpdateRequired,
        'keywordsUpdateRequired' : keywordsUpdateRequired,
        'numberOfKeywords' : numberOfKeywords,

        'zonesUpdateRequired' : zonesUpdateRequired,
      };
  }
// -----------------------------------------------------------------------------
  static AppState fromMap(Map<String, dynamic> map){
    return
      AppState(
        appUpdateRequired : map['appUpdateRequired'],

        wordzUpdateRequired : map['wordzUpdateRequired'],
        languageUpdateRequired : map['languageUpdateRequired'],

        termsUpdateRequired : map['termsUpdateRequired'],
        aboutBldrsUpdateRequired : map['aboutBldrsUpdateRequired'],

        notificationsUpdateRequired : map['notificationsUpdateRequired'],

        sponsors : map['sponsors'],

        sectionsUpdateRequired : map['sectionsUpdateRequired'],
        keywordsUpdateRequired : map['keywordsUpdateRequired'],
        numberOfKeywords: map['numberOfKeywords'],

        zonesUpdateRequired : map['zonesUpdateRequired'],
      );
  }
// -----------------------------------------------------------------------------
  /// no sponsors and no updates required
  static AppState initialState(){
    return
      AppState(
        appUpdateRequired : false,

        wordzUpdateRequired : false,
        languageUpdateRequired : false,

        termsUpdateRequired : false,
        aboutBldrsUpdateRequired : false,

        notificationsUpdateRequired : false,
        sponsors : <String>[],

        sectionsUpdateRequired : false,
        keywordsUpdateRequired : false,
        numberOfKeywords: 0,

        zonesUpdateRequired : false,
      );
  }
// -----------------------------------------------------------------------------
}