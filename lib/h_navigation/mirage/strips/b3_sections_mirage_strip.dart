part of mirage;
// ignore_for_file: unused_element

class _SectionsMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _SectionsMirageStrip({
    required this.mirageX1,
    required this.mirageX2,
    required this.allMirages,
    required this.onSelectFlyerType,
    required this.keywordsMap,
    super.key
  });
  // --------------------
  final MirageModel mirageX1;
  final MirageModel mirageX2;
  final List<MirageModel> allMirages;
  final Function(String path) onSelectFlyerType;
  final Map<String, dynamic>? keywordsMap;
  // --------------------------------------------------------------------------
  int getCount({
    required String phid,
    required ZonePhidsModel? zonePhidsModel,
    required bool isActive,
  }){
    int _output = 0;

    if (keywordsMap != null && zonePhidsModel != null && isActive == true){

      final List<String> _keysBelow = MapPathing.getAllKeysBelow(
        map: keywordsMap,
        path: '$phid/',
      );

      _output = ZonePhidsModel.getPhidsCount(
        zonePhidsModel: zonePhidsModel,
        phids: _keysBelow,
      );

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
    final List<FlyerType> _flyerTypes = Keyworder.getFlyerTypesByZonePhids(
      zonePhidsModel: _zonePhidsModel,
      keywordsMap: keywordsMap,
    );
    // --------------------
    final List<String> _phids = keywordsMap?.keys.toList() ?? [];
    // --------------------
    return ValueListenableBuilder(
        valueListenable: mirageX1.selectedButton,
        builder: (context, String? selectedButton, Widget? child) {

          return _MirageStripScrollableList(
            mirageModel: mirageX1,
            columnChildren: <Widget>[

              if (Lister.checkCanLoop(_phids) == true)
                ...List.generate(_phids.length, (index){

                  final String _phid = _phids[index];
                  final FlyerType? _flyerType = FlyerTyper.concludeFlyerTypeByRootID(rootID: _phid);
                  final bool _isActive = _flyerTypes.contains(_flyerType);

                  final bool _isFirst = index == 0;
                  final bool _isLast = index + 1 == _phids.length;

                  final int _count = getCount(
                    phid: _phid,
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
                      isDisabled: !_isActive,
                      isSelected: Pathing.getLastPathNode(selectedButton) == _phid,
                      verse: Verse(
                        id: _phid,
                        translate: true,
                        // casing: Casing.upperCase,
                      ),
                      secondLine: _count == 0 ? null : Verse.plain('$_count ${getWord('phid_flyers')}'),
                      icon: FlyerTyper.flyerTypeIcon(
                        flyerType: _flyerType,
                        isOn: false,
                      ),
                      bigIcon: true,
                      iconColor: null,
                      canShow: true,
                      buttonID: '$_phid/',
                      onTap: () => onSelectFlyerType('$_phid/'),
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
