// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/d_providers/phrase_provider.dart';
// import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class AddNewDraftShelf extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const AddNewDraftShelf({
//     @required this.isDeactivated,
//     @required this.onTap,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final bool isDeactivated;
//   final Function onTap;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return DreamBox(
//       key: const ValueKey<String>('AddNewDraftShelf'),
//       width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2,
//       height: 100,
//       color: Colorz.white10,
//       margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin, horizontal: Ratioz.appBarMargin),
//       bubble: false,
//       onTap: onTap,
//       subChild: DreamBox(
//         height: 70,
//         icon: Iconz.addFlyer,
//         iconSizeFactor: 0.7,
//         verse: superPhrase(context, 'phid_createFlyer'),
//         bubble: false,
//         isDeactivated: isDeactivated,
//       ),
//
//     );
//   }
//
// }
