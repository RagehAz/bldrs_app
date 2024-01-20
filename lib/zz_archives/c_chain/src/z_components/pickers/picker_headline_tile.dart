part of chains;

class PickerHeadlineTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerHeadlineTile({
    required this.picker,
    this.onTap,
    this.secondLine,
    super.key
  });
  
  final PickerModel picker;
  final Verse? secondLine;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return Align(
      key: ValueKey<String>('${picker.chainID}'),
      alignment: Alignment.centerLeft,
      child: BldrsBox(
        height: 40,
        verse: Verse(
          id: picker.chainID,
          translate: true,
          casing: Casing.upperCase,
        ),
        secondLine: secondLine,
        margins: 10,
        verseScaleFactor: 0.65,
        verseItalic: true,
        bubble: false,
        color: Colorz.yellow125,
        verseCentered: false,
        onTap: onTap,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
