import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/back_anb_search_button.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/buttons/keywords_buttons/sections_button.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:flutter/material.dart';

/// DEPRECATED
class LineWithSectionAndSearchButtons extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LineWithSectionAndSearchButtons({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _zoneHasChains = ChainsProvider.proGetThisZoneHasChains(context: context);
    final bool _loadingChains = ChainsProvider.proGetIsLoadingChains(context: context);

    if (_loadingChains == false && _zoneHasChains == false){
      return const SizedBox();
    }

    else {
      return LineBox(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
            child: SectionsButton(),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
            child: BackAndSearchButton(
              backAndSearchAction: BackAndSearchAction.goToSearchScreen,
              loading: _loadingChains,
            ),
          ),

        ],
      );
    }

  }
  // -----------------------------------------------------------------------------
}
