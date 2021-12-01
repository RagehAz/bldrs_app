import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/chain_expander/components/expanding_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inception extends StatelessWidget {
  final dynamic son;
  final int level;
  final double boxWidth;
  final ValueChanged<KW> onKeywordTap;
  final List<String> selectedKeywordsIDs;

  const Inception({
    @required this.son,
    this.level = 0,
    this.boxWidth,
    this.onKeywordTap,
    this.selectedKeywordsIDs,
    Key key,
  }) : super(key: key);

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

      final KW _kw = son;
      final bool _isSelected = Mapper.stringsContainString(strings: selectedKeywordsIDs, string: _kw.id);
      final Color _color = _isSelected == true ? Colorz.green255 : Colorz.white20;

      return
        DreamBox(
          width: _buttonWidth,
          height: _buttonHeight,
          icon: _keywordsProvider.getIcon(son: _kw, context: context),
          verse: Name.getNameByCurrentLingoFromNames(context, _kw.names),
          verseScaleFactor: 0.7,
          verseCentered: false,
          color: _color,
          margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
          onTap: () => onKeywordTap(_kw),
        );

    }

    else if (son.runtimeType == Chain){

      final Chain _chain = son;
      final List<dynamic> _sons = _chain.sons;

      return

        ExpandingTile(
          icon: _keywordsProvider.getIcon(son: son, context: context),
          width: _buttonWidth,
          collapsedHeight: _buttonHeight,
          firstHeadline: Name.getNameByCurrentLingoFromNames(context, son.names),
          secondHeadline: null,
          margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
          child: Column(
            children: <Widget>[

              ...List<Widget>.generate(_sons.length,
                      (int index) {
                    dynamic son = _sons[index];

                    return Inception(
                      son: son,
                      level: level + 1,
                      boxWidth: _boxWidth,
                      selectedKeywordsIDs: selectedKeywordsIDs,
                      onKeywordTap: onKeywordTap,
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
