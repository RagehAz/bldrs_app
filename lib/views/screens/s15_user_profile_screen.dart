import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/controllers/streamerz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/status_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  final _status = [
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

      layoutWidget: StreamBuilder<UserModel>(
        stream: UserProvider(userID: _user.userID).userData,
        builder: (context, snapshot){
          if(snapshot.hasData == false){
            return LoadingFullScreenLayer();
          } else {
            UserModel userModel = snapshot.data;
            return
              ListView(

                children: <Widget>[

                  SizedBox(
                    height: Ratioz.ddAppBarMargin,
                  ),

                  UserBubble(
                    user: userModel,
                    switchUserType: (type) =>_switchUserStatus(type),
                    editProfileBtOnTap: (){print('go to edit screen');},
                    loading: connectionIsWaiting(snapshot),
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
          } // bent el kalb dih when u comment off the Loading indicator widget part with its condition
        },
      ),
    );
  }
}

