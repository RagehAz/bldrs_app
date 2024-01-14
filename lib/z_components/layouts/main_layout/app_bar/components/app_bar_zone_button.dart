// ignore_for_file: unused_element
part of bldrs_app_bar;

class ZoneButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneButton({
    this.onTap,
    this.isOn = false,
    this.zoneOverride,
    this.height = Ratioz.appBarButtonSize,
    this.isPlanetButton = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTap;
  final bool isOn;
  final ZoneModel? zoneOverride;
  final double height;
  final bool isPlanetButton;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (isPlanetButton == true){
      // --------------------
      return _ZoneButtonTree(
        onTap: onTap,
        isOn: isOn,
        icon: Iconz.planet,
        firstRow: getWord('phid_the_world'),
        secondRow: null,
        height: height,
      );
      // --------------------
    }

    else {
      // --------------------
      final ZoneModel? _currentZone = zoneOverride ?? ZoneProvider.proGetCurrentZone(
        context: context,
        listen: true,
      );
      // --------------------
      final String? _countryName = _currentZone?.countryName;
      final String? _countryFlag = _currentZone?.icon;
      final String? _cityName = _currentZone?.cityName;
      // --------------------
      final String? _firstRow = _currentZone == null ? ' ' : _countryName;
      // --------------------
      final String? _secondRow = _currentZone == null ? ' ' : _cityName;
      // --------------------
      return _ZoneButtonTree(
        onTap: onTap,
        isOn: isOn,
        icon: _countryFlag,
        firstRow: _firstRow,
        secondRow: _secondRow,
        height: height,
      );
      // --------------------
    }

  }
  // -----------------------------------------------------------------------------
}

class _ZoneButtonTree extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _ZoneButtonTree({
    required this.onTap,
    required this.icon,
    required this.firstRow,
    required this.secondRow,
    required this.isOn,
    this.height = Ratioz.appBarButtonSize,
    super.key
  });
  // ---------------------
  final Function? onTap;
  final String? icon;
  final String? firstRow;
  final String? secondRow;
  final bool isOn;
  final double height;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _flagHorizontalMargins = 2;

    return GestureDetector(
      onTap: onTap == null ? null : () => onTap!(),
      child: Container(
        height: height,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(5),
        // margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(Ratioz.appBarButtonCorner),
            ),
            color: isOn ? Colorz.yellow255 : Colorz.white10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            /// --- COUNTRY & CITY NAMES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.5),
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    /// COUNTRY NAME
                    BldrsText(
                      verse: Verse(
                        id: firstRow ?? '',
                        translate: false,
                      ),
                      size: 1,
                      color: isOn ? Colorz.black230 : Colorz.white255,
                    ),

                    /// CITY NAME
                    BldrsText(
                      verse: Verse(
                        id: secondRow ?? '',
                        translate: false,
                      ),
                      size: 1,
                      scaleFactor: 0.8,
                      color: isOn ? Colorz.black230 : Colorz.white255,
                    ),

                  ],
                ),
              ),
            ),

            /// --- FLAG
            Stack(
              alignment: Alignment.center,
              children: <Widget>[

                /// --- FAKE FOOTPRINT to occupy space for flag while loading
                Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.symmetric(
                      horizontal: _flagHorizontalMargins
                  ),
                ),

                Center(
                  child: BldrsBox(
                    width: 30,
                    height: 30,
                    icon: icon ?? Iconz.dvBlankSVG,
                    corners: Ratioz.boxCorner8,
                    margins: const EdgeInsets.symmetric(
                        horizontal: _flagHorizontalMargins
                    ),
                    onTap: onTap,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
  // -----------------------------------------------------------------------------
}
