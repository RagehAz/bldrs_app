import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/chain.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/expanding_tile.dart';

class BldrsChains extends StatelessWidget {
  final double boxWidth;

  const BldrsChains({
    this.boxWidth,
  });

  @override
  Widget build(BuildContext context) {

    final Chain _allChains = Chain.bldrsChain;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _allChains.sons.length,
      shrinkWrap: false,
      itemBuilder: (ctx, index){

        dynamic son = _allChains.sons[index];

        return Inception(
          son: son,
          level: 0,
          boxWidth: boxWidth,
        );

      },
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

  @override
  Widget build(BuildContext context) {

    final _offset = (2 * Ratioz.appBarMargin) * level;

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _buttonHeight = 60;
    final double _boxWidth = boxWidth ?? _screenWidth - (2 * Ratioz.appBarMargin);
    final double _buttonWidth = _boxWidth - _offset;

    if(son.runtimeType == KW){

      return
        DreamBox(
          width: _buttonWidth,
          height: _buttonHeight,
          icon: Keyword.getImagePath(son.id),
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
          icon: Keyword.getImagePath(son.id),
          width: _buttonWidth,
          collapsedHeight: _buttonHeight,
          firstHeadline: Name.getNameByCurrentLingoFromNames(context, son.names),
          secondHeadline: null,
          margin: EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
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
