// import 'package:bldrs/a_models/chain/chain.dart';
// import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
// import 'package:bldrs/b_views/x_screens/j_chains/controllers/a_chains_screen_controllers.dart';
// import 'package:bldrs/b_views/x_screens/j_chains/no_need_no_more_isa/delete_when_done/chain_expander_by_flyer_type.dart';
// import 'package:bldrs/b_views/x_screens/j_chains/no_need_no_more_isa/delete_when_done/a_chain_bubble.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
// import 'package:bldrs/d_providers/chains_provider.dart';
// import 'package:bldrs/d_providers/phrase_provider.dart';
// import 'package:bldrs/f_helpers/drafters/scalers.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ChainViewBrowsing extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const ChainViewBrowsing({
//     @required this.bubbleWidth,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final double bubbleWidth;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: true);
//
//     final Chain _propertyChain = _chainsProvider.getChainKByFlyerType(
//       flyerType: FlyerType.property,
//       onlyUseCityChains: true,
//     );
//     final Chain _designChain = _chainsProvider.getChainKByFlyerType(
//       flyerType: FlyerType.design,
//       onlyUseCityChains: true,
//     );
//     final Chain _craftChain = _chainsProvider.getChainKByFlyerType(
//       flyerType: FlyerType.craft,
//       onlyUseCityChains: true,
//     );
//     final Chain _productChain = _chainsProvider.getChainKByFlyerType(
//       flyerType: FlyerType.product,
//       onlyUseCityChains: true,
//     );
//     final Chain _equipmentChain = _chainsProvider.getChainKByFlyerType(
//       flyerType: FlyerType.equipment,
//       onlyUseCityChains: true,
//     );
//
//     final bool _noChainsHere = allChainsCanNotBeBuilt(
//       context: context,
//     );
//
//     return Column(
//       // key: ValueKey<String>(ZoneProvider.proGetCurrentZone(context: context, listen: true).cityID),
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//
//         if (_noChainsHere == false)
//         SuperVerse(
//           verse: superPhrase(context, 'phid_select_a_section'),
//           weight: VerseWeight.black,
//           italic: true,
//           centered: false,
//           size: 3,
//           margin: Ratioz.appBarMargin,
//         ),
//
//         if (_noChainsHere == true)
//           Center(
//             child: Container(
//               width: bubbleWidth,
//               height: Scale.superScreenHeight(context),
//               padding: Scale.superMargins(margins: 20),
//               child: const SuperVerse(
//                 verse: 'No Available Flyers in This City yet',
//                 weight: VerseWeight.black,
//                 italic: true,
//                 size: 3,
//                 maxLines: 3,
//                 margin: Ratioz.appBarMargin,
//               ),
//             ),
//           ),
//
//         /// REAL ESTATE
//         if (canBuildChain(_propertyChain) == true)
//           ChainBubble(
//               title: superPhrase(context, 'phid_realEstate'),
//               icon: Iconz.pyramidSingleYellow,
//               bubbleWidth: bubbleWidth,
//               buttons: <Widget>[
//
//                 ChainExpanderForFlyerType(
//                   bubbleWidth: bubbleWidth,
//                   deactivated: false,
//                   flyerType: FlyerType.property,
//                   chain: _propertyChain,
//                 ),
//
//               ]
//           ),
//
//         /// Construction
//         if (canBuildChain(_designChain) == true || canBuildChain(_craftChain) == true)
//           ChainBubble(
//               title: superPhrase(context, 'phid_construction'),
//               icon: Iconz.pyramidSingleYellow,
//               bubbleWidth: bubbleWidth,
//               buttons: <Widget>[
//
//                 if (canBuildChain(_designChain) == true)
//                 ChainExpanderForFlyerType(
//                   bubbleWidth: bubbleWidth,
//                   deactivated: false,
//                   flyerType: FlyerType.design,
//                   chain: _designChain,
//                 ),
//
//                 MainLayout.spacer10,
//
//                 if (canBuildChain(_craftChain) == true)
//                 ChainExpanderForFlyerType(
//                   bubbleWidth: bubbleWidth,
//                   deactivated: false,
//                   flyerType: FlyerType.craft,
//                   chain: _craftChain,
//                 ),
//
//               ]
//           ),
//
//         /// Supplies
//         if (canBuildChain(_productChain) == true || canBuildChain(_equipmentChain) == true)
//           ChainBubble(
//             title: superPhrase(context, 'phid_supplies'),
//             icon: Iconz.pyramidSingleYellow,
//             bubbleWidth: bubbleWidth,
//             buttons: <Widget>[
//
//               if (canBuildChain(_productChain) == true)
//               ChainExpanderForFlyerType(
//                 bubbleWidth: bubbleWidth,
//                 deactivated: false,
//                 flyerType: FlyerType.product,
//                 chain: _productChain,
//               ),
//
//               MainLayout.spacer10,
//
//               if (canBuildChain(_equipmentChain) == true)
//               ChainExpanderForFlyerType(
//                 bubbleWidth: bubbleWidth,
//                 deactivated: false,
//                 flyerType: FlyerType.equipment,
//                 chain: _equipmentChain,
//               ),
//
//             ],
//           ),
//
//       ],
//     );
//   }
// }
