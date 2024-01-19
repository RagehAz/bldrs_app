part of mirage;
// ignore_for_file: unused_element

class _UserTabsMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _UserTabsMirageStrip({
    required this.mirage1,
    required this.allMirages,
    required this.onTabChanged,
    super.key
  });
  // --------------------
  final MirageModel mirage1;
  final List<MirageModel> allMirages;
  final Function(String tab) onTabChanged;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
        valueListenable: mirage1.selectedButton,
        builder: (_, String? selectedButton, Widget? child) {

          return _MirageStripFloatingList(
            columnChildren: <Widget>[

              /// PROFILE
              Builder(
                  builder: (context) {

                    const String _bid = BldrsTabber.bidMyInfo;
                    final bool _isSelected = selectedButton == _bid;

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

              /// SAVED FLYERS
              Builder(
                  builder: (context) {

                    const String _bid = BldrsTabber.bidMySaves;
                    final bool _isSelected = selectedButton == _bid;

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

              /// NOTIFICATIONS
              Builder(
                  builder: (context) {

                    const String _bid = BldrsTabber.bidMyNotes;
                    final bool _isSelected = selectedButton == _bid;

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

              /// FOLLOWS
              Builder(
                  builder: (context) {

                    const String _bid = BldrsTabber.bidMyFollows;
                    final bool _isSelected = selectedButton == _bid;

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

                    const String _bid = BldrsTabber.bidMySettings;
                    final bool _isSelected = selectedButton == _bid;

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
