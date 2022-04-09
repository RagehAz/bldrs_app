import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainSonButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSonButton({
    @required this.boxWidth,
    @required this.onTap,
    @required this.phid,
    this.color = Colorz.white20,
    this.level = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final Color color;
  final String phid; // phrase id
  final Function onTap;
  final int level;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    final double _offset = (2 * Ratioz.appBarMargin) * level;
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _boxWidth = boxWidth ?? _screenWidth - (2 * Ratioz.appBarMargin);
    final double buttonWidth = _boxWidth - _offset - ((level + 1) * 30);


    return Container(
      width: _boxWidth,
      alignment: superInverseCenterAlignment(context),
      padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
      child: DreamBox(
        height: 60,
        width: buttonWidth,
        color: color,
        verse: superPhrase(context, phid),
        // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
        icon: _chainsProvider.getKeywordIcon(
          context: context,
          son: phid,
        ),
        margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
        verseScaleFactor: 0.7,
        verseCentered: false,
        verseMaxLines: 2,
        onTap: onTap,
      ),
    );

  }
}
