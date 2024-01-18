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
  final MirageModel mirageX1;
  final List<MirageModel> allMirages;
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
      child: Selector<NotesProvider, Badger>(
          selector: (_, NotesProvider notesProvider) => notesProvider.badger,
          builder: (_, Badger badger, Widget? child){

            return ValueListenableBuilder(
                valueListenable: mirageX1.selectedButton,
                builder: (_, String? selectedButton, Widget? child) {

                  final String? _selectedBzID = BldrsTabber.getBzIDFromBidBz(
                      bzBid: selectedButton,
                  );

                  return _MirageStripFloatingList(
                    columnChildren: <Widget>[

                      if (Lister.checkCanLoop(_myBzzIDs) == true)
                        ...List.generate(_myBzzIDs.length, (index){

                          final String _bzID = _myBzzIDs[index];

                          final int _count = Badger.calculateBzTotal(
                            bzID: _bzID,
                            badger: badger,
                            onlyNumbers: true,
                          );

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
                                  redDotCount: _count,
                                  redDotIsOn: _count > 0,
                                  redDotVerse: null,
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
