part of chains;

class PhidsSearchView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PhidsSearchView({
    required this.foundChains,
    required this.searchText,
    required this.selectedPhidsNotifier,
    required this.onPagePhidTap,
    super.key
  });
  // --------------------
  final ValueNotifier<List<Chain>> foundChains;
  final ValueNotifier<dynamic> searchText;
  final ValueNotifier<List<String>> selectedPhidsNotifier;
  final Function(String? path, String? phid)? onPagePhidTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SizedBox(
      width: Scale.screenWidth(context),
      height: Scale.screenHeight(context),
      child: ValueListenableBuilder(
        valueListenable: foundChains,
        builder: (BuildContext context, List<Chain>? foundChains, Widget? child) {

          if (Lister.checkCanLoop(foundChains) == true){
            return PhidsBuilderPage(
              chain: Chain(
                id: 'foundChains',
                sons: foundChains,
              ),
              searchText: searchText,
              selectedPhidsNotifier: selectedPhidsNotifier,
              onPhidTap: onPagePhidTap,
            );
          }

          else {
            return const NoResultFound();
          }

          },
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
