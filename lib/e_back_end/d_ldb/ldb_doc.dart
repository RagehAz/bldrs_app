// ignore_for_file: always_put_control_body_on_new_line
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/c_protocols/phrase_protocols/keywords_phrases_protocols/keywords_phrases_ldb_ops.dart';

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

  /// DOCS

  // --------------------
  /// MAIN
  static const String flyers = 'flyers';
  static const String bzz = 'bzz';
  static const String notes = 'notes';
  static const String media = 'media';
  static const String pdfs = 'pdfs';
  // --------------------
  /// USER
  static const String users = 'users';
  static const String authModel = 'authModel';
  static const String accounts = 'accounts';
  static const String searches = 'searches';
  // --------------------
  /// CHAINS
  static const String keywords = 'keywords';
  static const String zonePhids = 'zonePhids';
  // --------------------
  /// ZONES
  static const String countries = 'countries';
  static const String cities = 'cities';
  static const String staging = 'staging';
  static const String census = 'census';
  // --------------------
  /// PHRASES
  // all docs include mixed lang phrases with extra primary key of "id_langCode"
  // static const String mainPhrases = 'mainPhrases';

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
  // static const String appState = 'appState';
  // static const String theLastWipe = 'theLastWipe';
  static const String langCode = 'langCode';
  // static const String langMaps = 'langMaps';
  static const String onboarding = 'onboarding';
  // --------------------
  /// DASHBOARD
  static const String gta = 'gta';
  static const String webpages = 'webpages';
  static const String noteCampaigns = 'noteCampaigns';
  // --------------------
  /// COUNTERS
  static const String bzzCounters = 'bzzCounters';
  static const String flyersCounters = 'flyersCounters';
  static const String usersCounters = 'usersCounters';
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
      case LDBDoc.media: return 'id';
      case LDBDoc.pdfs: return 'path';
      // -------------
      /// USER
      case LDBDoc.users: return 'id';
      case LDBDoc.authModel: return 'id';
      case LDBDoc.accounts: return 'id';
      case LDBDoc.searches: return 'id';
      // -------------
      /// ZONES
      case LDBDoc.countries: return 'id';
      case LDBDoc.cities: return 'cityID';
      case LDBDoc.staging: return 'id';
      case LDBDoc.census: return 'id';
      // -------------
      /// PHRASES
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
      // case LDBDoc.theLastWipe: return 'id';
      // case LDBDoc.appState: return 'id';
      case LDBDoc.langCode: return 'id';
      // case LDBDoc.langMaps: return 'id';
      case LDBDoc.onboarding: return 'id';
      case 'test': return 'id';

      /// DASHBOARD
      case LDBDoc.gta: return 'id';
      case LDBDoc.webpages: return 'id';
      case LDBDoc.noteCampaigns: return 'id';

      /// COUNTERS
      case LDBDoc.bzzCounters: return 'bzID';
      case LDBDoc.flyersCounters: return 'flyerID';
      case LDBDoc.usersCounters: return 'userID';
      // -------------
      default: return 'id';
    }
  }
  // -----------------------------------------------------------------------------

  /// ALL DOCS LIST

  // --------------------
  static const List<String> allDocs = <String>[
    'headline: Main',
    flyers,
    bzz,
    notes,
    media,
    pdfs,

    'headline :User',
    users,
    authModel,
    accounts,
    searches,

    'headline: Zones',
    countries,
    cities,
    staging,
    census,

    'headline: keywords',
    keywords,
    zonePhids,

    'headline: Phrases',
    countriesPhrases,

    'headline: Editors',
    userEditor,
    bzEditor,
    authorEditor,
    flyerMaker,
    reviewEditor,

    'headline: Settings',
    // theLastWipe,
    // appState,
    langCode,
    // langMaps,
    onboarding,

    'headline: Dashboard',
    gta,
    webpages,
    noteCampaigns,

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
    required bool media,
    required bool pdfs,
    required bool keywords,
    required bool zonePhids,
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
    required bool allKeywordsPhrasesInAllLangs,
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
    // required bool langMaps,
    required bool onboarding,
    /// DASHBOARD
    required bool gta,
    required bool webpages,
    required bool noteCampaigns,
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
    if (media == true) {_docs.add(LDBDoc.media);}
    if (pdfs == true) {_docs.add(LDBDoc.pdfs);}
    /// KEYWORDS
    if (keywords == true) {_docs.add(LDBDoc.keywords);}
    if (zonePhids == true) {_docs.add(LDBDoc.zonePhids);}
    /// USER
    if (users == true) {_docs.add(LDBDoc.users);}
    if (authModel == true) {_docs.add(LDBDoc.authModel);}
    if (accounts == true) {_docs.add(LDBDoc.accounts);}
    if (searches == true) {_docs.add(LDBDoc.searches);}
    /// CHAINS
    if (census == true) {_docs.add(LDBDoc.census);}
    /// ZONES
    if (countries == true) {_docs.add(LDBDoc.countries);}
    if (cities == true) {_docs.add(LDBDoc.cities);}
    if (staging == true) {_docs.add(LDBDoc.staging);}
    /// PHRASES
    if (allKeywordsPhrasesInAllLangs == true) {_docs.addAll(KeywordsPhrasesLDBOps.generateAllLDBDocsForHardReboot());}
    if (countriesPhrases == true) {_docs.add(LDBDoc.countriesPhrases);}
    /// EDITORS
    if (userEditor == true) {_docs.add(LDBDoc.userEditor);}
    if (bzEditor == true) {_docs.add(LDBDoc.bzEditor);}
    if (authorEditor == true) {_docs.add(LDBDoc.authorEditor);}
    if (flyerMaker == true) {_docs.add(LDBDoc.flyerMaker);}
    if (reviewEditor == true) {_docs.add(LDBDoc.reviewEditor);}
    /// SETTINGS
    // if (theLastWipe == true) {_docs.add(LDBDoc.theLastWipe);}
    // if (appState == true) {_docs.add(LDBDoc.appState);}
    if (langCode == true) {_docs.add(LDBDoc.langCode);}
    // if (langMaps == true) {_docs.add(LDBDoc.langMaps);}
    if (onboarding == true) {_docs.add(LDBDoc.onboarding);}
    /// DASHBOARD
    if (gta == true){_docs.add(LDBDoc.gta);}
    if (webpages == true){_docs.add(LDBDoc.webpages);}
    if (noteCampaigns == true){_docs.add(LDBDoc.noteCampaigns);}
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
  static Future<void> onLightRebootSystem() async {

    await wipeOutLDBDocs(
      /// TRUE
      flyers: true,
      bzz: true,
      notes: true,
      media: true,
      pdfs: true,
      users: true,
      pickers: true,
      countries: true,
      staging: true,
      census: true,
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
      allKeywordsPhrasesInAllLangs: false,
      keywords: false,
      zonePhids: true, // keda keda should be refreshed more often
      // langMaps: true, // yes, lets refresh the lang maps whenever user reboots
      userEditor: false,
      bzEditor: false,
      authorEditor: false,
      flyerMaker: false,
      reviewEditor: false,
      onboarding: false,
      theLastWipe: false,
      noteCampaigns: false, // keep them,, they are mine in dashboard
    );

  }
  // --------------------
  static Future<void> onHardRebootSystem() async {

    await wipeOutLDBDocs(
      flyers: true,
      bzz: true,
      notes: true,
      media: true,
      pdfs: true,
      users: true,
      pickers: true,
      countries: true,
      staging: true,
      census: true,
      allKeywordsPhrasesInAllLangs: true,
      keywords: true,
      zonePhids: true,
      appState: true,
      gta: true,
      webpages: true,
      noteCampaigns: true,
      cities: true,
      searches: true,
      bldrsChains: true,
      countriesPhrases: true,
      authModel: true,
      accounts: true,
      langCode: true,
      // langMaps: true,
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
