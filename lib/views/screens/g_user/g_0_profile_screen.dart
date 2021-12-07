import 'dart:async';

import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/stream_checkers.dart' as StreamChecker;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/db/fire/ops/bz_ops.dart' as FireBzOps;
import 'package:bldrs/db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/views/screens/g_user/g_x_user_editor_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/status_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UserProfileScreen({
    @required this.userModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
/// --------------------------------------------------------------------------
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserStatus _currentUserStatus;
  List<BzModel> _followedBzz;
  List<String> _followedBzzIDs;
  // FlyersProvider _pro;
  bool _isInit = true;

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    blog('LOADING--------------------------------------') : blog('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _followedBzz = <BzModel>[];
    _followedBzzIDs = <String>[];
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
        await _bzzProvider.fetchFollowedBzz(context);

        _followedBzzIDs = _usersProvider.myUserModel.followedBzzIDs;

        if (Mapper.canLoopList(_followedBzzIDs)){
          for (final String id in _followedBzzIDs) {
            final BzModel _bzModel = await FireBzOps.readBz(
              context: context,
              bzID: id,
            );
            _followedBzz.add(_bzModel);
          }
        }

        unawaited(_triggerLoading());

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  static const List<Map<String, dynamic>> _status = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Property Status',
      'buttons': <Map<String, dynamic>>[
        <String, dynamic>{
          'state': 'Looking for a\nnew property',
          'userStatus': UserStatus.searching
        },
        <String, dynamic>{
          'state': 'Constructing\nan existing\nproperty',
          'userStatus': UserStatus.finishing
        },
        <String, dynamic>{
          'state': 'Want to\nSell / Rent\nmy property',
          'userStatus': UserStatus.selling
        }
      ],
    },
    <String, dynamic>{
      'title': 'Construction Status',
      'buttons': <Map<String, dynamic>>[
        <String, dynamic>{
          'state': 'Planning Construction',
          'userStatus': UserStatus.planning
        },
        <String, dynamic>{
          'state': 'Under Construction',
          'userStatus': UserStatus.building
      }
      ],
    },
  ];
// -----------------------------------------------------------------------------
  void _switchUserStatus(UserStatus type) {
    setState(() {
      _currentUserStatus = type;
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _deleteUserOnTap(UserModel userModel) async {

    /// close bottom sheet
    Nav.goBack(context);

    /// pop confirmation dialog
    final bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Delete your account ?',
      boolDialog: true,
    );

    blog(_dialogResult);

    /// if user wants cancel ops
    if (_dialogResult == false) {
      blog('user : ${userModel.id} cancelled ops');
    }

    /// and if user wants to continue ops
    else {

      unawaited(_triggerLoading());

      /// start delete bz ops
      final dynamic _result = await UserFireOps.deleteUser(
        context: context,
        userModel: userModel,
      );

      unawaited(_triggerLoading());

      /// if user stopped ops
      if (_result == 'stop') {
        blog('user cancelled ops');
      }

      /// is delete ops succeeds
      else if (_result == 'deleted') {
        blog('successfully deleted user ops and got back to profile screen');

        /// go to user checker and remove all below screens
        await Nav.pushNamedAndRemoveAllBelow(context, Routez.userChecker);
      }

      /// if it fails
      else {
        blog('something went wrong');

        /// go to user checker and remove all below screens
        await Nav.pushNamedAndRemoveAllBelow(context, Routez.userChecker);
      }
    }
  }
// -----------------------------------------------------------------------------
  Future<void> _deactivateUserOnTap(UserModel userModel) async {

    /// close bottom sheet
    Nav.goBack(context);

    /// pop confirmation dialog
    final bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Deactivate your account ?',
      boolDialog: true,
    );

    blog(_dialogResult);

    /// if user wants to stop
    if (_dialogResult == false) {
      blog('user cancelled the operation');
    }

    /// if user wants to continue
    else {

      unawaited (_triggerLoading());

      /// start deactivate user ops
      final dynamic _result = await UserFireOps.deactivateUser(
        context: context,
        userModel: userModel,
      );

      /// if user stopped operations
      if (_result == 'stop') {

        blog('user cancelled ops');

      }

      /// if user finished ops

      else if (_result == 'deactivated') {

        unawaited(_triggerLoading());

        /// go to user checker and remove all below screens
        await Nav.pushNamedAndRemoveAllBelow(context, Routez.userChecker);

      }

      /// if something went wrong
      else {

        blog('something went wrong');

      }
    }
  }
// -----------------------------------------------------------------------------
    Future<void> _editUserOnTap(UserModel userModel) async {
      await Nav.goToNewScreen(context, EditProfileScreen(user: userModel,));
    }
// -----------------------------------------------------------------------------
    Future<void> _slideUserOptions(BuildContext context, UserModel userModel) async {
      const double _buttonHeight = 50;

      await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: _buttonHeight,
        buttons: <Widget>[

          /// --- Delete user ops
          DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.xSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.red255,
            verse: 'Delete account',
            verseScaleFactor: 1.2,
            verseWeight: VerseWeight.black,
            verseColor: Colorz.red255,
            // verseWeight: VerseWeight.thin,
            onTap: () => _deleteUserOnTap(userModel),

          ),

          /// --- Deactivate user ops
          DreamBox(
              height: _buttonHeight,
              width: BottomDialog.dialogClearWidth(context),
              icon: Iconz.xSmall,
              iconSizeFactor: 0.5,
              iconColor: Colorz.red255,
              verse: 'Deactivate account',
              verseScaleFactor: 1.2,
              verseColor: Colorz.red255,
              verseWeight: VerseWeight.black,
              onTap: () => _deactivateUserOnTap(userModel)

          ),

          /// --- EDIT BZ
          DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.gears,
            iconSizeFactor: 0.5,
            verse: 'Edit Account',
            verseScaleFactor: 1.2,
            onTap: () => _editUserOnTap(userModel),
          ),

        ],

      );
    }
// -----------------------------------------------------------------------------
    @override
    Widget build(BuildContext context) {
      // final _user = Provider.of<UserModel>(context);

      return MainLayout(
        appBarType: AppBarType.basic,
        skyType: SkyType.black,
        // appBarBackButton: true,
        pyramids: Iconz.pyramidzYellow,
        layoutWidget: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              const Stratosphere(),

              UserBubble(
                user: widget.userModel,
                switchUserType: (UserStatus type) => _switchUserStatus(type),
                editProfileBtOnTap: () =>
                    _slideUserOptions(context, widget.userModel),
                loading: StreamChecker.valueIsLoading(widget.userModel),
              ),

              FollowingBzzBubble(
                bzzModels: _followedBzz,
              ),

              /// --- STATUS LABEL : STATUS SURVEY WILL BE IN VERSION 2 ISA
              StatusBubble(
                status: _status,
                switchUserStatus: (UserStatus type) => _switchUserStatus(type),
                userStatus: _currentUserStatus ?? widget.userModel?.status,
                currentUserStatus: _currentUserStatus,
                // openEnumLister: widget.openEnumLister,
              ),

              ContactsBubble(
                contacts: widget.userModel?.contacts,
              ),

              const PyramidsHorizon(),

            ],
          ),
        ),
      );
    }
  }
