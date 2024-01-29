part of mirage;

class SectionMirageButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SectionMirageButton({
    required this.isSelected,
    required this.onTap,
    super.key
  });
  // --------------------
  final bool isSelected;
  final Function onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Badger _badger = NotesProvider.proGetBadger(
      context: context,
      listen: true,
    );
    // --------------------
    return RedDotBadge(
      height: MirageButton.getHeight,
      approxChildWidth: MirageButton.getWidth,
      shrinkChild: true,
      redDotIsOn: Badger.checkBadgeRedDotIsOn(badger: _badger, bid: BldrsTabber.bidHome),
      count: Badger.getBadgeCount(badger: _badger, bid: BldrsTabber.bidHome),
      verse: Badger.getBadgeVerse(badger: _badger, bid: BldrsTabber.bidHome),
      child: SectionsButton(
        height: MirageButton.getHeight,
        color: isSelected ? MirageModel.selectedButtonColor : MirageModel.buttonColor,
        textColor: isSelected ? MirageModel.selectedTextColor : MirageModel.textColor,
        titleColor: isSelected ? MirageModel.selectedTextColor : Colorz.grey255,
        borderColor: isSelected ? Colorz.black255 : null,
        onTap: onTap,
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
