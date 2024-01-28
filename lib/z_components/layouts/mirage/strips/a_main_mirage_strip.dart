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
    return Selector<NotesProvider, Badger>(
        selector: (_, NotesProvider notesProvider) => notesProvider.badger,
        builder: (_, Badger badger, Widget? child){

          return ValueListenableBuilder(
              valueListenable: _mirage0.selectedButton,
              builder: (_, String? selectedButton, Widget? child) {

                return _MirageStripScrollableList(
                  mirageModel: _mirage0,
                  columnChildren: <Widget>[

                    /// SECTIONS
                    Builder(
                        builder: (_) {

                          final bool _isSelected = selectedButton == BldrsTabber.bidHome;

                          return RedDotBadge(
                            height: _MirageButton.getHeight,
                            redDotIsOn: false,
                            approxChildWidth: _MirageButton.getWidth,
                            shrinkChild: true,
                            child: SectionsButton(
                              height: _MirageButton.getHeight,
                              color: _isSelected ? MirageModel.selectedButtonColor : MirageModel.buttonColor,
                              textColor: _isSelected ? MirageModel.selectedTextColor : MirageModel.textColor,
                              titleColor: _isSelected ? MirageModel.selectedTextColor : Colorz.grey255,
                              borderColor: _isSelected ? Colorz.black255 : null,
                              onTap: onSectionsTap,
                            ),
                          );
                        }
                        ),

                    /// ZONE
                    Selector<ZoneProvider, ZoneModel?>(
                        selector: (_, ZoneProvider pro) => pro.currentZone,
                        builder: (BuildContext context, ZoneModel? currentZone, Widget? child){

                          const String _bid = BldrsTabber.bidZone;

                          return _MirageButton(
                            isSelected: selectedButton == BldrsTabber.bidZone,
                            verse: ZoneModel.generateObeliskVerse(zone: currentZone),
                            icon: currentZone?.icon ?? Iconz.planet,
                            bigIcon: true,
                            iconColor: Colorz.nothing,
                            canShow: true,
                            redDotCount: Badger.getBadgeCount(badger: badger, bid: _bid),
                            redDotIsOn: Badger.checkBadgeRedDotIsOn(badger: badger, bid: _bid),
                            redDotVerse: Badger.getBadgeVerse(badger: badger, bid: _bid),
                            onTap: onZoneButtonTap,
                          );
                        }
                        ),

                    /// SIGN IN
                    Builder(
                        builder: (context) {

                          const String _bid = BldrsTabber.bidAuth;

                          return _MirageButton(
                            isSelected: selectedButton == BldrsTabber.bidAuth,
                            verse: const Verse(id: 'phid_sign', translate: true),
                            icon: Iconz.normalUser,
                            bigIcon: false,
                            iconColor: Colorz.white255,
                            canShow: !_userIsSignedUp,
                            redDotCount: Badger.getBadgeCount(badger: badger, bid: _bid),
                            redDotIsOn: Badger.checkBadgeRedDotIsOn(badger: badger, bid: _bid),
                            redDotVerse: Badger.getBadgeVerse(badger: badger, bid: _bid),
                            onTap: onSignInButtonTap,
                          );
                        }
                        ),

                    /// PROFILE
                    Builder(
                        builder: (_) {

                          const String _bid = BldrsTabber.bidAuth;
                          final bool _forceRedDot = _userModel == null || Formers.checkUserHasMissingFields(userModel: _userModel);

                          return _MirageButton(
                            isSelected: selectedButton == BldrsTabber.bidMyProfile,
                            verse: _userModel?.name == null ?
                            const Verse(id: 'phid_complete_my_profile', translate: true)
                                :
                            Verse(id: _userModel?.name, translate: false),
                            icon: _userModel?.picPath ?? Iconz.normalUser,
                            bigIcon: _userModel?.picPath != null,
                            iconColor: Colorz.nothing,
                            canShow: _userIsSignedUp,
                            redDotCount: Badger.getBadgeCount(badger: badger, bid: _bid),
                            redDotIsOn: Badger.checkBadgeRedDotIsOn(badger: badger, bid: _bid, forceRedDot: _forceRedDot),
                            redDotVerse: Badger.getBadgeVerse(badger: badger, bid: _bid),
                            onTap: onUserProfileButtonTap,
                          );
                        }
                        ),

                    /// ONE BZ ONLY
                    if (Lister.superLength(_userModel?.myBzzIDs) == 1)
                      BzBuilder(
                          bzID: _userModel!.myBzzIDs!.first,
                          builder: (bool loading, BzModel? bzModel, Widget? child) {

                            final int _count = Badger.calculateBzTotal(
                              bzID: _userModel.myBzzIDs!.first,
                              onlyNumbers: true,
                              badger: badger,
                            );

                            return _MirageButton(
                              loading: loading,
                              isSelected: selectedButton == BldrsTabber.bidMyBzz,
                              verse: Verse(
                                id: bzModel?.name,
                                translate: false,
                              ),
                              icon: StoragePath.bzz_bzID_logo(_userModel.myBzzIDs!.first),
                              bigIcon: true,
                              iconColor: null,
                              canShow: true,
                              redDotCount: _count,
                              redDotIsOn: _count > 0,
                              redDotVerse: null,
                              onTap: bzModel == null ? (){} : () => onMyBzTap(bzModel),
                            );
                          }
                          ),

                    /// MY BZZ
                    if (Lister.superLength(_userModel?.myBzzIDs) > 1)
                      BzzBuilder(
                          bzzIDs: _userModel?.myBzzIDs,
                          builder: (bool loading, List<BzModel> bzzModels, Widget? child) {

                            final int _count = Badger.calculateAllMyBzz(
                                badger: badger,
                                context: context,
                                listen: true,
                                onlyNumbers: true,
                            );

                            return _BzzMirageButton(
                              verse: const Verse(id: 'phid_my_bzz', translate: true,),
                              bzzModels: bzzModels,
                              canShow: Lister.superLength(bzzModels.length) > 1,
                              redDotCount: _count,
                              redDotIsOn: _count > 0,
                              redDotVerse: null,
                              isSelected: selectedButton == BldrsTabber.bidMyBzz,
                              onTap: onMyBzzTap,
                              loading: loading,
                            );
                          }
                          ),

                    /// SETTINGS
                    Builder(
                        builder: (context) {

                          const String _bid = BldrsTabber.bidAppSettings;

                          return _MirageButton(
                            isSelected: selectedButton == BldrsTabber.bidAppSettings,
                            verse: const Verse(id: 'phid_settings', translate: true),
                            icon: Iconz.more,
                            bigIcon: false,
                            iconColor: Colorz.white255,
                            canShow: true,
                            redDotCount: Badger.getBadgeCount(badger: badger, bid: _bid),
                            redDotIsOn: Badger.checkBadgeRedDotIsOn(badger: badger, bid: _bid),
                            redDotVerse: Badger.getBadgeVerse(badger: badger, bid: _bid),
                            onTap: onSettingsButtonTap,
                          );
                        }
                        ),

                  ],
                );
              }
              );
        }
        );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
