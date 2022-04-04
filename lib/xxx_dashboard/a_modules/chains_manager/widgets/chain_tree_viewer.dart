import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/xxx_dashboard/a_modules/chains_manager/widgets/chain_tree_strip.dart';
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
    final bool _sonsAreChain = Chain.sonsAreChains(widget.chain?.sons);
    final bool _sonsAreStrings = Chain.sonsAreStrings(widget.chain?.sons);
    final int _numberOfSons =
    _sonsAreChain ? widget.chain?.sons?.length
        :
    _sonsAreStrings ? widget.chain?.sons?.length
        :
    1
    ;

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
            if (_sonsAreStrings == true) // its a List<String>
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

            /// OTHERWISE
            if (_sonsAreChain == false && _sonsAreStrings == false)
              ChainTreeStrip(
                level: widget.initialLevel + 1,
                secondLine: widget.chain?.id,
                firstLine: widget.chain?.sons?.toString(),
                onTriggerExpansion: _triggerExpansion,
              ),

          ],
        ),
        builder: (_, bool _isExpanded, Widget sonsWidgets){

          return Column(

            children: <Widget>[

              /// chain title
              ChainTreeStrip(
                level: widget.initialLevel,
                secondLine: widget.chain?.id,
                firstLine: superPhrase(context, widget.chain?.id),
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
