import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/g1_news_screen.dart';
import 'package:bldrs/views/screens/gx_user_editor_screen.dart';
import 'package:bldrs/views/widgets/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/status_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/controllers/router/route_names.dart';


class UserProfileScreen extends StatefulWidget {


  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserStatus _currentUserStatus;
  List<TinyBz> _followedTinyBzz;
  List<String> _followedBzzIDs;
  FlyersProvider _pro;
  bool _isInit = true;

// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _followedTinyBzz = new List();
    _followedBzzIDs = new List();
    super.initState();
  }

// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading();
      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);

      _prof.fetchAndSetFollows(context)
          .then((_) async {
        _followedBzzIDs = _prof.getFollows;

        for (var id in _followedBzzIDs) {
          TinyBz _tinyBz = await BzOps.readTinyBzOps(
            context: context,
            bzID: id,
          );

          _followedTinyBzz.add(_tinyBz);
        }

        rebuildGrid();

        _triggerLoading();
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

// -----------------------------------------------------------------------------
  void rebuildGrid() {
    setState(() {});
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
    bool _dialogResult = await superDialog(
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
        Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
      }

      /// if it fails
      else {
        print('something went wrong');

        /// go to user checker and remove all below screens
        Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
      }
    }
  }

// -----------------------------------------------------------------------------
  Future<void> _deactivateUserOnTap(UserModel userModel) async {

    /// close bottom sheet
    Nav.goBack(context);

    /// pop confirmation dialog
    bool _dialogResult = await superDialog(
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
        Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);

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

      BottomDialog.slideButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: _buttonHeight,
        buttons: <Widget>[

          // --- Delete user ops
          DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.Black230,
            verse: 'delete user Account',
            verseScaleFactor: 1.2,
            verseWeight: VerseWeight.black,
            verseColor: Colorz.Black230,
            // verseWeight: VerseWeight.thin,
            onTap: () => _deleteUserOnTap(userModel),

          ),

          // --- Deactivate user ops
          DreamBox(
              height: _buttonHeight,
              width: BottomDialog.dialogClearWidth(context),
              icon: Iconz.XSmall,
              iconSizeFactor: 0.5,
              iconColor: Colorz.Red255,
              verse: 'Deactivate your Account',
              verseScaleFactor: 1.2,
              verseColor: Colorz.Red255,
              // verseWeight: VerseWeight.thin,
              onTap: () => _deactivateUserOnTap(userModel)

          ),

          // --- EDIT BZ
          DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.Gears,
            iconSizeFactor: 0.5,
            verse: 'Edit Business Account info',
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
        layoutWidget: userStreamBuilder(
            context: context,
            listen: true,
            builder: (context, UserModel userModel) {
              return
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[

                    Stratosphere(),

                    UserBubble(
                      user: userModel,
                      switchUserType: (type) => _switchUserStatus(type),
                      editProfileBtOnTap: () =>
                          _slideUserOptions(context, userModel),
                      loading: userModelIsLoading(userModel),
                    ),

                    InPyramidsBubble(
                      centered: true,
                      columnChildren: <Widget>[
                        DreamBox(
                          height: 40,
                          verse: Wordz.news(context),
                          icon: Iconz.News,
                          iconSizeFactor: 0.6,
                          verseWeight: VerseWeight.bold,
                          onTap: () =>
                              Nav.goToNewScreen(context, NewsScreen()),
                        ),
                      ],
                    ),

                    FollowingBzzBubble(
                      tinyBzz: _followedTinyBzz,
                    ),

                    // --- STATUS LABEL : STATUS SURVEY WILL BE IN VERSION 2 ISA
                    StatusBubble(
                      status: _status,
                      switchUserStatus: (type) => _switchUserStatus(type),
                      userStatus: _currentUserStatus == null ? userModel
                          ?.userStatus : _currentUserStatus,
                      currentUserStatus: _currentUserStatus,
                      // openEnumLister: widget.openEnumLister,
                    ),

                    ContactsBubble(
                      contacts: userModel.contacts,
                    ),

                    PyramidsHorizon(heightFactor: 5,),


                  ],
                );
            }
        ),
      );
    }
  }

