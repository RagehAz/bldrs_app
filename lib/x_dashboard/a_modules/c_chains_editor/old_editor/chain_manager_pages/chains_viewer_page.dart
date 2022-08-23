import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/old_editor/chain_viewer_structure/chains_tree_starter.dart';
import 'package:flutter/material.dart';

class ChainViewerPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainViewerPage({
    @required this.screenHeight,
    @required this.isSearching,
    @required this.foundChains,
    @required this.onStripTap,
    @required this.searchValue,
    @required this.allChains,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<bool> isSearching;
  final ValueNotifier<List<Chain>> foundChains;
  final ValueChanged<String> onStripTap;
  final ValueNotifier<String> searchValue;
  final List<Chain> allChains;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return PageBubble(
      screenHeightWithoutSafeArea: screenHeight,
      appBarType: AppBarType.search,
      color: Colorz.white20,
      child: ValueListenableBuilder<bool>(
        valueListenable: isSearching,
        builder: (_, bool isSearching, Widget child){

          if (isSearching == true){
            return ValueListenableBuilder(
                valueListenable: foundChains,
                builder: (_, List<Chain> foundChains, Widget child){

                  return ChainsTreesStarter(
                    width: PageBubble.width(context),
                    chains: foundChains,
                    onStripTap: onStripTap,
                    searchValue: searchValue,
                  );

                }
            );
          }

          else {
            return ChainsTreesStarter(
              width: PageBubble.width(context),
              chains: allChains,
              onStripTap: onStripTap,
              searchValue: searchValue,
            );
          }

        },
      ),
    );
  }
}
