import 'package:flutter/material.dart';

class AppState {
  final bool appUpdateRequired;
  final bool keywordsUpdateRequired;
  final bool wordzUpdateRequired;
  final bool zonesUpdateRequired;
  final bool languageUpdateRequired;
  final bool sectionsUpdateRequired; // sequences and groups
  final bool termsUpdateRequired;
  final bool aboutBldrsUpdateRequired;
  final bool notificationsUpdateRequired;
  List<String> sponsors;

  AppState({
    @required this.appUpdateRequired,
    @required this.keywordsUpdateRequired,
    @required this.wordzUpdateRequired,
    @required this.zonesUpdateRequired,
    @required this.languageUpdateRequired,
    @required this.sectionsUpdateRequired,
    @required this.termsUpdateRequired,
    @required this.aboutBldrsUpdateRequired,
    @required this.notificationsUpdateRequired,
    @required this.sponsors,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return
      {
        'appUpdateRequired' : appUpdateRequired,
        'keywordsUpdateRequired' : keywordsUpdateRequired,
        'wordzUpdateRequired' : wordzUpdateRequired,
        'zonesUpdateRequired' : zonesUpdateRequired,
        'languageUpdateRequired' : languageUpdateRequired,
        'sectionsUpdateRequired' : sectionsUpdateRequired,
        'termsUpdateRequired' : termsUpdateRequired,
        'aboutBldrsUpdateRequired' : aboutBldrsUpdateRequired,
        'notificationsUpdateRequired' : notificationsUpdateRequired,
        'sponsors' : sponsors,
      };
  }
// -----------------------------------------------------------------------------
  static AppState fromMap(Map<String, dynamic> map){
    return
      AppState(
        appUpdateRequired : map['appUpdateRequired'],
        keywordsUpdateRequired : map['keywordsUpdateRequired'],
        wordzUpdateRequired : map['wordzUpdateRequired'],
        zonesUpdateRequired : map['zonesUpdateRequired'],
        languageUpdateRequired : map['languageUpdateRequired'],
        sectionsUpdateRequired : map['sectionsUpdateRequired'],
        termsUpdateRequired : map['termsUpdateRequired'],
        aboutBldrsUpdateRequired : map['aboutBldrsUpdateRequired'],
        notificationsUpdateRequired : map['notificationsUpdateRequired'],
        sponsors : map['sponsors'],
      );
  }
// -----------------------------------------------------------------------------
  /// no sponsors and no updates required
  static AppState initialState(){
    return
      AppState(
          appUpdateRequired : false,
          keywordsUpdateRequired : false,
          wordzUpdateRequired : false,
          zonesUpdateRequired : false,
          languageUpdateRequired : false,
          sectionsUpdateRequired : false,
          termsUpdateRequired : false,
          aboutBldrsUpdateRequired : false,
          notificationsUpdateRequired : false,
          sponsors : <String>[],
      );
  }
// -----------------------------------------------------------------------------
}