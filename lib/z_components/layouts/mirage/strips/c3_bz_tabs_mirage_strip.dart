part of mirage;
// ignore_for_file: unused_element

class _BzTabsMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _BzTabsMirageStrip({
    required this.thisMirage,
    required this.allMirages,
    required this.onTabChanged,
    required this.bzID,
    // required this.bid,
    super.key
  });
  // --------------------
  final MirageModel thisMirage;
  final List<MirageModel> allMirages;
  final Function(String tab) onTabChanged;
  final String bzID;
  // final String bid;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
        valueListenable: thisMirage.selectedButton,
        builder: (_, String? selectedButton, Widget? child) {

          final String? _bidBz = selectedButton;

          return _MirageStripFloatingList(
            columnChildren: <Widget>[

              /// ABOUT
              Builder(
                  builder: (context) {

                    const String? _bid = BldrsTabber.bidMyBzInfo;
                    final bool _isSelected = _bid == BldrsTabber.getBidFromBidBz(bzBid: _bidBz);

                    return _MirageButton(
                      verse: BldrsTabber.translateBid(_bid),
                      icon: BldrsTabber.getBidIcon(_bid),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? MirageModel.selectedTextColor : MirageModel.textColor,
                      onTap: () => onTabChanged(_bid),
                    );
                  }
              ),

              /// FLYERS
              Builder(
                  builder: (context) {

                    const String? _bid = BldrsTabber.bidMyBzFlyers;
                    final bool _isSelected = _bid == BldrsTabber.getBidFromBidBz(bzBid: _bidBz);

                    return _MirageButton(
                      verse: BldrsTabber.translateBid(_bid),
                      icon: BldrsTabber.getBidIcon(_bid),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? MirageModel.selectedTextColor : MirageModel.textColor,
                      onTap: () => onTabChanged(_bid),
                    );
                  }
              ),

              /// TEAM
              Builder(
                  builder: (context) {

                    const String? _bid = BldrsTabber.bidMyBzTeam;
                    final bool _isSelected = _bid == BldrsTabber.getBidFromBidBz(bzBid: _bidBz);

                    return _MirageButton(
                      verse: BldrsTabber.translateBid(_bid),
                      icon: BldrsTabber.getBidIcon(_bid),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? MirageModel.selectedTextColor : MirageModel.textColor,
                      onTap: () => onTabChanged(_bid),
                    );
                  }
              ),

              /// NOTES
              Builder(
                  builder: (context) {

                    const String? _bid = BldrsTabber.bidMyBzNotes;
                    final bool _isSelected = _bid == BldrsTabber.getBidFromBidBz(bzBid: _bidBz);

                    return _MirageButton(
                      verse: BldrsTabber.translateBid(_bid),
                      icon: BldrsTabber.getBidIcon(_bid),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? MirageModel.selectedTextColor : MirageModel.textColor,
                      onTap: () => onTabChanged(_bid),
                    );
                  }
              ),

              /// SETTINGS
              Builder(
                  builder: (context) {

                    const String? _bid = BldrsTabber.bidMyBzSettings;
                    final bool _isSelected = _bid == BldrsTabber.getBidFromBidBz(bzBid: _bidBz);

                    return _MirageButton(
                      verse: BldrsTabber.translateBid(_bid),
                      icon: BldrsTabber.getBidIcon(_bid),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? MirageModel.selectedTextColor : MirageModel.textColor,
                      onTap: () => onTabChanged(_bid),
                    );
                  }
              ),

            ],
          );
        }
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
