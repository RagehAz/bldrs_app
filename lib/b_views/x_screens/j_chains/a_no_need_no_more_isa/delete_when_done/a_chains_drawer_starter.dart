// import 'package:bldrs/a_models/chain/chain.dart';
// import 'package:bldrs/b_views/x_screens/j_chains/controllers/b_chains_search_controller.dart';
// import 'package:bldrs/b_views/x_screens/j_chains/no_need_no_more_isa/delete_when_done/b_chain_drawer_search_bar_part.dart';
// import 'package:bldrs/b_views/x_screens/j_chains/no_need_no_more_isa/delete_when_done/c_chains_drawer_expanders_part.dart';
// import 'package:bldrs/f_helpers/drafters/aligners.dart';
// import 'package:bldrs/f_helpers/drafters/scalers.dart';
// import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class ChainsDrawerStarter extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const ChainsDrawerStarter({
//     this.width,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final double width;
//   /// --------------------------------------------------------------------------
//   static const double drawerEdgeDragWidth = 15;
//   static const bool drawerEnableOpenDragGesture = true;
//   static const Color drawerScrimColor = Colorz.black125;
//   /// --------------------------------------------------------------------------
//   @override
//   State<ChainsDrawerStarter> createState() => _ChainsDrawerStarterState();
//   /// --------------------------------------------------------------------------
// }
//
// class _ChainsDrawerStarterState extends State<ChainsDrawerStarter> {
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     TextChecker.disposeControllerIfNotEmpty(_searchController);
//     _isSearching.dispose();
//     _foundPhids.dispose();
//     _foundChains.dispose();
//     super.dispose(); /// tamam
//   }
// // -----------------------------------------------------------------------------
//   final TextEditingController _searchController = TextEditingController(); /// tamam disposed
//   final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false); /// tamam disposed
//   final ValueNotifier<List<String>> _foundPhids = ValueNotifier(<String>[]); /// tamam disposed
//   final ValueNotifier<List<Chain>> _foundChains = ValueNotifier(<Chain>[]); /// tamam disposed
// // ---------------------------
//   Future<void> _onSearchChanged(String text) async {
//     await onSearchChanged(
//         context: context,
//         text: text,
//         isSearching: _isSearching,
//         foundPhids: _foundPhids,
//         foundChains: _foundChains
//     );
//   }
// // ---------------------------
//   Future<void> _onSearchSubmit(String text) async {
//     await onSearchKeywords(
//       context: context,
//       text: text,
//       isSearching: _isSearching,
//       foundChains: _foundChains,
//       foundPhids: _foundPhids,
//     );
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // -----------------------------------------------------------------------------
//     final double _drawerWidth = widget.width ?? Scale.superScreenWidth(context) * 0.9;
//     final double _drawerHeight = Scale.superScreenHeightWithoutSafeArea(context);
//     final double _bubbleWidth = _drawerWidth - (Ratioz.appBarMargin * 2);
//     // -----------------------------------------------------------------------------
//     return SizedBox(
//       key: const ValueKey<String>('ChainsDialogStarter'),
//       width: _drawerWidth,
//       child: Drawer(
//         elevation: 10,
//         child: Container(
//           width: _drawerWidth,
//           height: _drawerHeight,
//           color: Colorz.black255,
//           alignment: Aligners.superTopAlignment(context),
//           child: Column(
//             children: <Widget>[
//
//               /// SEARCH BAR
//               ChainsDrawerSearchBarPart(
//                 width: _drawerWidth,
//                 onSearchSubmit: (String text) => _onSearchSubmit(text),
//                 onSearchChanged: (String text) => _onSearchChanged(text),
//                 searchController: _searchController,
//                 isSearching: _isSearching,
//               ),
//
//               /// KEYWORDS LISTS
//               ChainsDialogExpandersPart(
//                 bubbleWidth: _bubbleWidth,
//                 drawerWidth: _drawerWidth,
//                 isSearching: _isSearching,
//                 foundChains: _foundChains,
//                 foundPhids: _foundPhids,
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
