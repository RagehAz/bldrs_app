import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/screens/g_user/g_x_user_editor_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/status_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/controllers/router/route_names.dart';

class UserProfileScreen extends StatefulWidget {
  final UserModel userModel;

  UserProfileScreen({
    @required this.userModel,
});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserStatus _currentUserStatus;
  List<TinyBz> _followedTinyBzz;
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
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _followedTinyBzz = [];
    _followedBzzIDs = [];
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

        await _prof.fetchAndSetFollows(context);

        _followedBzzIDs = _prof.getFollows;

        for (var id in _followedBzzIDs) {
          TinyBz _tinyBz = await BzOps.readTinyBzOps(
            context: context,
            bzID: id,
          );
          _followedTinyBzz.add(_tinyBz);
        }

        _triggerLoading();

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  final _status = <Map<String, dynamic>>[
    {
      'title': 'Property Status',
      'buttons': [
        {
          'state': 'Looking for a\nnew property',
          'userStatus': UserStatus.SearchingThinking
        },
        {
          'state': 'Constructing\nan existing\nproperty',
          'userStatus': UserStatus.Finishing
        },
        {
          'state': 'Want to\nSell / Rent\nmy property',
          'userStatus': UserStatus.Selling
        }
      ],
    },
    {
      'title': 'Construction Status',
      'buttons': [
        {
          'state': 'Planning Construction',
          'userStatus': UserStatus.PlanningTalking
        },
        {'state': 'Under Construction', 'userStatus': UserStatus.Building}
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
    bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Delete your account ?',
      boolDialog: true,
    );

    print(_dialogResult);

    /// if user wants cancel ops
    if (_dialogResult == false) {
      print('user : ${userModel.userID} cancelled ops');
    }

    /// and if user wants to continue ops
    else {
      _triggerLoading();

      /// start delete bz ops
      dynamic _result = await UserOps().superDeleteUserOps(
        context: context,
        userModel: userModel,
      );

      _triggerLoading();

      /// if user stopped ops
      if (_result == 'stop') {
        print('user cancelled ops');
      }

      /// is delete ops succeeds
      else if (_result == 'deleted') {
        print('successfully deleted user ops and got back to profile screen');

        /// go to user checker and remove all below screens
        await Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
      }

      /// if it fails
      else {
        print('something went wrong');

        /// go to user checker and remove all below screens
        await Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
      }
    }
  }
// -----------------------------------------------------------------------------
  Future<void> _deactivateUserOnTap(UserModel userModel) async {

    /// close bottom sheet
    Nav.goBack(context);

    /// pop confirmation dialog
    bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Deactivate your account ?',
      boolDialog: true,
    );

    print(_dialogResult);

    /// if user wants to stop
    if (_dialogResult == false) {
      print('user cancelled the operation');
    }

    /// if user wants to continue
    else {

      _triggerLoading();

      /// start deactivate user ops
      dynamic _result = await UserOps().deactivateUserOps(
        context: context,
        userModel: userModel,
      );

      /// if user stopped operations
      if (_result == 'stop') {

        print('user cancelled ops');

      }

      /// if user finished ops

      else if (_result == 'deactivated') {

        _triggerLoading();

        /// go to user checker and remove all below screens
        await Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);

      }

      /// if something went wrong
      else {

        print('something went wrong');

      }
    }
  }
// -----------------------------------------------------------------------------
    Future<void> _editUserOnTap(UserModel userModel) async {
      Nav.goToNewScreen(context, EditProfileScreen(user: userModel,));
    }
// -----------------------------------------------------------------------------
    void _slideUserOptions(BuildContext context, UserModel userModel) {
      double _buttonHeight = 50;

      BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: _buttonHeight,
        buttons: <Widget>[

          /// --- Delete user ops
          DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.Red255,
            verse: 'Delete account',
            verseScaleFactor: 1.2,
            verseWeight: VerseWeight.black,
            verseColor: Colorz.Red255,
            // verseWeight: VerseWeight.thin,
            onTap: () => _deleteUserOnTap(userModel),

          ),

          /// --- Deactivate user ops
          DreamBox(
              height: _buttonHeight,
              width: BottomDialog.dialogClearWidth(context),
              icon: Iconz.XSmall,
              iconSizeFactor: 0.5,
              iconColor: Colorz.Red255,
              verse: 'Deactivate account',
              verseScaleFactor: 1.2,
              verseColor: Colorz.Red255,
              verseWeight: VerseWeight.black,
              onTap: () => _deactivateUserOnTap(userModel)

          ),

          /// --- EDIT BZ
          DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.Gears,
            iconSizeFactor: 0.5,
            verse: 'Edit Account',
            verseScaleFactor: 1.2,
            verseColor: Colorz.White255,
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
        appBarType: AppBarType.Basic,
        sky: Sky.Black,
        // appBarBackButton: true,
        pyramids: Iconz.PyramidzYellow,
        layoutWidget: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              Stratosphere(),

              UserBubble(
                user: widget.userModel,
                switchUserType: (type) => _switchUserStatus(type),
                editProfileBtOnTap: () =>
                    _slideUserOptions(context, widget.userModel),
                loading: StreamChecker.valueIsLoading(widget.userModel),
              ),

              FollowingBzzBubble(
                tinyBzz: _followedTinyBzz,
              ),

              // --- STATUS LABEL : STATUS SURVEY WILL BE IN VERSION 2 ISA
              StatusBubble(
                status: _status,
                switchUserStatus: (type) => _switchUserStatus(type),
                userStatus: _currentUserStatus == null ? widget.userModel
                    ?.userStatus : _currentUserStatus,
                currentUserStatus: _currentUserStatus,
                // openEnumLister: widget.openEnumLister,
              ),

              ContactsBubble(
                contacts: widget.userModel.contacts,
              ),

              PyramidsHorizon(),


            ],
          ),
        ),
      );
    }
  }

