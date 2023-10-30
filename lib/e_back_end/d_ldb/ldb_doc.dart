// ignore_for_file: always_put_control_body_on_new_line
import 'package:basics/ldb/methods/ldb_ops.dart';

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
      case LDBDoc.authModel: return 'id';
      case LDBDoc.accounts: return 'id';
      case LDBDoc.searches: return 'id';
      // -------------
      /// CHAINS
      case LDBDoc.bldrsChains: return 'id';
      case LDBDoc.pickers: return 'id';
      // -------------
      /// ZONES
      case LDBDoc.countries: return 'id';
      case LDBDoc.cities: return 'cityID';
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
      case LDBDoc.langCode: return 'id';
      case LDBDoc.onboarding: return 'id';
      case 'test': return 'id';

      case LDBDoc.gta: return 'id';
      case LDBDoc.webpages: return 'id';

      /// COUNTERS
      case LDBDoc.bzzCounters: return 'bzID';
      case LDBDoc.flyersCounters: return 'flyerID';
      case LDBDoc.usersCounters: return 'userID';
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
  static const String searches = 'searches';
  // --------------------
  /// CHAINS
  static const String bldrsChains = 'chains';
  static const String pickers = 'pickers';
  // --------------------
  /// ZONES
  static const String countries = 'countries';
  static const String cities = 'cities';
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
  static const String theLastWipe = 'theLastWipe';
  static const String langCode = 'langCode';
  static const String onboarding = 'onboarding';
  // --------------------
  /// GTA
  static const String gta = 'gta';
  static const String webpages = 'webpages';
  // --------------------
  /// COUNTERS
  static const String bzzCounters = 'bzzCounters';
  static const String flyersCounters = 'flyersCounters';
  static const String usersCounters = 'usersCounters';
  // -----------------------------------------------------------------------------

  /// ALL DOCS LIST

  // --------------------
  static const List<String> allDocs = <String>[
    'headline: Main',
    flyers,
    bzz,
    notes,
    pics,
    pdfs,

    'headline :User',
    users,
    authModel,
    accounts,
    searches,

    'headline: Chains',
    bldrsChains,
    pickers,

    'headline: Zones',
    countries,
    cities,
    staging,
    census,

    'headline: Phrases',
    mainPhrases,
    countriesPhrases,

    'headline: Editors',
    userEditor,
    bzEditor,
    authorEditor,
    flyerMaker,
    reviewEditor,

    'headline: Settings',
    theLastWipe,
    appState,
    langCode,
    onboarding,

    'headline: Dashboard',
    gta,
    webpages,

    'headline: Counters',
    bzzCounters,
    flyersCounters,
    usersCounters,

  ];
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOutLDBDocs({
    /// MAIN
    required bool flyers,
    required bool bzz,
    required bool notes,
    required bool pics,
    required bool pdfs,
    /// USER
    required bool users,
    required bool authModel,
    required bool accounts,
    required bool searches,
    /// CHAINS
    required bool bldrsChains,
    required bool pickers,
    /// ZONES
    required bool countries,
    required bool cities,
    required bool staging,
    required bool census,
    /// PHRASES
    required bool mainPhrases,
    required bool countriesPhrases,
    /// EDITORS
    required bool userEditor,
    required bool bzEditor,
    required bool authorEditor,
    required bool flyerMaker,
    required bool reviewEditor,
    /// SETTINGS
    required bool theLastWipe,
    required bool appState,
    required bool langCode,
    required bool onboarding,
    /// DASHBOARD
    required bool gta,
    required bool webpages,
    /// COUNTERS
    required bool bzzCounters,
    required bool flyersCounters,
    required bool usersCounters,
  }) async {

    final List<String> _docs = <String>[];

    /// MAIN
    if (flyers == true) {_docs.add(LDBDoc.flyers);}
    if (bzz == true) {_docs.add(LDBDoc.bzz);}
    if (notes == true) {_docs.add(LDBDoc.notes);}
    if (pics == true) {_docs.add(LDBDoc.pics);}
    if (pdfs == true) {_docs.add(LDBDoc.pdfs);}
    /// USER
    if (users == true) {_docs.add(LDBDoc.users);}
    if (authModel == true) {_docs.add(LDBDoc.authModel);}
    if (accounts == true) {_docs.add(LDBDoc.accounts);}
    if (searches == true) {_docs.add(LDBDoc.searches);}
    /// CHAINS
    if (bldrsChains == true) {_docs.add(LDBDoc.bldrsChains);}
    if (pickers == true) {_docs.add(LDBDoc.pickers);}
    if (census == true) {_docs.add(LDBDoc.census);}
    /// ZONES
    if (countries == true) {_docs.add(LDBDoc.countries);}
    if (cities == true) {_docs.add(LDBDoc.cities);}
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
    if (langCode == true) {_docs.add(LDBDoc.langCode);}
    if (onboarding == true) {_docs.add(LDBDoc.onboarding);}
    /// DASHBOARD
    if (gta == true){_docs.add(LDBDoc.gta);}
    if (webpages == true){_docs.add(LDBDoc.webpages);}
    /// COUNTERS
    if (bzzCounters == true){_docs.add(LDBDoc.bzzCounters);}
    if (flyersCounters == true){_docs.add(LDBDoc.flyersCounters);}
    if (usersCounters == true){_docs.add(LDBDoc.usersCounters);}

    await Future.wait(<Future>[
      ...List.generate(_docs.length, (index){
        return LDBOps.deleteAllMapsAtOnce(
            docName: _docs[index],
        );
      }),
    ]);

  }
  // --------------------
  static Future<void> mindfulWipeOfEntireLDB() async {

    await wipeOutLDBDocs(
      /// TRUE
      flyers: true,
      bzz: true,
      notes: true,
      pics: true,
      pdfs: true,
      users: true,
      pickers: true,
      countries: true,
      staging: true,
      census: true,
      mainPhrases: true,
      appState: true,
      gta: true,
      webpages: true,
      cities: true,
      searches: true,
      bldrsChains: true,
      countriesPhrases: true,
      bzzCounters: true, // yes this i super temp to stay anyways
      flyersCounters: true, // yes this i super temp to stay anyways
      usersCounters: true,  // yes this i super temp to stay anyways
      /// FALSE
      authModel: false,
      accounts: false,
      langCode: false, // lets always keep user language for life
      userEditor: false,
      bzEditor: false,
      authorEditor: false,
      flyerMaker: false,
      reviewEditor: false,
      onboarding: false,
      theLastWipe: false,
    );

  }
  // --------------------
  static Future<void> superWipeOfEntireLDB() async {

    await wipeOutLDBDocs(
      flyers: true,
      bzz: true,
      notes: true,
      pics: true,
      pdfs: true,
      users: true,
      pickers: true,
      countries: true,
      staging: true,
      census: true,
      mainPhrases: true,
      appState: true,
      gta: true,
      webpages: true,
      cities: true,
      searches: true,
      bldrsChains: true,
      countriesPhrases: true,
      authModel: true,
      accounts: true,
      langCode: true,
      userEditor: true,
      bzEditor: true,
      authorEditor: true,
      flyerMaker: true,
      reviewEditor: true,
      onboarding: true,
      theLastWipe: true,
      bzzCounters: true,
      flyersCounters: true,
      usersCounters: true,
    );

  }
  // -----------------------------------------------------------------------------
}
