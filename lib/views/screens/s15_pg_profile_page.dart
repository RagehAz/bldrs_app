import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/status_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show PyramidsHorizon;
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
    final List<UserModel> userStream = Provider.of<List<UserModel>>(context) ?? [];
    String userID = userStream.length < 1 ? '' : userStream[0]?.userID;

    userStream?.forEach((user) {
      print('name : ${user.name}');
      print('userID : ${user.userID}');
      print('savedFlyersIDs : ${user.savedFlyersIDs}');
      // print('email : ${user.contacts[0]['value']}');
      // print('joined at : ${user.joinedAt}');
    });

    return SliverList(
      delegate:
      editMode == true ?

      SliverChildListDelegate([
        EditProfilePage(
          cancelEdits: switchEditProfile,
        ),
      ])

      :

      SliverChildListDelegate([

        // SuperVerse(
        //   verse: userID == null ? '' : userID,
        //   margin: 2,
        //   color: Colorz.BloodTest,
        // ),

        UserBubble(
          userStatus: widget.userStatus,
          switchUserType: widget.switchUserStatus,
          userPicture: Iconz.DumAuthorPic,
          userName: 'Rageh Mohamed',
          userJobTitle: 'Fucking CEO',
          userCompanyName: 'Bldrs.net',
          userCity: 'Cairo',
          userCountry: 'Egypt',
          editProfileBtOnTap: switchEditProfile,
        ),

        // --- STATUS LABEL : STATUS SURVEY WILL BE IN VERSION 2 ISA
        StatusBubble(
          status: widget.status,
          switchUserStatus: widget.switchUserStatus,
          userStatus: widget.userStatus,
          currentUserStatus: widget.currentUserStatus,
          openEnumLister: widget.openEnumLister,
        ),

        ContactsBubble(),

        FollowingBzzBubble(),

        PyramidsHorizon(),

      ]),
    );
  }
}
