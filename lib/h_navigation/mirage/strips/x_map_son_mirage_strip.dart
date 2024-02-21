part of mirage;
// ignore_for_file: unused_element

class _MapSonMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MapSonMirageStrip({
    required this.thisMirage,
    required this.mirageBelow,
    required this.parentMap,
    required this.keywordsMap,
    required this.onPhidTap,
    required this.previousPath,
    super.key
  });
  // --------------------
  final MirageModel thisMirage;
  final MirageModel mirageBelow;
  final Map<String, dynamic>? parentMap;
  final Map<String, dynamic>? keywordsMap;
  final String previousPath;
  final Function(String path) onPhidTap;
  // --------------------------------------------------------------------------
  String? getPhid(){

    if (Pathing.checkIsPath(mirageBelow.selectedButton.value) == true){
      return Pathing.getLastPathNode(mirageBelow.selectedButton.value);
    }
    else if (Keyworder.checkIsPhidK(mirageBelow.selectedButton.value) == true){
      return mirageBelow.selectedButton.value;
    }
    else {
      return mirageBelow.selectedButton.value;
    }

  }
  // --------------------------------------------------------------------------
  int getCount({
    required String phid,
    required String path,
    required ZonePhidsModel? zonePhidsModel,
    required bool isActive,
  }){
    int _output = 0;

    if (keywordsMap != null && zonePhidsModel != null && isActive == true){

      final bool _nodeIsLast = !MapPathing.checkPathNodeHasSons(
        map: keywordsMap!,
        path: path,
      );

      if (_nodeIsLast == true){
        _output = ZonePhidsModel.getPhidCount(
          zonePhidsModel: zonePhidsModel,
          phid: phid,
        );
      }
      else {

        final List<String> _keysBelow = MapPathing.getAllKeysBelow(
            map: keywordsMap,
            path: path,
        );

        _output = ZonePhidsModel.getPhidsCount(
          zonePhidsModel: zonePhidsModel,
          phids: _keysBelow,
        );

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final ZonePhidsModel? _zonePhidsModel = ZoneProvider.proGetZonePhids(
      context: context,
      listen: true,
    );
    // --------------------
    final String? _phid = getPhid();
    // --------------------
    final Map<String, dynamic>? _sonMap = parentMap?[_phid] is Map ? parentMap![_phid] : null;
    // --------------------
    final List<String> _sonMapKeys = _sonMap?.keys.toList() ?? [];
    // --------------------
    return ValueListenableBuilder(
        valueListenable: thisMirage.selectedButton,
        builder: (context, String? selectedPath, Widget? child) {

          final String? _lastNode = Pathing.getLastPathNode(selectedPath);

          return _MirageStripScrollableList(
            mirageModel: thisMirage,
            columnChildren: <Widget>[

              if (Lister.checkCanLoop(_sonMapKeys) == true)

                ...List.generate(_sonMapKeys.length, (index){

                  final String _sonPhid = _sonMapKeys[index];
                  final String _path = '$previousPath$_sonPhid/';

                  final bool _isActive = Keyworder.checkNodeIsActiveInZone(
                    keywordsMap: keywordsMap,
                    path: _path,
                    zonePhidsModel: _zonePhidsModel,
                  );

                  final bool _isFirst = index == 0;
                  final bool _isLast = index + 1 == _sonMapKeys.length;

                  final int _count = getCount(
                    phid: _sonPhid,
                    path: _path,
                    zonePhidsModel: _zonePhidsModel,
                    isActive: _isActive,
                  );

                  return Padding(
                    padding: Scale.superInsets(
                      context: context,
                      appIsLTR: UiProvider.checkAppIsLeftToRight(),
                      enLeft: _isFirst ? 10 : 0,
                      enRight: _isLast ? 5 : 0,
                    ),
                    child: MirageButton(
                      isSelected: _lastNode == _sonPhid,
                      verse: Verse(
                        id: _sonPhid,
                        translate: true,
                        // casing: Casing.upperCase,
                      ),
                      secondLine: _count == 0 ? null : Verse.plain('$_count ${getWord('phid_flyers')}'),
                      icon: StoragePath.phids_phid(_sonPhid),
                      bigIcon: true,
                      iconColor: null,
                      canShow: true,
                      buttonID: _path,
                      isDisabled: !_isActive,
                      onTap: () => onPhidTap(_path),
                    ),
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
