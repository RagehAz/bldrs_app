import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/buttons/expander_button/b_expanding_tile.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhidsButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsButtonsList({
    required this.buttonWidth,
    required this.phids,
    required this.onPhidTap,
    super.key
  });
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
      height: BldrsExpandingButton.collapsedTileHeight * phids.length,
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      color: Colorz.bloodTest,
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: phids.length,
        itemExtent: BldrsExpandingButton.collapsedTileHeight + Ratioz.appBarPadding,
        // shrinkWrap: false,
        // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
        itemBuilder: (BuildContext ctx, int index) {

          final String _phid = phids[index];

          final String? _icon = _chainsProvider.getPhidIcon(
              son: _phid,
          );

          final String? _enName = _chainsProvider.translateChainPhid(
            phid: _phid,
            langCode: 'en',
          );

          final String? _arName = _chainsProvider.translateChainPhid(
            phid: _phid,
            langCode: 'ar',
          );

          return BldrsBox(
            height: BldrsExpandingButton.collapsedTileHeight,
            width: buttonWidth - (Ratioz.appBarMargin * 2),
            icon: _icon,
            verse: Verse.plain(_enName),
            secondLine: Verse.plain(_arName),
            verseScaleFactor: 0.7,
            verseCentered: false,
            bubble: false,
            color: Colorz.white20,
            margins: const EdgeInsets.only(
                bottom: BldrsExpandingButton.buttonVerticalPadding
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
