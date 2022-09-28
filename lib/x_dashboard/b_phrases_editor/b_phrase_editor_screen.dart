import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/ldb/ops/phrase_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/pages/phrase_creator_page.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/pages/phrases_viewer_page.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/x_phrase_editor_controllers.dart';
import 'package:flutter/material.dart';

class PhraseEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PhraseEditorScreen({
    this.createPhid,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse createPhid;
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
  // --------------------
  final FocusNode _idNode = FocusNode();
  final FocusNode _enNode = FocusNode();
  final FocusNode _arNode = FocusNode();
  // --------------------
  final TextEditingController _searchController = TextEditingController();
  // --------------------
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  // --------------------
  final GlobalKey<FormState> _globalKey = GlobalKey();
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
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _progressBarModel.value = const ProgressBarModel(
      swipeDirection: SwipeDirection.freeze,
      index: 0,
      numberOfStrips: 2,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        final List<Phrase> _mixedPhrases = await PhraseLDBOps.readMainPhrases();
        final List<Phrase> _sorted = Phrase.sortPhrasesByIDAndLang(phrases: _mixedPhrases);
        _initialMixedPhrases.value = _sorted;
        _tempMixedPhrases.value = _sorted;

        await prepareFastPhidCreation(
          context: context,
          untranslatedVerse: widget.createPhid,
          allMixedPhrases: _tempMixedPhrases.value,
          searchController: _searchController,
          mixedSearchResult: _mixedSearchedPhrases,
          isSearching: _isSearching,
          pageController: _pageController,
          idTextController: _idController,
          enTextController: _englishController,
          enNode: _enNode,
        );

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

    _idNode.dispose();
    _enNode.dispose();
    _arNode.dispose();

    _searchController.dispose();

    _pageController.dispose();
    _scrollController.dispose();
    _isSearching.dispose();
    _progressBarModel.dispose();

    _loading.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      isInPhrasesScreen: true,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalBlue,
      pageTitleVerse: Verse.plain('Phrases Editor'),
      sectionButtonIsOn: false,
      appBarType: AppBarType.search,
      searchController: _searchController,
      progressBarModel: _progressBarModel,
      onSearchCancelled: (){
        _searchController.text = '';
        _isSearching.value = false;
      },
      loading: _loading,
      onBack: () async {

        final bool _areIdentical = Phrase.checkPhrasesListsAreIdentical(
          phrases1: Phrase.sortPhrasesByIDAndLang(phrases: _initialMixedPhrases.value),
          phrases2: Phrase.sortPhrasesByIDAndLang(phrases: _tempMixedPhrases.value),
        );

        if (_areIdentical == true){
          await Nav.goBack(
              context: context,
              invoker: 'PhraseEditorScreen',
          );
        }

        else {
          await Dialogs.goBackDialog(
            context: context,
            goBackOnConfirm: true,
          );
        }

      },
      onSearchChanged: (String text) => onPhrasesSearchChanged(
        isSearching: _isSearching,
        allMixedPhrases: _tempMixedPhrases.value,
        mixedSearchResult: _mixedSearchedPhrases,
        searchController: _searchController,
        pageController: _pageController,
        context: context,
      ),
      onSearchSubmit: (String text) => onPhrasesSearchSubmit(
        isSearching: _isSearching,
        allMixedPhrases: _tempMixedPhrases.value,
        mixedSearchResult: _mixedSearchedPhrases,
        searchController: _searchController,
        pageController: _pageController,
        context: context,
      ),
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// DIFFERENCES
        AppBarButton(
          verse: Verse.plain('Blog'),
          onTap: () {

            // final List<String> _temp = Phrase.transformPhrasesToStrings(_tempMixedPhrases.value);
            // final List<String> _initial = Phrase.transformPhrasesToStrings(_initialMixedPhrases.value);
            //
            // Stringer.blogStringsListsDifferences(strings1: _temp, strings2: _initial);

            // Phrase.blogPhrases(_initialMixedPhrases.value);

            Phrase.blogPhrasesListsDifferences(
              phrases1: _tempMixedPhrases.value,
              phrases1Name: 'temp',
              phrases2: _initialMixedPhrases.value,
              phrases2Name: 'initial',
              sortBeforeCompare: false,
            );

          },
        ),

        /// SYNC BUTTON
        ValueListenableBuilder(
            valueListenable: _initialMixedPhrases,
            builder: (_, List<Phrase> _initial, Widget child){

              return ValueListenableBuilder(
                valueListenable: _tempMixedPhrases,
                builder: (_, List<Phrase> _temp, Widget child){

                  final bool _areIdentical = Phrase.checkPhrasesListsAreIdentical(
                    phrases1: Phrase.sortPhrasesByIDAndLang(phrases: _initial),
                    phrases2: Phrase.sortPhrasesByIDAndLang(phrases: _temp),
                  );

                  return AppBarButton(
                    verse: Verse.plain('Sync'),
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
              onPageChanged: (int index) => ProgressBarModel.onSwipe(
                context: context,
                newIndex: index,
                progressBarModel: _progressBarModel,
              ),
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
                  arNode: _arNode,
                  enNode: _enNode,
                  idNode: _idNode,
                  globalKey: _globalKey,
                  onConfirmEdits: () => onConfirmEditPhrase(
                    context: context,
                    mixedSearchResult: _mixedSearchedPhrases,
                    pageController: _pageController,
                    arTextController: _arabicController,
                    enTextController: _englishController,
                    idTextController: _idController,
                    tempMixedPhrases: _tempMixedPhrases,
                    isSearching: _isSearching,
                    searchController: _searchController,
                    updatedEnPhrase: Phrase(
                        id: _idController.text,
                        value: _englishController.text,
                        langCode: 'en'
                    ),
                    updatedArPhrase: Phrase(
                        id: _idController.text,
                        value: _arabicController.text,
                        langCode: 'ar'
                    ),
                  ),
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
