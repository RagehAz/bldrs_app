import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/a_chains_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class ChainsScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreenSearchView({
    @required this.screenHeight,
    @required this.foundChains,
    @required this.selectedPhids,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<List<Chain>> foundChains;
  final List<String> selectedPhids;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: foundChains,
        builder: (_, List<Chain> chains, Widget child){

          Chain.blogChains(chains);

          return PageBubble(
            screenHeightWithoutSafeArea: screenHeight,
            appBarType: AppBarType.search,
            child: ChainSplitter(
              chainOrChainsOrSonOrSons: chains,
              width: BldrsAppBar.width(context) - 10,
              onPhidTap: (String phid) => onSelectPhid(
                phid: phid,
              ),
              selectedPhids: selectedPhids,
              initiallyExpanded: true,
            ),
          );

        }
    );
  }
}
