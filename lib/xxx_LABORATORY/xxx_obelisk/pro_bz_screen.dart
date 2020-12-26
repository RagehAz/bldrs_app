// import 'package:bldrs/providers/bz_provider.dart';
// import 'package:bldrs/views/widgets/flyer/header/max_header/max_header.dart';
// import 'package:bldrs/views/widgets/flyer/header/mini_header/mini_header.dart';
// import 'package:bldrs/views/widgets/space/stratosphere.dart';
// import 'package:flutter/material.dart';
// import 'package:bldrs/views/widgets/layouts/main_layout.dart';
// import 'package:provider/provider.dart';
// import 'package:bldrs/views/widgets/buttons/dream_box.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
//
// class ProBzScreen extends StatefulWidget {
//   @override
//   _ProBzScreenState createState() => _ProBzScreenState();
// }
//
// class _ProBzScreenState extends State<ProBzScreen> {
//   bool _bzPageIsOn = false;
//   bool _flyerShowsAuthor = false;
//
// void _switchBzPage(){
//   setState(() {
//     _bzPageIsOn = !_bzPageIsOn;
//   });
// }
//
// @override
//   void initState() {
//   // _bzPageIsOn = false;
//   // _flyerShowsAuthor = false;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final proBzData = Provider.of<BzProvider>(context, listen: true);
//     final bzz = proBzData.allBzz;
//
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     int bzIndex = 0;
//     int i = bzIndex;
//
//     double flyerZoneWidth = screenWidth *0.8;
//
//     return MainLayout(
//       appBarRowWidgets: <Widget>[
//         DreamBox(
//           height: 40,
//           icon: Iconz.Statistics,
//           boxFunction: _switchBzPage,
//         ),
//       ],
//
//       layoutWidget: ChangeNotifierProvider(
//         create: (c) => bzz[i],
//         key: Key(bzz[i].bzId),
//         child: Container(
//           width: screenWidth,
//           height: screenHeight,
//           child: SingleChildScrollView(
//
//             child: Column(
//               children: <Widget>[
//                 Stratosphere(),
//
//                 MiniHeader(
//                   flyerZoneWidth: flyerZoneWidth,
//                   bzPageIsOn: _bzPageIsOn,
//                   flyerShowsAuthor: _flyerShowsAuthor,
//                   tappingHeader: (){
//                   _switchBzPage();
//                   },
//                   tappingFollow: (){},
//                   authorID: 'au02',
//                   coAuthorData: ,
//                 ),
//
//                 MaxHeader(
//                     flyerZoneWidth: flyerZoneWidth,
//                     bzPageIsOn: _bzPageIsOn,
//                     bzShowsTeam: bzz[i].bzShowsTeam,
//                     authorID: 'null',
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
