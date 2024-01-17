part of mirage;
// ignore_for_file: unused_element

class _BzTabsMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _BzTabsMirageStrip({
    required this.mirage2,
    required this.allMirages,
    required this.onTabChanged,
    super.key
  });
  // --------------------
  final _MirageModel mirage2;
  final List<_MirageModel> allMirages;
  final Function(String tab) onTabChanged;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
        valueListenable: mirage2.selectedButton,
        builder: (_, String? selectedButton, Widget? child) {

          return _MirageStripFloatingList(
            columnChildren: <Widget>[

              /// ABOUT
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.about;
                    final bool _isSelected = selectedButton == BldrsTabber.bidMyBzAbout;

                    return _MirageButton(
                      verse: BzTabber.translateBzTab(_tab),
                      icon: BzTabber.getBzTabIcon(_tab),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? _MirageModel.selectedTextColor : _MirageModel.textColor,
                      onTap: () => onTabChanged(BldrsTabber.bidMyBzAbout),
                    );
                  }
              ),

              /// FLYERS
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.flyers;
                    final bool _isSelected = selectedButton == BldrsTabber.bidMyBzFlyers;

                    return _MirageButton(
                      verse: BzTabber.translateBzTab(_tab),
                      icon: BzTabber.getBzTabIcon(_tab),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? _MirageModel.selectedTextColor : _MirageModel.textColor,
                      onTap: () => onTabChanged(BldrsTabber.bidMyBzFlyers),
                    );
                  }
              ),

              /// TEAM
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.team;
                    final bool _isSelected = selectedButton == BldrsTabber.bidMyBzTeam;

                    return _MirageButton(
                      verse: BzTabber.translateBzTab(_tab),
                      icon: BzTabber.getBzTabIcon(_tab),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? _MirageModel.selectedTextColor : _MirageModel.textColor,
                      onTap: () => onTabChanged(BldrsTabber.bidMyBzTeam),
                    );
                  }
              ),

              /// NOTES
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.notes;
                    final bool _isSelected = selectedButton == BldrsTabber.bidMyBzNotes;

                    return _MirageButton(
                      verse: BzTabber.translateBzTab(_tab),
                      icon: BzTabber.getBzTabIcon(_tab),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? _MirageModel.selectedTextColor : _MirageModel.textColor,
                      onTap: () => onTabChanged(BldrsTabber.bidMyBzNotes),
                    );
                  }
              ),

              /// SETTINGS
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.settings;
                    final bool _isSelected = selectedButton == BldrsTabber.bidMyBzSettings;

                    return _MirageButton(
                      verse: BzTabber.translateBzTab(_tab),
                      icon: BzTabber.getBzTabIcon(_tab),
                      redDotIsOn: false,
                      isSelected: _isSelected,
                      redDotVerse: null,
                      redDotCount: null,
                      canShow: true,
                      bigIcon: false,
                      iconColor: _isSelected ? _MirageModel.selectedTextColor : _MirageModel.textColor,
                      onTap: () => onTabChanged(BldrsTabber.bidMyBzSettings),
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
