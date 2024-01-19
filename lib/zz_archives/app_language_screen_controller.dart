// import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
// import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
// import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
// import 'package:bldrs/f_helpers/localization/localizer.dart';
// import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
// import 'package:flutter/material.dart';
// // -----------------------------------------------------------------------------
//
// /// CHANGE APP LANGUAGE
//
// // --------------------
// /// TESTED : WORKS PERFECT
// Future<void> changeAppLang({
//   required String langCode,
// }) async {
//   pushWaitDialog(
//     verse: const Verse(
//       id: 'phid_change_app_lang_description',
//       translate: true,
//     ),
//   );
//
//   final PhraseProvider _phraseProvider = PhraseProvider.pro(listen: false);
//   await _phraseProvider.fetchSetCurrentLangAndAllPhrases(
//     setLangCode: langCode,
//   );
//
//   await Localizer.changeAppLanguage(getMainContext(), langCode);
//
//   final ChainsProvider _chainsProvider = ChainsProvider.pro(listen: false);
//   await _chainsProvider.fetchSortSetBldrsChains(
//     notify: true,
//   );
//
//   await WaitDialog.closeWaitDialog();
//
//   await BldrsNav.goBackToLogoScreen(
//     animatedLogoScreen: true,
//   );
// }
// // -----------------------------------------------------------------------------
