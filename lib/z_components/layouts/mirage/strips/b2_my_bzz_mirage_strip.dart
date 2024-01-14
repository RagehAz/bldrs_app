part of mirage;
// ignore_for_file: unused_element

class _MyBzzMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MyBzzMirageStrip({
    required this.mirageX1,
    required this.mounted,
    required this.allMirages,
    required this.onBzTap,
    super.key
  });
  // --------------------
  final _MirageModel mirageX1;
  final List<_MirageModel> allMirages;
  final bool mounted;
  final Function(String bzID) onBzTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(
      context: context,
      listen: true,
    );
    // --------------------
    return Container(
      width: mirageX1.getWidth(),
      height: mirageX1.getClearHeight(),
      alignment: Alignment.topCenter,
      child: Selector<NotesProvider, List<MapModel>>(
          selector: (_, NotesProvider notesProvider) => notesProvider.obeliskBadges,
          builder: (_, List<MapModel>? badges, Widget? child){

            return ValueListenableBuilder(
                valueListenable: mirageX1.selectedButton,
                builder: (_, String? selectedButton, Widget? child) {

                  final String? _selectedBzID = TextMod.removeTextBeforeFirstSpecialCharacter(
                      text: selectedButton,
                      specialCharacter: '_',
                  );

                  return _MirageStripFloatingList(
                  columnChildren: <Widget>[

                    if (Lister.checkCanLoop(_bzzModels) == true)
                    ...List.generate(_bzzModels.length, (index){

                      final BzModel _bzModel = _bzzModels[index];

                      final MapModel? _badge = MapModel.getModelByKey(
                        models: badges,
                        key: NavModel.getMainNavIDString(
                          navID: MainNavModel.bz,
                          bzID: _bzModel.id,
                        ),
                      );
                      final Verse? _redDotVerse = ObeliskIcon.getRedDotVerse(badge: _badge);

                      return _MirageButton(
                        isSelected: _selectedBzID == _bzModel.id,
                        verse: Verse(
                          id: _bzModel.name,
                          translate: false,
                        ),
                        icon: _bzModel.logoPath,
                        bigIcon: true,
                        iconColor: null,
                        canShow: true,
                        redDotCount: ObeliskIcon.getCount(badge: _badge),
                        redDotIsOn: ObeliskIcon.checkRedDotIsOn(forceRedDot: false, badge: _badge),
                        redDotVerse: _redDotVerse,
                        onTap: () => onBzTap(_bzModel.id!),
                      );

                    }),


                  ],
                );
              }
            );

          }
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
