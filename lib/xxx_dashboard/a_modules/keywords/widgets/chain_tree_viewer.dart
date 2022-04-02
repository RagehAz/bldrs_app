import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/xxx_dashboard/a_modules/keywords/widgets/chain_tree_strip.dart';
import 'package:flutter/material.dart';

class ChainTreeViewer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainTreeViewer({
    @required this.chain,
    this.initialLevel = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  final int initialLevel;
  /// --------------------------------------------------------------------------
  @override
  State<ChainTreeViewer> createState() => _ChainTreeViewerState();
}

class _ChainTreeViewerState extends State<ChainTreeViewer> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _expanded = ValueNotifier(false);
// ----------------------------------------------
  void _triggerExpansion(){
    _expanded.value = !_expanded.value;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth  = Scale.superScreenWidth(context);
    final int _numberOfSons = widget.chain.sons.length;
    final bool _sonsAreChain = Chain.sonsAreChains(widget.chain.sons);

    return SizedBox(
      width: _screenWidth,
      child: ValueListenableBuilder(
        valueListenable: _expanded,
        child: Column(
          // physics: const NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          children: <Widget>[

            /// WHEN  CHAIN SONS ARE CHAINS
            if (_sonsAreChain == true)
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _numberOfSons,
                  shrinkWrap: true,
                  itemBuilder: (_, index){
                    final Chain son = widget.chain.sons[index];
                    return ChainTreeViewer(
                      chain: son,
                      initialLevel: widget.initialLevel + 1,

                    );
                  }
              ),

            /// WHEN CHAIN SONS ARE STRINGS (PHRASES IDS)
            if (_sonsAreChain == false) // its a List<String>
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _numberOfSons,
                  shrinkWrap: true,
                  itemBuilder: (_, index){
                    final String keywordID = widget.chain.sons[index];
                    return ChainTreeStrip(
                      level: widget.initialLevel + 1,
                      secondLine: keywordID,
                      firstLine: superPhrase(context, keywordID),
                      onTriggerExpansion: (){},
                    );

                  }
              ),

          ],
        ),
        builder: (_, bool _isExpanded, Widget sonsWidgets){

          return Column(

            children: <Widget>[

              /// chain title
              ChainTreeStrip(
                level: widget.initialLevel,
                secondLine: widget.chain.id,
                firstLine: superPhrase(context, widget.chain.id),
                expanded: _isExpanded,
                onTriggerExpansion: _triggerExpansion,
              ),

              if (_isExpanded)
                sonsWidgets,

            ],

          );

        },

      ),
    );
  }
}
