part of mirage;
// ignore_for_file: unused_element

class Mirage2StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Mirage2StripSwitcher({
    required this.mounted,
    required this.allMirages,
    required this.mirageX3,
    required this.mirageX2,
    required this.mirageX1,
    required this.keywordsMap,
    required this.onPhidTap,
    required this.onBzTabChanged,
    super.key
  });
  // -------------------
  final List<MirageModel> allMirages;
  final bool mounted;
  final MirageModel mirageX3;
  final MirageModel mirageX2;
  final MirageModel mirageX1;
  final Map<String, dynamic>? keywordsMap;
  final Function (String path) onPhidTap;
  final Function(String tab) onBzTabChanged;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirageX1.selectedButton,
      builder: (_, String? selectedButton, Widget? child){

        /// BZ TABS
        if (BldrsTabber.checkBidIsBidBz(bid: selectedButton) == true){
          return _BzTabsMirageStrip(
            thisMirage: mirageX2,
            allMirages: allMirages,
            onTabChanged: onBzTabChanged,
            bzID: BldrsTabber.getBzIDFromBidBz(bzBid: selectedButton)!,
            // bid: BldrsTabber.getBidFromBidBz(bzBid: selectedButton)!,
          );
        }

        /// IS PHID_K
        else if (Pathing.checkIsPath(selectedButton) == true){
          return _MapSonMirageStrip(
            thisMirage: mirageX2,
            mirageBelow: mirageX1,
            previousPath: '$selectedButton/',
            parentMap: keywordsMap,
            onPhidTap: onPhidTap,
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
