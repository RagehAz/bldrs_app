import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:flutter/material.dart';
import 'common_parts/header_shadow.dart';
import 'max_header_parts/bz_pg_headline.dart';
import 'mini_header_parts/mini_header_strip.dart';

class MiniHeader extends StatelessWidget {
  final TinyBz tinyBz;
  final TinyUser tinyAuthor;
  final bool followIsOn;
  final double flyerZoneWidth;
  final bool flyerShowsAuthor;
  final int bzGalleryCount;
  final bool bzPageIsOn;
  final Function tappingHeader;
  final Function onFollowTap;
  final Function onCallTap;

  MiniHeader({
    @required this.tinyBz,
    @required this.tinyAuthor,
    @required this.followIsOn,
    @required this.flyerShowsAuthor,
    @required this.bzGalleryCount,
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.tappingHeader,
    @required this.onFollowTap,
    @required this.onCallTap,
});

  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === ===
    String _phoneNumber = tinyAuthor.contact;//getAContactValueFromContacts(bz?.bzContacts, ContactType.Phone);
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    String businessLocale = TextGenerator.zoneStringer(context: context, zone: tinyBz?.bzZone,);
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
                tinyBz: tinyBz,
                tinyAuthor: tinyAuthor,
                flyerZoneWidth: flyerZoneWidth,
                bzPageIsOn: bzPageIsOn,
                flyerShowsAuthor: flyerShowsAuthor,
                followIsOn: followIsOn,
                tappingHeader: tappingHeader,
                onFollowTap: onFollowTap,
                onCallTap: onCallTap,
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
      )
    ;
  }
}
