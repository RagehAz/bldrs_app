import 'package:bldrs/providers/combined_models/co_author.dart';
import 'package:bldrs/providers/combined_models/co_bz.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:flutter/material.dart';
import 'mini_header_items/bz_pg_headline.dart';
import 'mini_header_items/mini_header_strip/mini_header_strip.dart';
import 'mini_header_items/header_shadow.dart';

class MiniHeader extends StatelessWidget {
  final CoBz coBz;
  final CoAuthor coAuthor;
  final bool followIsOn;
  final double flyerZoneWidth;
  final bool flyerShowsAuthor;
  final int bzGalleryCount;
  final bool bzPageIsOn;
  final Function tappingHeader;
  final Function tappingFollow;

  MiniHeader({
    @required this.coBz,
    @required this.coAuthor,
    @required this.followIsOn,
    @required this.flyerShowsAuthor,
    @required this.bzGalleryCount,
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.tappingHeader,
    @required this.tappingFollow,
});

  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === ===
    String _phoneNumber = feinPhoneFromContacts(coBz?.bzContacts);
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    String businessLocale = localeStringer(context, coBz.bz.bzCity, coBz.bz.bzCountry);
    // === === === === === === === === === === === === === === === === === === ===
    return
      Container(
        height: superHeaderHeight(bzPageIsOn, flyerZoneWidth),
        width: flyerZoneWidth,
        child: Stack(
          children: <Widget>[

            // --- HEADER SHADOW
            HeaderShadow(
              flyerZoneWidth: flyerZoneWidth,
              bzPageIsOn: bzPageIsOn,
            ),

            // --- HEADER COMPONENTS
            MiniHeaderStrip(
              flyerZoneWidth: flyerZoneWidth,
              bzPageIsOn: bzPageIsOn,
              flyerShowsAuthor: flyerShowsAuthor,
              authorID: coAuthor.author.authorID,
              bzLogo: coBz.bz.bzLogo,
              bzName: coBz.bz.bzName,
              bzCity: coBz.bz.bzCity,
              bzCountry: coBz.bz.bzCountry,
              phoneNumber: _phoneNumber,
              aPic: coAuthor.coUser.user.pic,
              aName: coAuthor.coUser.user.name,
              aTitle: coAuthor.coUser.user.title,
              followersCount: coBz.followsCount,
              followIsOn: followIsOn,
              bzGalleryCount: bzGalleryCount,
              bzConnects: coBz.bzConnects,
              tappingHeader: tappingHeader,
              tappingFollow: tappingFollow,
            ),

            // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
            BzPageHeadline(
              flyerZoneWidth: flyerZoneWidth,
              bzPageIsOn: bzPageIsOn,
              bzLocale: businessLocale,
              bzName: coBz.bz.bzName,
            ),

          ],
        ),
      )
    ;
  }
}
