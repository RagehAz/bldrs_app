import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/components/chain_son_button.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainViewSearching extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainViewSearching({
    @required this.boxWidth,
    @required this.foundPhids,
    @required this.foundChains,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final ValueNotifier<List<String>> foundPhids;
  final ValueNotifier<List<Chain>> foundChains;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    final List<Chain> _allChains = _chainsProvider.keywordsChain.sons;
// -----------------------------------------------------------------------------
    return ValueListenableBuilder(
        valueListenable: foundPhids,
        builder: (_, List<String> _foundPhids, Widget childA){

          return ValueListenableBuilder(
              valueListenable: foundChains,
              builder: (_, List<Chain> _foundChains, Widget childB){

                final bool _noResultsFound =
                    Mapper.canLoopList(_foundPhids) == false
                        &&
                        Mapper.canLoopList(_foundChains) == false;


                return Column(
                  children: <Widget>[

                    /// FOUND SEARCH RESULT
                    if (Mapper.canLoopList(_foundPhids) == true)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _foundPhids.length,
                          itemBuilder: (_, index) {

                            final String _phidk = _foundPhids[index];

                            final Chain _chain = Chain.getChainFromChainsByID(
                              chainID: _phidk,
                              chains: _allChains,
                            );

                            final bool _phidIncludedInFoundChains = Chain.chainsIncludeThisPhid(
                              chains: _foundChains,
                              phid: _phidk,
                            );

                            blog('_phidIncludedInFoundChains : $_phidIncludedInFoundChains : _phidk : $_phidk : foundChains : $foundChains');

                            /// NOTHING : WHEN ITS A CHAIN
                            if (_chain != null){

                              return const SizedBox();

                              // return ChainExpander(
                              //   icon: _chainsProvider.getKeywordIcon(
                              //     context: context,
                              //     son: _phidk,
                              //   ),
                              //   width: width,
                              //   firstHeadline: superPhrase(context, _phidk),
                              //   secondHeadline: null,
                              //   chain: _chain,
                              //   initiallyExpanded: true,
                              //   margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
                              //
                              // );
                            }

                            // /// NOTHING WHEN KEYWORD IS INCLUDED IN THE CHAIN
                            // else if (_phidIncludedInFoundChains == true){
                            //   return const SizedBox();
                            // }

                            /// DREAMBOX WHEN KEYWORD IS NOT INCLUDED IN THE CHAIN
                            else {

                              return ChainSonButton(
                                boxWidth: boxWidth,
                                phid: _phidk,
                                onTap: () async {},
                              );

                            }

                          }
                      ),

                    /// DID NOT FIND SEARCH RESULT
                    if (_noResultsFound == true)
                      SuperVerse(
                        verse: superPhrase(context, 'phid_nothing_found'),
                      ),

                  ],
                );

              }
          );

        }
    );

  }
}
