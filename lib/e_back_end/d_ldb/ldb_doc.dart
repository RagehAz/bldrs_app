
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';

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
      case LDBDoc.users: return 'id';
      case LDBDoc.authModel: return 'uid';
      case LDBDoc.notes: return 'id';
      case LDBDoc.pics: return 'path';
      case LDBDoc.pdfs: return 'path';
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
  static const String users = 'users';
  static const String authModel = 'authModel';
  static const String notes = 'notes';
  static const String pics = 'pics';
  static const String pdfs = 'pdfs';
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
  // -----------------------------------------------------------------------------

  /// ALL DOCS LIST

  // --------------------
  static const List<dynamic> allDocs = <dynamic>[
    Verse(text: 'Main', translate: false),
    flyers,
    bzz,
    users,
    authModel,
    notes,
    pics,
    pdfs,

    Verse(text: 'Chains', translate: false),
    bldrsChains,
    pickers,

    Verse(text: 'Zones', translate: false),
    countries,
    cities,
    districts,
    staging,

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

  ];
// -----------------------------------------------------------------------------
}
