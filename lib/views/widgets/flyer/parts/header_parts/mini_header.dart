import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:flutter/material.dart';
import 'common_parts/header_shadow.dart';
import 'max_header_parts/bz_pg_headline.dart';
import 'mini_header_parts/mini_header_strip.dart';

class MiniHeader extends StatelessWidget {
  final BzModel bz;
  final AuthorModel author;
  final bool followIsOn;
  final double flyerZoneWidth;
  final bool flyerShowsAuthor;
  final int bzGalleryCount;
  final bool bzPageIsOn;
  final Function tappingHeader;
  final Function tappingFollow;

  MiniHeader({
    @required this.bz,
    @required this.author,
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
    String _phoneNumber = getAContactValueFromContacts(bz?.bzContacts, ContactType.Phone);
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    String businessLocale = localeStringer(context: context,
      countryISO3: bz?.bzCountry,
      provinceID: bz?.bzProvince,
      areaID: bz?.bzArea,
    );
    // === === === === === === === === === === === === === === === === === === ===
    return
      GestureDetector(
        onTap: tappingHeader,
        child: Container(
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
                bz: bz,
                flyerShowsAuthor: flyerShowsAuthor,
                authorID: author.userID,
                phoneNumber: _phoneNumber,
                aPic: author.authorPic,
                aName: author.authorName,
                aTitle: author.authorTitle,
                followersCount: bz.bzTotalFollowers,
                followIsOn: followIsOn,
                bzGalleryCount: bzGalleryCount,
                tappingHeader: tappingHeader,
                tappingFollow: tappingFollow,
              ),

              // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
              BzPageHeadline(
                flyerZoneWidth: flyerZoneWidth,
                bzPageIsOn: bzPageIsOn,
                bzLocale: businessLocale,
                bzName: bz.bzName,
              ),

            ],
          ),
        ),
      )
    ;
  }
}
