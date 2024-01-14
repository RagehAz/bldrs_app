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
  final _MirageModel mirage1;
  final List<_MirageModel> allMirages;
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

                    const UserTab _tab = UserTab.profile;
                    final String _tabID = UserTabber.getUserTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

                    return _MirageButton(
                      verse: UserTabber.translateUserTab(_tab),
                      icon: Iconz.normalUser,//UserTabber.getUserTabIcon(_tab),
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

              /// NOTIFICATIONS
              Builder(
                  builder: (context) {

                    const UserTab _tab = UserTab.notifications;
                    final String _tabID = UserTabber.getUserTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

                    return _MirageButton(
                      verse: UserTabber.translateUserTab(_tab),
                      icon: UserTabber.getUserTabIcon(_tab),
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

              /// FOLLOWS
              Builder(
                  builder: (context) {

                    const UserTab _tab = UserTab.following;
                    final String _tabID = UserTabber.getUserTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

                    return _MirageButton(
                      verse: UserTabber.translateUserTab(_tab),
                      icon: UserTabber.getUserTabIcon(_tab),
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

                    const UserTab _tab = UserTab.settings;
                    final String _tabID = UserTabber.getUserTabID(_tab)!;
                    final bool _isSelected = selectedButton == _tabID;

                    return _MirageButton(
                      verse: UserTabber.translateUserTab(_tab),
                      icon: UserTabber.getUserTabIcon(_tab),
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
