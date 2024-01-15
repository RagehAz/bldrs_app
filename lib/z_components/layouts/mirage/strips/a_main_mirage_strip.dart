part of mirage;
// ignore_for_file: unused_element

class _MainMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MainMirageStrip({
    required this.mirage0,
    required this.mounted,
    required this.allMirages,
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
  final _MirageModel mirage0;
  final List<_MirageModel> allMirages;
  final bool mounted;
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
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      /// if true, rebuilds the grid for each flyer save
      listen: false,
    );
    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: true,
    );
    final bool _userIsSignedUp = Authing.userIsSignedUp(_userModel?.signInMethod);
    // --------------------
    return Selector<NotesProvider, List<MapModel>>(
        selector: (_, NotesProvider notesProvider) => notesProvider.obeliskBadges,
        builder: (_, List<MapModel>? badges, Widget? child){

          return ValueListenableBuilder(
              valueListenable: mirage0.selectedButton,
              builder: (_, String? selectedButton, Widget? child) {

                return _MirageStripFloatingList(
                  columnChildren: <Widget>[

                    /// SECTIONS
                    Builder(
                        builder: (_) {

                          final bool _isSelected = selectedButton == _MirageModel.sectionsButtonID;

                          return RedDotBadge(
                            height: _MirageButton.getHeight,
                            redDotIsOn: false,
                            approxChildWidth: _MirageButton.getWidth,
                            shrinkChild: true,
                            child: SectionsButton(
                              height: _MirageButton.getHeight,
                              color: _isSelected ? _MirageModel.selectedButtonColor : _MirageModel.buttonColor,
                              textColor: _isSelected ? _MirageModel.selectedTextColor : _MirageModel.textColor,
                              titleColor: _isSelected ? _MirageModel.selectedTextColor : Colorz.grey255,
                              borderColor: _isSelected ? Colorz.black255 : null,
                              onTap: onSectionsTap,
                            ),
                          );
                        }
                        ),

                    /// ZONE
                    Builder(
                        builder: (context) {

                          final String _countryFlag = _currentZone?.icon ?? Iconz.planet;

                          final MapModel? _badge = MapModel.getModelByKey(
                            models: badges,
                            key: NavModel.getMainNavIDString(navID: MainNavModel.zone),
                          );
                          final Verse? _redDotVerse = ObeliskIcon.getRedDotVerse(badge: _badge);

                          return _MirageButton(
                            isSelected: false,
                            verse: ZoneModel.generateObeliskVerse(zone: _currentZone),
                            icon: _countryFlag,
                            bigIcon: true,
                            iconColor: null,
                            canShow: true,
                            redDotCount: ObeliskIcon.getCount(badge: _badge),
                            redDotIsOn: ObeliskIcon.checkRedDotIsOn(forceRedDot: false, badge: _badge),
                            redDotVerse: _redDotVerse,
                            onTap: onZoneButtonTap,
                          );
                        }
                        ),

                    /// SIGN IN
                    Builder(
                        builder: (context) {

                          final MapModel? _badge = MapModel.getModelByKey(
                            models: badges,
                            key: NavModel.getMainNavIDString(navID: MainNavModel.signIn),
                          );
                          final Verse? _redDotVerse = ObeliskIcon.getRedDotVerse(badge: _badge);

                          return _MirageButton(
                            isSelected: false,
                            verse: const Verse(id: 'phid_sign', translate: true),
                            icon: Iconz.normalUser,
                            bigIcon: false,
                            iconColor: Colorz.white255,
                            canShow: !_userIsSignedUp,
                            redDotCount: ObeliskIcon.getCount(badge: _badge),
                            redDotIsOn: ObeliskIcon.checkRedDotIsOn(forceRedDot: false, badge: _badge),
                            redDotVerse: _redDotVerse,
                            onTap: onSignInButtonTap,
                          );
                        }
                        ),

                    /// PROFILE
                    Builder(
                        builder: (_) {

                          final MapModel? _badge = MapModel.getModelByKey(
                            models: badges,
                            key: NavModel.getMainNavIDString(navID: MainNavModel.profile),
                          );
                          final Verse? _redDotVerse = ObeliskIcon.getRedDotVerse(badge: _badge);

                          final bool _forceRedDot = _userModel == null || Formers.checkUserHasMissingFields(userModel: _userModel);

                          return _MirageButton(
                            isSelected: selectedButton == _MirageModel.userTabID,
                            verse: _userModel?.name == null ?
                            const Verse(id: 'phid_complete_my_profile', translate: true)
                                :
                            Verse(id: _userModel?.name, translate: false),
                            icon: _userModel?.picPath ?? Iconz.normalUser,
                            bigIcon: _userModel?.picPath != null,
                            iconColor: Colorz.nothing,
                            canShow: _userIsSignedUp,
                            redDotCount: ObeliskIcon.getCount(badge: _badge),
                            redDotIsOn: ObeliskIcon.checkRedDotIsOn(forceRedDot: _forceRedDot, badge: _badge),
                            redDotVerse: _redDotVerse,
                            onTap: onUserProfileButtonTap,
                          );
                        }
                        ),

                    /// ONE BZ ONLY
                    if (Lister.superLength(_userModel?.myBzzIDs) == 1)
                      BzBuilder(
                          bzID: _userModel!.myBzzIDs!.first,
                          builder: (bool loading, BzModel? bzModel, Widget? child) {

                            final MapModel? _badge = MapModel.getModelByKey(
                              models: badges,
                              key: NavModel.getMainNavIDString(
                                navID: MainNavModel.bz,
                                bzID: bzModel?.id,
                              ),
                            );
                            final Verse? _redDotVerse = ObeliskIcon.getRedDotVerse(badge: _badge);

                            return _MirageButton(
                              loading: loading,
                              isSelected: false,
                              verse: Verse(
                                id: bzModel?.name,
                                translate: false,
                              ),
                              icon: StoragePath.bzz_bzID_logo(_userModel.myBzzIDs!.first),
                              bigIcon: true,
                              iconColor: null,
                              canShow: true,
                              redDotCount: ObeliskIcon.getCount(badge: _badge),
                              redDotIsOn: ObeliskIcon.checkRedDotIsOn(forceRedDot: false, badge: _badge),
                              redDotVerse: _redDotVerse,
                              onTap: bzModel == null ? (){} : () => onMyBzTap(bzModel),
                            );
                          }
                          ),

                    /// MY BZZ
                    if (Lister.superLength(_userModel?.myBzzIDs) > 1)
                      BzzBuilder(
                          bzzIDs: _userModel?.myBzzIDs,
                          builder: (bool loading, List<BzModel> bzzModels, Widget? child) {

                            final MapModel? _badge = MapModel.getModelByKey(
                              models: badges,
                              key: '',//NavModel.getMainNavIDString(navID: ''),
                            );
                            final Verse? _redDotVerse = ObeliskIcon.getRedDotVerse(badge: _badge);
                            final bool _isSelected = selectedButton == _MirageModel.bzzButtonID;

                            return _BzzMirageButton(
                              verse: const Verse(id: 'phid_my_bzz', translate: true,),
                              bzzModels: bzzModels,
                              canShow: Lister.superLength(bzzModels.length) > 1,
                              redDotCount: ObeliskIcon.getCount(badge: _badge),
                              redDotIsOn: ObeliskIcon.checkRedDotIsOn(forceRedDot: false, badge: _badge),
                              redDotVerse: _redDotVerse,
                              isSelected: _isSelected,
                              onTap: onMyBzzTap,
                              loading: loading,
                            );
                          }
                          ),

                    /// SETTINGS
                    Builder(
                        builder: (context) {

                          final MapModel? _badge = MapModel.getModelByKey(
                            models: badges,
                            key: NavModel.getMainNavIDString(navID: MainNavModel.settings),
                          );
                          final Verse? _redDotVerse = ObeliskIcon.getRedDotVerse(badge: _badge);

                          return _MirageButton(
                            isSelected: selectedButton == _MirageModel.appSettingsID,
                            verse: const Verse(id: 'phid_settings', translate: true),
                            icon: Iconz.more,
                            bigIcon: false,
                            iconColor: Colorz.white255,
                            canShow: true,
                            redDotCount: ObeliskIcon.getCount(badge: _badge),
                            redDotIsOn: ObeliskIcon.checkRedDotIsOn(forceRedDot: false, badge: _badge),
                            redDotVerse: _redDotVerse,
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
