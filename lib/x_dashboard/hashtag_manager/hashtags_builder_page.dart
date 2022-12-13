import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class HashtagsBuilderPage extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const HashtagsBuilderPage({
    @required this.chain,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Chain chain;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
      itemCount: chain.sons.length,
      itemBuilder: (BuildContext context, int index) {

        final dynamic _son = chain.sons[index];

        return ChainSplitter(
          width: PageBubble.width(context),
          chainOrChainsOrSonOrSons: _son,
          initiallyExpanded: true,
          secondLinesType: ChainSecondLinesType.non,
          // level: 0,
          onPhidTap: (String path, String phid){
            blog('onPhidTap : path: $path, phid: $phid');
          },
          onPhidLongTap: (String path, String phid){
            blog('onPhidLongTap : path: $path, phid: $phid');
          },
          onPhidDoubleTap: (String path, String phid){
            blog('onPhidDoubleTap : path: $path, phid: $phid');
          },
          selectedPhids: const [],
          searchText: null,
          onExportSpecs: null,
          zone: null,
          onlyUseCityChains: false,
          isMultipleSelectionMode: false,
          isCollapsable: false,
        );
      },
    );

    // return PageBubble(
    //   screenHeightWithoutSafeArea: _screenHeight - 21,
    //   appBarType: AppBarType.search,
    //   color: Colorz.white10,
    //   child: ListView.builder(
    //     physics: const BouncingScrollPhysics(),
    //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //     itemCount: chain.sons.length,
    //     itemBuilder: (BuildContext context, int index) {
    //
    //       final dynamic _son = chain.sons[index];
    //
    //       return ChainSplitter(
    //         width: PageBubble.clearWidth(context),
    //         chainOrChainsOrSonOrSons: _son,
    //         initiallyExpanded: true,
    //         secondLinesType: ChainSecondLinesType.non,
    //         onPhidTap: (String path, String phid){
    //           blog('onPhidTap : path: $path, phid: $phid');
    //         },
    //         onPhidLongTap: (String path, String phid){
    //           blog('onPhidLongTap : path: $path, phid: $phid');
    //         },
    //         onPhidDoubleTap: (String path, String phid){
    //           blog('onPhidDoubleTap : path: $path, phid: $phid');
    //         },
    //         selectedPhids: const [],
    //         searchText: null,
    //         onExportSpecs: null,
    //         zone: null,
    //         onlyUseCityChains: false,
    //         isMultipleSelectionMode: false,
    //         isCollapsable: false,
    //       );
    //     },
    //   ),
    // );

  }
  // -----------------------------------------------------------------------------
}
