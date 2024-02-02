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
  @override
  Widget build(BuildContext context) {
    // --------------------
    // final ZonePhidsModel? _zonePhidsModel = ChainsProvider.proGetZonePhids(
    //   context: context,
    //   listen: false,
    // );
    // --------------------
    // final List<FlyerType> _flyerTypes = Keyworder.getFlyerTypesByZonePhids(
    //   zonePhidsModel: _zonePhidsModel,
    //   keywordsMap: keywordsMap,
    // );

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

                  // final FlyerType _flyerType = _flyerTypes[index];

                  // final String? _flyerTypePhid = FlyerTyper.getFlyerTypePhid(flyerType: _flyerType);

                  final FlyerType? _flyerType = FlyerTyper.concludeFlyerTypeByRootID(rootID: _phid);

                  // final String? _rootPhid = FlyerTyper.concludeChainIDByFlyerType(
                  //   flyerType: _flyerType,
                  // );

                  return MirageButton(
                    isSelected: Pathing.getLastPathNode(selectedButton) == _phid,
                    verse: Verse(
                      id: _phid,
                      translate: true,
                      // casing: Casing.upperCase,
                    ),
                    icon: FlyerTyper.flyerTypeIcon(
                      flyerType: _flyerType,
                      isOn: false,
                    ),
                    bigIcon: true,
                    iconColor: null,
                    canShow: true,
                    buttonID: '$_phid/',
                    onTap: () => onSelectFlyerType('$_phid/'),
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
