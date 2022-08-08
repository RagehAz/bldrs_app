import 'package:bldrs/b_views/x_screens/j_chains/components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/d_chain_son_starter.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsBuilder({
    @required this.chains,
    @required this.width,
    @required this.parentLevel,
    @required this.onPhidTap,
    @required this.selectedPhids,
    @required this.initiallyExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic chains;
  final double width;
  final int parentLevel;
  final ValueChanged<String> onPhidTap;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _sonWidth = ChainButtonBox.getSonWidth(
      parentWidth: width,
      parentLevel: parentLevel,
    );

    return SizedBox(
      key: const ValueKey<String>('ChainSonsBuilder'),
      width: width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: Ratioz.appBarPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            ...List.generate(chains.length, (index){

              final dynamic _chain = chains[index];

              return Container(
                width: _sonWidth,
                margin: const EdgeInsets.only(
                  bottom: Ratioz.appBarPadding,
                  left: Ratioz.appBarPadding,
                  right: Ratioz.appBarPadding,
                ),
                child: ChainSonStarter(
                  son: _chain,
                  width: _sonWidth,
                  onPhidTap: onPhidTap,
                  selectedPhids: selectedPhids,
                  initiallyExpanded: initiallyExpanded,
                  parentLevel: parentLevel+1,
                ),
              );

            }),

          ],
        ),

      ),

    );
  }
}
