part of mirage;
// ignore_for_file: unused_element
class Mirage4StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Mirage4StripSwitcher({
    required this.mounted,
    required this.allMirages,
    required this.mirageX4,
    required this.mirageX3,
    required this.keywordsMap,
    required this.onPhidTap,
    super.key
  });
  // -------------------

  final List<MirageModel> allMirages;
  final bool mounted;
  final MirageModel mirageX4;
  final MirageModel mirageX3;
  final Map<String, dynamic>? keywordsMap;
  final Function (String path) onPhidTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirageX3.selectedButton,
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
            thisMirage: mirageX4,
            mirageBelow: mirageX3,
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
