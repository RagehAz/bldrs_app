import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/b_chain_box.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TASK : NEED TO MERGE THIS WIDGET WITH THIS [@KeywordBarButton]
class ChainSonButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSonButton({
    @required this.sonWidth,
    @required this.onTap,
    @required this.phid,
    this.color = Colorz.white20,
    this.parentLevel = 1,
    this.isDisabled = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double sonWidth;
  final Color color;
  final String phid; // phrase id
  final Function onTap;
  final int parentLevel;
  final bool isDisabled;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    // final double _offset = (2 * Ratioz.appBarMargin) * parentLevel;
    // final double _screenWidth = Scale.superScreenWidth(context);
    // final double _boxWidth = boxWidth ?? _screenWidth - (2 * Ratioz.appBarMargin);
    // final double buttonWidth = _boxWidth - _offset - (level * 30);

    // final double buttonWidth = ChainBox.getSonWidth(
    //   parentWidth: sonWidth,
    //   parentLevel: parentLevel,
    // );

    return ChainBox(
      boxWidth: sonWidth,
      child: DreamBox(
        height: ChainBox.sonHeight(),
        width: sonWidth,
        color: color,
        verse: superPhrase(context, phid),
        // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
        icon: _chainsProvider.getKeywordIcon(
          context: context,
          son: phid,
        ),
        verseScaleFactor: 0.7,
        verseCentered: false,
        verseMaxLines: 2,
        bubble: false,
        verseShadow: false,
        verseItalic: true,
        onTap: onTap,
      ),
    );

  }
}
