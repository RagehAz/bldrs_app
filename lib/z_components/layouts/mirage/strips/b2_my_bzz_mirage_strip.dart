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
    final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(
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

                      if (Lister.checkCanLoop(_myBzzIDs) == true)
                        ...List.generate(_myBzzIDs.length, (index){

                          final String _bzID = _myBzzIDs[index];
                          final MapModel? _badge = MapModel.getModelByKey(
                            models: badges,
                            key: NavModel.getMainNavIDString(
                              navID: MainNavModel.bz,
                              bzID: _bzID,
                            ),
                          );
                          final Verse? _redDotVerse = ObeliskIcon.getRedDotVerse(badge: _badge);

                          return BzBuilder(
                              bzID: _bzID,
                              builder: (bool loading, BzModel? bzModel, Widget? child) {
                                return _MirageButton(
                                  isSelected: _selectedBzID == _bzID,
                                  verse: Verse(
                                    id: bzModel?.name,
                                    translate: false,
                                  ),
                                  icon: StoragePath.bzz_bzID_logo(_bzID),
                                  bigIcon: true,
                                  iconColor: null,
                                  canShow: true,
                                  redDotCount: ObeliskIcon.getCount(badge: _badge),
                                  redDotIsOn: ObeliskIcon.checkRedDotIsOn(forceRedDot: false, badge: _badge),
                                  redDotVerse: _redDotVerse,
                                  onTap: bzModel == null ? (){} : () => onBzTap(_bzID),
                                  loading: loading,
                                );
                              }
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
