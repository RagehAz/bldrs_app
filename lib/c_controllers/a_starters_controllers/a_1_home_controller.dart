import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/b_auth/b_0_auth_screen.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_1_select_country_screen.dart';
import 'package:bldrs/b_views/x_screens/e_saves/e_0_saved_flyers_screen.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_0_my_bz_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_0_user_profile_screen.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/b_views/z_components/streamers/fire_coll_streamer.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/zone_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;

// -----------------------------------------------------------------------------

/// INITIALIZATION

// -------------------------------
Future<void> initializeHomeScreen(BuildContext context) async {

  await Future.wait(
      <Future<void>>[
        /// A - SHOW AD FLYER
        //
        /// D - ZONES
        initializeUserZone(context),
        /// E - PROMOTED FLYERS
        _initializePromotedFlyers(context),
        /// F - SPONSORS : USES BZZ PROVIDER
        _initializeSponsors(
          context: context,
          notify: true,
        ),
        /// J - SAVED FLYERS
        _initializeSavedFlyers(context),
        /// G - USER BZZ : USES BZZ PROVIDER
        _initializeUserBzz(
          context: context,
          notify: true,
        ),
        /// H - USER FOLLOWED BZZ : USES BZZ PROVIDER
        _initializeUserFollowedBzz(
            context: context,
            notify: true
        ),
        /// I - KEYWORDS
        _initializeSpecsAndKeywords(context)
  ]);

}
// -------------------------------
Future<void> initializeUserZone(BuildContext context) async {
  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  final UserModel _myUserModel = _userProvider.myUserModel;

  /// WHEN USER IS AUTHENTICATED
  if (_myUserModel != null && ZoneModel.zoneHasAllIDs(_myUserModel.zone)) {

    await zoneProvider.fetchSetCurrentZoneAndCountryAndCity(
      context: context,
      zone: _myUserModel.zone,
      notify: false,
    );

    await zoneProvider.fetchSetUserCountryAndCity(
      context: context,
      zone: _myUserModel.zone,
      notify: false,
    );

    await zoneProvider.fetchSetContinentByCountryID(
      context: context,
      countryID: _myUserModel.zone.countryID,
      notify: true,
    );

  }

  /// WHEN USER IS ANONYMOUS
  else {
    final ZoneModel _zoneByIP = await superGetZone(context);

    await zoneProvider.fetchSetCurrentZoneAndCountryAndCity(
      context: context,
      zone: _zoneByIP,
      notify: false,
    );

    await zoneProvider.fetchSetUserCountryAndCity(
      context: context,
      zone: _zoneByIP,
      notify: false,
    );
    await zoneProvider.fetchSetContinentByCountryID(
      context: context,
      countryID: _zoneByIP.countryID,
      notify: true,
    );

  }
}
// -------------------------------
Future<void> _initializeSponsors({
  @required BuildContext context,
  @required bool notify,
}) async {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.fetchSetSponsors(
    context: context,
    notify: notify,
  );
}
// -------------------------------
Future<void> _initializeSpecsAndKeywords(BuildContext context) async {
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  await _chainsProvider.fetchSetAllChains(context);
}
// -------------------------------
Future<void> _initializeUserBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.fetchSetMyBzz(
    context: context,
    notify: notify,
  );
}
// -------------------------------
Future<void> _initializeUserFollowedBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.fetchSetFollowedBzz(
    context: context,
    notify: notify,
  );
}
// -------------------------------
Future<void> _initializePromotedFlyers(BuildContext context) async {

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

  await _flyersProvider.fetchSetPromotedFlyers(
    context: context,
    notify: true,
  );

  /// OPEN FIRST PROMOTED FLYER IF POSSIBLE
  // final List<FlyerModel> _promotedFlyers = _flyersProvider.promotedFlyers;
  // if (Mapper.canLoopList(_promotedFlyers)){
  //   await Future.delayed(Ratioz.duration150ms, () async {
  //
  //      unawaited(Nav.openFlyer(
  //        context: context,
  //        flyer: _flyersProvider.promotedFlyers[0],
  //        isSponsored: true,
  //      ));
  //
  //   });
  // }

}
// -------------------------------
Future<void> _initializeSavedFlyers(BuildContext context) async {

  if (AuthModel.userIsSignedIn() == true ){

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(context);

    final List<String> _savedFlyersIDs = _myUserModel?.savedFlyersIDs;

    if (Mapper.checkCanLoopList(_savedFlyersIDs)){

      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
      await _flyersProvider.fetchSetSavedFlyers(
        context: context,
        notify: true,
      );
    }

  }
}
// -----------------------------------------------------------------------------

/// PYRAMIDS NAVIGATION

// -------------------------------
List<NavModel> generateMainNavModels(BuildContext context){

  final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(context: context, listen: true);
  final UserModel _userModel = UsersProvider.proGetMyUserModel(context, listen: true);
  final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(context: context, listen: true);
  final String _countryFlag = Flag.getFlagIconByCountryID(_currentZone?.countryID);

  return <NavModel>[

    /// SIGN IN
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.signIn),
      title: superPhrase(context, 'phid_sign'),
      icon: Iconz.normalUser,
      screen: const AuthScreen(),
      iconSizeFactor: 0.6,
      canShow: AuthModel.userIsSignedIn() == false,
    ),

    /// QUESTIONS
    // NavModel(
    // id: NavModelID.questions,
    //   title: 'Questions',
    //   icon: Iconz.utPlanning,
    //   screen: const QScreen(),
    // ),

    /// MY PROFILE
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.profile),
      title: _userModel?.name,
      icon: _userModel?.pic,
      screen: const UserProfileScreen(),
      iconSizeFactor: 1,
      iconColor: Colorz.nothing,
      canShow: AuthModel.userIsSignedIn() == true,
    ),

    /// SAVED FLYERS
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.savedFlyers),
      title: 'Saved Flyers',
      icon: Iconz.saveOff,
      screen: const SavedFlyersScreen(),
      canShow: AuthModel.userIsSignedIn() == true,
    ),

    /// SEPARATOR
    if (AuthModel.userIsSignedIn() == true && UserModel.checkUserIsAuthor(_userModel) == true)
      null,

    /// MY BZZ
    ...List.generate(_bzzModels.length, (index){

      final BzModel _bzModel = _bzzModels[index];

      return NavModel(
          id: NavModel.getMainNavIDString(
              navID: MainNavModel.bz,
              bzID: _bzModel.id,
          ),
          title: _bzModel.name,
          icon: _bzModel.logo,
          iconSizeFactor: 1,
          iconColor: Colorz.nothing,
          screen: const MyBzScreen(),
          onNavigate: (){

            final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
            _bzzProvider.setActiveBz(bzModel: _bzModel, notify: true);

          }
      );

    }),

    /// SEPARATOR
    null,

    /// ZONE
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.zone),
      title: '${_currentZone?.districtName}, ${_currentZone?.cityName}, ${_currentZone?.countryName}',
      icon: _countryFlag,
      screen: const SelectCountryScreen(),
      iconSizeFactor: 1,
      iconColor: Colorz.nothing,
    ),

  ];
}
// -------------------------------
Future<void> onNavigate({
  @required int index,
  @required List<NavModel> models,
  @required ValueNotifier<int> tabIndex,
  @required BuildContext context,
  @required ValueNotifier<bool> isExpanded,
}) async {

  final NavModel _navModel = models[index];

  tabIndex.value = index;
  // onTriggerExpansion();

  await Future.delayed(const Duration(milliseconds: 50), () async {

    if (_navModel.onNavigate != null){
      await _navModel.onNavigate();
    }

    await Nav.goToNewScreen(
      context: context,
      screen: _navModel.screen,
      transitionType: PageTransitionType.fade,
    );

    tabIndex.value = null;
    isExpanded.value = false;

  });


}
// -----------------------------------------------------------------------------

/// FLYERS PAGINATION

// -------------------------------
bool fuckingPaginator({
  @required BuildContext context,
  @required ScrollController scrollController,
  @required bool canPaginate,
  @required Function function,
}){
  bool _canPaginate = canPaginate;

  scrollController.addListener(() async {

    final double _maxScroll = scrollController.position.maxScrollExtent;
    final double _currentScroll = scrollController.position.pixels;
    // final double _screenHeight = Scale.superScreenHeight(context);
    const double _paginationHeightLight = Ratioz.horizon * 3;

    if (_maxScroll - _currentScroll <= _paginationHeightLight && _canPaginate == true){

      // blog('_maxScroll : $_maxScroll : _currentScroll : $_currentScroll : diff : ${_maxScroll - _currentScroll} : _delta : $_delta');

      _canPaginate = false;

      await function();

      _canPaginate = true;

    }

  });

  return _canPaginate;
}
// -------------------------------
bool initializeFlyersPagination({
  @required BuildContext context,
  @required ScrollController scrollController,
  @required bool canPaginate,
}) {

  bool _canPaginate = canPaginate;

  scrollController.addListener(() async {

    final double _maxScroll = scrollController.position.maxScrollExtent;
    final double _currentScroll = scrollController.position.pixels;
    // final double _screenHeight = Scale.superScreenHeight(context);
    const double _paginationHeightLight = Ratioz.horizon * 3;

    if (_maxScroll - _currentScroll <= _paginationHeightLight && _canPaginate == true){

      // blog('_maxScroll : $_maxScroll : _currentScroll : $_currentScroll : diff : ${_maxScroll - _currentScroll} : _delta : $_delta');

      _canPaginate = false;

      await readMoreFlyers(context);

      _canPaginate = true;

    }

  });

  return _canPaginate;
}
// -------------------------------
Future<void> readMoreFlyers(BuildContext context) async {
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  await _flyersProvider.paginateWallFlyers(context);
}
// -------------------------------
Future<void> onRefreshHomeWall(BuildContext context) async {
  // final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  // final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: true);
  // final SectionClass.Section _currentSection = _keywordsProvider.currentSection;
  // final KW _currentKeyword = _keywordsProvider.currentKeyword;

  // await _flyersProvider.getsetWallFlyersBySectionAndKeyword(
  //   context: context,
  //   section: _currentSection,
  //   kw: _currentKeyword,
  // );

  blog('onRefreshHomeWall : SHOULD REFRESH SCREEN');

}
// -----------------------------------------------------------------------------

/// FLYERS INTERACTIONS

// -------------------------------
Future<void> onFlyerTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  // blog('OPENING FLYER ID : ${flyer?.id}');

  await Nav.goToNewScreen(
      context: context,
      screen: FlyerScreen(
        flyerModel: flyer,
        flyerID: flyer.id,
        initialSlideIndex: 0,
      )
  );

}
// -----------------------------------------------------------------------------

/// USER NOTES

// -------------------------------
void initializeUserNotes(BuildContext context){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  final UserModel _userModel = UsersProvider.proGetMyUserModel(context);

  if (_userModel != null){

    final bool _thereAreMissingFields = UserModel.checkMissingFields(_userModel);

    final Stream<QuerySnapshot<Object>> _stream  = Fire.streamCollection(
      collName: FireColl.notes,
      limit: 100,
      orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
      finders: <FireFinder>[

        FireFinder(
          field: 'receiverID',
          comparison: FireComparison.equalTo,
          value: _userModel.id,
        ),

        FireFinder(
          field: 'seen',
          comparison: FireComparison.equalTo,
          value: false,
        ),

      ],
    );

    FireCollStreamer.onStreamDataChanged(
      stream: _stream,
      oldMaps: NoteModel.cipherNotesModels(notes: _notesProvider.userNotes, toJSON: false),
      onChange: (List<Map<String, dynamic>> newMaps){

        blog('new maps are :-');
        Mapper.blogMaps(newMaps);

        final List<NoteModel> _notes = NoteModel.decipherNotesModels(
          maps: newMaps,
          fromJSON: false,
        );

        _notesProvider.setUserNotes(
            notes: _notes,
            notify: true
        );

        final bool _noteDotIsOn = _checkNoteDotIsOn(
          thereAreMissingFields: _thereAreMissingFields,
          notes: _notes,
        );

        final int _notesCount = _getNotesCount(
          notes: _notes,
          thereAreMissingFields: _thereAreMissingFields,
        );

        if (_notesCount != null){
          _notesProvider.incrementObeliskNoteNumber(
            value: _notesCount,
            navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
            notify: false,
          );
          _notesProvider.incrementObeliskNoteNumber(
            value: _notesCount,
            navModelID: NavModel.getUserTabNavID(UserTab.notifications),
            notify: true,
          );

        }

        if (_noteDotIsOn == true){
          _notesProvider.setIsFlashing(
            flashing: true,
            notify: true,
          );
        }

      },
    );

  }

}
// -------------------------------
bool _checkNoteDotIsOn({
  @required bool thereAreMissingFields,
  @required List<NoteModel> notes,
}){

  bool _isOn = false;

  if (thereAreMissingFields == true){
    _isOn = true;
  }
  else {

    if (Mapper.checkCanLoopList(notes) == true){
      _isOn = NoteModel.checkThereAreUnSeenNotes(notes);
    }

  }

  return _isOn;
}
// -------------------------------
int _getNotesCount({
  @required bool thereAreMissingFields,
  @required List<NoteModel> notes,
}){
  int _count;

  if (thereAreMissingFields == false){
    if (Mapper.checkCanLoopList(notes) == true){
      _count = NoteModel.getNumberOfUnseenNotes(notes);
    }
  }

  return _count;
}
// -------------------------------
