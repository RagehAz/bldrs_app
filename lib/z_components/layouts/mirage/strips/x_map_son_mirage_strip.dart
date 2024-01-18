part of mirage;
// ignore_for_file: unused_element

class _MapSonMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MapSonMirageStrip({
    required this.thisMirage,
    required this.mirageBelow,
    required this.parentMap,
    required this.onPhidTap,
    required this.previousPath,
    super.key
  });
  // --------------------
  final MirageModel thisMirage;
  final MirageModel mirageBelow;
  final Map<String, dynamic>? parentMap;
  final String previousPath;
  final Function(String path) onPhidTap;
  // --------------------------------------------------------------------------
  String? getPhid(){

    if (Pathing.checkIsPath(mirageBelow.selectedButton.value) == true){
      return Pathing.getLastPathNode(mirageBelow.selectedButton.value);
    }
    else if (Phider.checkIsPhidK(mirageBelow.selectedButton.value) == true){
      return mirageBelow.selectedButton.value;
    }
    else {
      return mirageBelow.selectedButton.value;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String? _phid = getPhid();
    // --------------------
    final Map<String, dynamic>? _sonMap = parentMap?[_phid];
    // --------------------
    final List<String> _sonMapKeys = _sonMap?.keys.toList() ?? [];
    // --------------------
    return ValueListenableBuilder(
        valueListenable: thisMirage.selectedButton,
        builder: (context, String? selectedPath, Widget? child) {

          final String? _lastNode = Pathing.getLastPathNode(selectedPath);


          return _MirageStripFloatingList(
            columnChildren: <Widget>[

              if (Lister.checkCanLoop(_sonMapKeys) == true)

                ...List.generate(_sonMapKeys.length, (index){

                  final String _sonPhid = _sonMapKeys[index];

                  return _MirageButton(
                    isSelected: _lastNode == _sonPhid,
                    verse: Verse(
                      id: _sonPhid,
                      translate: true,
                      // casing: Casing.upperCase,
                    ),
                    icon: StoragePath.phids_phid(_sonPhid),
                    bigIcon: true,
                    iconColor: null,
                    canShow: true,
                    redDotCount: null,
                    redDotIsOn: false,
                    redDotVerse: null,
                    onTap: () => onPhidTap('$previousPath$_sonPhid/'),
                  );

                }),


            ],
          );

        }
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
