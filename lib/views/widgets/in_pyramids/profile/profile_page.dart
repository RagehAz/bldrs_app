import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/user_bubble.dart';
import 'package:bldrs/views/widgets/space/pyramids_horizon.dart';
import 'package:flutter/material.dart';
import 'profile_items/bldrs_following.dart';
import 'profile_items/user_contacts.dart';
import 'profile_items/user_label.dart';
import 'profile_items/status_label.dart';

class ProfilePage extends StatelessWidget {

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
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // double pageMargin = Ratioz.ddAppBarMargin * 2;

    // double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    return SliverList(
      delegate: SliverChildListDelegate([

        UserLabel(
          userType: userType,
          switchUserType: switchUserType,
          userPicture: Iconz.DumAuthorPic,
          userName: 'Rageh Mohamed',
          userJobTitle: 'Fucking CEO',
          userCompanyName: 'Bldrs.net',
          userCity: 'Cairo',
          userCountry: 'Egypt',
        ),

        // --- STATUS LABEL : STATUS SURVEY WILL BE IN VERSION 2 ISA
        StatusLabel(
          status: status,
          switchUserType: switchUserType,
          userType: userType,
          currentUserType: currentUserType,
          openEnumLister: openEnumLister,
        ),

        UserContacts(),

        BldrsFollowing(
          // bzLogos: bzLogos,
        ),

        PyramidsHorizon(),

      ]),
    );
  }
}
