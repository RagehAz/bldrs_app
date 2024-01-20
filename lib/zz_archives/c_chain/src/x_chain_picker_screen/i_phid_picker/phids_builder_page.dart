part of chains;

class PhidsBuilderPage extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PhidsBuilderPage({
    required this.chain,
    required this.searchText,
    required this.onPhidTap,
    required this.selectedPhidsNotifier,
    this.onPhidDoubleTap,
    this.onPhidLongTap,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Chain chain;
  final ValueNotifier<dynamic> searchText;
  final Function(String? path, String? phid)? onPhidTap;
  final Function(String? path, String? phid)? onPhidDoubleTap;
  final Function(String? path, String? phid)? onPhidLongTap;
  final ValueNotifier<List<String>> selectedPhidsNotifier;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: selectedPhidsNotifier,
        builder: (_, List<String> selectedPhids, Widget? child){

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
            itemCount: chain.sons?.length,
            itemBuilder: (BuildContext context, int index) {

              final dynamic _son = chain.sons[index];

              return ChainSplitter(
                width: PageBubble.width(context),
                chainOrChainsOrSonOrSons: _son,
                initiallyExpanded: true,
                secondLinesType: ChainSecondLinesType.non,
                // level: 0,
                onPhidTap: onPhidTap,
                onPhidLongTap: onPhidLongTap,
                onPhidDoubleTap: onPhidDoubleTap,
                selectedPhids: selectedPhids,
                searchText: searchText,
                onExportSpecs: null,
                zone: null,
                onlyUseZoneChains: false,
                isMultipleSelectionMode: false,
                isCollapsable: false,
              );
            },
          );

        },
    );

  }
  // -----------------------------------------------------------------------------
}
