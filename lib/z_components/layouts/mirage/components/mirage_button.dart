part of mirage;
// ignore_for_file: unused_element

class _MirageButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MirageButton({
    required this.icon,
    required this.bigIcon,
    required this.verse,
    required this.onTap,
    required this.iconColor,
    required this.redDotVerse,
    required this.redDotCount,
    required this.redDotIsOn,
    required this.canShow,
    required this.isSelected,
    this.loading = false,
    super.key
  });
  // --------------------
  final dynamic icon;
  final Verse verse;
  final bool bigIcon;
  final Color? iconColor;
  final Function onTap;
  final Verse? redDotVerse;
  final int? redDotCount;
  final bool redDotIsOn;
  final bool canShow;
  final bool isSelected;
  final bool loading;
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
      // --------------------
      return RedDotBadge(
        height: getHeight,
        redDotIsOn: redDotIsOn,
        count: redDotCount,
        verse: redDotVerse,
        approxChildWidth: getWidth,
        shrinkChild: true,
        isNano: redDotVerse != null,
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
