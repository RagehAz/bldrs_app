import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// SELECTING KEYWORD

// --------------------------------------------
Future<void> onSelectKeyword({
  @required BuildContext context,
  @required String phid,
  @required bool inActiveMode,
  @required FlyerType flyerType,
}) async {

  /// A - if section is not active * if user is author or not
  if (inActiveMode == true) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final String _currentCityID = _zoneProvider.currentZone.cityID;

    final String _flyerTypeString = translateFlyerType(
        context: context,
        flyerType: flyerType
    );

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Section "$_flyerTypeString" is\nTemporarily closed in $_currentCityID',
      body: 'The Bldrs in $_currentCityID are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DialogButton(
            verse: 'Inform a friend',
            width: 133,
            onTap: () async {
              await Launcher.shareLink(context, LinkModel.bldrsWebSiteLink);
            },
          ),

          DialogButton(
            verse: 'Go back',
            color: Colorz.yellow255,
            verseColor: Colorz.black230,
            onTap: () => Nav.goBack(context),
          ),

        ],
      ),
    );
  }

  /// A - if section is active
  else {

    final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(context, listen: false);

    await _keywordsProvider.changeSection(
      context: context,
      section: flyerType,
      keywordID: phid,
    );

    /// B - close dialog
    Nav.goBack(context);
  }
}
// -----------------------------------------------------------------------------

/// ICONS

// --------------------------------------------
String getSectionIcon({
  @required FlyerType section,
  @required bool inActiveMode
}){

  String _icon;

  if (inActiveMode == true) {
    _icon = Iconizer.flyerTypeIconOff(section);
  } else {
    _icon = Iconizer.flyerTypeIconOn(section);
  }

  return _icon;
}
// -----------------------------------------------------------------------------

/// SEARCHING

// --------------------------------------------
Future<void> onSearchChanged({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<String>> foundPhids,
  @required ValueNotifier<List<Chain>> foundChains,
}) async {

  blog('drawer receives text : $text : Length ${text.length}: isSearching : ${isSearching.value}');

  /// A - not searching
  if (isSearching.value == false) {

    /// A.1 starts searching
    if (text.length > 1) {
      isSearching.value = true;
    }

  }

  /// B - while searching
  else {

    /// B.1 ends searching
    if (text.length < 3) {
      isSearching.value = false;
      _clearSearchResult(
          foundChains: foundChains,
          foundPhids: foundPhids
      );
    }

    /// B.2 keeps searching
    else {

      await onSearchKeywords(
        context: context,
        foundPhids: foundPhids,
        foundChains: foundChains,
        isSearching: isSearching,
        text: text,
      );

    }

  }

}
// --------------------------------------------
Future<void> onSearchKeywords({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<String>> foundPhids,
  @required ValueNotifier<List<Chain>> foundChains,
}) async {

  final List<String> _phids = await _searchBasicPhrases(text);

  final List<Chain> _chains = _getChainsFromPhids(
    context: context,
    phids: _phids,
  );

  await _setFoundResults(
    context: context,
    searchedPhids: _phids,
    chainsFromPhids: _chains,
    foundChains: foundChains,
    foundPhids: foundPhids,
  );

}
// --------------------------------------------
Future<List<String>> _searchBasicPhrases(String text) async {

  List<Phrase> _results = <Phrase>[];

  final List<Map<String, dynamic>> _maps = await LDBOps.searchPhrasesDoc(
    searchValue: text,
    docName: LDBDoc.basicPhrases,
    lingCode: TextChecker.concludeEnglishOrArabicLingo(text),
  );

  if (Mapper.canLoopList(_maps)) {
    _results = Phrase.decipherMixedLangPhrases(
      maps: _maps,
    );
  }

  final List<String> _keywordsIDs = Phrase.getPhrasesIDs(_results);

  return _keywordsIDs;
}
// --------------------------------------------
List<Chain> _getChainsFromPhids({
  @required BuildContext context,
  @required List<String> phids,
}){

  List<Chain> _chains = <Chain>[];

  if (Mapper.canLoopList(phids) == true){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    _chains = Chain.getChainsFromChainsByIDs(
      ids: phids,
      sourceChains: _chainsProvider.keywordsChain.sons,
    );

  }

  return _chains;
}
// --------------------------------------------
Future<void> _setFoundResults({
  @required BuildContext context,
  @required ValueNotifier<List<Chain>> foundChains,
  @required ValueNotifier<List<String>> foundPhids,
  @required List<String> searchedPhids,
  @required List<Chain> chainsFromPhids,
}) async {

  /// found results
  if (Mapper.canLoopList(searchedPhids) == true) {

    foundPhids.value = searchedPhids;
    foundChains.value = chainsFromPhids;

  }

  /// did not find results
  else {

    foundPhids.value = <String>[];
    foundChains.value = <Chain>[];

  }

}
// --------------------------------------------
void _clearSearchResult({
  @required ValueNotifier<List<Chain>> foundChains,
  @required ValueNotifier<List<String>> foundPhids,
}){

  foundPhids.value = <String>[];
  foundChains.value = <Chain>[];

}
// -----------------------------------------------------------------------------
