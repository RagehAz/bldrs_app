import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/views/widgets/general/chain_expander/components/inception.dart';
import 'package:flutter/material.dart';

class BldrsChain extends StatelessWidget {
  final double boxWidth;
  final Chain chain;
  final ValueChanged<KW> onKeywordTap;
  final List<String> selectedKeywordsIDs;

  const BldrsChain({
    this.boxWidth,
    this.chain,
    this.onKeywordTap,
    this.selectedKeywordsIDs,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _boxWidth = boxWidth ?? Scale.superScreenWidth(context);
    final Chain _allChains = chain ?? Chain.bldrsChain;

    return Container(
      width: _boxWidth,
      // height: _allChains.sons.length * Inception.buttonHeight,
      child:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            if(Mapper.canLoopList(_allChains.sons))
            ...List<Widget>.generate(_allChains.sons.length, (int index){

                  dynamic son = _allChains.sons[index];

                  return Inception(
                    son: son,
                    boxWidth: _boxWidth,
                    onKeywordTap: onKeywordTap,
                    selectedKeywordsIDs: selectedKeywordsIDs,
                  );

            }),

          ],
        ),

      // ListView.builder(
      //   physics: const NeverScrollableScrollPhysics(),
      //   itemCount: _allChains.sons.length,
      //   shrinkWrap: false,
      //   itemExtent: Inception.buttonHeight + Ratioz.appBarMargin,
      //   itemBuilder: (BuildContext ctx, int index){
      //
      //     dynamic son = _allChains.sons[index];
      //
      //     return Inception(
      //       son: son,
      //       level: 0,
      //       boxWidth: _boxWidth,
      //     );
      //
      //   },
      // ),


    );
  }
}
