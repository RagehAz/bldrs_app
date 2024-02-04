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
    this.isDisabled = false,
    this.onDisabledTap,
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
  final bool isDisabled;
  final Function? onDisabledTap;
  // --------------------------------------------------------------------------
  static double getWidth = 150;
  static double getMaxWidth = getWidth * 2;
  static double getHeight = MirageModel.standardStripHeight * 0.95;
  // --------------------------------------------------------------------------
  static Color getButtonColor({
    required bool isDisabled,
    required bool isSelected,
  }){

    if (isDisabled){
      return isSelected == true ? MirageModel.selectedButtonColor : MirageModel.buttonColor;
    }
    else {
      return isSelected == true ? MirageModel.selectedButtonColor : MirageModel.buttonColor;
    }

  }
  // --------------------
  static Color getVerseColor({
    required bool isDisabled,
    required bool isSelected,
  }){

    if (isDisabled){
      return isSelected == true ? MirageModel.selectedTextColor : MirageModel.textColor;
    }
    else {
      return isSelected == true ? MirageModel.selectedTextColor : MirageModel.textColor;
    }

  }
  // --------------------
  static Color? getIconColor({
    required bool isDisabled,
    required bool isSelected,
    required Color? iconColor,
  }){

    if (isDisabled){
      return null;
    }
    else {
      return iconColor == Colorz.nothing ? null : isSelected == true ? MirageModel.selectedTextColor : iconColor;
    }

  }
  // --------------------
  static Color? getBorderColor({
    required bool isDisabled,
    required bool isSelected,
  }){

    if (isDisabled){
      return Colorz.white50;
    }
    else {
      return isSelected == true ? Colorz.black255 : null;
    }

  }
  // --------------------
  static double getIconScaleFactor({
    required bool bigIcon,
  }){
    return bigIcon == true ? 1 : 0.5;
  }
  // --------------------
  static double getVerseScaleFactor({
    required bool bigIcon,
  }){
    final double _iconSizeFactor = getIconScaleFactor(bigIcon: bigIcon);
    return 0.6 / _iconSizeFactor;
  }
  // --------------------
  static bool checkRedDotIsOn({
    required Badger badger,
    required int? countOverride,
    required String buttonID,
    required bool forceRedDot,
  }){
    return (countOverride != null && countOverride != 0)
            ||
            Badger.checkBadgeRedDotIsOn(badger: badger, bid: buttonID, forceRedDot: forceRedDot);
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    if (canShow == true){
      // --------------------

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
        redDotIsOn: checkRedDotIsOn(
          forceRedDot: forceRedDot,
          badger: _badger,
          buttonID: buttonID,
          countOverride: countOverride,
        ),
        count: countOverride ?? Badger.getBadgeCount(badger: _badger, bid: buttonID),
        verse: _redDotVerse,
        isNano: _redDotVerse != null,
        child: WidgetFader(
          fadeType: FadeType.stillAtMax,
          max: isDisabled ? 0.3 : 1,
          child: BldrsBox(
            // isDisabled: isDisabled,
            // iconBackgroundColor: Colorz.bloodTest,
            onDisabledTap: onDisabledTap,
            maxWidth: getMaxWidth,
            height: getHeight,
            icon: icon,
            iconSizeFactor: getIconScaleFactor(bigIcon: bigIcon),
            verseScaleFactor: getVerseScaleFactor(bigIcon: bigIcon),
            verse: verse,
            color: getButtonColor(
              isSelected: isSelected,
              isDisabled: isDisabled,
            ),
            verseColor: getVerseColor(
              isSelected: isSelected,
              isDisabled: isDisabled,
            ),
            iconColor: getIconColor(
                isDisabled: isDisabled,
                isSelected: isSelected,
                iconColor: iconColor,
            ),
            borderColor: getBorderColor(
              isDisabled: isDisabled,
              isSelected: isSelected,
            ),
            verseMaxLines: 2,
            verseCentered: false,
            onTap: onTap,
            loading: loading,
          ),
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
