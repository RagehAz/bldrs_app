part of chains;

class PickerTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerTile({
    required this.picker,
    required this.pickerSelectedSpecs,
    required this.onDeleteSpec,
    required this.onSpecTap,
    required this.onTap,
    this.searchText,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PickerModel? picker;
  final List<SpecModel> pickerSelectedSpecs;
  final Function? onTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onSpecTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onDeleteSpec;
  final ValueNotifier<String?>? searchText;
  final double? width;
/// --------------------------------------------------------------------------
  static double height() {
    return 70;
  }
  // --------------------
  static double getDefaultWidth(BuildContext context) {
    final double _specTileWidth = Bubble.bubbleWidth(context: context);
    return _specTileWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _specTileHeight = height();
    final double _specTileWidth = width ?? getDefaultWidth(context);
    const BorderRadius _tileBorders = BldrsAppBar.corners;
    final double _specNameBoxWidth = _specTileWidth - (2 * _specTileHeight);
    // --------------------
    return GestureDetector(
      key: const ValueKey<String>('PickerTile'),
      onTap: onTap == null ? null : () => onTap!(),
      child: Center(
        child: Container(
          width: _specTileWidth,
          // height: _specTileHeight,
          margin: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
          decoration: const BoxDecoration(
            color: Colorz.white10,
            borderRadius: _tileBorders,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// SPECS LIST ROW
              SizedBox(
                width: _specTileWidth,
                child: Row(
                  children: <Widget>[

                    /// - ICON
                    BldrsBox(
                      width: _specTileHeight,
                      height: _specTileHeight,
                      color: Colorz.white10,
                      corners: _tileBorders,
                      bubble: false,
                      icon: ChainsProvider.proGetPhidIcon(
                        son: picker?.chainID,
                      ),
                      iconSizeFactor: 0.6,
                    ),

                    /// - PICKER NAME
                    SizedBox(
                      width: _specNameBoxWidth,
                      height: _specTileHeight,
                      child: BldrsText(
                        verse: Verse(
                          id: picker?.chainID,
                          translate: true,
                        ),
                        centered: false,
                        margin: 10,
                        maxLines: 2,
                        redDot: picker?.isRequired,
                        highlight: searchText,
                      ),
                    ),

                    /// - ARROW
                    BldrsBox(
                      width: _specTileHeight,
                      height: _specTileHeight,
                      corners: _tileBorders,
                      icon: Iconizer.superArrowENRight(context),
                      iconSizeFactor: 0.15,
                      bubble: false,

                    ),

                  ],
                ),
              ),

              /// SELECTED SPECS ROW
              if (pickerSelectedSpecs.isNotEmpty)
                SizedBox(
                  width: _specTileWidth,
                  child: Row(
                    children: <Widget>[

                      /// FAKE SPACE UNDER ICON
                      SizedBox(
                        width: _specTileHeight,
                        height: 10,
                      ),

                      /// SELECTED SPECS BOX
                      SpecsWrapper(
                        width: _specTileWidth - _specTileHeight,
                        specs: pickerSelectedSpecs,
                        picker: picker,
                        onSpecTap: onSpecTap,
                        onDeleteSpec: onDeleteSpec,
                        xIsOn: true,
                        searchText: searchText,

                      ),

                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
