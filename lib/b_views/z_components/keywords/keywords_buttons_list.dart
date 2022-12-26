import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhidsButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsButtonsList({
    @required this.buttonWidth,
    @required this.phids,
    @required this.onPhidTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double buttonWidth;
  final List<String> phids;
  final Function onPhidTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    return Container(
      width: buttonWidth,
      height: ExpandingTile.collapsedTileHeight * phids.length,
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      color: Colorz.bloodTest,
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: phids.length,
        itemExtent: ExpandingTile.collapsedTileHeight + Ratioz.appBarPadding,
        // shrinkWrap: false,
        // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
        itemBuilder: (BuildContext ctx, int index) {

          final String _phid = phids[index];

          final String _icon = _chainsProvider.getPhidIcon(
              context: context,
              son: _phid,
          );

          final String _enName = _chainsProvider.translatePhid(
            phid: _phid,
            langCode: 'en',
          );

          final String _arName = _chainsProvider.translatePhid(
            phid: _phid,
            langCode: 'ar',
          );

          return DreamBox(
            height: ExpandingTile.collapsedTileHeight,
            width: buttonWidth - (Ratioz.appBarMargin * 2),
            icon: _icon,
            verse: Verse.plain(_enName),
            secondLine: Verse.plain(_arName),
            verseScaleFactor: 0.7,
            verseCentered: false,
            bubble: false,
            color: Colorz.white20,
            margins: const EdgeInsets.only(
                bottom: ExpandingTile.buttonVerticalPadding
            ),
            onTap: () async {
              await onPhidTap(_phid);
            },
          );

        },
      ),
    );

  }
/// --------------------------------------------------------------------------
}
