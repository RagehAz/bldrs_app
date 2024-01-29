part of mirage;

class BzMirageButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzMirageButton({
    required this.bzID,
    required this.onTap,
    required this.buttonID,
    required this.isSelected,
    super.key
  });
  // --------------------
  final String bzID;
  final Function(BzModel bzModel) onTap;
  final String buttonID;
  final bool isSelected;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Badger _badger = NotesProvider.proGetBadger(
      context: context,
      listen: true,
    );

    final int _count = Badger.calculateBzTotal(
      bzID: bzID,
      onlyNumbers: true,
      badger: _badger,
    );

    return BzBuilder(
        bzID: bzID,
        builder: (bool loading, BzModel? bzModel, Widget? child) {

          return MirageButton(
            buttonID: buttonID,
            loading: loading,
            isSelected: isSelected,
            verse: Verse(
              id: bzModel?.name,
              translate: false,
            ),
            icon: StoragePath.bzz_bzID_logo(bzID),
            bigIcon: true,
            iconColor: null,
            canShow: true,
            countOverride: _count,
            onTap: bzModel == null ? (){} : () => onTap(bzModel),
          );

        }
        );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
