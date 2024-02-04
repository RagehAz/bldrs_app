part of mirage;
// ignore_for_file: unused_element

class MainMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MainMirageStrip({
    required this.onMyBzzTap,
    required this.onSectionsTap,
    required this.onUserProfileButtonTap,
    required this.onZoneButtonTap,
    required this.onSignInButtonTap,
    required this.onMyBzTap,
    required this.onSettingsButtonTap,
    super.key
  });
  // --------------------
  final Function onMyBzzTap;
  final Function onSectionsTap;
  final Function onUserProfileButtonTap;
  final Function onZoneButtonTap;
  final Function onSignInButtonTap;
  final Function(BzModel bzModel) onMyBzTap;
  final Function onSettingsButtonTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final MirageModel _mirage0 = HomeProvider.proGetMirageByIndex(
      context: context,
      listen: true,
      index: 0,
    );
    // --------------------
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );
    final bool _userIsSignedUp = Authing.userIsSignedUp(_userModel?.signInMethod);
    // --------------------
    return ValueListenableBuilder(
        valueListenable: _mirage0.selectedButton,
        builder: (_, String? selectedButton, Widget? child) {

          return _MirageStripScrollableList(
            mirageModel: _mirage0,
            columnChildren: <Widget>[

              /// SECTIONS
              Padding(
                padding: Scale.superInsets(
                  context: context,
                  appIsLTR: UiProvider.checkAppIsLeftToRight(),
                  enLeft: 10,
                ),
                child: SectionMirageButton(
                  isSelected: selectedButton == TabName.bid_Home,
                  onTap: onSectionsTap,
                ),
              ),

              /// ZONE
              Selector<ZoneProvider, ZoneModel?>(
                  selector: (_, ZoneProvider pro) => pro.currentZone,
                  builder: (BuildContext context, ZoneModel? currentZone, Widget? child){

                    return MirageButton(
                      buttonID: TabName.bid_Zone,
                      isSelected: selectedButton == TabName.bid_Zone,
                      verse: ZoneModel.generateObeliskVerse(zone: currentZone),
                      icon: currentZone?.icon ?? Iconz.planet,
                      bigIcon: true,
                      iconColor: Colorz.nothing,
                      canShow: true,
                      onTap: onZoneButtonTap,
                    );
                  }
              ),

              /// SIGN IN
              MirageButton(
                buttonID: TabName.bid_Auth,
                isSelected: selectedButton == TabName.bid_Auth,
                verse: const Verse(id: 'phid_sign', translate: true),
                icon: Iconz.normalUser,
                bigIcon: false,
                iconColor: Colorz.white255,
                canShow: !_userIsSignedUp,
                onTap: onSignInButtonTap,
              ),

              /// PROFILE
              Builder(
                  builder: (_) {

                    final bool _forceRedDot = _userModel == null || Formers.checkUserHasMissingFields(userModel: _userModel);

                    final Badger _badger = NotesProvider.proGetBadger(
                      context: context,
                      listen: true,
                    );

                    final int _count = Badger.calculateUserTotal(
                      onlyNumbers: true,
                      badger: _badger,
                    );

                    return MirageButton(
                      buttonID: TabName.bid_MyProfile,
                      isSelected: selectedButton == TabName.bid_MyProfile,
                      verse: _userModel?.name == null ?
                      const Verse(id: 'phid_complete_my_profile', translate: true)
                          :
                      Verse(id: _userModel?.name, translate: false),
                      icon: _userModel?.picPath ?? Iconz.normalUser,
                      bigIcon: _userModel?.picPath != null,
                      iconColor: Colorz.nothing,
                      canShow: _userIsSignedUp,
                      forceRedDot: _forceRedDot,
                      countOverride: _count,
                      onTap: onUserProfileButtonTap,
                    );
                  }
              ),

              /// ONE BZ ONLY
              if (Lister.superLength(_userModel?.myBzzIDs) == 1)
                BzMirageButton(
                  isSelected: TabName.getBzIDFromBidBz(bzBid: selectedButton) == _userModel!.myBzzIDs!.first,
                  buttonID: TabName.bid_MyBzz,
                  bzID: _userModel.myBzzIDs!.first,
                  onTap: onMyBzTap,
                ),

              /// MY BZZ
              if (Lister.superLength(_userModel?.myBzzIDs) > 1)
                _BzzMirageButton(
                  verse: const Verse(id: 'phid_my_bzz', translate: true,),
                  bzzIDs: _userModel?.myBzzIDs,
                  canShow: Lister.superLength(_userModel?.myBzzIDs) > 1,
                  isSelected: selectedButton == TabName.bid_MyBzz,
                  onTap: onMyBzzTap,
                ),

              /// SETTINGS
              Padding(
                padding: Scale.superInsets(
                  context: context,
                  appIsLTR: UiProvider.checkAppIsLeftToRight(),
                  enRight: 5,
                ),
                child: MirageButton(
                  buttonID: TabName.bid_AppSettings,
                  isSelected: selectedButton == TabName.bid_AppSettings,
                  verse: const Verse(id: 'phid_settings', translate: true),
                  icon: Iconz.more,
                  bigIcon: false,
                  iconColor: Colorz.white255,
                  canShow: true,
                  onTap: onSettingsButtonTap,
                ),
              ),

            ],
          );
        }
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
