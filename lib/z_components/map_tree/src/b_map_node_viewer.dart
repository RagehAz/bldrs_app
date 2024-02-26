part of map_tree;

class _MapNodeViewer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _MapNodeViewer({
    required this.width,
    required this.node,
    required this.parent,
    required this.searchValue,
    required this.index,
    required this.isTop,
    required this.isBottom,
    required this.onLastNodeTap,
    required this.onExpandableNodeTap,
    required this.selectedPaths,
    required this.previousPath,
    required this.myParentIsLastNode,
    required this.myGranpaIsLastNode,
    required this.keywordsMap,
    this.initialLevel = 1,
    this.initiallyExpanded = false,
    this.keyWidth,
  });
  /// --------------------------------------------------------------------------
  final double width;
  final dynamic node;
  final String parent;
  final int initialLevel;
  final ValueNotifier<dynamic>? searchValue;
  final bool initiallyExpanded;
  final int index;
  final double? keyWidth;
  final bool isTop;
  final bool isBottom;
  final Function(String path) onLastNodeTap;
  final Function(String path) onExpandableNodeTap;
  final List<String> selectedPaths;
  final String previousPath;
  final bool myParentIsLastNode;
  final bool myGranpaIsLastNode;
  final Map<String, dynamic>? keywordsMap;
  /// --------------------------------------------------------------------------
  @override
  State<_MapNodeViewer> createState() => _MapNodeViewerState();
  /// --------------------------------------------------------------------------
}

class _MapNodeViewerState extends State<_MapNodeViewer> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _expanded = ValueNotifier<bool>(false);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    setNotifier(
      notifier: _expanded,
      mounted: mounted,
      value: widget.initiallyExpanded,
    );

  }
  // --------------------
  @override
  void dispose() {
    blog('disposing the view');
    _expanded.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _triggerExpansion(){
    setNotifier(
      notifier: _expanded,
      mounted: mounted,
      value: !_expanded.value,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _hasSons = MapPathing.checkNodeHasSons(
      nodeValue: widget.node,
    );
    // --------------------
    return SizedBox(
      key: const ValueKey<String>('theKeywordNodeViewer'),
      width: widget.width,
      child: ValueListenableBuilder(
        valueListenable: _expanded,
        builder: (_, bool _isExpanded, Widget? sonsStrips){

          return Column(

            children: <Widget>[

              /// PARENT NODE
              _MapTreeStrip(
                width: widget.width,
                keyWidth: widget.keyWidth,
                level: widget.initialLevel,
                nodeKey: widget.parent,
                nodeValue: widget.node,
                expanded: _isExpanded,
                onTriggerExpansion: _triggerExpansion,
                searchValue: widget.searchValue,
                isTop: widget.isTop,
                isBottom: widget.isBottom,
                onLastNodeTap: () => widget.onLastNodeTap.call('${widget.parent}/'),
                onExpandableNodeTap: (){
                  widget.onExpandableNodeTap.call('${widget.parent}/');
                  _triggerExpansion();
                },
                isSelected: Stringer.checkStringsContainString(
                    strings: widget.selectedPaths,
                    string: widget.previousPath,
                ),
                myParentIsLastNode: widget.myParentIsLastNode,
                myGranpaIsLastNode: widget.myGranpaIsLastNode,
                keywordsMap: widget.keywordsMap,
                path: widget.previousPath,
              ),

              /// SONS NODES
              if (_isExpanded && _hasSons)
                sonsStrips!,

            ],

          );

        },

        /// sonsStrips
        child: Builder(
          builder: (_){

            // --------------------

            /// NODE IS MAP
            if (widget.node is Map){

              final Map<String, dynamic> _sonMap = Mapper.convertDynamicMap(widget.node);
              final List<String> _sonKeys = _sonMap.keys.toList();

              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _sonKeys.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
                  itemBuilder: (_, index){

                    final String _sonKey = _sonKeys[index];
                    final dynamic _grandSonNode = _sonMap[_sonKey];

                    return _MapNodeViewer(
                      width: widget.width,
                      keyWidth: widget.keyWidth,
                      parent: _sonKey,
                      node: _grandSonNode,
                      initialLevel: widget.initialLevel + 1,
                      searchValue: widget.searchValue,
                      initiallyExpanded: widget.initiallyExpanded,
                      index: index,
                      isBottom: index + 1 == _sonKeys.length,
                      isTop: index == 0,
                      onLastNodeTap: (String path) => widget.onLastNodeTap.call('${widget.parent}/$path'),
                      onExpandableNodeTap: (String path) => widget.onExpandableNodeTap.call('${widget.parent}/$path'),
                      selectedPaths: widget.selectedPaths,
                      previousPath: '${widget.previousPath}$_sonKey/',
                      myParentIsLastNode: widget.isBottom,
                      myGranpaIsLastNode: widget.myGranpaIsLastNode,
                      keywordsMap: widget.keywordsMap,
                    );

                  }
              );
            }

            /// NODE IS LIST
            else if (widget.node is List) {

              final List<dynamic> _children = widget.node;

              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _children.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
                  itemBuilder: (_, index){

                    // final String _sonKey = _children[index];
                    final dynamic _grandSonNode = _children[index];

                    return _MapNodeViewer(
                      width: widget.width,
                      keyWidth: widget.keyWidth,
                      parent: 'i:$index',
                      node: _grandSonNode,
                      initialLevel: widget.initialLevel + 1,
                      searchValue: widget.searchValue,
                      initiallyExpanded: widget.initiallyExpanded,
                      index: index,
                      isBottom: index + 1 == _children.length,
                      isTop: index == 0,
                      onLastNodeTap: (String path) => widget.onLastNodeTap.call('${widget.parent}/$path'),
                      onExpandableNodeTap: (String path) => widget.onExpandableNodeTap.call('${widget.parent}/$path'),
                      selectedPaths: widget.selectedPaths,
                      previousPath: '${widget.previousPath}i:$index}/',
                      myParentIsLastNode: widget.isBottom,
                      myGranpaIsLastNode: widget.myGranpaIsLastNode,
                      keywordsMap: widget.keywordsMap,
                    );

                  }
              );

            }

            /// OTHERWISE
            else {
              return const SizedBox();
            }

          },
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
