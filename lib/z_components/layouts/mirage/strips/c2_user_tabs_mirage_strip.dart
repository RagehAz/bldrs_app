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

                    const UserTab _tab = UserTab.profile; /// MOVE_USER_TABS_TO_BLDRS_TABS
                    final bool _isSelected = selectedButton == BldrsTabs.bidProfileInfo;

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
                      onTap: () => onTabChanged(BldrsTabs.bidProfileInfo),
                    );
                  }
              ),

              /// NOTIFICATIONS
              Builder(
                  builder: (context) {

                    const UserTab _tab = UserTab.notifications;
                    final bool _isSelected = selectedButton == BldrsTabs.bidProfileNotifications;

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
                      onTap: () => onTabChanged(BldrsTabs.bidProfileNotifications),
                    );
                  }
              ),

              /// SAVED FLYERS
              Builder(
                  builder: (context) {

                    const UserTab _tab = UserTab.saves;
                    final bool _isSelected = selectedButton == BldrsTabs.bidProfileSaves;

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
                      onTap: () => onTabChanged(BldrsTabs.bidProfileSaves),
                    );
                  }
              ),

              /// FOLLOWS
              Builder(
                  builder: (context) {

                    const UserTab _tab = UserTab.following;
                    final bool _isSelected = selectedButton == BldrsTabs.bidProfileFollowing;

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
                      onTap: () => onTabChanged(BldrsTabs.bidProfileFollowing),
                    );
                  }
              ),

              /// SETTINGS
              Builder(
                  builder: (context) {

                    const UserTab _tab = UserTab.settings;
                    final bool _isSelected = selectedButton == BldrsTabs.bidProfileSettings;

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
                      onTap: () => onTabChanged(BldrsTabs.bidProfileSettings),
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
