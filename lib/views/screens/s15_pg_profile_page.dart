import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/views/widgets/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/status_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show PyramidsHorizon, Stratosphere;
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 's16_pg_edit_profile_page.dart';

class ProfilePage extends StatefulWidget {

  final List<Map<String, Object>> status;
  final UserStatus userStatus;
  final Function switchUserStatus;
  final UserStatus currentUserStatus;
  // final List<FlyerData> bzLogos;
  final Function openEnumLister;

  ProfilePage({
    @required this.status,
    @required this.userStatus,
    @required this.switchUserStatus,
    @required this.currentUserStatus,
    // @required this.bzLogos,
    @required this.openEnumLister,
});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editMode = false;

  void switchEditProfile(){
    setState(() {
      editMode = !editMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final List<UserModel> _userStream = Provider.of<List<UserModel>>(context) ?? [];
    // String _userID = _userStream.length < 1 ? '' : _userStream[0]?.userID;
    // print(_userID);
    // _userStream?.forEach((user) {
    //   print('name : ${user.name}');
    //   print('userID : ${user.userID}');
    //   print('savedFlyersIDs : ${user.savedFlyersIDs}');
    //   // print('email : ${user.contacts[0]['value']}');
    //   // print('joined at : ${user.joinedAt}');
    // });


    return SliverList(
      delegate:
      editMode == true ?

      SliverChildListDelegate([

        Stratosphere(),

        EditProfilePage(
          cancelEdits: switchEditProfile,
          confirmEdits: switchEditProfile,
        ),

      ])

          :

      SliverChildListDelegate([

        ProfileBubblesList(
        status: widget.status,
        userStatus: widget.userStatus,
        switchUserStatus: widget.switchUserStatus,
        currentUserStatus: widget.currentUserStatus,
        openEnumLister: widget.openEnumLister,
        switchEditProfile: switchEditProfile,
        ),

      ]),

    );
}
}

class ProfileBubblesList extends StatefulWidget {
  final List<Map<String, Object>> status;
  final UserStatus userStatus;
  final Function switchUserStatus;
  final UserStatus currentUserStatus;
  // final List<FlyerData> bzLogos;
  final Function openEnumLister;
  final Function switchEditProfile;

  ProfileBubblesList({
    @required this.status,
    @required this.userStatus,
    @required this.switchUserStatus,
    @required this.currentUserStatus,
    // @required this.bzLogos,
    @required this.openEnumLister,
    @required this.switchEditProfile,
  });



  @override
  _ProfileBubblesListState createState() => _ProfileBubblesListState();
}

class _ProfileBubblesListState extends State<ProfileBubblesList> {
  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserModel>(context);

    return StreamBuilder<UserModel>(
      stream: UserProvider(userID: _user.userID).userData,
      builder: (context, snapshot){
        if(snapshot.hasData == false){
          return LoadingFullScreenLayer();
        } else {
          UserModel userModel = snapshot.data;
          return
            Column(
              children: <Widget>[


                Stratosphere(),

                UserBubble(
                  user: userModel,
                  switchUserType: widget.switchUserStatus,
                  editProfileBtOnTap: widget.switchEditProfile,
                ),

                // --- STATUS LABEL : STATUS SURVEY WILL BE IN VERSION 2 ISA
                // StatusBubble(
                //   status: widget.status,
                //   switchUserStatus: widget.switchUserStatus,
                //   userStatus: widget.userStatus,
                //   currentUserStatus: widget.currentUserStatus,
                //   openEnumLister: widget.openEnumLister,
                // ),

                ContactsBubble(
                  contacts : userModel.contacts,
                ),

                FollowingBzzBubble(),

                PyramidsHorizon(heightFactor: 5,),



              ],
            );
        } // bent el kalb dih when u comment off the Loading indicator widget part with its condition
      },
    );
  }
}