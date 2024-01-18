part of mirage;
// ignore_for_file: unused_element
class Mirage4StripSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Mirage4StripSwitcher({
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

    final List<MirageModel> _allMirages = HomeProvider.proGetMirages(context: context, listen: true);
    final MirageModel mirage3 = _allMirages[3];
    final MirageModel mirage4 = _allMirages[4];

    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirage3.selectedButton,
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
            thisMirage: mirage4,
            mirageBelow: mirage3,
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
