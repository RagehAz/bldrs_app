part of mirage;
// ignore_for_file: unused_element

class Mirage2StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Mirage2StripSwitcher({
    required this.keywordsMap,
    required this.onPhidTap,
    required this.onBzTabChanged,
    super.key
  });
  // -------------------
  final Map<String, dynamic>? keywordsMap;
  final Function (String path) onPhidTap;
  final Function(String tab) onBzTabChanged;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
      context: context,
      listen: true,
    );
    final MirageModel mirage1 = allMirages[1];
    final MirageModel mirage2 = allMirages[2];
    // --------------------
    final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(context: context, listen: true);
    final bool _hasSingleBz = _myBzzIDs.length == 1;
    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirage1.selectedButton,
      builder: (_, String? selectedButton, Widget? child){

        /// BZ FLYERS PAGE
        if (_hasSingleBz == true && TabName.getBidFromBidBz(bzBid: selectedButton) == TabName.bid_MyBz_Flyers){

          return _BzFlyersPhidsMirageStrip(
            thisMirage: mirage2,
          );

        }

        /// BZ TABS
        else if (_hasSingleBz == false && TabName.checkBidIsBidBz(bid: selectedButton) == true){
          return _BzTabsMirageStrip(
            thisMirage: mirage2,
            allMirages: allMirages,
            onTabChanged: onBzTabChanged,
            bzID: TabName.getBzIDFromBidBz(bzBid: selectedButton)!,
            // bid: BldrsTabber.getBidFromBidBz(bzBid: selectedButton)!,
          );
        }

        /// IS PHID_K
        else if (Pathing.checkIsPath(selectedButton) == true){
          return _MapSonMirageStrip(
            thisMirage: mirage2,
            mirageBelow: mirage1,
            previousPath: '$selectedButton',
            parentMap: keywordsMap,
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
