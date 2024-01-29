part of mirage;
// ignore_for_file: unused_element

class MirageButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MirageButton({
    required this.icon,
    required this.bigIcon,
    required this.verse,
    required this.onTap,
    required this.iconColor,
    required this.canShow,
    required this.isSelected,
    required this.buttonID,
    this.loading = false,
    this.forceRedDot = false,
    this.countOverride,
    super.key
  });
  // --------------------
  final dynamic icon;
  final Verse verse;
  final bool bigIcon;
  final Color? iconColor;
  final Function onTap;

  final bool canShow;
  final bool isSelected;
  final bool loading;
  final String buttonID;
  final bool forceRedDot;
  final int? countOverride;
  // --------------------------------------------------------------------------
  static double getWidth = 150;
  static double getMaxWidth = getWidth * 2;
  static double getHeight = MirageModel.standardStripHeight * 0.95;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (canShow == true){
      // --------------------
      final double _iconSizeFactor = bigIcon == true ? 1 : 0.5;

      final Badger _badger = NotesProvider.proGetBadger(
        context: context,
        listen: true,
      );
      final Verse? _redDotVerse = Badger.getBadgeVerse(badger: _badger, bid: buttonID);

      // --------------------
      return RedDotBadge(
        height: getHeight,
        approxChildWidth: getWidth,
        shrinkChild: true,
        redDotIsOn: Badger.checkBadgeRedDotIsOn(badger: _badger, bid: buttonID, forceRedDot: forceRedDot),
        count: countOverride ?? Badger.getBadgeCount(badger: _badger, bid: buttonID),
        verse: _redDotVerse,
        isNano: _redDotVerse != null,
        child: BldrsBox(
          maxWidth: getMaxWidth,
          height: getHeight,
          icon: icon,
          iconSizeFactor: _iconSizeFactor,
          verseScaleFactor: 0.6 / _iconSizeFactor,
          verse: verse,
          color: isSelected == true ? MirageModel.selectedButtonColor : MirageModel.buttonColor,
          verseColor: isSelected == true ? MirageModel.selectedTextColor : MirageModel.textColor,
          iconColor: iconColor == Colorz.nothing ? null : isSelected == true ? MirageModel.selectedTextColor : iconColor,
          borderColor: isSelected == true ? Colorz.black255 : null,
          verseMaxLines: 2,
          verseCentered: false,
          onTap: onTap,
          loading: loading,
        ),
      );
      // --------------------
    }

    else {
      return const SizedBox();
    }

  }
  // --------------------------------------------------------------------------
}
