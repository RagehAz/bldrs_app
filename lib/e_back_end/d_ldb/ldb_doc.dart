// ignore_for_file: always_put_control_body_on_new_line
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header_vm.dart';
import 'package:ldb/ldb.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';

/*

WHEN YOU ADD NEW LDB DOC

1. add ldbDoc name as static const String in below (DOCS) section
2. add in getPrimaryKey()
3. add in <String>[allDocs]
4. add in LDBOps.wipeOutEntireLDB()
          &
          logo_screen_controller._dailyRefreshLDB()
          &
          logo_screen_controller._refreshUserDeviceModel()

 */

class LDBDoc {
  // -----------------------------------------------------------------------------

  const LDBDoc();

  // -----------------------------------------------------------------------------

  /// PRIMARY KEYS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getPrimaryKey(String docName) {
    switch (docName) {
      // -------------
      /// MAIN
      case LDBDoc.flyers: return 'id';
      case LDBDoc.bzz: return 'id';
      case LDBDoc.notes: return 'id';
      case LDBDoc.pics: return 'path';
      case LDBDoc.pdfs: return 'path';
      // -------------
      /// USER
      case LDBDoc.users: return 'id';
      case LDBDoc.authModel: return 'uid';
      case LDBDoc.accounts: return 'id';
      // -------------
      /// CHAINS
      case LDBDoc.bldrsChains: return 'id';
      case LDBDoc.pickers: return 'id';
      // -------------
      /// ZONES
      case LDBDoc.countries: return 'id';
      case LDBDoc.cities: return 'cityID';
      case LDBDoc.districts: return 'id';
      case LDBDoc.staging: return 'id';
      case LDBDoc.census: return 'id';
    // -------------
      /// PHRASES
      case LDBDoc.mainPhrases: return 'id';
      case LDBDoc.countriesPhrases: return 'id';
      // -------------
      /// EDITORS
      case LDBDoc.userEditor: return 'id';
      case LDBDoc.bzEditor: return 'id';
      case LDBDoc.authorEditor: return 'userID';
      case LDBDoc.flyerMaker: return 'id';
      case LDBDoc.reviewEditor: return 'id';
      // -------------
      /// SETTINGS
      case LDBDoc.theLastWipe: return 'id';
      case LDBDoc.appState: return 'id';
      case LDBDoc.appControls: return 'id';
      case LDBDoc.langCode: return 'id';
      case 'test': return 'id';
      // -------------
      default: return 'id';
    }
  }
  // -----------------------------------------------------------------------------

  /// DOCS

  // --------------------
  /// MAIN
  static const String flyers = 'flyers';
  static const String bzz = 'bzz';
  static const String notes = 'notes';
  static const String pics = 'pics';
  static const String pdfs = 'pdfs';
  // --------------------
  /// USER
  static const String users = 'users';
  static const String authModel = 'authModel';
  static const String accounts = 'accounts';
  // --------------------
  /// CHAINS
  static const String bldrsChains = 'chains';
  static const String pickers = 'pickers';
  // --------------------
  /// ZONES
  static const String countries = 'countries';
  static const String cities = 'cities';
  static const String districts = 'districts';
  static const String staging = 'staging';
  static const String census = 'census';
  // --------------------
  /// PHRASES
  // all docs include mixed lang phrases with extra primary key of "id_langCodo"
  static const String mainPhrases = 'mainPhrases';
  static const String countriesPhrases = 'countriesPhrases';
  // --------------------
  /// EDITORS
  static const String userEditor = 'userEditor';
  static const String bzEditor = 'bzEditor';
  static const String authorEditor = 'authorEditor';
  static const String flyerMaker = 'flyerMaker';
  static const String reviewEditor = 'reviewEditor';
  // --------------------
  /// SETTINGS
  static const String appState = 'appState';
  static const String appControls = 'appControls';
  static const String theLastWipe = 'theLastWipe';
  static const String langCode = 'langCode';
  // -----------------------------------------------------------------------------

  /// ALL DOCS LIST

  // --------------------
  static const List<dynamic> allDocs = <dynamic>[
    Verse(text: 'Main', translate: false),
    flyers,
    bzz,
    notes,
    pics,
    pdfs,

    Verse(text: 'User', translate: false),
    users,
    authModel,
    accounts,

    Verse(text: 'Chains', translate: false),
    bldrsChains,
    pickers,

    Verse(text: 'Zones', translate: false),
    countries,
    cities,
    districts,
    staging,
    census,

    Verse(text: 'Phrases', translate: false),
    mainPhrases,
    countriesPhrases,

    Verse(text: 'Editors', translate: false),
    userEditor,
    bzEditor,
    authorEditor,
    flyerMaker,
    reviewEditor,

    Verse(text: 'Settings', translate: false),
    theLastWipe,
    appState,
    appControls,
    langCode,

  ];
  // -----------------------------------------------------------------------------

  /// LDB REFRESH - DAILY WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkShouldRefreshLDB(BuildContext context) async {
    bool _shouldRefresh = true;

    /// NOTE : if did not find last wipe dateTime => will wipe
    /// if found and its more than {24 hours} => will wipe
    /// if found and its less than {24 hours} => will not wipe

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: ['theLastWipeMap'],
      docName: LDBDoc.theLastWipe,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.theLastWipe),
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      final DateTime _lastWipe = Timers.decipherTime(
          time: _maps.first['time'],
          fromJSON: true,
      );

      double _diff = Timers.calculateTimeDifferenceInHours(
          from: _lastWipe,
          to: DateTime.now(),
      )?.toDouble();

      _diff = Numeric.modulus(_diff);

      // blog('checkShouldRefreshLDB : _diff : $_diff < ${Standards.dailyLDBWipeIntervalInHours} hrs = ${_diff < Standards.dailyLDBWipeIntervalInHours}');

      /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
      if (_diff != null && _diff < Standards.dailyLDBWipeIntervalInHours){
        _shouldRefresh = false;
      }

    }

    await LDBOps.insertMap(
      // allowDuplicateIDs: false,
      docName: LDBDoc.theLastWipe,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.theLastWipe),
      input: {
        'id': 'theLastWipeMap',
        'time': Timers.cipherTime(time: DateTime.now(), toJSON: true),
      },
    );

    return _shouldRefresh;
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOutEntireLDB({
    /// MAIN
    bool flyers = true,
    bool bzz = true,
    bool notes = true,
    bool pics = true,
    bool pdfs = true,
    /// USER
    bool users = true,
    bool authModel = true,
    bool accounts = true,
    /// CHAINS
    bool bldrsChains = true,
    bool pickers = true,
    /// ZONES
    bool countries = true,
    bool cities = true,
    bool districts = true,
    bool staging = true,
    bool census = true,
    /// PHRASES
    bool mainPhrases = true,
    bool countriesPhrases = true,
    /// EDITORS
    bool userEditor = true,
    bool bzEditor = true,
    bool authorEditor = true,
    bool flyerMaker = true,
    bool reviewEditor = true,
    /// SETTINGS
    bool theLastWipe = true,
    bool appState = true,
    bool appControls = true,
    bool langCode = true,
  }) async {

    final List<String> _docs = <String>[];

    /// MAIN
    if (flyers == true) {_docs.add(LDBDoc.flyers);}
    if (bzz == true) {_docs.add(LDBDoc.bzz);}
    if (notes == true) {_docs.add(LDBDoc.notes);}
    if (pics == true) {_docs.add(LDBDoc.pics);}
    if (pdfs == true) {_docs.add(LDBDoc.pdfs);}
    /// MAIN
    if (users == true) {_docs.add(LDBDoc.users);}
    if (authModel == true) {_docs.add(LDBDoc.authModel);}
    if (accounts == true) {_docs.add(LDBDoc.accounts);}
    /// CHAINS
    if (bldrsChains == true) {_docs.add(LDBDoc.bldrsChains);}
    if (pickers == true) {_docs.add(LDBDoc.pickers);}
    if (census == true) {_docs.add(LDBDoc.census);}
    /// ZONES
    if (countries == true) {_docs.add(LDBDoc.countries);}
    if (cities == true) {_docs.add(LDBDoc.cities);}
    if (districts == true) {_docs.add(LDBDoc.districts);}
    if (staging == true) {_docs.add(LDBDoc.staging);}
    /// PHRASES
    if (mainPhrases == true) {_docs.add(LDBDoc.mainPhrases);}
    if (countriesPhrases == true) {_docs.add(LDBDoc.countriesPhrases);}
    /// EDITORS
    if (userEditor == true) {_docs.add(LDBDoc.userEditor);}
    if (bzEditor == true) {_docs.add(LDBDoc.bzEditor);}
    if (authorEditor == true) {_docs.add(LDBDoc.authorEditor);}
    if (flyerMaker == true) {_docs.add(LDBDoc.flyerMaker);}
    if (reviewEditor == true) {_docs.add(LDBDoc.reviewEditor);}
    /// SETTINGS
    if (theLastWipe == true) {_docs.add(LDBDoc.theLastWipe);}
    if (appState == true) {_docs.add(LDBDoc.appState);}
    if (appControls == true) {_docs.add(LDBDoc.appControls);}
    if (langCode == true) {_docs.add(LDBDoc.langCode);}

    await Future.wait(<Future>[
      ...List.generate(_docs.length, (index){
        return LDBOps.deleteAllMapsAtOnce(
            docName: _docs[index],
        );
      }),
    ]);

  }
  // -----------------------------------------------------------------------------
  void f(){}
}
