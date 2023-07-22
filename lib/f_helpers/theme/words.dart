import 'package:bldrs/f_helpers/localization/localizer.dart';

class Words {
  // -----------------------------------------------------------------------------

  const Words();

  // -----------------------------------------------------------------------------
  static String allahoAkbar () => Localizer.translate('allahoAkbar')!;
  static String activeLanguage () => Localizer.translate('activeLanguage')!;
  static String textDirection () => Localizer.translate('textDirection')!;
  static String headlineFont () => Localizer.translate('headlineFont')!;
  static String bodyFont () => Localizer.translate('bodyFont')!;
  static String languageName () => Localizer.translate('languageName')!;
  static String languageCode () => Localizer.translate('languageCode')!;
  static String bldrsFullName () => Localizer.translate('bldrsFullName')!;
  static String bldrsShortName () => Localizer.translate('bldrsShortName')!;
  static String bldrsTagLine () => Localizer.translate('bldrsTagLine')!;
  static String bldrsDescription () => Localizer.translate('bldrsDescription')!;
  static String loading () => Localizer.translate('loading')!;
  static String connected() => Localizer.translate('connected')!;
  static String disconnected() => Localizer.translate('disconnected')!;
  static String checkYourInternetConnection() => Localizer.translate('checkYourInternetConnection')!;
  static String newUpdateAvailable () => Localizer.translate('newUpdateAvailable')!;
  static String pleaseUpdateToContinue () => Localizer.translate('pleaseUpdateToContinue')!;
  static String updateApp () => Localizer.translate('updateApp')!;
  static String bldrsUnderConstruction () => Localizer.translate('bldrsUnderConstruction')!;
  static String somethingWentWrong () => Localizer.translate('somethingWentWrong')!;
  static String bldrsWillRestart () => Localizer.translate('bldrsWillRestart')!;
  static String no() => Localizer.translate('no')!;
  static String yes() => Localizer.translate('yes')!;
  static String ok() => Localizer.translate('ok')!;
  static String changeLanguage() => Localizer.translate('changeLanguage')!;

  // -----------------------------------------------------------------------------
  static String pleaseWait(){

    final String _langCode = Localizer.getCurrentLangCode();

    if (_langCode == 'ar'){
      return 'من فضلك انتظر';
    }
    else {
      return 'Please wait';
    }

  }

  static String thisIsBabyApp(){

    final String _langCode = Localizer.getCurrentLangCode();

    if (_langCode == 'ar'){
      return '🤏 مازلت أقرأ البيانات، من فضلك أصبر قليلا';
    }
    else {
      return 'Still loading, please be patient 🤏';
    }

  }

  static String thankYouForWaiting(){

      final String _langCode = Localizer.getCurrentLangCode();

      if (_langCode == 'ar'){
        return 'شكرا لصبرك 💛';
      }
      else {
        return 'Thank you for waiting 💛';
      }

  }

}

// String xxx3 () => Localizer.translate('xxx3');
// String accountType () => Localizer.translate('accountType');
// String owner () => Localizer.translate('owner');
// String owners () => Localizer.translate('owners');
// String property () => Localizer.translate('property');
// String properties () => Localizer.translate('properties');
// String realtor () => Localizer.translate('realtor');
// String realtors () => Localizer.translate('realtors');
// String realEstateDeveloper () => Localizer.translate('realEstateDeveloper');
// String realEstateDevelopers () => Localizer.translate('realEstateDevelopers');
// String realEstateBroker () => Localizer.translate('realEstateBroker');
// String realEstateBrokers () => Localizer.translate('realEstateBrokers');
// String developer () => Localizer.translate('developer');
// String developers () => Localizer.translate('developers');
// String broker () => Localizer.translate('broker');
// String brokers () => Localizer.translate('brokers');
// String design () => Localizer.translate('design');
// String designs () => Localizer.translate('designs');
// String designer () => Localizer.translate('designer');
// String designers () => Localizer.translate('designers');
// String product () => Localizer.translate('product');
// String products () => Localizer.translate('products');
// String equipment () => Localizer.translate('equipment');
// String equipments () => Localizer.translate('equipments');
// String supplier () => Localizer.translate('supplier');
// String suppliers () => Localizer.translate('suppliers');
// String manufacturer () => Localizer.translate('manufacturer');
// String manufacturers () => Localizer.translate('manufacturers');
// String project () => Localizer.translate('project');
// String projects () => Localizer.translate('projects');
// String contractor () => Localizer.translate('contractor');
// String contractors () => Localizer.translate('contractors');
// String trade () => Localizer.translate('trade');
// String trades () => Localizer.translate('trades');
// String artisan () => Localizer.translate('artisan');
// String artisans () => Localizer.translate('artisans');
// String bldr () => Localizer.translate('bldr');
// String bldrs () => Localizer.translate('bldrs');
// String xxx4 () => Localizer.translate('xxx4');
// String propertiesDescription () => Localizer.translate('propertiesDescription');
// String designsDescription () => Localizer.translate('designsDescription');
// String productsDescription () => Localizer.translate('productsDescription');
// String projectsDescription () => Localizer.translate('projectsDescription');
// String tradesDescription () => Localizer.translate('tradesDescription');
// String equipmentDescription () => Localizer.translate('equipmentDescription');
// String xxx5 () => Localizer.translate('xxx5');
// String flyer () => Localizer.translate('flyer');
// String flyers () => Localizer.translate('flyers');
// String propertyFlyer () => Localizer.translate('propertyFlyer');
// String designFlyer () => Localizer.translate('designFlyer');
// String projectFlyer () => Localizer.translate('projectFlyer');
// String tradeFlyer () => Localizer.translate('tradeFlyer');
// String productFlyer () => Localizer.translate('productFlyer');
// String equipmentFlyer () => Localizer.translate('equipmentFlyer');
// String general () => Localizer.translate('general');
// String xxx6 () => Localizer.translate('xxx6');
// String createAccount () => Localizer.translate('createAccount');
// String signIn () => Localizer.translate('signIn');
// String signInExisting () => Localizer.translate('signInExisting');
// String register () => Localizer.translate('register');
// String continueApple () => Localizer.translate('continueApple');
// String continueFacebook () => Localizer.translate('continueFacebook');
// String continueLinkedIn () => Localizer.translate('continueLinkedIn');
// String continueEmail () => Localizer.translate('continueEmail');
// String skip () => Localizer.translate('skip');
// String emailAddress () => Localizer.translate('emailAddress');
// String password () => Localizer.translate('password');
// String confirmPassword () => Localizer.translate('confirmPassword');
// String min6Char () => Localizer.translate('min6Char');
// String xxx7 () => Localizer.translate('xxx7');
// String createBzAccount () => Localizer.translate('createBzAccount');
// String scopeOfServices () => Localizer.translate('scopeOfServices');
// String productTypes () => Localizer.translate('productTypes');
// String about () => Localizer.translate('about');
// String business () => Localizer.translate('business');
// String yourBusiness () => Localizer.translate('yourBusiness');
// String businesses () => Localizer.translate('businesses');
// String businessForm () => Localizer.translate('businessForm');
// String individual () => Localizer.translate('individual');
// String individuals () => Localizer.translate('individuals');
// String company () => Localizer.translate('company');
// String companies () => Localizer.translate('companies');
// String companyName () => Localizer.translate('companyName');
// String hqCity () => Localizer.translate('hqCity'); // موقع المقر الرئيسي
// String authorName () => Localizer.translate('authorName');
// String bldrsConnected () => Localizer.translate('bldrsConnected');
// String callsReceived () => Localizer.translate('callsReceived');
// String slidesPublished () => Localizer.translate('slidesPublished');
// String totalViews () => Localizer.translate('totalViews');
// String totalShares () => Localizer.translate('totalShares');
// String totalSaves () => Localizer.translate('totalSaves');
// String flyersPublishedBy () => Localizer.translate('flyersPublishedBy');
// String authorsTeam () => Localizer.translate('authorsTeam');
// String businessLogo () => Localizer.translate('businessLogo');
// String xxx8 () => Localizer.translate('xxx8');
// String publish () => Localizer.translate('publish');
// String published () => Localizer.translate('published');
// String keywordTag () => Localizer.translate('keywordTag');
// String flyerSlides () => Localizer.translate('flyerSlides');
// String follow () => Localizer.translate('follow');
// String following () => Localizer.translate('following');
// String followers () => Localizer.translate('followers');
// String inn () => Localizer.translate('inn');
// String view () => Localizer.translate('view');
// String views () => Localizer.translate('views');
// String viewed () => Localizer.translate('viewed');
// String send () => Localizer.translate('send');
// String sent () => Localizer.translate('sent');
// String save () => Localizer.translate('save');
// String saved () => Localizer.translate('saved');
// String call () => Localizer.translate('call');
// String createFlyer () => Localizer.translate('createFlyer');
// String publishFlyer () => Localizer.translate('publishFlyer');
// String saveDraft () => Localizer.translate('saveDraft');
// String xxx9 () => Localizer.translate('xxx9');
// String second () => Localizer.translate('second');
// String seconds () => Localizer.translate('seconds');
// String minute () => Localizer.translate('minute');
// String minutes () => Localizer.translate('minutes');
// String hour () => Localizer.translate('hour');
// String hours () => Localizer.translate('hours');
// String day () => Localizer.translate('day');
// String days () => Localizer.translate('days');
// String week () => Localizer.translate('week');
// String weeks () => Localizer.translate('weeks');
// String year () => Localizer.translate('year');
// String years () => Localizer.translate('years');
// String thousand () => Localizer.translate('thousand');
// String million () => Localizer.translate('million');
// String xxx10 () => Localizer.translate('xxx10');
// String collections () => Localizer.translate('collections');
// String savedFlyers () => Localizer.translate('savedFlyers');
// String profile () => Localizer.translate('profile');
// String news () => Localizer.translate('news');
// String more () => Localizer.translate('more');
// String contacts () => Localizer.translate('contacts');
// String inviteFriends () => Localizer.translate('inviteFriends');
// String inviteBusinesses () => Localizer.translate('inviteBusinesses');
// String changeCountry () => Localizer.translate('changeCountry');
// String feedback () => Localizer.translate('feedback');
// String termsRegulations () => Localizer.translate('termsRegulations');
// String advertiseOnBldrs () => Localizer.translate('advertiseOnBldrs');
// String whatIsFlyer () => Localizer.translate('whatIsFlyer');
// String whoAreBldrs () => Localizer.translate('whoAreBldrs');
// String howItWorks () => Localizer.translate('howItWorks');
// String signOut () => Localizer.translate('signOut');
// String editProfile () => Localizer.translate('editProfile');
// String updateProfile () => Localizer.translate('updateProfile');
// String name () => Localizer.translate('name');
// String enterName () => Localizer.translate('enterName');
// String jobTitle () => Localizer.translate('jobTitle');
// String enterJobTitle () => Localizer.translate('enterJobTitle');
// String enterCompanyName () => Localizer.translate('enterCompanyName');
// String selectCity () => Localizer.translate('selectCity');
// String phone () => Localizer.translate('phone');
// String website () => Localizer.translate('website');
// String facebookLink () => Localizer.translate('facebookLink');
// String instagramLink () => Localizer.translate('instagramLink');
// String linkedinLink () => Localizer.translate('linkedinLink');
// String youtubeChannel () => Localizer.translate('youtubeChannel');
// String tiktokLink () => Localizer.translate('tiktokLink');
// String pinterestLink () => Localizer.translate('pinterestLink');
// String xxx11 () => Localizer.translate('xxx11');
// String enterEmail () => Localizer.translate('enterEmail');
// String emailInvalid () => Localizer.translate('emailInvalid');
// String enterPassword () => Localizer.translate('enterPassword');
// String min6CharError () => Localizer.translate('min6CharError');
// String wrongPassword () => Localizer.translate('wrongPassword');
// String emailNotFound () => Localizer.translate('emailNotFound');
// String emailWrong () => Localizer.translate('emailWrong');
// String signInFailure () => Localizer.translate('signInFailure');
// String passwordMismatch () => Localizer.translate('passwordMismatch');
// String somethingIsWrong () => Localizer.translate('somethingIsWrong');
// String emailAlreadyRegistered () => Localizer.translate('emailAlreadyRegistered');
// String xxx12 () => Localizer.translate('xxx12');
// String section () => Localizer.translate('section');
// String sections () => Localizer.translate('sections');
// String choose () => Localizer.translate('choose');
// String realEstate () => Localizer.translate('realEstate');
// String realEstateTagLine () => Localizer.translate('realEstateTagLine');
// String construction () => Localizer.translate('construction');
// String constructionTagLine () => Localizer.translate('constructionTagLine');
// String supplies () => Localizer.translate('supplies');
// String suppliesTagLine () => Localizer.translate('suppliesTagLine');
// String search () => Localizer.translate('search');
// String language () => Localizer.translate('language');
// String country () => Localizer.translate('country');
// String chooseCountryTagline () => Localizer.translate('chooseCountryTagline');
// String city () => Localizer.translate('city');
// String xxx13 () => Localizer.translate('xxx13');
// String ask () => Localizer.translate('ask');
// String question () => Localizer.translate('question');
// String askHint () => Localizer.translate('askHint');
// String askInfo () => Localizer.translate('askInfo');
// String askConfirm () => Localizer.translate('askConfirm');
// String askConfirmHint () => Localizer.translate('askConfirmHint');
// String xxx14 () => Localizer.translate('xxx14');
// String confirm () => Localizer.translate('confirm');
// String cancel () => Localizer.translate('cancel');
// String paste () => Localizer.translate('paste');
// String xxx15 () => Localizer.translate('xxx15');
// String xxx16 () => Localizer.translate('xxx16');
// String january () => Localizer.translate('january');
// String february () => Localizer.translate('february');
// String march () => Localizer.translate('march');
// String april () => Localizer.translate('april');
// String may () => Localizer.translate('may');
// String june () => Localizer.translate('june');
// String july () => Localizer.translate('july');
// String august () => Localizer.translate('august');
// String september () => Localizer.translate('september');
// String october () => Localizer.translate('october');
// String november () => Localizer.translate('november');
// String december () => Localizer.translate('december');
// String xxxEND () => Localizer.translate('xxxEND');

// unicode_map = {
// // #           superscript     subscript
// '0'        : ('\u2070',   '\u2080'      ),
// '1'        : ('\u00B9',   '\u2081'      ),
// '2'        : ('\u00B2',   '\u2082'      ),
// '3'        : ('\u00B3',   '\u2083'      ),
// '4'        : ('\u2074',   '\u2084'      ),
// '5'        : ('\u2075',   '\u2085'      ),
// '6'        : ('\u2076',   '\u2086'      ),
// '7'        : ('\u2077',   '\u2087'      ),
// '8'        : ('\u2078',   '\u2088'      ),
// '9'        : ('\u2079',   '\u2089'      ),
// 'a'        : ('\u1d43',   '\u2090'      ),
// 'b'        : ('\u1d47',   '?'           ),
// 'c'        : ('\u1d9c',   '?'           ),
// 'd'        : ('\u1d48',   '?'           ),
// 'e'        : ('\u1d49',   '\u2091'      ),
// 'f'        : ('\u1da0',   '?'           ),
// 'g'        : ('\u1d4d',   '?'           ),
// 'h'        : ('\u02b0',   '\u2095'      ),
// 'i'        : ('\u2071',   '\u1d62'      ),
// 'j'        : ('\u02b2',   '\u2c7c'      ),
// 'k'        : ('\u1d4f',   '\u2096'      ),
// 'l'        : ('\u02e1',   '\u2097'      ),
// 'm'        : ('\u1d50',   '\u2098'      ),
// 'n'        : ('\u207f',   '\u2099'      ),
// 'o'        : ('\u1d52',   '\u2092'      ),
// 'p'        : ('\u1d56',   '\u209a'      ),
// 'q'        : ('?',        '?'           ),
// 'r'        : ('\u02b3',   '\u1d63'      ),
// 's'        : ('\u02e2',   '\u209b'      ),
// 't'        : ('\u1d57',   '\u209c'      ),
// 'u'        : ('\u1d58',   '\u1d64'      ),
// 'v'        : ('\u1d5b',   '\u1d65'      ),
// 'w'        : ('\u02b7',   '?'           ),
// 'x'        : ('\u02e3',   '\u2093'      ),
// 'y'        : ('\u02b8',   '?'           ),
// 'z'        : ('?',        '?'           ),
// 'A'        : ('\u1d2c',   '?'           ),
// 'B'        : ('\u1d2e',   '?'           ),
// 'C'        : ('?',        '?'           ),
// 'D'        : ('\u1d30',   '?'           ),
// 'E'        : ('\u1d31',   '?'           ),
// 'F'        : ('?',        '?'           ),
// 'G'        : ('\u1d33',   '?'           ),
// 'H'        : ('\u1d34',   '?'           ),
// 'I'        : ('\u1d35',   '?'           ),
// 'J'        : ('\u1d36',   '?'           ),
// 'K'        : ('\u1d37',   '?'           ),
// 'L'        : ('\u1d38',   '?'           ),
// 'M'        : ('\u1d39',   '?'           ),
// 'N'        : ('\u1d3a',   '?'           ),
// 'O'        : ('\u1d3c',   '?'           ),
// 'P'        : ('\u1d3e',   '?'           ),
// 'Q'        : ('?',        '?'           ),
// 'R'        : ('\u1d3f',   '?'           ),
// 'S'        : ('?',        '?'           ),
// 'T'        : ('\u1d40',   '?'           ),
// 'U'        : ('\u1d41',   '?'           ),
// 'V'        : ('\u2c7d',   '?'           ),
// 'W'        : ('\u1d42',   '?'           ),
// 'X'        : ('?',        '?'           ),
// 'Y'        : ('?',        '?'           ),
// 'Z'        : ('?',        '?'           ),
// '+'        : ('\u207A',   '\u208A'      ),
// '-'        : ('\u207B',   '\u208B'      ),
// '='        : ('\u207C',   '\u208C'      ),
// '('        : ('\u207D',   '\u208D'      ),
// ')'        : ('\u207E',   '\u208E'      ),
// ':alpha'   : ('\u1d45',   '?'           ),
// ':beta'    : ('\u1d5d',   '\u1d66'      ),
// ':gamma'   : ('\u1d5e',   '\u1d67'      ),
// ':delta'   : ('\u1d5f',   '?'           ),
// ':epsilon' : ('\u1d4b',   '?'           ),
// ':theta'   : ('\u1dbf',   '?'           ),
// ':iota'    : ('\u1da5',   '?'           ),
// ':pho'     : ('?',        '\u1d68'      ),
// ':phi'     : ('\u1db2',   '?'           ),
// ':psi'     : ('\u1d60',   '\u1d69'      ),
// ':chi'     : ('\u1d61',   '\u1d6a'      ),
// ':coffee'  : ('\u2615',   '\u2615'      )
// }

// ⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎
// ᵃ ᵇ ᶜ ᵈ ᵉ ᶠ ᵍ ʰ ⁱ ʲ ᵏ ˡ ᵐ ⁿ ᵒ ᵖ ʳ ˢ ᵗ ᵘ ᵛ ʷ ˣ ʸ ᶻ
// ᴬ ᴮ ᴰ ᴱ ᴳ ᴴ ᴵ ᴶ ᴷ ᴸ ᴹ ᴺ ᴼ ᴾ ᴿ ᵀ ᵁ ⱽ ᵂ
// ₐ ₑ ₕ ᵢ ⱼ ₖ ₗ ₘ ₙ ₒ ₚ ᵣ ₛ ₜ ᵤ ᵥ ₓ ᵅ ᵝ ᵞ ᵟ ᵋ ᶿ ᶥ ᶲ ᵠ ᵡ ᵦ ᵧ ᵨ ᵩ ᵪ
// 1ˢᵗ _ 2ⁿᵈ _ 3ʳᵈ _ 4ᵗʰ _ n² _ n³ - m² - م²

// const List<String> superJSONWords = <String>[
// 'allahoAkbar',
// 'activeLanguage',
// 'textDirection',
// 'headlineFont',
// 'bodyFont',
// 'languageName',
// 'languageCode',
// 'bldrsFullName',
// 'bldrsShortName',
// 'bldrsTagLine',
// 'bldrsDescription',
// 'accountType',
// 'owner',
// 'owners',
// 'property',
// 'properties',
// 'realtor',
// 'realtors',
// 'realEstateDeveloper',
// 'realEstateDevelopers',
// 'realEstateBroker',
// 'realEstateBrokers',
// 'developer',
// 'developers',
// 'broker',
// 'brokers',
// 'design',
// 'designs',
// 'designer',
// 'designers',
// 'product',
// 'products',
// 'equipment',
// 'equipments',
// 'supplier',
// 'suppliers',
// 'manufacturer',
// 'manufacturers',
// 'project',
// 'projects',
// 'contractor',
// 'contractors',
// 'craft',
// 'crafts',
// 'craftsman',
// 'craftsmen',
// 'artisan',
// 'artisans',
// 'bldr',
// 'bldrs',
// 'propertiesDescription',
// 'designsDescription',
// 'productsDescription',
// 'projectsDescription',
// 'craftsDescription',
// 'equipmentDescription',
// 'flyer',
// 'flyers',
// 'propertyFlyer',
// 'designFlyer',
// 'projectFlyer',
// 'craftFlyer',
// 'productFlyer',
// 'equipmentFlyer',
// 'general',
// 'createAccount',
// 'signIn',
// 'signInExisting',
// 'register',
// 'continueApple',
// 'continueFacebook',
// 'continueLinkedIn',
// 'continueEmail',
// 'skip',
// 'emailAddress',
// 'password',
// 'confirmPassword',
// 'min6Char',
// 'createBzAccount',
// 'scopeOfServices',
// 'productTypes',
// 'about',
// 'business',
// 'yourBusiness',
// 'businesses',
// 'businessForm',
// 'individual',
// 'individuals',
// 'company',
// 'companies',
// 'companyName',
// 'hqCity',
// 'authorName',
// 'bldrsConnected',
// 'callsReceived',
// 'slidesPublished',
// 'totalViews',
// 'totalShares',
// 'totalSaves',
// 'flyersPublishedBy',
// 'authorsTeam',
// 'businessLogo',
// 'publish',
// 'published',
// 'keywordTag',
// 'flyerSlides',
// 'follow',
// 'following',
// 'followers',
// 'inn',
// 'view',
// 'views',
// 'viewed',
// 'send',
// 'sent',
// 'save',
// 'saved',
// 'call',
// 'createFlyer',
// 'publishFlyer',
// 'saveDraft',
// 'second',
// 'seconds',
// 'minute',
// 'minutes',
// 'hour',
// 'hours',
// 'day',
// 'days',
// 'week',
// 'weeks',
// 'year',
// 'years',
// 'thousand',
// 'million',
// 'collections',
// 'savedFlyers',
// 'profile',
// 'news',
// 'more',
// 'contacts',
// 'inviteFriends',
// 'inviteBusinesses',
// 'changeCountry',
// 'changeLanguage',
// 'feedback',
// 'termsRegulations',
// 'advertiseOnBldrs',
// 'whatIsFlyer',
// 'whoAreBldrs',
// 'howItWorks',
// 'signOut',
// 'editProfile',
// 'updateProfile',
// 'name',
// 'enterName',
// 'jobTitle',
// 'enterJobTitle',
// 'enterCompanyName',
// 'selectCity',
// 'phone',
// 'website',
// 'facebookLink',
// 'instagramLink',
// 'linkedinLink',
// 'youtubeChannel',
// 'tiktokLink',
// 'pinterestLink',
// 'enterEmail',
// 'emailInvalid',
// 'enterPassword',
// 'min6CharError',
// 'wrongPassword',
// 'emailNotFound',
// 'emailWrong',
// 'signInFailure',
// 'passwordMismatch',
// 'somethingIsWrong',
// 'emailAlreadyRegistered',
// 'section',
// 'sections',
// 'choose',
// 'realEstate',
// 'realEstateTagLine',
// 'construction',
// 'constructionTagLine',
// 'supplies',
// 'suppliesTagLine',
// 'search',
// 'language',
// 'country',
// 'chooseCountryTagline',
// 'city',
// 'ask',
// 'question',
// 'askHint',
// 'askInfo',
// 'askConfirm',
// 'askConfirmHint',
// 'confirm',
// 'cancel',
// 'paste',

// ];
