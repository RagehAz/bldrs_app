import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/xxx_dashboard/modules/translations_manager/translations_controller.dart';
import 'package:bldrs/xxx_dashboard/modules/translations_manager/widgets/translations_bubble.dart';
import 'package:flutter/material.dart';

class TranslationsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TranslationsPage({
    @required this.isSearching,
    @required this.mixedSearchedPhrases,
    @required this.scrollController,
    @required this.enPhrases,
    @required this.arPhrases,
    @required this.pageController,
    @required this.enController,
    @required this.arController,
    @required this.idTextController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isSearching;
  final ValueNotifier<List<Phrase>> mixedSearchedPhrases;
  final ScrollController scrollController;
  final List<Phrase> enPhrases;
  final List<Phrase> arPhrases;
  final PageController pageController;
  final TextEditingController enController;
  final TextEditingController arController;
  final TextEditingController idTextController;
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

              final List<Phrase> _allLanguagesPhrasesOfAllMixedPhrases = Phrase.getAllLanguagesPhrasesOfMixedPhrases(
                enPhrases : enPhrases,
                arPhrases : arPhrases,
                mixedPhrases : mixedPhrases,
              );

              final List<Phrase> _enSearchedPhrases = Phrase.getPhrasesByLangFromPhrases(
                phrases: _allLanguagesPhrasesOfAllMixedPhrases,
                langCode: 'en',
              );

              final List<Phrase> _arSearchedPhrases = Phrase.getPhrasesByLangFromPhrases(
                phrases: _allLanguagesPhrasesOfAllMixedPhrases,
                langCode: 'ar',
              );

              return TranslationsBubble(
                enPhrases: _enSearchedPhrases,
                arPhrases: _arSearchedPhrases,
                scrollController: scrollController,
                onCopyValue: (String value) => onCopyText(context, value),
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

            },
          );


        }

        /// VIEW PAGE
        else {
          return child;
        }

      },
      child: TranslationsBubble(
        scrollController: scrollController,
        arPhrases: arPhrases,
        enPhrases: enPhrases,
        onCopyValue: (String value) => onCopyText(context, value),
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
