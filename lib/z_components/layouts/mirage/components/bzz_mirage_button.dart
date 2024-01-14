part of mirage;
// ignore_for_file: unused_element

class _BzzMirageButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _BzzMirageButton({
    required this.bzzModels,
    required this.verse,
    required this.onTap,
    required this.redDotVerse,
    required this.redDotCount,
    required this.redDotIsOn,
    required this.canShow,
    required this.isSelected,
    super.key
  });
  // --------------------
  final List<BzModel>? bzzModels;
  final Verse verse;
  final Function onTap;
  final Verse? redDotVerse;
  final int? redDotCount;
  final bool redDotIsOn;
  final bool canShow;
  final bool isSelected;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (canShow == true){
      // --------------------
      return RedDotBadge(
        height: _MirageButton.getHeight,
        redDotIsOn: redDotIsOn,
        count: redDotCount,
        verse: redDotVerse,
        approxChildWidth: _MirageButton.getWidth,
        shrinkChild: true,
        isNano: redDotVerse != null,
        child: MultiButton(
          maxWidth: _MirageButton.getMaxWidth,
          height: _MirageButton.getHeight,
          pics: BzModel.getBzzLogos(bzzModels),
          verse: verse,
          color: isSelected ? _MirageModel.selectedButtonColor : _MirageModel.buttonColor,
          textColor: isSelected ? _MirageModel.selectedTextColor : _MirageModel.textColor,
          borderColor: isSelected ? Colorz.black255 : null,
          verseMaxLines: 2,
          onTap: onTap,
          bubble: true,
          margins: EdgeInsets.zero,
          // verseScaleFactor: 0.7 / 1,
          // verseCentered: false,
          // verseItalic: false,
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
