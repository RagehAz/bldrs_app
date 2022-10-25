import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/x_dashboard/chains_editor/z_components/chain_tree_viewer/c_chain_tree_strip.dart';
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
  final ValueNotifier<dynamic> searchValue;
  final bool initiallyExpanded;
  final int index;
  /// --------------------------------------------------------------------------
  @override
  State<ChainTreeViewer> createState() => _ChainTreeViewerState();
  /// --------------------------------------------------------------------------
}

class _ChainTreeViewerState extends State<ChainTreeViewer> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _expanded = ValueNotifier<bool>(false);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _expanded.value = widget.initiallyExpanded;
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
                  // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
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
                    // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
                    itemBuilder: (_, index){
                      final String keywordID = widget.chain.sons[index];
                      return ChainTreeStrip(
                        width: widget.width,
                        level: widget.initialLevel + 1,
                        phid: keywordID,
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
