import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/phrase_editor_controllers.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/widgets/translations_bubble.dart';
import 'package:flutter/material.dart';

class TranslationsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TranslationsPage({
    @required this.screenHeight,
    @required this.isSearching,
    @required this.mixedSearchedPhrases,
    @required this.scrollController,
    @required this.enPhrases,
    @required this.arPhrases,
    @required this.pageController,
    @required this.enController,
    @required this.arController,
    @required this.idTextController,
    @required this.searchController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<bool> isSearching; /// p
  final ValueNotifier<List<Phrase>> mixedSearchedPhrases; /// p
  final ScrollController scrollController;
  final List<Phrase> enPhrases;
  final List<Phrase> arPhrases;
  final PageController pageController;
  final TextEditingController enController;
  final TextEditingController arController;
  final TextEditingController idTextController;
  final TextEditingController searchController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: isSearching,
      builder: (_, bool isSearching, Widget child){

        /// SEARCHING PAGE
        if (isSearching == true){

          return ValueListenableBuilder(
            valueListenable: mixedSearchedPhrases,
            builder: (_, List<Phrase> mixedPhrases, Widget child){

              if (mixedPhrases.isEmpty == true){
                return PageBubble(
                    screenHeightWithoutSafeArea: screenHeight,
                    appBarType: AppBarType.search,
                    color: Colorz.black125,
                    child: const Center(
                      child: SuperVerse(
                        verse: 'No result found',
                        size: 3,
                        italic: true,
                      ),
                    ),
                );
              }

              else {

                final List<Phrase> _allLanguagesPhrasesOfAllMixedPhrases = Phrase.getAllLanguagesPhrasesOfMixedPhrases(
                  enPhrases : enPhrases,
                  arPhrases : arPhrases,
                  mixedPhrases : mixedPhrases,
                );

                final List<Phrase> _cleaned = Phrase.cleanIdenticalPhrases(_allLanguagesPhrasesOfAllMixedPhrases);

                final List<Phrase> _enSearchedPhrases = Phrase.getPhrasesByLangFromPhrases(
                  phrases: _cleaned,
                  langCode: 'en',
                );

                final List<Phrase> _arSearchedPhrases = Phrase.getPhrasesByLangFromPhrases(
                  phrases: _cleaned,
                  langCode: 'ar',
                );

                return TranslationsBubble(
                  screenHeight: screenHeight,
                  searchController: searchController,
                  enPhrases: _enSearchedPhrases,
                  arPhrases: _arSearchedPhrases,
                  scrollController: scrollController,
                  onCopyValue: (String value) => TextMod.controllerCopy(context, value),
                  onDeletePhrase: (String phraseID) => onDeletePhrase(
                    context: context,
                    phraseID: phraseID,
                    enPhrases: enPhrases,
                    arPhrases: arPhrases,
                  ),
                  onEditPhrase: (String phraseID) async {

                    await onEditPhrase(
                      context: context,
                      pageController: pageController,
                      enPhrases: enPhrases,
                      arPhrases: arPhrases,
                      phraseID: phraseID,
                      enTextController: enController,
                      arTextController: arController,
                      idTextController: idTextController,
                    );

                  },
                );

              }

            },
          );


        }

        /// VIEW PAGE
        else {
          return child;
        }

      },
      child: TranslationsBubble(
        screenHeight: screenHeight,
        searchController: searchController,
        scrollController: scrollController,
        arPhrases: arPhrases,
        enPhrases: enPhrases,
        onCopyValue: (String value) => TextMod.controllerCopy(context, value),
        onEditPhrase: (String phraseID) => onEditPhrase(
          context: context,
          pageController: pageController,
          enPhrases: enPhrases,
          arPhrases: arPhrases,
          phraseID: phraseID,
          enTextController: enController,
          arTextController: arController,
          idTextController: idTextController,
        ),
        onDeletePhrase: (String phraseID) => onDeletePhrase(
          context: context,
          phraseID: phraseID,
          enPhrases: enPhrases,
          arPhrases: arPhrases,
        ),
      ),
    );

  }
}
