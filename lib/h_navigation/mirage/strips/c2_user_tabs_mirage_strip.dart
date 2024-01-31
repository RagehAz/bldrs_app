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

          return _MirageStripScrollableList(
            mirageModel: mirage1,
            columnChildren: <Widget>[

              /// PROFILE
              Builder(
                  builder: (context) {

                    const String _bid = TabName.bid_My_Info;
                    final bool _isSelected = selectedButton == _bid;

                    return MirageButton(
                      verse: TabName.translateBid(_bid),
                      icon: TabName.getBidIcon(_bid),
                      buttonID: TabName.bid_My_Info,
                      isSelected: _isSelected,
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

                    const String _bid = TabName.bid_My_Saves;
                    final bool _isSelected = selectedButton == _bid;

                    return MirageButton(
                      buttonID: _bid,
                      verse: TabName.translateBid(_bid),
                      icon: TabName.getBidIcon(_bid),
                      isSelected: _isSelected,
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

                    const String _bid = TabName.bid_My_Notes;
                    final bool _isSelected = selectedButton == _bid;

                    return MirageButton(
                      buttonID: _bid,
                      verse: TabName.translateBid(_bid),
                      icon: TabName.getBidIcon(_bid),
                      isSelected: _isSelected,
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

                    const String _bid = TabName.bid_My_Follows;
                    final bool _isSelected = selectedButton == _bid;

                    return MirageButton(
                      buttonID: _bid,
                      verse: TabName.translateBid(_bid),
                      icon: TabName.getBidIcon(_bid),
                      isSelected: _isSelected,
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

                    const String _bid = TabName.bid_My_Settings;
                    final bool _isSelected = selectedButton == _bid;

                    return MirageButton(
                      buttonID: _bid,
                      verse: TabName.translateBid(_bid),
                      icon: TabName.getBidIcon(_bid),
                      isSelected: _isSelected,
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
