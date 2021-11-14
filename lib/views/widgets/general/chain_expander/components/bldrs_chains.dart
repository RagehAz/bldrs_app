import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/views/widgets/general/chain_expander/components/inception.dart';
import 'package:flutter/material.dart';

class BldrsChain extends StatelessWidget {
  final double boxWidth;
  final Chain chain;

  const BldrsChain({
    this.boxWidth,
    this.chain,
  });

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            ...List.generate(_allChains.sons.length, (index){

                  dynamic son = _allChains.sons[index];

                  return Inception(
                    son: son,
                    level: 0,
                    boxWidth: _boxWidth,
                  );

            }),

          ],
        ),

      // ListView.builder(
      //   physics: const NeverScrollableScrollPhysics(),
      //   itemCount: _allChains.sons.length,
      //   shrinkWrap: false,
      //   itemExtent: Inception.buttonHeight + Ratioz.appBarMargin,
      //   itemBuilder: (ctx, index){
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

