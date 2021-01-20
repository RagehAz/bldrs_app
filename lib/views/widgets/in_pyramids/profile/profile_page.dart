import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/status_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/buttons/user_balloon.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show PyramidsHorizon;
import 'package:flutter/material.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {

  final List<Map<String, Object>> status;
  final UserType userType;
  final Function switchUserType;
  final UserType currentUserType;
  // final List<FlyerData> bzLogos;
  final Function openEnumLister;

  ProfilePage({
    @required this.status,
    @required this.userType,
    @required this.switchUserType,
    @required this.currentUserType,
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
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // double pageMargin = Ratioz.ddAppBarMargin * 2;

    // double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

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

        UserBubble(
          userType: widget.userType,
          switchUserType: widget.switchUserType,
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
          switchUserType: widget.switchUserType,
          userType: widget.userType,
          currentUserType: widget.currentUserType,
          openEnumLister: widget.openEnumLister,
        ),

        ContactsBubble(),

        FollowingBzzBubble(
          // bzLogos: bzLogos,
        ),

        PyramidsHorizon(),

      ]),
    );
  }
}
