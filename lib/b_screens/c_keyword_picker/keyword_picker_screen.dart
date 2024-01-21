import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/map_pathing.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/searching.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_screens/c_keyword_picker/z_keywords_tree/keywords_tree.dart';
import 'package:bldrs/z_components/buttons/editors_buttons/editor_confirm_button.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/keywords_protocols/keywords_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class KeywordsPickerScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const KeywordsPickerScreen({
    this.multipleSelection = false,
    this.selectedPhids = const [],
    super.key
  });
  // --------------------
  final bool multipleSelection;
  final List<String> selectedPhids;
  // --------------------
  @override
  _KeywordsPickerScreenState createState() => _KeywordsPickerScreenState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> pickPath() async {

    final String? _path = await BldrsNav.goToNewScreen(
        screen: const KeywordsPickerScreen(
          // multipleSelection: false,
          // selectedPhids: [],
        ),
    );

    return _path;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> pickPaths({
    required List<String> selectedPaths,

  }) async {

    final List<String> _paths = await BldrsNav.goToNewScreen(
      screen: KeywordsPickerScreen(
        multipleSelection: true,
        selectedPhids: Pathing.getPathsLastNodes(selectedPaths),
      ),
    );

    return _paths;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> pickPhid() async {
    final String? _path = await pickPath();
    return Pathing.getLastPathNode(_path);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> pickPhids({
    required List<String>? selectedPhids,
  }) async {

    final List<String> _paths = await BldrsNav.goToNewScreen(
      screen: KeywordsPickerScreen(
        multipleSelection: true,
        selectedPhids: selectedPhids ?? [],
      ),
    );

    return Pathing.getPathsLastNodes(_paths);
  }
  // --------------------------------------------------------------------------
}

class _KeywordsPickerScreenState extends State<KeywordsPickerScreen> {
  // ----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final TextEditingController _searchController = TextEditingController();
  List<String> _mapPaths = [];
  Map<String, dynamic> _foundMap = {};
  List<Phrase> _phrases = [];
  List<String> _allPhids = [];
  List<String> _selectedPaths = [];
  // -----------------------------------------------------------------------------
  Map<String, dynamic>? _keywordsMap;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);

        final Map<String, dynamic>? _map = await KeywordsProtocols.fetch();


        setState(() {
          _mapPaths = MapPathing.generatePathsFromMap(map: _map);
          _allPhids = Mapper.getAllNestedKeys(
            map: _map,
            allowDuplicates: false,
          );
          _phrases = _generatePhrases();
          _keywordsMap = _map;
          _selectedPaths = Pathing.findPathsContainingSubStrings(
            paths: _mapPaths,
            subStrings: widget.selectedPhids,
          );

        });

        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _isSearching.dispose();
    _searchController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// GENERATE PHRASES

  // --------------------
  /// TESTED : WORKS PERFECT
  List<Phrase> _generatePhrases(){

    final List<Phrase> _output = [];

    for (final String phid in _allPhids){

      /// DO_THE_TRANSLATE_PHID_to_second_lang
      final String _value = getWord(phid);
      final Phrase _phrase = Phrase(
        id: phid,
        value: _value,
        langCode: Localizer.getCurrentLangCode(),
        trigram: Stringer.createTrigram(input: _value),
      );

      _output.add(_phrase);

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// MAP SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchChanged(String? text) async {

    if (_keywordsMap != null){

      Searching.triggerIsSearchingNotifier(
        text: text,
        isSearching: _isSearching,
        mounted: mounted,
      );

      if (_isSearching.value  == true){

        /// SEARCH KEYS
        final List<String> _foundPaths = Pathing.findPathsContainingSubstring(
          paths: _mapPaths,
          subString: text,
        );

        /// SEARCH TRANSLATIONS
        final List<String> _foundPhrases = searchPhrasesAndGetPaths(
          text: text,
        );

        final List<String> _allFound = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: _foundPaths,
          listToAdd: _foundPhrases,
        );

        /// FOUND PATHS
        if (Lister.checkCanLoop(_allFound) == true){

          final Map<String, dynamic> _output = MapPathing.generateMapFromSomePaths(
            somePaths: _allFound,
            sourceMap: _keywordsMap!,
          );

          setState(() {
            _foundMap = _output;
          });

        }

        /// NOTHING FOUND
        else {
          setState(() {
            _foundMap = {};
          });
        }

      }

    }

  }
// --------------------
  /// TESTED : WORKS PERFECT
  List<String> searchPhrasesAndGetPaths({
    required String? text
  }){
    List<String> _output = [];

    final List<Phrase> _foundPhrases = Phrase.searchPhrasesTrigrams(
      sourcePhrases: _phrases,
      inputText: text,
    );

    if (Lister.checkCanLoop(_foundPhrases) == true){

      final List<String> _phids = Phrase.getPhrasesIDs(_foundPhrases);

      _output = Pathing.findPathsContainingSubStrings(
        paths: _mapPaths,
        subStrings: _phids,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onSearchCancelled(){
    setNotifier(notifier: _isSearching, mounted: mounted, value: false);
    _searchController.text = '';
  }
  // --------------------------------------------------------------------------

  /// TAPS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onLastNodeTap(String path) async {

    if (widget.multipleSelection == true){
      setState(() {
        _selectedPaths = Stringer.addOrRemoveStringToStrings(
            strings: _selectedPaths,
            string: path
        );
      });
    }

    else {
      await Nav.goBack(
        context: context,
        passedData: path,
      );
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onExpandableNodeTap(String path) async {

    blog('expandable node path is : $path');

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _treeZoneWidth = Scale.screenWidth(context) * 0.8;
    final double _keyWidth = Scale.screenWidth(context) * 0.6;
    // --------------------
    return MainLayout(
      key: const ValueKey<String>('theKeywordsPickerScreen'),
      canSwipeBack: false,
      loading: _loading,
      // pyramidType: PyramidType.crystalYellow,

      appBarType: AppBarType.search,
      onSearchChanged: _onSearchChanged,
      searchController: _searchController,
      onSearchCancelled: _onSearchCancelled,
      onSearchSubmit: _onSearchChanged,
      confirmButton: widget.multipleSelection == false ? null : ConfirmButton(
        confirmButtonModel: ConfirmButtonModel(
          onTap: () => Nav.goBack(
            context: context,
            passedData: _selectedPaths,
          ),
          firstLine: const Verse(id: 'phid_confirm', translate: true),
          isWide: true,
        ),
        enAlignment: Alignment.bottomCenter,
      ),
      child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (_, bool searching, Widget? child){

            return FloatingList(
              width: Scale.screenWidth(context),
              height: Scale.screenHeight(context),
              boxAlignment: Alignment.topCenter,
              padding: Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
              columnChildren: <Widget>[

                /// BROWSING : MAP TREE
                if (searching == false)
                  KeywordsTreeStarter(
                    key: const ValueKey<String>('KeywordsTreeStarter_browse'),
                    map: _keywordsMap,
                    width: _treeZoneWidth,
                    keyWidth: _keyWidth,
                    onLastNodeTap: onLastNodeTap,
                    onExpandableNodeTap: onExpandableNodeTap,
                    selectedPaths: _selectedPaths,
                    // initiallyExpanded: false,
                  ),

                /// SEARCHING : NO RESULT FOUND
                if (searching == true && _foundMap.isEmpty)
                  const Center(
                    child: NoResultFound(),
                  ),

                /// SEARCHING : FOUND RESULTS TREE
                if (searching == true && _foundMap.isNotEmpty)
                  KeywordsTreeStarter(
                    key: const ValueKey<String>('KeywordsTreeStarter_search'),
                    map: _foundMap,
                    width: _treeZoneWidth,
                    keyWidth: _keyWidth,
                    searchValue: _searchController,
                    initiallyExpanded: true,
                    onLastNodeTap: onLastNodeTap,
                    onExpandableNodeTap: onExpandableNodeTap,
                    selectedPaths: _selectedPaths,
                  ),

              ],
            );

          }
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
