import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:flutter/material.dart';

class MiniHeader extends StatelessWidget {
  // final TinyBz tinyBz;
  // final TinyUser tinyAuthor;
  // final bool followIsOn;
  // final double flyerZoneWidth;
  // final bool flyerShowsAuthor;
  // final int bzGalleryCount;
  // final bool bzPageIsOn;
  // final Function tappingHeader;
  // final Function onFollowTap;
  // final Function onCallTap;
  final SuperFlyer superFlyer;

  MiniHeader({
    @required this.superFlyer,

    // this.tinyBz,
    // this.tinyAuthor,
    // this.followIsOn,
    // this.flyerShowsAuthor,
    // this.bzGalleryCount,
    // this.flyerZoneWidth,
    // this.bzPageIsOn,
    // this.tappingHeader,
    // this.onFollowTap,
    // this.onCallTap,

});

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    // String _phoneNumber = tinyAuthor.contact;//getAContactValueFromContacts(bz?.bzContacts, ContactType.Phone);
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // String businessLocale = TextGenerator.zoneStringer(context: context, zone: tinyBz?.bzZone,);
// -----------------------------------------------------------------------------
    return
      GestureDetector(
        onTap: superFlyer.onHeaderTap,
        child: Container(
          height: Scale.superHeaderHeight(superFlyer.bzPageIsOn, superFlyer.flyerZoneWidth),
          width: superFlyer.flyerZoneWidth,
          child: Stack(
            children: <Widget>[

              // --- HEADER SHADOW
              HeaderShadow(
                flyerZoneWidth: superFlyer.flyerZoneWidth,
                bzPageIsOn: superFlyer.bzPageIsOn,
              ),

              // --- HEADER COMPONENTS
              MiniHeaderStrip(
                superFlyer: superFlyer,
              //   // tinyBz: tinyBz,
              //   // tinyAuthor: tinyAuthor,
              //   // flyerZoneWidth: flyerZoneWidth,
              //   // bzPageIsOn: bzPageIsOn,
              //   // flyerShowsAuthor: flyerShowsAuthor,
              //   // followIsOn: followIsOn,
              //   // tappingHeader: tappingHeader,
              //   // onFollowTap: onFollowTap,
              //   // onCallTap: onCallTap,
              ),

              // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
              BzPageHeadline(
                flyerZoneWidth: superFlyer.flyerZoneWidth,
                bzPageIsOn: superFlyer.bzPageIsOn,
                tinyBz: SuperFlyer.getTinyBzFromSuperFlyer(superFlyer),
              ),

            ],
          ),
        ),
      )
    ;
  }
}
