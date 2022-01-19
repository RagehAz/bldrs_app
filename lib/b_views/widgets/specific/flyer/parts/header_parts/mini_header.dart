import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:flutter/material.dart';

class MiniHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MiniHeader({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    // String _phoneNumber = tinyAuthor.contact;//getAContactValueFromContacts(bz?.bzContacts, ContactType.Phone);
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // String businessLocale = TextGenerator.zoneStringer(context: context, zone: tinyBz?.bzZone,);
// -----------------------------------------------------------------------------

    final bool _tinyMode = OldFlyerBox.isTinyMode(context, flyerBoxWidth);

    return GestureDetector(
      onTap: _tinyMode == true
          ? null
          : () async {
              await superFlyer.nav.onTinyFlyerTap();
            },
      child: SizedBox(
        height: OldFlyerBox.headerBoxHeight(
            bzPageIsOn: superFlyer.nav.bzPageIsOn,
            flyerBoxWidth: flyerBoxWidth),
        width: flyerBoxWidth,
        child: Stack(
          children: <Widget>[
            /// HEADER SHADOW
            HeaderShadow(
              flyerBoxWidth: flyerBoxWidth,
              bzPageIsOn: superFlyer.nav.bzPageIsOn,
            ),

            /// HEADER COMPONENTS
            MiniHeaderStrip(
              superFlyer: superFlyer,
              flyerBoxWidth: flyerBoxWidth,
            ),

            /// HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
            BzPageHeadline(
              flyerBoxWidth: flyerBoxWidth,
              bzPageIsOn: superFlyer.nav.bzPageIsOn,
              bzModel: superFlyer.bz,
              country: superFlyer.bzCountry,
              city: superFlyer.bzCity,
            ),
          ],
        ),
      ),
    );
  }
}
