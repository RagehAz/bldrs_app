
class LDBDoc {

  static const String follows = 'follows';
  static const String calls = 'calls';
  static const String shares = 'shares';
  static const String views = 'views';
  static const String saves = 'saves';
  static const String reviews = 'reviews';
  static const String questions = 'questions';
  static const String answers = 'answers';
  static const String searches = 'searches';
  static const String flyers = 'flyers';
  static const String bzz = 'bzz';
  static const String users = 'users';

  static const String bigChainK = 'bigChainK';
  static const String bigChainS = 'bigChainS';
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

  static const List<String> allDocs = <String>[
    follows,
    calls,
    shares,
    views,
    saves,
    reviews,
    questions,
    answers,
    searches,
    flyers,
    bzz,
    users,
    bigChainK,
    bigChainS,
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
  ];

}
