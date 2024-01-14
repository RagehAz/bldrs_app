import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/b_views/j_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
/// => TAMAM
class UiInitializer {
  // -----------------------------------------------------------------------------

  const UiInitializer();

  // -----------------------------------------------------------------------------

  /// LOADING VERSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static void setLoadingVerse(String? text){
    UiProvider.proSetLoadingVerse(verse: Verse.plain(text));
  }
  // -----------------------------------------------------------------------------

  /// APP LANGUAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeAppLanguage({
    required BuildContext context,
    required bool mounted,
  }) async {

    String? _lang = await Localizer.readLDBLangCode();

    _lang ??= await Dialogs.languageDialog();
    _lang ??= 'en';

    if (mounted == true){
      await Localizer.changeAppLanguage(
        code: _lang,
        context: context,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CLOCK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> initializeClock() async {

    /// CHECK DEVICE CLOCK
    bool _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
      context: getMainContext(),
      showIncorrectTimeDialog: true,
      canThrowError: true,
    );

    /// OVERRIDE : FOR WEB AND WINDOWS
    if (
        _deviceTimeIsCorrect == true ||
        kIsWeb == true ||
        DeviceChecker.deviceIsWindows() == true
    ){
      return true;
    }
    else {

      await Future.delayed(const Duration(seconds: 5));

      _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
        context: getMainContext(),
        showIncorrectTimeDialog: false,
        canThrowError: false,
      );

      if (_deviceTimeIsCorrect == true){
        return true;
      }
      else {
        await BldrsNav.pushLogoRouteAndRemoveAllBelow(
          animatedLogoScreen: false,
        );
        return false;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SCREEN DIM - ICONS - PHRASES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeIconsAndPhrases() async {

    UiProvider.proSetScreenDimensions(
      notify: false,
    );

    UiProvider.proSetLayoutIsVisible(
      setTo: true,
      notify: true,
    );

    await Future.wait([

      GeneralProvider.proGetSetLocalAssetsPaths(notify: true),

      PhraseProtocols.generateCountriesPhrases(),

    ]);

  }
  // -----------------------------------------------------------------------------

  /// LDB REFRESH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> refreshLDB() async {

    // await _monitorRefreshLDBThing();

    final bool _shouldRefresh = await LDBOps.checkShouldRefreshLDB(
      refreshDurationInMinutes: Standards.ldbWipeIntervalInMinutes,
    );

    if (_shouldRefresh == true){

      await LDBDoc.wipeOutLDBDocs(
        /// MAIN
        flyers: true, /// flyers are updated frequently
        bzz: true, /// bzz might be updated frequently
        notes: false, // I do not think we need to refresh notes everyday
        pics: true, /// pics of logos - users - flyers might change over time
        pdfs: false, // i do not think that fetched pdfs are changed frequently by authors,
        /// USER
        users: true, // users might change their profile info
        authModel: false, // need my authModel to prevent re-auth everyday
        accounts: false, // keep accounts until user decides to not "remember me trigger"
        searches: false,
        /// CHAIN
        bldrsChains: false, // keep the chains man, if chains updated - appState protocols handles this
        pickers: false, // same as chains
        /// ZONES
        countries: true, // countries include staging info, so lets refresh that daily
        cities: false, // cities do not change often
        staging: true, // staging info changes frequently
        census: true, // might need faster refresh aslan
        /// PHRASES
        mainPhrases: false,
        countriesPhrases: false,
        /// EDITORS
        userEditor: false, // keep this for user to find later anytime
        bzEditor: false, // keep this as well
        authorEditor: false, // keep
        flyerMaker: false, // keep
        reviewEditor: false, // keep
        /// SETTINGS
        theLastWipe: false, // no need to wipe
        appState: false, // no need to wipe
        langCode: false, // no need to wipe
        langMaps: false, // no need to wipe
        onboarding: false,
        /// DASHBOARD
        gta: false, // this is for dashboard
        webpages: false, // this is for dashboard
        noteCampaigns: false, // dashboard
        /// COUNTERS
        bzzCounters: true, // this stays for 10 minutes anyways
        flyersCounters: true, // this stays for 10 minutes anyways
        usersCounters: true, // this stays for 10 minutes anyways
      );

    }

  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> _monitorRefreshLDBThing() async {

    if (kDebugMode == true){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: ['theLastWipeMap'],
        docName: 'theLastWipeMap',
        primaryKey: 'id',
      );

      bool _shouldRefresh = false;
      double? _diff;
      DateTime? _lastWipe;

      if (Lister.checkCanLoop(_maps) == true){

        _lastWipe = Timers.decipherTime(
          time: _maps.first['time'],
          fromJSON: true,
        );

        _diff = Timers.calculateTimeDifferenceInMinutes(
          from: _lastWipe,
          to: DateTime.now(),
        ).toDouble();

        _diff = Numeric.modulus(_diff);

        /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
        if (_diff != null && _diff < Standards.ldbWipeIntervalInMinutes){
          _shouldRefresh = false;
        }
        else {
          _shouldRefresh = true;
        }

      }

      await Dialogs.centerNotice(
        verse: Verse.plain('checkShouldRefreshLDB : $_shouldRefresh'),
        color: _shouldRefresh == true ? Colorz.green255 : Colorz.red255,
        body: Verse.plain(
            '''
_diff Minutes

Last Wipe : $_lastWipe

($_diff) < (${Standards.ldbWipeIntervalInMinutes}) >  = (${Numeric.isLesserThan(number: Standards.ldbWipeIntervalInMinutes, isLesserThan: _diff)}))
            '''),
      );

    }

  }
   */
  // -----------------------------------------------------------------------------

  /// ONBOARDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeOnBoarding() async {

    final bool autoOnBoardingIsActive = await OnBoardingScreen.autoOnBoardingIsActive();

      if (autoOnBoardingIsActive == true){

        await OnBoardingScreen.goToOnboardingScreen(
          showDontShowAgainButton: true,
        );

      }

  }
  // -----------------------------------------------------------------------------
}
