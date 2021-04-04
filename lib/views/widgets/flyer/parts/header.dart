import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:flutter/material.dart';
import 'header_parts/common_parts/header_shadow.dart';
import 'header_parts/max_header.dart';
import 'header_parts/max_header_parts/bz_pg_headline.dart';
import 'header_parts/mini_header_parts/mini_header_strip.dart';

class Header extends StatelessWidget {
  final TinyBz tinyBz;
  final TinyUser tinyAuthor;
  final bool flyerShowsAuthor;
  final bool followIsOn;
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final Function tappingHeader;
  final Function tappingFollow;
  final Function tappingUnfollow;

  Header({
    this.tinyBz,
    this.tinyAuthor,
    this.flyerShowsAuthor = true,
    this.followIsOn = false,
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.tappingHeader,
    @required this.tappingFollow,
    @required this.tappingUnfollow,
  });

  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === ===
    // String _phoneNumber = getFirstPhoneFromContacts(bz?.bzContacts);
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // String _bzCounty = bz != null ? bz?.bzCountry : '';
    // String _bzProvince = bz != null ? bz?.bzProvince : '';
    // String _bzArea = bz != null ? bz?.bzArea : '' ;
    // String _businessLocale = localeStringer(context: context, countryISO3: _bzCounty, provinceID: _bzProvince, areaID: _bzArea);
    // === === === === === === === === === === === === === === === === === === ===

    return GestureDetector(
        onTap: tappingHeader,
        child: BackdropFilter(
          filter: superBlur(bzPageIsOn),
          child: ListView(
            physics: superScroller(bzPageIsOn),
            shrinkWrap: true,
            addAutomaticKeepAlives: true,
            children: <Widget>[

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
                      tinyBz: tinyBz,
                      tinyAuthor: tinyAuthor,
                      flyerShowsAuthor: flyerShowsAuthor,
                      followIsOn: false, // TASK : fix following issue
                      tappingHeader: tappingHeader,
                      tappingFollow: tappingFollow,
                    ),

                    // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
                    BzPageHeadline(
                      flyerZoneWidth: flyerZoneWidth,
                      bzPageIsOn: bzPageIsOn,
                      tinyBz: tinyBz,
                    ),

                  ],
                ),
              ),

              // 3ayzeen zorar follow gowwa el bzPage
              bzPageIsOn == false ? Container() :
              MaxHeader(
                flyerZoneWidth: flyerZoneWidth,
                bzPageIsOn: bzPageIsOn,
                tinyBz: tinyBz,
              ),

            ],
          ),
        )
    );

  }
}

