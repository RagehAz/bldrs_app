import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/trans_mdel_streamer.dart';
import 'package:bldrs/e_db/fire/ops/trans_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/xxx_dashboard/modules/translations_manager/pages/translations_creator_page.dart';
import 'package:bldrs/xxx_dashboard/modules/translations_manager/pages/translations_page.dart';
import 'package:bldrs/xxx_dashboard/modules/translations_manager/translations_controller.dart';
import 'package:flutter/material.dart';

class TranslationsLab extends StatefulWidget {

  const TranslationsLab({
    Key key
  }) : super(key: key);

  @override
  _TranslationsLabState createState() => _TranslationsLabState();
}

class _TranslationsLabState extends State<TranslationsLab> {
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

      blog('Blogging BLDRS.net ahooo');

  }
  // -----------------------------

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
                  onSearchChanged: (String text) => onSearchChanged(
                    text: text,
                    arPhrases: _arPhrases,
                    enPhrase: _enPhrases,
                    isSearching: _isSearching,
                    mixedSearchResult: _mixedSearchedPhrases,
                    searchController: _searchController,
                  ),
                  appBarRowWidgets: <Widget>[

                    const Expander(),

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
                      onTap: () async {},
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
