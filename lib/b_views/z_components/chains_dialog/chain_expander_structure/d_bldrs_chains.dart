import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/components/inception.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:flutter/material.dart';

class BldrsChain extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsChain({
    @required this.initiallyExpanded,
    this.boxWidth,
    this.chain,
    this.onKeywordTap,
    this.selectedKeywordsIDs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final Chain chain;
  final ValueChanged<String> onKeywordTap;
  final List<String> selectedKeywordsIDs;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxWidth = boxWidth ?? Scale.superScreenWidth(context);

    return SizedBox(
      width: _boxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[

          if (Mapper.canLoopList(chain.sons))
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: chain.sons.length,
                itemBuilder: (_, index) {
                  final dynamic _son = chain.sons[index];
                  return Inception(
                    son: _son,
                    boxWidth: _boxWidth,
                    onKeywordTap: onKeywordTap,
                    selectedKeywordsIDs: selectedKeywordsIDs,
                    initiallyExpanded: initiallyExpanded,
                  );
                }),

        ],
      ),

    );
  }
}
