import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/b_views/j_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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
  static Future<void> initializeAppLanguage(BuildContext context) async {

    final String? _ldbLangCode = await Localizer.readLDBLangCode();

      if (_ldbLangCode == null){
        final String? _selectedLangCode = await Dialogs.languageDialog();
        await Localizer.changeAppLanguage(
          code: _selectedLangCode,
          context: context,
        );

        if (_selectedLangCode == null){
          await initializeAppLanguage(context);
        }

      }
      else {
        await Localizer.changeAppLanguage(
          code: _ldbLangCode,
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
    final bool _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
      context: getMainContext(),
      showIncorrectTimeDialog: true,
    );

    if (_deviceTimeIsCorrect == true){
      return true;
    }
    else {

      await BldrsNav.goToLogoScreenAndRemoveAllBelow(
        animatedLogoScreen: false,
      );

      return false;
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

    final BuildContext context = getMainContext();
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

    await Future.wait([

      _uiProvider.getSetLocalAssetsPaths(notify: true),

      PhraseProtocols.generateCountriesPhrases(),

    ]);

  }
  // -----------------------------------------------------------------------------

  /// LDB REFRESH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> refreshLDB() async {

    final bool _shouldRefresh = await LDBOps.checkShouldRefreshLDB(
      refreshDurationInHours: Standards.ldbWipeIntervalInHours,
    );

    if (_shouldRefresh == true){

      await LDBDoc.wipeOutLDBDocs(
        /// MAIN
        flyers: true,
        bzz: true,
        notes: false, // I do not think we need to refresh notes everyday
        pics: false, // I do not think we need to refresh pics everyday
        pdfs: false, // i do not think that fetched pdfs are changed frequently by authors,
        /// USER
        users: false,
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
        onboarding: false,
        /// GTA
        gta: false, // this is for dashboard
      );

    }

  }
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
