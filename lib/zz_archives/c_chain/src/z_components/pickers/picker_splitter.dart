part of chains;

class PickerSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerSplitter({
    required this.picker,
    required this.onPickerTap,
    required this.allSelectedSpecs,
    required this.onDeleteSpec,
    required this.onSelectedSpecTap,
    this.searchText,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PickerModel? picker;
  final List<SpecModel> allSelectedSpecs;
  final Function onPickerTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onSelectedSpecTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onDeleteSpec;
  final ValueNotifier<String?>? searchText;
  final double? width;
/// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// HEADLINE
    if (Mapper.boolIsTrue(picker?.isHeadline) == true){

      return PickersGroupHeadline(
        width: width,
        headline: Verse(
          id: picker?.chainID,
          translate: true,
          casing: Casing.upperCase,
        ),
      );

      /// TASK TEST THIS
      // return PickerHeadlineTile(
      //   picker: picker,
      //   // secondLine: ,
      //   // onTap: ,
      // );

    }

    /// PICKER TILE
    else {

      final List<SpecModel> _pickerSelectedSpecs = SpecModel.getSpecsBelongingToThisPicker(
        specs: allSelectedSpecs,
        picker: picker,
      );

      return PickerTile(
        width: width,
        onTap: onPickerTap,
        picker: picker,
        pickerSelectedSpecs: _pickerSelectedSpecs,
        onDeleteSpec: onDeleteSpec,
        onSpecTap: onSelectedSpecTap,
        searchText: searchText,
      );

    }

  }
  /// --------------------------------------------------------------------------
}
