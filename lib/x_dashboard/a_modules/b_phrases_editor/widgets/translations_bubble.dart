import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/widgets/translation_strip.dart';
import 'package:flutter/material.dart';

class TranslationsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TranslationsBubble({
    @required this.screenHeight,
    @required this.enPhrases,
    @required this.arPhrases,
    @required this.scrollController,
    @required this.onCopyValue,
    @required this.onDeletePhrase,
    @required this.onEditPhrase,
    @required this.searchController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final List<Phrase> enPhrases;
  final List<Phrase> arPhrases;
  final ScrollController scrollController;
  final Function onCopyValue;
  /// passes phrase id
  final ValueChanged<String> onDeletePhrase;
  final ValueChanged<String> onEditPhrase;
  final TextEditingController searchController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _canBuildPhrases =
        Mapper.checkCanLoopList(enPhrases) == true
        &&
        Mapper.checkCanLoopList(arPhrases) == true;

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
            itemCount: arPhrases.length,
            itemBuilder: (_, index){

              final int _number = index + 1;

              final bool _canBuild = _number <= arPhrases.length && _number <= enPhrases.length;

              final Phrase _enPhrase = _canBuild  ? enPhrases[index]  : null;
              final Phrase _arPhrase = _canBuild  ? arPhrases[index] : null;

              return TranslationStrip(
                width: BldrsAppBar.width(context) - 20,
                searchController: searchController,
                enPhrase: _enPhrase,
                arPhrase: _arPhrase,
                onCopyValue: onCopyValue,
                onDelete: () => onDeletePhrase(_enPhrase.id),
                onEdit: () => onEditPhrase(_enPhrase.id),
              );


            }
        ),
      ),
    );

  }
}
