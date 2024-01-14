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
                    final String _tabID = BzTabber.getBzTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

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
                      onTap: () => onTabChanged(_tabID),
                    );
                  }
              ),

              /// FLYERS
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.flyers;
                    final String _tabID = BzTabber.getBzTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

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
                      onTap: () => onTabChanged(_tabID),
                    );
                  }
              ),

              /// TEAM
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.team;
                    final String _tabID = BzTabber.getBzTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

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
                      onTap: () => onTabChanged(_tabID),
                    );
                  }
              ),

              /// NOTES
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.notes;
                    final String _tabID = BzTabber.getBzTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

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
                      onTap: () => onTabChanged(_tabID),
                    );
                  }
              ),

              /// SETTINGS
              Builder(
                  builder: (context) {

                    const BzTab _tab = BzTab.settings;
                    final String _tabID = BzTabber.getBzTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

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
                      onTap: () => onTabChanged(_tabID),
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
