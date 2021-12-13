import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/b_views/widgets/general/chain_expander/components/inception.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:flutter/material.dart';

class BldrsChain extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsChain({
    this.boxWidth,
    this.chain,
    this.onKeywordTap,
    this.selectedKeywordsIDs,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double boxWidth;
  final Chain chain;
  final ValueChanged<KW> onKeywordTap;
  final List<String> selectedKeywordsIDs;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _boxWidth = boxWidth ?? Scale.superScreenWidth(context);
    final Chain _allChains = chain ?? Chain.bldrsChain;

    return SizedBox(
      width: _boxWidth,
      // height: _allChains.sons.length * Inception.buttonHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (Mapper.canLoopList(_allChains.sons))
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _allChains.sons.length,
                itemBuilder: (_, index) {
                  final dynamic _son = _allChains.sons[index];
                  return Inception(
                    son: _son,
                    boxWidth: _boxWidth,
                    onKeywordTap: onKeywordTap,
                    selectedKeywordsIDs: selectedKeywordsIDs,
                  );
                }),

          //   if(Mapper.canLoopList(_allChains.sons))
          // ...List<Widget>.generate(_allChains.sons.length, (int index){
          //
          //       final dynamic _son = _allChains.sons[index];
          //
          //       return Inception(
          //         son: _son,
          //         boxWidth: _boxWidth,
          //         onKeywordTap: onKeywordTap,
          //         selectedKeywordsIDs: selectedKeywordsIDs,
          //       );
          //
          // }),
        ],
      ),

      // ListView.builder(
      //   physics: const NeverScrollableScrollPhysics(),
      //   itemCount: _allChains.sons.length,
      //   shrinkWrap: false,
      //   itemExtent: Inception.buttonHeight + Ratioz.appBarMargin,
      //   itemBuilder: (BuildContext ctx, int index){
      //
      //     dynamic _son = _allChains.sons[index];
      //
      //     return Inception(
      //       _son: _son,
      //       level: 0,
      //       boxWidth: _boxWidth,
      //     );
      //
      //   },
      // ),
    );
  }
}
