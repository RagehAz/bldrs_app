import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/chain_expander_structure/d_bldrs_chains.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/chain_expander_structure/b_expanding_tile.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainExpander extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainExpander({
    @required this.chain,
    @required this.width,
    // @required this.onTap,
    @required this.icon,
    @required this.firstHeadline,
    @required this.secondHeadline,
    @required this.initiallyExpanded,
    this.inActiveMode = false,
    this.margin,
    this.initialColor = Colorz.black50,
    this.expansionColor = Colorz.white20,
    this.onKeywordTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  final bool inActiveMode;
  final double width;
  // final ValueChanged<bool> onTap;
  final String icon;
  final String firstHeadline;
  final String secondHeadline;
  final Color initialColor;
  final Color expansionColor;
  final EdgeInsets margin;
  final ValueChanged<String> onKeywordTap;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: inActiveMode == true ? 0.3 : 1,
      child: ExpandingTile(
        key: key,
        width: width,
        margin: margin,
        // onTap: (bool isExpanded) => onTap(isExpanded),
        inActiveMode: inActiveMode,
        // maxHeight: 150,
        icon: icon,
        firstHeadline: firstHeadline,
        secondHeadline: secondHeadline,
        initialColor: initialColor,
        expansionColor: expansionColor,
        child: Container(
          width: width,
          // height: 350,
          decoration: BoxDecoration(
            // color: Colorz.white10, // do no do this
            borderRadius: Borderers.superOneSideBorders(
              context: context,
              corner: ExpandingTile.cornersValue,
              side: AxisDirection.down,
            ),
          ),
          padding: const EdgeInsets.only(
              top: Ratioz.appBarMargin,
              bottom: Ratioz.appBarMargin
          ),

          child: BldrsChain(
            chain: chain,
            boxWidth: width,
            initiallyExpanded: initiallyExpanded,
            onKeywordTap: (String keywordID) => onKeywordTap(keywordID),
          ),

        ),
      ),
    );
  }
}
