import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/expanding_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class Inception extends StatelessWidget {
  final dynamic son;
  final int level;
  final double boxWidth;

  const Inception({
    @required this.son,
    this.level = 0,
    this.boxWidth,
  });

  static const double buttonHeight = 60;

  @override
  Widget build(BuildContext context) {

    final _offset = (2 * Ratioz.appBarMargin) * level;

    final double _screenWidth = Scale.superScreenWidth(context);
    const double _buttonHeight = buttonHeight;
    final double _boxWidth = boxWidth ?? _screenWidth - (2 * Ratioz.appBarMargin);
    final double _buttonWidth = _boxWidth - _offset;

    final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);


    if(son.runtimeType == KW){

      return
        DreamBox(
          width: _buttonWidth,
          height: _buttonHeight,
          icon: _keywordsProvider.getIcon(son),
          verse: Name.getNameByCurrentLingoFromNames(context, son.names),
          verseScaleFactor: 0.7,
          verseCentered: false,
          color: Colorz.white20,
          margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
        );

    }

    else if (son.runtimeType == Chain){

      final Chain _chain = son;
      final List<dynamic> _sons = _chain.sons;

      return

        ExpandingTile(
          icon: _keywordsProvider.getIcon(son),
          width: _buttonWidth,
          collapsedHeight: _buttonHeight,
          firstHeadline: Name.getNameByCurrentLingoFromNames(context, son.names),
          secondHeadline: null,
          margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
          child: Column(
            children: <Widget>[

              ...List.generate(_sons.length,
                      (index) {
                    dynamic son = _sons[index];

                    return Inception(
                      son: son,
                      level: level + 1,
                      boxWidth: _boxWidth,
                    );
                  }
              ),
            ],

          ),

        );

    }

    else {

      return
        const BldrsName(size: 40);

    }

  }
}
