import 'dart:async';

import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/trans_model_streamer.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/old_phrase_editor/phrase_fire_ops.dart';
import 'package:flutter/material.dart';

class OLDTranslationsManager extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const OLDTranslationsManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _OLDTranslationsManagerState createState() => _OLDTranslationsManagerState();
/// --------------------------------------------------------------------------
}

class _OLDTranslationsManagerState extends State<OLDTranslationsManager> {
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
  Stream<List<Phrase>> _arStream;
  Stream<List<Phrase>> _enStream;
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
  // -------------------------------------
  /// TAMAM
  @override
  void dispose(){
    _idController.dispose();
    _englishController.dispose();
    _arabicController.dispose();
    _docScrollController.dispose();
    _searchController.dispose();
    _pageController.dispose();
    _newID.dispose();
    _isSearching.dispose();
    _mixedSearchedPhrases.dispose();

    super.dispose();
  }
  // ---------------------------------------------------------------------------

  /// BUTTONS

  // -----------------------------
  Future<void> _onUploadPhrase({
    @required List<Phrase> enPhrases,
    @required List<Phrase> arPhrases,
  }) async {

    // if (Stringer.checkStringIsNotEmpty(_idController.text) == true){
    //   await onUploadPhrase(
    //     context: context,
    //     enOldPhrases: enPhrases,
    //     arOldPhrases: arPhrases,
    //     enValue: _englishController.text,
    //     arValue: _arabicController.text,
    //     phraseID: _idController.text,
    //   );
    // }
    //
    // else {
    //   await TopDialog.showTopDialog(
    //     context: context,
    //     firstLine: 'ID is Empty',
    //   );
    // }

  }
  // -----------------------------
  /*
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
   */
  // -----------------------------
  Future<void> _reloadPhrases() async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Reload All Phrases',
      body: 'This will restart the app',
      boolDialog: true,
      confirmButtonText: 'Yes, Reload !',
    );

    if (_result == true){
      await PhraseProtocols.reloadMainPhrases(context);
    }

  }
  // -----------------------------
  /*
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
   */
  // -----------------------------
  Future<void> _onBackupPhrases({
    @required List<Phrase> originalEnPhrases,
    @required List<Phrase> originalArPhrases,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Create a backup',
      body: 'will be located in :\ndb/admin/backups/phrases \n and will include current time stamp',
      boolDialog: true,
      confirmButtonText: 'Back the fuck up',
    );

    if (_result == true){

    String _error;

    final bool _result = await tryCatchAndReturnBool(
        context: context,
        functions: () async {

          await backupPhrasesOps(context);

        },
      onError: (String error){
          _error = error;
      }
    );

    await CenterDialog.showCenterDialog(
      context: context,
      // boolDialog: false,
      title: _result == true ? 'Tamam' : 'Ops,, errr',
      body: _result == true ? 'Phrases are backed up successfully' : 'error : $_error',
    );

    }
  }
  // -----------------------------
  @override
  Widget build(BuildContext context) {

    // final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    const double _buttonsHeight = 40;

    return PhrasesStreamer(
        stream: _arStream,
        builder: (_, List<Phrase> arPhrases) {

          final List<Phrase> _arPhrases = Phrase.sortPhrasesByID(
            phrases: arPhrases,
          );

          return PhrasesStreamer(
              stream: _enStream,
              builder: (_, List<Phrase> enPhrases) {

                final List<Phrase> _enPhrases = Phrase.sortPhrasesByID(
                  phrases: enPhrases,
                );

                return MainLayout(
                  key: const ValueKey<String>('DashBoardLayout_translations_lab'),
                  historyButtonIsOn: false,
                  skyType: SkyType.black,
                  pyramidsAreOn: true,
                  sectionButtonIsOn: false,
                  appBarType: AppBarType.search,
                  searchHint: 'Search ${_enPhrases.length} phrases by ID only',
                  searchController: _searchController,
                  onSearchChanged: (String text){
                    if (text.isEmpty){
                      _isSearching.value = false;
                    }
                  },
                  // onSearchSubmit: (String text) => onSearchPhrases(
                  //   text: text,
                  //   allMixedPhrases: _arPhrases,
                  //   enPhrase: _enPhrases,
                  //   isSearching: _isSearching,
                  //   mixedSearchResult: _mixedSearchedPhrases,
                  //   searchController: _searchController,
                  //   // forceSearch: true,
                  // ),
                  appBarRowWidgets: <Widget>[

                    /// RELOAD
                    DreamBox(
                      height: _buttonsHeight,
                      width: _buttonsHeight,
                      color: Colorz.green255,
                      icon: Iconz.reload,
                      iconSizeFactor: 0.6,
                      margins: const EdgeInsets.symmetric(horizontal: 5),
                      onTap: () => _reloadPhrases(),
                    ),

                    /// UPLOAD GROUP
                    DreamBox(
                      height: _buttonsHeight,
                      verseShadow: false,
                      verseMaxLines: 2,
                      verseScaleFactor: 0.6,
                      verse: 'Backup',
                      secondLine: 'All phrases',
                      margins: const EdgeInsets.symmetric(horizontal: 5),
                      onTap: () => _onBackupPhrases(
                        originalArPhrases: _arPhrases,
                        originalEnPhrases: _enPhrases,
                      ),
                    ),

                    // /// PASTE
                    // DreamBox(
                    //   height: _buttonsHeight,
                    //   verseShadow: false,
                    //   verseMaxLines: 2,
                    //   verseScaleFactor: 0.6,
                    //   verse: 'paste',
                    //   margins: const EdgeInsets.symmetric(horizontal: 5),
                    //   onTap: () async {
                    //     await onPasteText(_searchController);
                    //   },
                    // ),

                    const Expander(),

                    /// UPLOAD BUTTON
                    ValueListenableBuilder(
                        valueListenable: _newID,
                        builder: (_, String newID, Widget child){

                          return DreamBox(
                            isDeactivated: newID == '',
                            height: _buttonsHeight,
                            width: 80,
                            color: Colorz.yellow255,
                            verse: 'Upload',
                            verseColor: Colorz.black255,
                            secondLineColor: Colorz.black255,
                            secondLine: newID == '' ? null : newID,
                            verseShadow: false,
                            secondVerseMaxLines: 1,
                            verseScaleFactor: 0.6,
                            margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                            onTap: () => _onUploadPhrase(
                              enPhrases: enPhrases,
                              arPhrases: arPhrases,
                            ),
                          );

                        }
                    ),


                  ],

                  // layoutWidget: PageView(
                  //   controller: _pageController,
                  //   physics: const BouncingScrollPhysics(),
                  //   children: <Widget>[
                  //
                  //     // /// TRANSLATIONS LIST PAGE
                  //     // PhrasesViewerPage(
                  //     //   screenHeight: _screenHeight,
                  //     //   searchController: _searchController,
                  //     //   pageController: _pageController,
                  //     //   scrollController: _docScrollController,
                  //     //   arController: _arabicController,
                  //     //   enController: _englishController,
                  //     //   arPhrases: _arPhrases,
                  //     //   enPhrases: _enPhrases,
                  //     //   idTextController: _idController,
                  //     //   isSearching: _isSearching,
                  //     //   mixedSearchedPhrases: _mixedSearchedPhrases,
                  //     // ),
                  //
                  //     // /// CREATOR
                  //     // PhraseCreatorPage(
                  //     //   tempMixedPhrases: ,
                  //     //   idController: _idController,
                  //     //   enController: _englishController,
                  //     //   arController: _arabicController,
                  //     // ),
                  //
                  //   ],
                  // ),

                );
              }
              );
        }
        );

  }
}
// ---------------------------------------------------------------------------
