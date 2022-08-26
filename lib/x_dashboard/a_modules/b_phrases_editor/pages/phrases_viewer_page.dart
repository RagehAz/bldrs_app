import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/no_result_found.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/phrase_editor_controllers.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/widgets/phrase_builder_bubble.dart';
import 'package:flutter/material.dart';

class PhrasesViewerPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhrasesViewerPage({
    @required this.screenHeight,
    @required this.isSearching,
    @required this.mixedSearchedPhrases,
    @required this.scrollController,
    // @required this.enPhrases,
    // @required this.arPhrases,
    @required this.pageController,
    @required this.enController,
    @required this.arController,
    @required this.idTextController,
    @required this.searchController,
    @required this.tempMixedPhrases,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<bool> isSearching; /// p
  final ValueNotifier<List<Phrase>> mixedSearchedPhrases; /// p
  final ScrollController scrollController;
  // final List<Phrase> enPhrases;
  // final List<Phrase> arPhrases;
  final PageController pageController;
  final TextEditingController enController;
  final TextEditingController arController;
  final TextEditingController idTextController;
  final TextEditingController searchController;
  final ValueNotifier<List<Phrase>> tempMixedPhrases;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------
    Future<void> _onEditPhraseTap(String phid) async {

      await onTapEditPhrase(
        context: context,
        pageController: pageController,
        tempMixedPhrases: tempMixedPhrases,
        // enPhrases: enPhrases,
        // arPhrases: arPhrases,
        phid: phid,
        enTextController: enController,
        arTextController: arController,
        idTextController: idTextController,
      );

    }
// -----------------------------
    Future<void> _onDeletePhraseTap(String phid) async {
       await onDeletePhrase(
        context: context,
        phid: phid,
        tempMixedPhrases: tempMixedPhrases,
      );
    }
// -----------------------------
    Future<void> _onSelectPhrase(String phid) async {

      await onSelectPhrase(
        context: context,
        phid: phid,
      );

    }
// -----------------------------
    return ValueListenableBuilder(
      valueListenable: isSearching,
      builder: (_, bool isSearching, Widget child){

        /// SEARCHING PAGE
        if (isSearching == true){

          return ValueListenableBuilder(
            valueListenable: mixedSearchedPhrases,
            builder: (_, List<Phrase> mixedPhrases, Widget child){

              /// NO RESULT FOUND
              if (mixedPhrases.isEmpty == true){
                return PageBubble(
                    screenHeightWithoutSafeArea: screenHeight,
                    appBarType: AppBarType.search,
                    color: Colorz.black125,
                    child: const NoResultFound(),
                );
              }

              /// FOUND RESULTS
              else {

                // final List<Phrase> _allMixedPhrases = Phrase.getAllLanguagesPhrasesOfMixedPhrases(
                //   enPhrases : enPhrases,
                //   arPhrases : arPhrases,
                //   mixedPhrases : mixedPhrases,
                // );

                // final List<Phrase> _cleaned = Phrase.cleanIdenticalPhrases(_allMixedPhrases);

                // final List<Phrase> _enPhrases = Phrase.getPhrasesByLangFromPhrases(
                //   phrases: _cleaned,
                //   langCode: 'en',
                // );
                //
                // final List<Phrase> _arSearchedPhrases = Phrase.getPhrasesByLangFromPhrases(
                //   phrases: _cleaned,
                //   langCode: 'ar',
                // );

                return PhrasesBuilderBubble(
                  screenHeight: screenHeight,
                  searchController: searchController,
                  mixedPhrases: mixedPhrases,
                  // enPhrases: _enSearchedPhrases,
                  // arPhrases: _arSearchedPhrases,
                  scrollController: scrollController,
                  onCopyValue: (String value) => TextMod.controllerCopy(context, value),
                  onDeletePhraseTap: _onDeletePhraseTap,
                  onEditPhraseTap: _onEditPhraseTap,
                  onSelectPhrase: _onSelectPhrase,
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
      child: ValueListenableBuilder(
        valueListenable: tempMixedPhrases,
        builder: (_, List<Phrase> tempPhrases, Widget child){

          return PhrasesBuilderBubble(
            screenHeight: screenHeight,
            searchController: searchController,
            scrollController: scrollController,
            mixedPhrases: tempPhrases,
            // enPhrases: enPhrases,
            // arPhrases: arPhrases,
            onCopyValue: (String value) => TextMod.controllerCopy(context, value),
            onEditPhraseTap: _onEditPhraseTap,
            onDeletePhraseTap: _onDeletePhraseTap,
            onSelectPhrase: _onSelectPhrase,
          );

        },
      ),
    );

  }
}
