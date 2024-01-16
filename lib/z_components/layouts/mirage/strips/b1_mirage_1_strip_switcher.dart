part of mirage;
// ignore_for_file: unused_element

class _Mirage1StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _Mirage1StripSwitcher({
    required this.mirage0,
    required this.mirage1,
    required this.mirage2,
    required this.mounted,
    required this.allMirages,
    required this.onSelectFlyerType,
    required this.keywordsMap,
    required this.onUserTabChanged,
    required this.onBzTap,
    super.key
  });
  // --------------------
  final _MirageModel mirage0;
  final _MirageModel mirage1;
  final _MirageModel mirage2;
  final List<_MirageModel> allMirages;
  final bool mounted;
  final Function(String path) onSelectFlyerType;
  final Map<String, dynamic>? keywordsMap;
  final Function(String tab) onUserTabChanged;
  final Function(String bzID) onBzTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirage0.selectedButton,
      builder: (_, String? selectedButton, Widget? child){

        /// USER TABS
        if (selectedButton == BldrsTabs.bidProfile){
          return _UserTabsMirageStrip(
            mirage1: allMirages[1],
            allMirages: allMirages,
            onTabChanged: onUserTabChanged,
          );
        }

        /// MY BZZ STRIP
        else if (selectedButton == BldrsTabs.bidBzz){
          return _MyBzzMirageStrip(
            mirageX1: mirage1,
            mounted: mounted,
            allMirages: allMirages,
            onBzTap: onBzTap,
          );
        }

        /// SECTIONS STRIP
        else if (selectedButton == BldrsTabs.bidSections){
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
