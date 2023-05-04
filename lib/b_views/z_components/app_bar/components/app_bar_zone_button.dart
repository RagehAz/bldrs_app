part of bldrs_app_bar;

class ZoneButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneButton({
    this.onTap,
    this.isOn = false,
    this.zoneOverride,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final bool isOn;
  final ZoneModel zoneOverride;
  // -----------------------------------------------------------------------------
  ZoneModel _buttonZone(BuildContext context){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final ZoneModel _currentZone = _zoneProvider.currentZone;
    return zoneOverride ?? _currentZone;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final ZoneModel _currentZone = _buttonZone(context);
    // --------------------
    final String _countryName = _currentZone?.countryName;
    final String _countryFlag = _currentZone?.icon;
    final String _cityName = _currentZone?.cityName;
    // --------------------
    final String _firstRow = _currentZone == null ? ' ' : _countryName;
    // --------------------
    final String _secondRow = _currentZone == null ? ' ' : _cityName;
    // --------------------
    const double _flagHorizontalMargins = 2;
    // --------------------
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 40,
        height: 40,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
                        id: _firstRow ?? '',
                        translate: false,
                      ),
                      size: 1,
                      color: isOn ? Colorz.black230 : Colorz.white255,
                    ),

                    /// CITY NAME
                    BldrsText(
                      verse: Verse(
                        id: _secondRow ?? '',
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
                    icon: _countryFlag,
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
