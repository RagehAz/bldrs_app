// import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/header_shadow.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_strip.dart';
// import 'package:bldrs/xxx_lab/xxx_old_stuff/old_flyer_stuff/old_flyer_zone_box.dart';
// import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
// import 'package:flutter/material.dart';
//
// class MiniHeader extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const MiniHeader({
//     @required this.superFlyer,
//     @required this.flyerBoxWidth,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final SuperFlyer superFlyer;
//   final double flyerBoxWidth;
//
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
//     // String _phoneNumber = tinyAuthor.contact;//getAContactValueFromContacts(bz?.bzContacts, ContactType.Phone);
//     // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
//     // String businessLocale = TextGenerator.zoneStringer(context: context, zone: tinyBz?.bzZone,);
// // -----------------------------------------------------------------------------
//
//     final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
//
//     return GestureDetector(
//       onTap: _tinyMode == true
//           ? null
//           : () async {
//               await superFlyer.nav.onTinyFlyerTap();
//             },
//       child: SizedBox(
//         height: FlyerBox.headerBoxHeight(
//             // bzPageIsOn: superFlyer.nav.bzPageIsOn,
//             flyerBoxWidth: flyerBoxWidth,
//         ),
//         width: flyerBoxWidth,
//         child: Stack(
//           children: <Widget>[
//             /// HEADER SHADOW
//             HeaderShadow(
//               flyerBoxWidth: flyerBoxWidth,
//               bzPageIsOn: superFlyer.nav.bzPageIsOn,
//             ),
//
//             /// HEADER COMPONENTS
//             MiniHeaderStrip(
//               flyerShowsAuthor: superFlyer.flyerShowsAuthor,
//               authorID: superFlyer.authorID,
//               onFollowTap: superFlyer.rec.onFollowTap,
//               onCallTap: superFlyer.rec.onCallTap,
//               followIsOn: superFlyer.rec.followIsOn,
//               bzCountry: superFlyer.bzCountry,
//               bzCity: superFlyer.bzCity,
//               bzModel: superFlyer.bz,
//               bzPageIsOn: superFlyer.nav.bzPageIsOn,
//               flyerBoxWidth: flyerBoxWidth,
//             ),
//
//             /// HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
//             OldBzPageHeadline(
//               flyerBoxWidth: flyerBoxWidth,
//               bzPageIsOn: superFlyer.nav.bzPageIsOn,
//               bzModel: superFlyer.bz,
//               country: superFlyer.bzCountry,
//               city: superFlyer.bzCity,
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
