part of mirage;
// ignore_for_file: unused_element

class _BzzMirageButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _BzzMirageButton({
    required this.bzzIDs,
    required this.verse,
    required this.onTap,
    required this.canShow,
    required this.isSelected,
    super.key
  });
  // --------------------
  final List<String>? bzzIDs;
  final Verse verse;
  final Function onTap;
  final bool canShow;
  final bool isSelected;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (canShow == true){

      final Badger _badger = NotesProvider.proGetBadger(
        context: context,
        listen: true,
      );

      final int _count = Badger.calculateAllMyBzz(
        badger: _badger,
        context: context,
        listen: true,
        onlyNumbers: true,
      );
      // --------------------
      return BzzBuilder(
          bzzIDs: bzzIDs,
          builder: (bool loading, List<BzModel> bzzModels, Widget? child) {

            return RedDotBadge(
              height: MirageButton.getHeight,
              redDotIsOn: _count > 0,
              count: _count,
              approxChildWidth: MirageButton.getWidth,
              shrinkChild: true,
              // verse: null,
              // isNano: false,
              child: MultiButton(
                maxWidth: MirageButton.getMaxWidth,
                height: MirageButton.getHeight,
                pics: BzModel.getBzzLogos(bzzModels),
                verse: verse,
                color: isSelected ? MirageModel.selectedButtonColor : MirageModel.buttonColor,
                textColor: isSelected ? MirageModel.selectedTextColor : MirageModel.textColor,
                borderColor: isSelected ? Colorz.black255 : null,
                verseMaxLines: 2,
                onTap: onTap,
                bubble: true,
                margins: EdgeInsets.zero,
                loading: loading,
                corners: MirageButton.getCorners,
                // verseScaleFactor: 0.7 / 1,
                // verseCentered: false,
                // verseItalic: false,
              ),
            );

          }
      );
      // --------------------
    }

    else {
      return const SizedBox();
    }

  }
// --------------------------------------------------------------------------
}
