part of mirage;
// ignore_for_file: unused_element

class _MyBzzMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MyBzzMirageStrip({
    required this.mirageX1,
    required this.allMirages,
    required this.onBzTap,
    super.key
  });
  // --------------------
  final MirageModel mirageX1;
  final List<MirageModel> allMirages;
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

                  final String? _selectedBzID = TabName.getBzIDFromBidBz(
                      bzBid: selectedButton,
                  );

                  return _MirageStripScrollableList(
                    mirageModel: mirageX1,
                    columnChildren: <Widget>[

                      if (Lister.checkCanLoop(_myBzzIDs) == true)
                        ...List.generate(_myBzzIDs.length, (index){

                          final String _bzID = _myBzzIDs[index];

                          return BzMirageButton(
                            bzID: _bzID,
                            buttonID: TabName.generateBzBid(bzID: _bzID, bid: null),
                            onTap: (BzModel bz) => onBzTap(_bzID),
                            isSelected: _selectedBzID == _bzID,
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
