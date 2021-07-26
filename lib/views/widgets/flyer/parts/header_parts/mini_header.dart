import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:flutter/material.dart';

class MiniHeader extends StatelessWidget {
  final SuperFlyer superFlyer;

  MiniHeader({
    @required this.superFlyer,

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
        onTap: superFlyer.microMode == true ? null : () async { await superFlyer.onTinyFlyerTap();},
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
