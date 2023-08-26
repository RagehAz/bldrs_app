// ignore_for_file: unused_element
part of top_button;

class _AmazonButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _AmazonButton({
    required this.flyerModel,
    required this.flyerBoxWidth,
    super.key,
  });
  // --------------------
  final FlyerModel? flyerModel;
  final double flyerBoxWidth;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = getTopButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    final double _width = getTopButtonWidth(
      flyerModel: flyerModel,
      flyerBoxWidth: flyerBoxWidth,
    );
    final Verse _firstLine = generateFirstLineForAmazonButton(
      flyerModel: flyerModel,
    );
    final Verse? _secondLine = generateSecondLineForAmazonButton(
      flyerModel: flyerModel,
    );

    final bool _isTinyMode = FlyerDim.isTinyMode(
      flyerBoxWidth: flyerBoxWidth,
      gridWidth: Scale.screenWidth(context),
      gridHeight: Scale.screenHeight(context),
    );

    return BldrsBox(
      color: const Color.fromARGB(255, 255, 153, 0),
      height: _height,
      width: _width,
      verse: _firstLine,
      secondLine: _secondLine,
      verseMaxLines: 3,
      icon: Iconz.amazon,
      iconSizeFactor: 0.7,
      verseScaleFactor: 0.7,
      verseCentered: false,
      verseColor: Colorz.black255,
      iconColor: Colorz.white255,
      verseShadow: true,
      corners: flyerBoxWidth * 0.05,
      margins: FlyerDim.gtaButtonMargins(
        flyerBoxWidth: flyerBoxWidth,
      ),
      verseWeight: _isTinyMode == true ? VerseWeight.bold : VerseWeight.black,
      onTap: () async {
        await Launcher.launchURL(flyerModel?.affiliateLink);
        },
    );

  }
  // -----------------------------------------------------------------------------
}
