import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ChainsScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreenSearchView({
    @required this.screenHeight,
    @required this.foundChains,
    @required this.selectedSpecs,
    @required this.searchText,
    @required this.onSelectPhid,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<List<Chain>> foundChains;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final Function(String path, String phid) onSelectPhid;
  final ValueNotifier<String> searchText;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: foundChains,
        builder: (_, List<Chain> _foundChains, Widget childB){

          final bool _noResultsFound = Mapper.checkCanLoopList(_foundChains) == false;

          /// NO RESULT FOUND
          if (_noResultsFound == true){
            return PageBubble(
              screenHeightWithoutSafeArea: screenHeight,
              appBarType: AppBarType.search,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SuperVerse(
                  verse: xPhrase(context, 'phid_nothing_found'),
                  margin: 50,
                  maxLines: 4,
                ),
              ),
            );
          }

          else {

            return PageBubble(
              screenHeightWithoutSafeArea: screenHeight,
              appBarType: AppBarType.search,
              color: Colorz.white20,
              child: ValueListenableBuilder(
                valueListenable: selectedSpecs,
                builder: (_, List<SpecModel> _selectedSpecs, Widget child){

                  return ChainSplitter(
                      chainOrChainsOrSonOrSons: _foundChains,
                      width: PageBubble.clearWidth(context) + 20,
                      selectedPhids: SpecModel.getSpecsIDs(_selectedSpecs),
                      initiallyExpanded: true,
                      onSelectPhid: onSelectPhid,
                      searchText: searchText,
                  );

                },
              ),
            );
          }

        }
    );

  }
}
