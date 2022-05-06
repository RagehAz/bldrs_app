import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chain_viewer_structure/chain_tree_strip.dart';
import 'package:flutter/material.dart';

class ChainTreeViewer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainTreeViewer({
    @required this.width,
    @required this.chain,
    @required this.onStripTap,
    @required this.searchValue,
    this.initialLevel = 1,
    this.initiallyExpanded = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final Chain chain;
  final int initialLevel;
  final ValueChanged<String> onStripTap;
  final ValueNotifier<String> searchValue;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  State<ChainTreeViewer> createState() => _ChainTreeViewerState();
/// --------------------------------------------------------------------------
}

class _ChainTreeViewerState extends State<ChainTreeViewer> {
// -----------------------------------------------------------------------------
  ValueNotifier<bool> _expanded; /// tamam disposed
// ----------------------------------------------
  @override
  void initState() {
    super.initState();
    _expanded = ValueNotifier(widget.initiallyExpanded);
  }
// ----------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _expanded.dispose();
  }
// ----------------------------------------------
  void _triggerExpansion(){
    _expanded.value = !_expanded.value;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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
      width: widget.width,
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
                      width: widget.width,
                      chain: son,
                      initialLevel: widget.initialLevel + 1,
                      onStripTap: (String sonID) => widget.onStripTap('${widget.chain.id}/$sonID'),
                      searchValue: widget.searchValue,
                      initiallyExpanded: widget.initiallyExpanded,
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
                      width: widget.width,
                      level: widget.initialLevel + 1,
                      phraseID: keywordID,
                      phraseValue: superPhrase(context, keywordID),
                      onTriggerExpansion: (){},
                      onStripTap: (String sonID) => widget.onStripTap('${widget.chain.id}/$sonID/'),
                      searchValue: widget.searchValue,
                    );

                  }
              ),

            /// OTHERWISE
            if (_sonsAreChain == false && _sonsAreStrings == false)
              ChainTreeStrip(
                width: widget.width,
                level: widget.initialLevel + 1,
                phraseID: widget.chain?.id,
                phraseValue: widget.chain?.sons?.toString(),
                onTriggerExpansion: _triggerExpansion,
                onStripTap: (String sonID) => widget.onStripTap('${widget.chain.id}/$sonID'),
                searchValue: widget.searchValue,
              ),

          ],
        ),
        builder: (_, bool _isExpanded, Widget sonsWidgets){

          return Column(

            children: <Widget>[

              /// chain title
              ChainTreeStrip(
                width: widget.width,
                level: widget.initialLevel,
                phraseID: widget.chain?.id,
                phraseValue: superPhrase(context, widget.chain?.id),
                expanded: _isExpanded,
                onTriggerExpansion: _triggerExpansion,
                onStripTap: (String sonID) => widget.onStripTap('$sonID/'),
                searchValue: widget.searchValue,
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
