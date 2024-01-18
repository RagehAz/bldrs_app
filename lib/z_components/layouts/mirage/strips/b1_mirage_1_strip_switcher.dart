part of mirage;
// ignore_for_file: unused_element

class Mirage1StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Mirage1StripSwitcher({
    required this.onSelectFlyerType,
    required this.keywordsMap,
    required this.onUserTabChanged,
    required this.onBzTap,
    required this.onBzTabChanged,
    super.key
  });
  // --------------------
  final Function(String path) onSelectFlyerType;
  final Map<String, dynamic>? keywordsMap;
  final Function(String tab) onUserTabChanged;
  final Function(String bzID) onBzTap;
  final Function(String tab) onBzTabChanged;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
      context: context,
      listen: true,
    );
    final MirageModel mirage0 = allMirages[0];
    final MirageModel mirage1 = allMirages[1];
    final MirageModel mirage2 = allMirages[2];
    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirage0.selectedButton,
      builder: (_, String? selectedButton, Widget? child){

        /// USER TABS
        if (selectedButton == BldrsTabber.bidProfile){
          return _UserTabsMirageStrip(
            mirage1: mirage1,
            allMirages: allMirages,
            onTabChanged: onUserTabChanged,
          );
        }

        /// MY BZZ STRIP
        else if (selectedButton == BldrsTabber.bidBzz){
          return _MyBzzMirageStrip(
            mirageX1: mirage1,
            allMirages: allMirages,
            onBzTap: onBzTap,
          );
        }

        /// BZ TABS
        else if (BldrsTabber.checkBidIsBidBz(bid: selectedButton) == true){
          return _BzTabsMirageStrip(
            thisMirage: mirage1,
            allMirages: allMirages,
            onTabChanged: onBzTabChanged,
            bzID: BldrsTabber.getBzIDFromBidBz(bzBid: selectedButton)!,
          );
        }

        /// SECTIONS STRIP
        else if (selectedButton == BldrsTabber.bidSections){
          return _SectionsMirageStrip(
            mirageX1: mirage1,
            mirageX2: mirage2,
            allMirages: allMirages,
            onSelectFlyerType: onSelectFlyerType,
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
