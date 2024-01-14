part of mirage;
// ignore_for_file: unused_element

class _Mirage2StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _Mirage2StripSwitcher({
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
  final List<_MirageModel> allMirages;
  final bool mounted;
  final _MirageModel mirageX3;
  final _MirageModel mirageX2;
  final _MirageModel mirageX1;
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
        if (TextCheck.stringStartsExactlyWith(text: selectedButton, startsWith: 'bzID') == true){
          return _BzTabsMirageStrip(
            mirage2: mirageX2,
            allMirages: allMirages,
            onTabChanged: onBzTabChanged,
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
