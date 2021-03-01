import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/controllers/streamerz.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
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
import 's16_edit_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {


  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserStatus _currentUserStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserModel>(context);

    return MainLayout(
      tappingRageh: () => goToNewScreen(context, NewsScreen()),

      layoutWidget: userStreamBuilder(
        context: context,
        listen: true,
        builder: (context, UserModel userModel){
          return
            ListView(

              children: <Widget>[

                SizedBox(
                  height: Ratioz.ddAppBarMargin,
                ),

                UserBubble(
                  user: userModel,
                  switchUserType: (type) =>_switchUserStatus(type),
                  editProfileBtOnTap: () => goToNewScreen(context, EditProfileScreen(user: userModel,)),
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
                      boxFunction: ()=> goToNewScreen(context, NewsScreen()),
                    ),
                  ],
                ),


                FollowingBzzBubble(),


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

