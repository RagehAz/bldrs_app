part of mirage;
// ignore_for_file: unused_element

class Mirage3StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Mirage3StripSwitcher({
    required this.keywordsMap,
    required this.onPhidTap,
    super.key
  });
  // -------------------
  final Map<String, dynamic>? keywordsMap;
  final Function (String path) onPhidTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
      context: context,
      listen: true,
    );
    final MirageModel mirage2 = allMirages[2];
    final MirageModel mirage3 = allMirages[3];
    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirage2.selectedButton,
      builder: (_, String? selectedButton, Widget? child){

        /// BZ FLYERS PAGE
        if (TabName.getBidFromBidBz(bzBid: selectedButton) == TabName.bid_MyBz_Flyers){

          return _BzFlyersPhidsMirageStrip(
            thisMirage: mirage3,
          );

        }

        /// NOTHING SELECTED IN MIRAGE1
        if (TabName.checkBidIsBidBz(bid: selectedButton) == true){
          return const SizedBox();
        }

        /// IS path
        else if (Pathing.checkIsPath(selectedButton) == true){

          final String previousPath = selectedButton!;
          final String _parentPath = Pathing.removeLastPathNode(path: previousPath) ?? '';
          final Map<String, dynamic> _parentMap = MapPathing.getNodeValue(
            path: _parentPath,
            map: keywordsMap,
          );

          return _MapSonMirageStrip(
            thisMirage: mirage3,
            mirageBelow: mirage2,
            previousPath: previousPath,
            parentMap: _parentMap,
            onPhidTap: onPhidTap,
            keywordsMap: keywordsMap,
          );
        }

        /// NOTHING FOR NOW
        else {
          return const SizedBox();
        }

      },
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
