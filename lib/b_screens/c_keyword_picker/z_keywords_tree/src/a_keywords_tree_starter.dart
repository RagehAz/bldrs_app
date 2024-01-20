part of keywords_tree;

class KeywordsTreeStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeywordsTreeStarter({
    required this.width,
    required this.map,
    required this.onLastNodeTap,
    required this.onExpandableNodeTap,
    required this.selectedPaths,
    this.searchValue,
    this.initiallyExpanded = false,
    this.keyWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final Map<String, dynamic>? map;
  final ValueNotifier<dynamic>? searchValue;
  final bool initiallyExpanded;
  final double? keyWidth;
  final Function(String path) onLastNodeTap;
  final Function(String path) onExpandableNodeTap;
  final List<String> selectedPaths;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<String> _keys = map?.keys.toList() ?? [];

    if (Lister.checkCanLoop(_keys) == true){
      return ListView.builder(
          key: const ValueKey<String>('theKeywordTreeStarter'),
          physics: const BouncingScrollPhysics(),
          // padding: const EdgeInsets.only(bottom: Ratioz.horizon),
          shrinkWrap: true,
          itemCount: _keys.length,
          itemBuilder: (_, index){

            final String _key = _keys[index];
            final dynamic _node = map![_key];

            return KeywordNodeViewer(
              width: width,
              keyWidth: keyWidth,
              parent: _key,
              node: _node,
              searchValue: searchValue,
              initiallyExpanded: initiallyExpanded,
              index: index,
              isBottom: index + 1 == _keys.length,
              isTop: index == 0,
              onLastNodeTap: onLastNodeTap,
              onExpandableNodeTap: onExpandableNodeTap,
              selectedPaths: selectedPaths,
              previousPath: '$_key/',
              myParentIsLastNode: index + 1 == _keys.length,
              myGranpaIsLastNode: true,
              keywordsMap: map,
            );

          }
      );
    }

    else {
      return const SizedBox();
    }

  }
/// --------------------------------------------------------------------------
}
