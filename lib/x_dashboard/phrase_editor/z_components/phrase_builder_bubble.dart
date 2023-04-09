import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:animators/animators.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:mapper/mapper.dart';


import 'package:bldrs/x_dashboard/phrase_editor/z_components/phrase_strip.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class PhrasesBuilderBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhrasesBuilderBubble({
    @required this.screenHeight,
    // @required this.enPhrases,
    // @required this.arPhrases,
    @required this.scrollController,
    @required this.onCopyValue,
    @required this.onDeletePhraseTap,
    @required this.onEditPhraseTap,
    @required this.onSelectPhrase,
    @required this.searchController,
    @required this.mixedPhrases,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  // final List<Phrase> enPhrases;
  // final List<Phrase> arPhrases;
  final ScrollController scrollController;
  final Function onCopyValue;
  /// passes phrase id
  final ValueChanged<String> onDeletePhraseTap;
  final ValueChanged<String> onEditPhraseTap;
  final ValueChanged<String> onSelectPhrase;
  final TextEditingController searchController;
  final List<Phrase> mixedPhrases;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _canBuildPhrases = Mapper.checkCanLoopList(mixedPhrases) == true;
    final List<Phrase> _enListBeforeSorting = Phrase.searchPhrasesByLang(
      phrases: mixedPhrases,
      langCode: 'en',
    );
    // final List<Phrase> _arList = arPhrases; //Phrase.sortPhrasesByID(phrases: arPhrases);
    final List<Phrase> _enList = Phrase.sortPhrasesByIDAndLang(phrases: _enListBeforeSorting);
    // --------------------
    return PageBubble(
      screenHeightWithoutSafeArea: screenHeight,
      appBarType: AppBarType.search,
      color: Colorz.black125,
      child: _canBuildPhrases == false ? null :
      Scroller(
        controller: scrollController,
        child: ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: Ratioz.horizon),
            itemCount: _enList.length,
            itemBuilder: (_, index){

              // final int _number = index + 1;

              // final bool _canBuild = _number <= _enList.length && _number <= _arList.length;

              final Phrase _enPhrase = _enList[index];
              final Phrase _arPhrase = Phrase.searchPhraseByIDAndLangCode(
                phid: _enPhrase.id,
                phrases: mixedPhrases,
                langCode: 'ar',
              );

              if (_arPhrase == null){
                return BldrsBox(
                  width: BldrsAppBar.width(context) - 20,
                  height: 50,
                  color: Colorz.bloodTest,
                  verse: Verse.plain('${_enPhrase.id} : ${_enPhrase.value} : ar is null'),
                  verseScaleFactor: 0.7,
                  verseCentered: false,
                  verseWeight: VerseWeight.thin,
                  onTap: (){

                    final List<Phrase> _phrases = mixedPhrases.where((element) => element.id == _enPhrase.id).toList();
                    Phrase.blogPhrases(_phrases);

                  },
                );
              }

              else {
                return PhraseStrip(
                  width: BldrsAppBar.width(context) - 20,
                  searchController: searchController,
                  enPhrase: _enPhrase,
                  arPhrase: _arPhrase,
                  onCopyValue: onCopyValue,
                  onDelete: () => onDeletePhraseTap(_enPhrase.id),
                  onEdit: () => onEditPhraseTap(_enPhrase.id),
                  onSelect: () => onSelectPhrase(_enPhrase.id),
                );
              }

            }
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
