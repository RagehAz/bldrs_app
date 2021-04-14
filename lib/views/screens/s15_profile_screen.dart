import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/crud/bz_ops.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/status_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 's13_news_screen.dart';
import 's16_user_editor_screen.dart';

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
  // ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading();
      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);

      _prof.fetchAndSetFollows(context)
          .then((_) async {

        _followedBzzIDs = _prof.getFollows;

        for (var id in _followedBzzIDs){

          TinyBz _tinyBz = await BzCRUD().readTinyBzOps(
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
// ---------------------------------------------------------------------------
  void rebuildGrid(){setState(() {});}
// ---------------------------------------------------------------------------
  final _status = <Map<String, dynamic>>[
    {
      'title': 'Property Status',
      'buttons': [
        {'state': 'Looking for a\nnew property', 'userStatus' : UserStatus.SearchingThinking},
        {'state': 'Constructing\nan existing\nproperty', 'userStatus' : UserStatus.Finishing},
        {'state': 'Want to\nSell / Rent\nmy property', 'userStatus' : UserStatus.Selling}
      ],
    },
    {
      'title': 'Construction Status',
      'buttons': [
        {'state': 'Planning Construction', 'userStatus' : UserStatus.PlanningTalking},
        {'state': 'Under Construction', 'userStatus' : UserStatus.Building}
      ],
    },
  ];
// ----------------------------------------------------------------------------
  void _switchUserStatus (UserStatus type){
    setState(() {
      _currentUserStatus = type;
    });
  }
// ----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final _user = Provider.of<UserModel>(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      sky: Sky.Black,
      appBarBackButton: true,
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: userStreamBuilder(
        context: context,
        listen: true,
        builder: (context, UserModel userModel){
          return
            ListView(

              children: <Widget>[

                Stratosphere(),

                UserBubble(
                  user: userModel,
                  switchUserType: (type) =>_switchUserStatus(type),
                  editProfileBtOnTap: () => Nav.goToNewScreen(context, EditProfileScreen(user: userModel,)),
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
                      boxFunction: ()=> Nav.goToNewScreen(context, NewsScreen()),
                    ),
                  ],
                ),

                FollowingBzzBubble(
                  tinyBzz: _followedTinyBzz,
                ),

                // --- STATUS LABEL : STATUS SURVEY WILL BE IN VERSION 2 ISA
                StatusBubble(
                  status:_status,
                  switchUserStatus: (type) =>_switchUserStatus(type),
                  userStatus: _currentUserStatus == null ? userModel?.userStatus : _currentUserStatus,
                  currentUserStatus: _currentUserStatus,
                  // openEnumLister: widget.openEnumLister,
                ),

                ContactsBubble(
                  contacts : userModel.contacts,
                ),

                PyramidsHorizon(heightFactor: 5,),



              ],
            );
        }
      ),
    );
  }
}

