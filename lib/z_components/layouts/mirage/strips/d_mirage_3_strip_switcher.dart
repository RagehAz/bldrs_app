part of mirage;
// ignore_for_file: unused_element

class _Mirage3StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _Mirage3StripSwitcher({
    required this.mounted,
    required this.allMirages,
    required this.mirageX4,
    required this.mirageX3,
    required this.mirageX2,
    required this.keywordsMap,
    required this.onPhidTap,
    super.key
  });
  // -------------------
  final List<_MirageModel> allMirages;
  final bool mounted;
  final _MirageModel mirageX4;
  final _MirageModel mirageX3;
  final _MirageModel mirageX2;
  final Map<String, dynamic>? keywordsMap;
  final Function (String path) onPhidTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirageX2.selectedButton,
      builder: (_, String? selectedButton, Widget? child){

        /// NOTHING SELECTED IN MIRAGE1
        if (selectedButton == null){
          return const SizedBox();
        }

        /// IS path
        else if (Pathing.checkIsPath(selectedButton) == true){

          final String previousPath = selectedButton;
          final String _parentPath = Pathing.removeLastPathNode(path: previousPath) ?? '';
          final Map<String, dynamic> _parentMap = MapPathing.getNodeValue(
              path: _parentPath,
              map: keywordsMap,
          );

          return _MapSonMirageStrip(
            thisMirage: mirageX3,
            mirageBelow: mirageX2,
            previousPath: previousPath,
            parentMap: _parentMap,
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
