import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/d_chain_son_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainViewSearching extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainViewSearching({
    @required this.bubbleWidth,
    @required this.foundPhids,
    @required this.foundChains,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  final ValueNotifier<List<String>> foundPhids; /// p
  final ValueNotifier<List<Chain>> foundChains; /// p
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    final List<Chain> _allCityChains = _chainsProvider.cityKeywordsChain.sons;
// -----------------------------------------------------------------------------
    return ValueListenableBuilder(
        valueListenable: foundPhids,
        builder: (_, List<String> _foundPhids, Widget childA){

          return ValueListenableBuilder(
              valueListenable: foundChains,
              builder: (_, List<Chain> _foundChains, Widget childB){

                final bool _noResultsFound =
                    Mapper.checkCanLoopList(_foundPhids) == false
                        &&
                        Mapper.checkCanLoopList(_foundChains) == false;


                return Column(
                  children: <Widget>[

                    /// FOUND SEARCH RESULT
                    if (Mapper.checkCanLoopList(_foundPhids) == true)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _foundPhids.length,
                          itemBuilder: (_, index) {

                            final String _phidk = _foundPhids[index];

                            final Chain _chain = Chain.getChainFromChainsByID(
                              chainID: _phidk,
                              chains: _allCityChains,
                            );

                            // final bool _phidIncludedInFoundChains = Chain.chainsIncludeThisPhid(
                            //   chains: _foundChains,
                            //   phid: _phidk,
                            // );

                            // blog('_phidIncludedInFoundChains : $_phidIncludedInFoundChains : _phidk : $_phidk : foundChains : ${foundChains.value}');

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

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Ratioz.appBarPadding,
                                    horizontal: Ratioz.appBarMargin,
                                ),
                                child: ChainSonButton(
                                  sonWidth: bubbleWidth,
                                  phid: _phidk,
                                  // isDisabled: false,
                                  parentLevel: 2,
                                  onTap: (){
                                    blog(_phidk);
                                  }
                                ),
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
