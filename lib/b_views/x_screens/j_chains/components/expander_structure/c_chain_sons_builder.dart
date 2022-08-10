import 'package:bldrs/b_views/x_screens/j_chains/components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainSonsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSonsBuilder({
    @required this.sons,
    @required this.width,
    @required this.parentLevel,
    @required this.onPhidTap,
    @required this.selectedPhids,
    @required this.initiallyExpanded,
    this.searchText,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic sons;
  final double width;
  final int parentLevel;
  final ValueChanged<String> onPhidTap;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<String> searchText;
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

            ...List.generate(sons?.length ?? 0, (index){

              final dynamic _chain = sons[index];

              return Container(
                width: _sonWidth,
                margin: const EdgeInsets.only(
                  bottom: Ratioz.appBarPadding,
                  left: Ratioz.appBarPadding,
                  right: Ratioz.appBarPadding,
                ),
                child: ChainSplitter(
                  chainOrChainsOrSonOrSons: _chain,
                  width: _sonWidth,
                  onSelectPhid: onPhidTap,
                  selectedPhids: selectedPhids,
                  initiallyExpanded: initiallyExpanded,
                  parentLevel: parentLevel+1,
                  searchText: searchText,
                ),
              );

            }),

          ],
        ),

      ),

    );
  }
}
