// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/z_components/bz_profile/appbar/bz_credits_counter.dart';
// import 'package:bldrs/c_controllers/f_bz_controllers/f_my_bz_screen_controller.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
// import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class BzAppBar extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const BzAppBar({
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
//         context: context,
//         listen: true,
//     );
//
//     final double _appBarBzButtonWidth = Scale.superScreenWidth(context) -
//         (Ratioz.appBarMargin * 2) -
//         (Ratioz.appBarButtonSize * 2) -
//         (Ratioz.appBarPadding * 4) -
//         (Ratioz.appBarButtonSize * 1.4) -
//         Ratioz.appBarPadding;
//
//     // final String _zoneString = ZoneModel.generateZoneString(
//     //   context: context,
//     //   zoneModel: _bzModel?.zone,
//     // );
//
//
//     return Row(
//       children: <Widget>[
//
//         /// --- BZ LOGO
//         DreamBox(
//           height: Ratioz.appBarButtonSize,
//           width: _appBarBzButtonWidth,
//           icon: _bzModel.logo,
//           verse: _bzModel.name,
//           verseCentered: false,
//           bubble: false,
//           verseScaleFactor: 0.65,
//           color: Colorz.white20,
//           // secondLine: '$_bzTypesString :  $_zoneString',
//           // secondLineColor: Colorz.white200,
//           // secondLineScaleFactor: 0.7,
//         ),
//
//         const SizedBox(
//           width: Ratioz.appBarPadding,
//           height: Ratioz.appBarPadding,
//         ),
//
//         BzCreditsCounter(
//           width: Ratioz.appBarButtonSize * 1.4,
//           slidesCredit: Numeric.formatNumToCounterCaliber(context, 1234),
//           ankhsCredit: Numeric.formatNumToCounterCaliber(context, 123),
//         ),
//
//         /// -- SLIDE BZ ACCOUNT OPTIONS
//         DreamBox(
//           height: Ratioz.appBarButtonSize,
//           width: Ratioz.appBarButtonSize,
//           icon: Iconz.more,
//           iconSizeFactor: 0.6,
//           margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
//           bubble: false,
//           onTap: () => onBzAccountOptionsTap(
//               context: context,
//               bzModel: _bzModel,
//           ),
//         ),
//
//       ],
//     );
//   }
// }
