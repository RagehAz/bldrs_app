import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/structure/b_chain_dialog_search_bar_part.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/structure/c_chains_dialog_expanders_part.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainsDialogStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsDialogStarter({
    this.width,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  /// --------------------------------------------------------------------------
  static const double drawerEdgeDragWidth = 15;
  static const bool drawerEnableOpenDragGesture = true;
  static const Color drawerScrimColor = Colorz.black125;
  /// --------------------------------------------------------------------------
  @override
  State<ChainsDialogStarter> createState() => _ChainsDialogStarterState();
  /// --------------------------------------------------------------------------
}

class _ChainsDialogStarterState extends State<ChainsDialogStarter> {
  ChainsProvider _chainsProvider;
  List<Chain> _allChains;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    _allChains = _chainsProvider.keywordsChain.sons;
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _isSearching.dispose();
    _noResultFound.dispose();
    _foundPhids.dispose();
    _foundChains.dispose();
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _noResultFound = ValueNotifier<bool>(false);
// ---------------------------
  Future<void> _onSearchChanged(String text) async {
    blog('drawer receives text : $text : Length ${text.length}: _isSearching : ${_isSearching.value}');

    /// A - not searching
    if (_isSearching.value == false) {
      /// A.1 starts searching
      if (text.length > 1) {
          _isSearching.value = true;
      }
    }

    /// B - while searching
    else {
      /// B.1 ends searching
      if (text.length < 3) {
          _isSearching.value = false;
          _foundPhids.value = <String>[];
      }

      /// B.2 keeps searching
      else {
        final List<String> _phids = await _searchKeywords(text);

        /// found results
        if (Mapper.canLoopList(_phids)) {

            _foundPhids.value = _phids;
            _foundChains.value = Chain.getChainsFromChainsByIDs(
              ids: _foundPhids.value,
              sourceChains: _allChains,
            );
            _noResultFound.value = false;

        }

        /// did not find results
        else {

            _foundPhids.value = <String>[];
            _foundChains.value = <Chain>[];
            _noResultFound.value = true;

        }

      }
    }
  }
// ---------------------------
  Future<void> _onSearchSubmit(String text) async {
    await _searchKeywords(text);
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<List<String>> _foundPhids = ValueNotifier(<String>[]);
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier(<Chain>[]);
// ---------------------------
  Future<List<String>> _searchKeywords(String text) async {

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
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------------------
    final double _drawerWidth = widget.width ?? Scale.superScreenWidth(context) * 0.9;
    final double _drawerHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _bubbleWidth = _drawerWidth - (Ratioz.appBarMargin * 2);
    // -----------------------------------------------------------------------------
    return SizedBox(
      width: _drawerWidth,
      child: Drawer(
        key: const ValueKey<String>('drawer'),
        elevation: 10,
        child: Container(
          width: _drawerWidth,
          height: _drawerHeight,
          color: Colorz.black255,
          alignment: Aligners.superTopAlignment(context),
          child: Column(
            children: <Widget>[

              /// SEARCH BAR
              ChainsDialogSearchBarPart(
                width: _drawerWidth,
                onSearchSubmit: (String text) => _onSearchSubmit(text),
                onSearchChanged: (String text) => _onSearchChanged(text),
              ),

              /// KEYWORDS LISTS
              ChainsDialogExpandersPart(
                bubbleWidth: _bubbleWidth,
                drawerWidth: _drawerWidth,
                isSearching: _isSearching,
                foundChains: _foundChains,
                foundPhids: _foundPhids,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
