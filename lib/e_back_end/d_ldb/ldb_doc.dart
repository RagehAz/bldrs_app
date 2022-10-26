
class LDBDoc {
  // -----------------------------------------------------------------------------

  const LDBDoc();

  // -----------------------------------------------------------------------------

  /// PRIMARY KEYS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getPrimaryKey(String docName) {
    switch (docName) {
      case LDBDoc.flyers: return 'id';
      case LDBDoc.bzz: return 'id';
      case LDBDoc.users: return 'id';
      case LDBDoc.bldrsChains: return 'id';
      case LDBDoc.countries: return 'id';
      case LDBDoc.cities: return 'cityID';
      case LDBDoc.continents: return 'name';
      case LDBDoc.currencies: return 'id';
      case LDBDoc.mainPhrases: return 'id';
      case LDBDoc.countriesPhrases: return 'id';
      case LDBDoc.appState: return 'id';
      case LDBDoc.appControls: return 'primaryKey'; /// TASK : WTF
      case LDBDoc.authModel: return 'uid';
      case LDBDoc.notes: return 'id';
      case LDBDoc.pickers: return 'id';

      case LDBDoc.userEditor: return 'id';
      case LDBDoc.bzEditor: return 'id';
      case LDBDoc.authorEditor: return 'userID';
      case LDBDoc.flyerMaker: return 'id';
      case LDBDoc.reviewEditor: return 'id';

      case LDBDoc.theLastWipe: return 'id';
      case 'test': return 'id';
      default: return 'id';
    }
  }
  // -----------------------------------------------------------------------------

  /// DOCS

  // --------------------
  static const String flyers = 'flyers';
  static const String bzz = 'bzz';
  static const String users = 'users';

  static const String bldrsChains = 'chains';
  static const String pickers = 'pickers';

  static const String countries = 'countries';
  static const String cities = 'cities';
  static const String continents = 'continents';
  static const String currencies = 'currencies';
  static const String notes = 'notes';

  /// all docs include mixed lang phrases with extra primary key of "id_langCodo"
  static const String mainPhrases = 'mainPhrases';
  static const String countriesPhrases = 'countriesPhrases';

  static const String appState = 'appState';
  static const String appControls = 'appControls';
  static const String authModel = 'authModel';

  static const String userEditor = 'userEditor';
  static const String bzEditor = 'bzEditor';
  static const String authorEditor = 'authorEditor';
  static const String flyerMaker = 'flyerMaker';
  static const String reviewEditor = 'reviewEditor';

  static const String theLastWipe = 'theLastWipe';
  // -----------------------------------------------------------------------------

  /// ALL DOCS LIST

  // --------------------
  static const List<String> allDocs = <String>[
    flyers,
    bzz,
    users,
    bldrsChains,
    pickers,
    countries,
    cities,
    continents,
    currencies,
    notes,
    mainPhrases,
    countriesPhrases,
    appState,
    appControls,
    authModel,

    userEditor,
    bzEditor,
    authorEditor,
    flyerMaker,
    reviewEditor,

    theLastWipe,
  ];
// -----------------------------------------------------------------------------
}
