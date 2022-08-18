import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/b_auth/a_auth_screen.dart';
import 'package:bldrs/b_views/x_screens/d_user/a_user_profile/a_user_profile_screen.dart';
import 'package:bldrs/b_views/x_screens/d_user/b_user_editor/a_user_editor_screen.dart';
import 'package:bldrs/b_views/x_screens/e_saves/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/a_my_bz_screen.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/a_select_country_screen.dart';
import 'package:bldrs/b_views/x_screens/i_app_settings/a_app_settings_screen.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_streamer.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
import 'package:bldrs/e_db/fire/ops/zone_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/nav_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// INITIALIZATION

// -------------------------------
Future<void> initializeHomeScreen(BuildContext context) async {

  await checkIfUserIsMissingFields(
    context: context,
  );

  await _initializeUserZone(context);

  /// D - ZONES
  await _initializeCurrentZone(context);

  await Future.wait(
      <Future<void>>[
        /// A - SHOW AD FLYER
        //
        /// E - PROMOTED FLYERS
        _initializePromotedFlyers(context),
        /// F - SPONSORS : USES BZZ PROVIDER
        _initializeSponsors(
          context: context,
          notify: true,
        ),
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
  ]);

  /// I - KEYWORDS
  unawaited(_initializeAllChains(context));

}
// -------------------------------
Future<void> _initializeUserZone(BuildContext context) async {
  blog('initializeHomeScreen._initializeUserZone : ~~~~~~~~~~ START');

  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _userProvider.myUserModel;

  if (_myUserModel != null){

    final ZoneModel _userZoneCompleted = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _myUserModel?.zone,
    );

    _userProvider.setMyUserModelAndAuthModel(
      userModel: _myUserModel?.copyWith(zone: _userZoneCompleted),
      notify: true,
    );

  }
  blog('initializeHomeScreen._initializeUserZone : ~~~~~~~~~~ END');
}
// -------------------------------
Future<void> _initializeCurrentZone(BuildContext context) async {
  blog('initializeHomeScreen._initializeCurrentZone : ~~~~~~~~~~ START');

  final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  /// USER ZONE IS DEFINED
  if (_myUserModel?.zone != null && AuthModel.userIsSignedIn() == true){

    await zoneProvider.fetchSetCurrentCompleteZone(
        context: context,
        zone: _myUserModel.zone,
        notify: true,
    );

  }

  /// USER ZONE IS NOT DEFINED
  else {

    final ZoneModel _zoneByIP = await ZoneFireOps.superGetZoneByIP(context);

    await zoneProvider.fetchSetCurrentCompleteZone(
      context: context,
      zone: _zoneByIP,
      notify: true,
    );

  }

  blog('initializeHomeScreen._initializeCurrentZone : ~~~~~~~~~~ END');
}
// -------------------------------
Future<void> _initializeSponsors({
  @required BuildContext context,
  @required bool notify,
}) async {
  blog('initializeHomeScreen._initializeSponsors : ~~~~~~~~~~ START');
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.fetchSetSponsors(
    context: context,
    notify: notify,
  );
  blog('initializeHomeScreen._initializeSponsors : ~~~~~~~~~~ END');
}
// -------------------------------
Future<void> _initializeAllChains(BuildContext context) async {
  blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ START');
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  await _chainsProvider.initializeAllChains(
    context: context,
    notify: true,
  );
  blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ END');
}
// -------------------------------
Future<void> _initializeUserBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ START');
  if (AuthModel.userIsSignedIn() == true){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    await _bzzProvider.fetchSetMyBzz(
      context: context,
      notify: notify,
    );
  }
  blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ END');
}
// -------------------------------
Future<void> _initializeUserFollowedBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ START');
  if (AuthModel.userIsSignedIn() == true){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    await _bzzProvider.fetchSetFollowedBzz(
      context: context,
      notify: notify,
    );
  }
  blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ END');
}
// -------------------------------
Future<void> _initializePromotedFlyers(BuildContext context) async {
  blog('initializeHomeScreen._initializePromotedFlyers : ~~~~~~~~~~ START');

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
  blog('initializeHomeScreen._initializePromotedFlyers : ~~~~~~~~~~ END');

}

// -----------------------------------------------------------------------------

/// USER MISSING FIELDS

// -------------------------------
Future<void> checkIfUserIsMissingFields({
  @required BuildContext context,
}) async {
  blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ START');

  if (AuthFireOps.superUserID() != null){

    final AuthModel _authModel = await AuthLDBOps.readAuthModel();

    final bool _thereAreMissingFields = UserModel.checkMissingFields(_authModel?.userModel);

    /// MISSING FIELDS FOUND
    if (_thereAreMissingFields == true){

      await _controlMissingFieldsCase(
        context: context,
        authModel: _authModel,
      );

    }

  }
  blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ END');
}
// ---------------------------------
Future<void> _controlMissingFieldsCase({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  await showMissingFieldsDialog(
    context: context,
    userModel: authModel?.userModel,
  );

  await Nav.goToNewScreen(
      context: context,
      screen: EditProfileScreen(
        userModel: authModel.userModel,
        reAuthBeforeConfirm: false,
        canGoBack: true,
        onFinish: () async {
          Nav.goBack(
            context: context,
            invoker: '_controlMissingFieldsCase',
          );
        },
      )

  );

}
// ------------------------------------
/// TESTED : WORKS PERFECT
Future<void> showMissingFieldsDialog({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  final List<String> _missingFields = UserModel.missingFields(userModel);
  final String _missingFieldsString = Stringer.generateStringFromStrings(
    strings: _missingFields,
  );

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'Complete Your profile',
    body:
    'Required fields :\n'
        '$_missingFieldsString',
  );

}
// -----------------------------------------------------------------------------

/// PYRAMIDS NAVIGATION

// -------------------------------
List<NavModel> generateMainNavModels({
  @required BuildContext context,
  @required List<BzModel> bzzModels,
  @required ZoneModel currentZone,
  @required UserModel userModel,
}){

  final String _countryFlag = currentZone?.flag;

  return <NavModel>[

    /// SIGN IN
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.signIn),
      title: xPhrase(context, 'phid_sign'),
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
      title: userModel?.name ?? 'Complete my profile',
      icon: userModel?.pic ?? Iconz.normalUser,
      screen: const UserProfileScreen(),
      iconSizeFactor: userModel?.pic == null ? 0.55 : 1,
      iconColor: Colorz.nothing,
      canShow: AuthModel.userIsSignedIn() == true,
      forceRedDot: userModel == null || UserModel.checkMissingFields(userModel),
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
    if (AuthModel.userIsSignedIn() == true && UserModel.checkUserIsAuthor(userModel) == true)
      null,

    /// MY BZZ
    ...List.generate(bzzModels.length, (index){

      final BzModel _bzModel = bzzModels[index];

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
      icon: _countryFlag,
      screen: const SelectCountryScreen(
        selectCountryAndCityOnly: true,
        settingCurrentZone: true,
      ),
      iconSizeFactor: 1,
      iconColor: Colorz.nothing,
      title: ZoneModel.generateObeliskString(
          context: context,
          zone: currentZone
      ),
    ),

    /// SEPARATOR
    null,

    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.settings),
      title: 'Settings',
      icon: Iconz.more,
      screen: const AppSettingsScreen(),
      iconSizeFactor: 0.6,
      iconColor: Colorz.nothing,
    ),

  ];
}
// -------------------------------
Future<void> onNavigate({
  @required int index,
  @required List<NavModel> models,
  @required ValueNotifier<ProgressBarModel> progressBarModel,
  @required BuildContext context,
  @required ValueNotifier<bool> isExpanded,
}) async {

  final NavModel _navModel = models[index];

  progressBarModel.value = progressBarModel.value?.copyWith(
    index: index,
  );
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

    progressBarModel.value = ProgressBarModel.emptyModel();
    isExpanded.value = false;

  });


}
// -----------------------------------------------------------------------------

/// FLYERS PAGINATION

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
/*
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
 */
// -----------------------------------------------------------------------------

/// OBELISK

// -------------------------------
void initializeObeliskNumbers(BuildContext context){
  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  _notesProvider.generateSetInitialObeliskNumbers(
      context: context,
      notify: false,
  );
}
// -----------------------------------------------------------------------------

/// USER NOTES STREAM

// -------------------------------
StreamSubscription initializeUserNotes(BuildContext context){

  StreamSubscription _sub;

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  if (_userModel != null){

    /// TASK : STREAM NEEDS TO BE CLOSED WHEN DELETING USER
    final Stream<QuerySnapshot<Object>> _stream = _userUnseenReceivedNotesStream(
      context: context
    );

    final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = _getCipheredProUserUnseenReceivedNotes(
      context: context,
    );

    _sub = FireCollStreamer.onStreamDataChanged(
      stream: _stream,
      oldMaps: _oldMaps,
      onChange: (List<Map<String, dynamic>> allUpdatedMaps) async {

        blog('new maps are :-');
        Mapper.blogMaps(allUpdatedMaps);

        final List<NoteModel> _notes = NoteModel.decipherNotes(
          maps: allUpdatedMaps,
          fromJSON: false,
        );

        _notesProvider.setUserNotesAndRebuild(
            context: context,
            notes: _notes,
            notify: true,
        );

        final bool _noteDotIsOn = _checkNoteDotIsOn(
          context: context,
          notes: _notes,
        );

        if (_noteDotIsOn == true){
          _notesProvider.setIsFlashing(
            setTo: true,
            notify: true,
          );
        }

        await _checkForBzDeletionNoteAndProceed(
          context: context,
          notes: _notes,
        );

      },
    );

  }

  return _sub;
}
// -------------------------------
ValueNotifier<List<Map<String, dynamic>>> _getCipheredProUserUnseenReceivedNotes({
  @required BuildContext context,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

  final List<Map<String, dynamic>> _oldNotesMaps = NoteModel.cipherNotesModels(
    notes: _notesProvider.userNotes,
    toJSON: false,
  );

  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = ValueNotifier(_oldNotesMaps);

  return _oldMaps;
}
// -------------------------------
Stream<QuerySnapshot<Object>> _userUnseenReceivedNotesStream({
  @required BuildContext context,
}){

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  return Fire.streamCollection(
    queryModel: FireQueryModel(
        collRef: Fire.createSuperCollRef(aCollName: FireColl.notes),
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
        onDataChanged: (List<Map<String, dynamic>> maps){
          blog('_userUnseenReceivedNotesStream : onDataChanged : ${maps.length} maps');
        }
    ),
  );

}
// -------------------------------
Future<void> _checkForBzDeletionNoteAndProceed({
  @required BuildContext context,
  @required List<NoteModel> notes,
}) async {

  blog('_checkForBzDeletionNoteAndProceed : start');

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
  );

  if (UserModel.checkUserIsAuthor(_userModel) == true){

    blog('_checkForBzDeletionNoteAndProceed : user is author');

    final List<NoteModel> _bzDeletionNotes = NoteModel.getNotesFromNotesByNoteType(
      notes: notes,
      noteType: NoteType.bzDeletion,
    );

    if (Mapper.checkCanLoopList(_bzDeletionNotes) == true){

      blog('_checkForBzDeletionNoteAndProceed : ${_bzDeletionNotes.length} bz deletion notes');

      for (final NoteModel note in _bzDeletionNotes){

        /// in the case of bzDeletion NoteType : attachment is bzID
        final String _bzID = note.attachment;

        final bool _bzIDisInMyBzzIDs = Stringer.checkStringsContainString(
            strings: _userModel.myBzzIDs,
            string: _bzID,
        );

        if (_bzIDisInMyBzzIDs == true){
          await AuthorProtocols.authorBzExitAfterBzDeletionProtocol(
            context: context,
            bzID: note.attachment,
          );
        }

      }

    }

  }

}
// -----------------------------------------------------------------------------

/// BZZ NOTES STREAMS

// -------------------------------
List<StreamSubscription> initializeMyBzzNotes(BuildContext context){

  final List<StreamSubscription> _subs = <StreamSubscription>[];

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  final bool _userIsAuthor = UserModel.checkUserIsAuthor(_userModel);
  blog('initializeMyBzzNotes : _userIsAuthor : $_userIsAuthor');

  if (_userIsAuthor == true){

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: false);

    for (final BzModel bzModel in _myBzz){

      final StreamSubscription _sub = initializeBzNotesStream(
        context: context,
        bzID: bzModel.id,
      );

      _subs.add(_sub);

    }

  }

  return _subs;
}
// -------------------------------
Stream<QuerySnapshot<Object>> _bzUnseenReceivedNotesStream({
  @required String bzID,
}){

  final Stream<QuerySnapshot<Object>> _stream  = Fire.streamCollection(
    queryModel: FireQueryModel(
        collRef: Fire.createSuperCollRef(aCollName: FireColl.notes),
        limit: 100,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        finders: <FireFinder>[

          FireFinder(
            field: 'receiverID',
            comparison: FireComparison.equalTo,
            value: bzID,
          ),

          FireFinder(
            field: 'seen',
            comparison: FireComparison.equalTo,
            value: false,
          ),

        ],
        onDataChanged: (List<Map<String, dynamic>> maps){
          blog('_bzUnseenReceivedNotesStream : onDataChanged : ${maps.length} maps');
        }
        ),
  );

  return _stream;
}
// -------------------------------
ValueNotifier<List<Map<String, dynamic>>> _getCipheredProBzUnseenReceivedNotes ({
  @required BuildContext context,
  @required String bzID,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

  final List<NoteModel> _bzOldNotes = _notesProvider.myBzzNotes[bzID];

  final List<Map<String, dynamic>> _oldNotesMaps = NoteModel.cipherNotesModels(
    notes: _bzOldNotes,
    toJSON: false,
  );

  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = ValueNotifier(_oldNotesMaps);

  return _oldMaps;
}
// -------------------------------
StreamSubscription initializeBzNotesStream({
  @required BuildContext context,
  @required String bzID,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);


  final Stream<QuerySnapshot<Object>> _stream  = _bzUnseenReceivedNotesStream(
    bzID: bzID,
  );

  // final _stream.listen((event) { });


  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = _getCipheredProBzUnseenReceivedNotes(
    context: context,
    bzID: bzID,
  );

  final StreamSubscription _streamSubscription = FireCollStreamer.onStreamDataChanged(
    stream: _stream,
    oldMaps: _oldMaps,
    onChange: (List<Map<String, dynamic>> allBzNotes) async {

      final List<NoteModel> _allBzNotes = NoteModel.decipherNotes(
        maps: allBzNotes,
        fromJSON: false,
      );

      _notesProvider.setBzNotesAndRebuildObelisk(
          context: context,
          bzID: bzID,
          notes: _allBzNotes,
          notify: true
      );

      final bool _noteDotIsOn = _checkNoteDotIsOn(
        context: context,
        notes: _allBzNotes,
      );

      if (_noteDotIsOn == true){
        _notesProvider.setIsFlashing(
          setTo: true,
          notify: true,
        );
      }

      await _bzCheckLocalFlyerUpdatesNotesAndProceed(
        context: context,
        newBzNotes: _allBzNotes,
      );

    },
  );

  return _streamSubscription;
}
// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> _bzCheckLocalFlyerUpdatesNotesAndProceed({
  @required BuildContext context,
  @required List<NoteModel> newBzNotes,
}) async {

  final List<NoteModel> _flyerUpdatesNotes = NoteModel.getNotesFromNotesByNoteType(
    notes: newBzNotes,
    noteType: NoteType.flyerUpdate,
  );

  if (Mapper.checkCanLoopList(_flyerUpdatesNotes) == true){

    for (int i =0; i < _flyerUpdatesNotes.length; i++){

      final NoteModel note = _flyerUpdatesNotes[i];

      final String _flyerID = Stringer.transformDynamicsToStrings(
        dynamics: note.attachment,
      )?.first;

      if (_flyerID != null){

        final FlyerModel flyerModel = await FlyerFireOps.readFlyerOps(
            context: context,
            flyerID: _flyerID
        );

        await FlyerProtocols.updateFlyerLocally(
          context: context,
          flyerModel: flyerModel,
          notifyFlyerPro: (i + 1) == _flyerUpdatesNotes.length,
          resetActiveBz: true,
        );

      }


    }

  }

}
// -----------------------------------------------------------------------------

/// NOTES CHECKERS

// -------------------------------
bool _checkNoteDotIsOn({
  @required BuildContext context,
  @required List<NoteModel> notes,
}){

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  final bool _thereAreMissingFields = UserModel.checkMissingFields(_userModel);


  bool _isOn = false;

  if (_thereAreMissingFields == true){
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
/*
// int _getNotesCount({
//   @required bool thereAreMissingFields,
//   @required List<NoteModel> notes,
// }){
//   int _count;
//
//   if (thereAreMissingFields == false){
//     if (Mapper.checkCanLoopList(notes) == true){
//       _count = NoteModel.getNumberOfUnseenNotes(notes);
//     }
//   }
//
//   return _count;
// }
 */
// -----------------------------------------------------------------------------
