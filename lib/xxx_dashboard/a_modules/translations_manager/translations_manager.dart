import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/trans_model_streamer.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/trans_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/pages/translations_creator_page.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/pages/translations_page.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/translations_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranslationsManager extends StatefulWidget {

  const TranslationsManager({
    Key key
  }) : super(key: key);

  @override
  _TranslationsManagerState createState() => _TranslationsManagerState();
}

class _TranslationsManagerState extends State<TranslationsManager> {
  // ---------------------------------------------------------------------------
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _englishController = TextEditingController();
  final TextEditingController _arabicController = TextEditingController();
  ScrollController _docScrollController;
  final TextEditingController _searchController = TextEditingController();
  PageController _pageController;
  final ValueNotifier<String> _newID = ValueNotifier('');
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  final ValueNotifier<List<Phrase>> _mixedSearchedPhrases = ValueNotifier(<Phrase>[]);
  // ---------------------------------------------------------------------------
  Stream<TransModel> _arStream;
  Stream<TransModel> _enStream;
  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _idController.addListener(() {
      _newID.value = _idController.text;
    });

    _arStream = getTransModelStream(
      context: context,
      langCode: 'ar',
    );

    _enStream = getTransModelStream(
      context: context,
      langCode: 'en',
    );

    _docScrollController = ScrollController();
  }
  // ---------------------------------------------------------------------------

  /// BUTTONS

  // -----------------------------
  Future<void> _onBldrsTap() async {


  }
  // -----------------------------
  Future<void> _onUploadGroup({
    @required List<Phrase> originalEnPhrases,
    @required List<Phrase> originalArPhrases,
}) async {

    final List<Phrase>  extraPhrases = [];

    await onUploadPhrases(
      context: context,
      enOldPhrases: originalEnPhrases,
      arOldPhrases: originalArPhrases,
      inputMixedLangPhrases: extraPhrases,
    );

  }
  // -----------------------------
  Future<void> _updatePhrases() async {
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    await _phraseProvider.reloadPhrases(context);
  }

  // -----------------------------
  // Future<void> _doTheThingForCities(List<Map<String, dynamic>> citiesMaps) async {
  //
  //   int count = 1;
  //
  //   for (final Map<String, dynamic> cityMap in citiesMaps) {
  //
  //     // Mapper.blogMap(cityMap);
  //
  //     final Map<String, dynamic> _namesMap = cityMap['names'];
  //
  //     final List<String> _keys = _namesMap.keys.toList();
  //
  //     final List<Phrase> _mixedPhrases = <Phrase>[];
  //
  //     for (final String _key in _keys){
  //
  //       final Map<String, dynamic> nameMap = _namesMap[_key];
  //
  //       final Phrase _phrase = Phrase(
  //         langCode: _key,
  //         trigram: Mapper.getStringsFromDynamics(dynamics: nameMap['trigram']),
  //         value: nameMap['value'],
  //       );
  //       // _phrase.blogPhrase();
  //
  //       _mixedPhrases.add(_phrase);
  //     }
  //
  //     final Map<String, dynamic> _mixedPhrasesMap = Phrase.cipherPhrasesToMap(
  //       phrases: _mixedPhrases,
  //       useLangCodeAsKeys: true,
  //       addTrigrams: true,
  //     );
  //
  //     Mapper.blogMap(_mixedPhrasesMap);
  //
  //     await updateSubDocField(
  //         context: context,
  //         collName: FireColl.zones,
  //         docName: FireDoc.zones_cities,
  //         subCollName: FireSubColl.zones_cities_cities,
  //         subDocName: cityMap['cityID'],
  //         field: 'phrases',
  //         input: _mixedPhrasesMap,
  //     );
  //
  //     await deleteSubDocField(
  //       context: context,
  //       collName: FireColl.zones,
  //       docName: FireDoc.zones_cities,
  //       subCollName: FireSubColl.zones_cities_cities,
  //       subDocName: cityMap['cityID'],
  //       field: 'names',
  //     );
  //
  //     blog('$count : tamam with ${cityMap['cityID']} : remaining ${citiesMaps.length - count} cities in ${cityMap['countryID']}');
  //     count++;
  //   }
  //
  //
  // }

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    const double _buttonsHeight = 40;

    return TransModelStreamer(
        stream: _arStream,
        builder: (_, TransModel arTransModel) {

          final List<Phrase> _arPhrases = Phrase.sortPhrasesByID(
            phrases: arTransModel?.phrases,
          );

          return TransModelStreamer(
              stream: _enStream,
              builder: (_, TransModel enTransModel) {

                final List<Phrase> _enPhrases = Phrase.sortPhrasesByID(
                  phrases: enTransModel?.phrases,
                );

                return MainLayout(
                  key: const ValueKey<String>('DashBoardLayout_translations_lab'),
                  historyButtonIsOn: false,
                  skyType: SkyType.black,
                  pyramidsAreOn: true,
                  sectionButtonIsOn: false,
                  zoneButtonIsOn: false,
                  appBarType: AppBarType.search,
                  searchHint: 'Search ${_enPhrases.length} phrases by ID only',
                  searchController: _searchController,
                  // onSearchChanged: (String text) => onSearchPhrases(
                  //   text: text,
                  //   arPhrases: _arPhrases,
                  //   enPhrase: _enPhrases,\
                  //   isSearching: _isSearching,
                  //   mixedSearchResult: _mixedSearchedPhrases,
                  //   searchController: _searchController,
                  // ),
                  onSearchSubmit: (String text) => onSearchPhrases(
                    text: text,
                    arPhrases: _arPhrases,
                    enPhrase: _enPhrases,
                    isSearching: _isSearching,
                    mixedSearchResult: _mixedSearchedPhrases,
                    searchController: _searchController,
                    forceSearch: true,
                  ),
                  appBarRowWidgets: <Widget>[

                    const Expander(),

                    /// UPLOAD GROUP
                    DreamBox(
                      height: _buttonsHeight,
                      color: Colorz.green255,
                      verseShadow: false,
                      verseMaxLines: 2,
                      verseScaleFactor: 0.6,
                      verse: 'UPDATE',
                      secondLine: 'PHRASES',
                      margins: const EdgeInsets.symmetric(horizontal: 5),
                      onTap: () => _updatePhrases(),
                    ),


                    /// UPLOAD GROUP
                    DreamBox(
                      height: _buttonsHeight,
                      color: Colorz.red255,
                      verseShadow: false,
                      verseMaxLines: 2,
                      verseScaleFactor: 0.6,
                      verse: 'Upload',
                      secondLine: 'group',
                      margins: const EdgeInsets.symmetric(horizontal: 5),
                      onTap: () => _onUploadGroup(
                        originalArPhrases: _arPhrases,
                        originalEnPhrases: _enPhrases,
                      ),
                    ),

                    /// UPLOAD BUTTON
                    ValueListenableBuilder(
                        valueListenable: _newID,
                        builder: (_, String newID, Widget child){

                          return DreamBox(
                            height: _buttonsHeight,
                            color: Colorz.yellow255,
                            verse: 'Upload',
                            verseColor: Colorz.black255,
                            secondLineColor: Colorz.black255,
                            secondLine: newID,
                            verseShadow: false,
                            verseMaxLines: 2,
                            verseScaleFactor: 0.6,
                            onTap: () async {

                              if (TextChecker.stringIsNotEmpty(_idController.text) == true){
                                await onUploadPhrase(
                                  context: context,
                                  enOldPhrases: _enPhrases,
                                  arOldPhrases: _arPhrases,
                                  enValue: _englishController.text,
                                  arValue: _arabicController.text,
                                  phraseID: _idController.text,
                                );
                              }

                              else {
                                await TopDialog.showTopDialog(
                                    context: context,
                                    verse: 'ID is Empty',
                                );
                              }

                            },
                          );

                        }
                    ),

                    /// BLDRS BUTTON
                    GestureDetector(
                      onTap: _onBldrsTap,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: BldrsName(
                          size: 40,
                        ),
                      ),
                    ),

                  ],

                  layoutWidget: PageView(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[

                      /// TRANSLATIONS LIST PAGE
                      TranslationsPage(
                        pageController: _pageController,
                        scrollController: _docScrollController,
                        arController: _arabicController,
                        enController: _englishController,
                        arPhrases: _arPhrases,
                        enPhrases: _enPhrases,
                        idTextController: _idController,
                        isSearching: _isSearching,
                        mixedSearchedPhrases: _mixedSearchedPhrases,
                      ),

                      /// CREATOR
                      TranslationsCreatorPage(
                        idController: _idController,
                        enController: _englishController,
                        arController: _arabicController,
                      ),

                    ],
                  ),

                );
              }
              );
        }
        );

  }
}
// ---------------------------------------------------------------------------
