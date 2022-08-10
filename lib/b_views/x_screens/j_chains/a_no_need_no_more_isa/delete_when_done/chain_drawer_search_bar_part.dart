// import 'package:bldrs/b_views/z_components/app_bar/search_bar.dart';
// import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
// import 'package:bldrs/d_providers/phrase_provider.dart';
// import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
// import 'package:bldrs/f_helpers/router/navigators.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class ChainsDrawerSearchBarPart extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const ChainsDrawerSearchBarPart({
//     @required this.width,
//     @required this.onSearchChanged,
//     @required this.onSearchSubmit,
//     @required this.isSearching,
//     @required this.searchController,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final double width;
//   final ValueChanged<String> onSearchSubmit;
//   final ValueChanged<String> onSearchChanged;
//   final ValueNotifier<bool> isSearching; /// p
//   final TextEditingController searchController;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       key: const ValueKey<String>('ChainsDialogSearchBarPart'),
//       width: width,
//       height: Ratioz.appBarButtonSize,
//       margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin + Ratioz.appBarPadding
//       ),
//
//       child: Row(
//         children: <Widget>[
//
//           ValueListenableBuilder(
//               valueListenable: isSearching,
//               builder: (_, bool _isSearching, Widget child){
//
//                 return BackAndSearchButton(
//                   backAndSearchAction: BackAndSearchAction.goBack,
//                   onTap: () async {
//
//                     if (_isSearching == true){
//                       Keyboarders.closeKeyboard(context);
//                       isSearching.value = false;
//                       searchController.text = '';
//                     }
//                     else {
//                       Nav.goBack(context);
//                     }
//
//                   },
//                 );
//
//               }
//           ),
//
//           SearchBar(
//             searchController: searchController,
//             height: Ratioz.appBarButtonSize,
//             boxWidth: width - 40,
//             onSearchSubmit: (String val) => onSearchSubmit(val),
//             historyButtonIsOn: false,
//             onSearchChanged: (String val) => onSearchChanged(val),
//             hintText: superPhrase(context, 'phid_search_keywords'),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
