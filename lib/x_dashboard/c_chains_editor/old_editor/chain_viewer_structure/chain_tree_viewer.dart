import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/x_dashboard/c_chains_editor/old_editor/chain_viewer_structure/chain_tree_strip.dart';
import 'package:flutter/material.dart';

class ChainTreeViewer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainTreeViewer({
    @required this.width,
    @required this.chain,
    @required this.onStripTap,
    @required this.searchValue,
    @required this.index,
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
  final int index;
  /// --------------------------------------------------------------------------
  @override
  State<ChainTreeViewer> createState() => _ChainTreeViewerState();
  /// --------------------------------------------------------------------------
}

class _ChainTreeViewerState extends State<ChainTreeViewer> {
  // -----------------------------------------------------------------------------
  ValueNotifier<bool> _expanded;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _expanded = ValueNotifier(widget.initiallyExpanded);
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _expanded.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _triggerExpansion(){
    _expanded.value = !_expanded.value;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _sonsAreChain = Chain.checkIsChains(widget.chain?.sons);
    final bool _sonsArePhids = Phider.checkIsPhids(widget.chain?.sons);
    final bool _sonsAreDataCreators = DataCreation.checkIsDataCreator(widget.chain?.sons);
    final int _numberOfSons =
    _sonsAreChain ? widget.chain?.sons?.length
        :
    _sonsArePhids ? widget.chain?.sons?.length
        :
    1;
    // --------------------
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
                      index: index,
                    );
                  }
              ),

            /// WHEN CHAIN SONS ARE PHIDS
            if (_sonsArePhids == true) // its a List<String>
              SizedBox(
                width: widget.width,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _numberOfSons,
                    shrinkWrap: true,
                    itemBuilder: (_, index){
                      final String keywordID = widget.chain.sons[index];
                      return ChainTreeStrip(
                        width: widget.width,
                        level: widget.initialLevel + 1,
                        phid: keywordID,
                        phraseValue: '${index + 1} - ${xPhrase( context, keywordID)}',
                        onTriggerExpansion: (){},
                        onStripTap: (String sonID) => widget.onStripTap('${widget.chain.id}/$sonID/'),
                        searchValue: widget.searchValue,
                      );

                    }
                ),
              ),

            /// DATE CREATOR
            if (_sonsAreDataCreators == true)
              ChainTreeStrip(
                width: widget.width,
                level: widget.initialLevel + 1,
                phid: DataCreation.cipherDataCreator(widget.chain?.sons),
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
                phid: widget.chain?.id,
                phraseValue: '${widget.index + 1} - ${xPhrase( context, widget.chain?.id)}',
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
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
