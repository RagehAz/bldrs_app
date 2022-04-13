import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/widgets/chain_tree_strip.dart';
import 'package:flutter/material.dart';

class ChainTreeViewer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainTreeViewer({
    @required this.chain,
    @required this.onStripTap,
    this.initialLevel = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  final int initialLevel;
  final ValueChanged<String> onStripTap;
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
                      onStripTap: (String sonID) => widget.onStripTap('${widget.chain.id}/$sonID'),
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
                      phraseID: keywordID,
                      phraseValue: superPhrase(context, keywordID),
                      onTriggerExpansion: (){},
                      onStripTap: (String sonID) => widget.onStripTap('${widget.chain.id}/$sonID'),
                    );

                  }
              ),

            /// OTHERWISE
            if (_sonsAreChain == false && _sonsAreStrings == false)
              ChainTreeStrip(
                level: widget.initialLevel + 1,
                phraseID: widget.chain?.id,
                phraseValue: widget.chain?.sons?.toString(),
                onTriggerExpansion: _triggerExpansion,
                onStripTap: (String sonID) => widget.onStripTap('${widget.chain.id}/$sonID'),
              ),

          ],
        ),
        builder: (_, bool _isExpanded, Widget sonsWidgets){

          return Column(

            children: <Widget>[

              /// chain title
              ChainTreeStrip(
                level: widget.initialLevel,
                phraseID: widget.chain?.id,
                phraseValue: superPhrase(context, widget.chain?.id),
                expanded: _isExpanded,
                onTriggerExpansion: _triggerExpansion,
                onStripTap: (String sonID) => widget.onStripTap(sonID),
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
