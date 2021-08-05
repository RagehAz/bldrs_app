import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:flutter/material.dart';

class MiniHeader extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;

  MiniHeader({
    @required this.superFlyer,
    @required this.flyerZoneWidth,

});

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    // String _phoneNumber = tinyAuthor.contact;//getAContactValueFromContacts(bz?.bzContacts, ContactType.Phone);
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // String businessLocale = TextGenerator.zoneStringer(context: context, zone: tinyBz?.bzZone,);
// -----------------------------------------------------------------------------

  bool _tinyMode = Scale.superFlyerTinyMode(context, flyerZoneWidth);

    return
      GestureDetector(
        onTap: _tinyMode == true ? null : () async { await superFlyer.onTinyFlyerTap();},
        child: Container(
          height: Scale.superHeaderHeight(superFlyer.bzPageIsOn, flyerZoneWidth),
          width: flyerZoneWidth,
          child: Stack(
            children: <Widget>[

              // --- HEADER SHADOW
              HeaderShadow(
                flyerZoneWidth: flyerZoneWidth,
                bzPageIsOn: superFlyer.bzPageIsOn,
              ),

              // --- HEADER COMPONENTS
              MiniHeaderStrip(
                superFlyer: superFlyer,
                flyerZoneWidth: flyerZoneWidth,
              ),

              // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
              BzPageHeadline(
                flyerZoneWidth: flyerZoneWidth,
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
