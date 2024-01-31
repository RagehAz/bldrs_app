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

          return _MirageStripScrollableList(
            mirageModel: thisMirage,
            columnChildren: <Widget>[

              /// ABOUT
              Builder(
                  builder: (context) {

                    const String? _bid = TabName.bid_MyBz_Info;
                    final bool _isSelected = _bid == TabName.getBidFromBidBz(bzBid: _bidBz);

                    return MirageButton(
                      buttonID: TabName.generateBzBid(bzID: bzID, bid: _bid),
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

              /// FLYERS
              Builder(
                  builder: (context) {

                    const String? _bid = TabName.bid_MyBz_Flyers;
                    final bool _isSelected = _bid == TabName.getBidFromBidBz(bzBid: _bidBz);

                    return MirageButton(
                      buttonID: TabName.generateBzBid(bzID: bzID, bid: _bid),
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

              /// TEAM
              Builder(
                  builder: (context) {

                    const String? _bid = TabName.bid_MyBz_Team;
                    final bool _isSelected = _bid == TabName.getBidFromBidBz(bzBid: _bidBz);

                    return MirageButton(
                      buttonID: TabName.generateBzBid(bzID: bzID, bid: _bid),
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

              /// NOTES
              Builder(
                  builder: (context) {

                    const String? _bid = TabName.bid_MyBz_Notes;
                    final bool _isSelected = _bid == TabName.getBidFromBidBz(bzBid: _bidBz);

                    return MirageButton(
                      buttonID: TabName.generateBzBid(bzID: bzID, bid: _bid),
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

                    const String? _bid = TabName.bid_MyBz_Settings;
                    final bool _isSelected = _bid == TabName.getBidFromBidBz(bzBid: _bidBz);

                    return MirageButton(
                      buttonID: TabName.generateBzBid(bzID: bzID, bid: _bid),
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
