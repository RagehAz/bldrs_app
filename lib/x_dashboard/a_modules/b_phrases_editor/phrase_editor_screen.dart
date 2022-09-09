import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/ldb/ops/phrase_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/pages/phrase_creator_page.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/pages/phrases_viewer_page.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/phrase_editor_controllers.dart';
import 'package:flutter/material.dart';

class PhraseEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PhraseEditorScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<PhraseEditorScreen> createState() => _PhraseEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _PhraseEditorScreenState extends State<PhraseEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<Phrase>> _initialMixedPhrases = ValueNotifier(<Phrase>[]);
  final ValueNotifier<List<Phrase>> _tempMixedPhrases = ValueNotifier(<Phrase>[]);
  final ValueNotifier<List<Phrase>> _mixedSearchedPhrases = ValueNotifier(<Phrase>[]);
  // --------------------
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _englishController = TextEditingController();
  final TextEditingController _arabicController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  // --------------------
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
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

      _triggerLoading(setTo: true).then((_) async {

        final List<Phrase> _mixedPhrases = await PhraseLDBOps.readMainPhrases();
        _initialMixedPhrases.value = _mixedPhrases;
        _tempMixedPhrases.value = _mixedPhrases;

        // Phrase.blogPhrases(_tempMixedPhrases.value);

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _initialMixedPhrases.dispose();
    _tempMixedPhrases.dispose();
    _mixedSearchedPhrases.dispose();

    _idController.dispose();
    _englishController.dispose();
    _arabicController.dispose();
    _searchController.dispose();

    _pageController.dispose();
    _scrollController.dispose();
    _isSearching.dispose();

    _loading.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      pageTitleVerse:  'Phrases Editor',
      sectionButtonIsOn: false,
      appBarType: AppBarType.search,
      searchController: _searchController,
      onSearchCancelled: (){
        _searchController.text = '';
        _isSearching.value = false;
      },
      loading: _loading,
      onBack: () => Dialogs.goBackDialog(
        context: context,
        goBackOnConfirm: true,
      ),
      onSearchChanged: (String text) => onPhrasesSearchChanged(
        isSearching: _isSearching,
        allMixedPhrases: _tempMixedPhrases.value,
        mixedSearchResult: _mixedSearchedPhrases,
        searchController: _searchController,
      ),
      onSearchSubmit: (String text) => onPhrasesSearchSubmit(
        isSearching: _isSearching,
        allMixedPhrases: _tempMixedPhrases.value,
        mixedSearchResult: _mixedSearchedPhrases,
        searchController: _searchController,
      ),
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// SYNC BUTTON
        ValueListenableBuilder(
            valueListenable: _initialMixedPhrases,
            builder: (_, List<Phrase> _initial, Widget child){

              return ValueListenableBuilder(
                valueListenable: _tempMixedPhrases,
                builder: (_, List<Phrase> _temp, Widget child){

                  final bool _areIdentical = Phrase.checkPhrasesListsAreIdentical(
                    phrases1: _initial,
                    phrases2: _temp,
                  );

                  return AppBarButton(
                    verse:  'Sync',
                    isDeactivated: _areIdentical,
                    buttonColor: Colorz.yellow255,
                    verseColor: Colorz.black255,
                    onTap: () => onSyncPhrases(
                      context: context,
                      tempMixedPhrases: _tempMixedPhrases,
                      initialMixedPhrases :_initialMixedPhrases,
                      idTextController: _idController,
                      enTextController: _englishController,
                      arTextController: _arabicController,
                      pageController: _pageController,
                    ),
                  );

                },
              );

            }),

      ],
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: _tempMixedPhrases,
          builder: (_, List<Phrase> mixedTempPhrases, Widget child){

            return PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[

                /// PHRASES VIEWER PAGE
                PhrasesViewerPage(
                  screenHeight: _screenHeight,
                  pageController: _pageController,
                  scrollController: _scrollController,
                  enController: _englishController,
                  arController: _arabicController,
                  idTextController: _idController,
                  isSearching: _isSearching,
                  mixedSearchedPhrases: _mixedSearchedPhrases,
                  searchController: _searchController,
                  tempMixedPhrases: _tempMixedPhrases,
                ),

                /// PHRASE EDITOR PAGE
                PhraseCreatorPage(
                  appBarType: AppBarType.search,
                  idController: _idController,
                  enController: _englishController,
                  arController: _arabicController,
                  tempMixedPhrases: _tempMixedPhrases,
                  pageController: _pageController,
                ),

              ],
            );

          },

        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
