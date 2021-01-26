// import 'package:bldrs/models/bz_model.dart';
// import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_author.dart';
// import 'package:bldrs/models/user_model.dart';
// import 'package:bldrs/view_brains/drafters/scalers.dart';
// import 'package:bldrs/view_brains/drafters/stringers.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/views/widgets/layouts/dream_list.dart';
// import 'package:bldrs/views/widgets/layouts/main_layout.dart';
// import 'package:bldrs/views/widgets/layouts/swiper_layout.dart';
// import 'package:bldrs/views/widgets/textings/super_verse.dart';
// import 'package:flutter/material.dart';
//
// List<BzModel> allBz = getAllBzz();
// List<UserModel> allUsers = getAllUsers();
// List<CoAuthor> allCoAuthors = getAllCoAuthors();
// List<SlideModel> allSlides = xSlides;
//
// Widget allBzzDreamList = DreamList(
//   itemCount: allBz?.length,
//   itemBuilder: (BuildContext c, int x) =>
//       DreamTile(
//         index: x,
//         info: '${allBz[x]?.bzId}: ${bzTypeSingleStringer(c, allBz[x]?.bzType)}, ${bzFormStringer(c,allBz[x]?.bzForm)}, ${allBz[x]?.bzCity}',
//         icon: allBz[x].bzLogo,
//         verse: allBz[x].bzName,
//         secondLine: 'bzAccountIsDeactivated:${allBz[x]?.bzAccountIsBanned} ... bzAccountIsDeactivated:${allBz[x]?.bzAccountIsDeactivated}',
//       ),
//
// );
//
// Widget allUsersDreamList = DreamList(
//   itemCount: allUsers.length,
//   itemBuilder: (BuildContext c, int x) =>
//       DreamTile(
//         index: x,
//         info: '${allUsers[x]?.userID}: ${allUsers[x]?.city}, whatsapp: ${allUsers[x]?.whatsAppIsOn}',
//         icon: allUsers[x]?.pic,
//         verse: allUsers[x]?.name,
//         secondLine: '${allUsers[x]?.title}',
//       ),
// );
//
// Widget allAuthorsDreamList = DreamList(
//   itemCount: allCoAuthors.length,
//   itemBuilder: (BuildContext c, int x) =>
//       DreamTile(
//         index: x,
//         info: '${allCoAuthors[x].author.authorID}: ${allCoAuthors[x].coUser.user.city}, bzID: ${allCoAuthors[x].author.bzId}',
//         icon: allCoAuthors[x].coUser.user.pic,
//         verse: allCoAuthors[x].coUser.user.name,
//         secondLine: '${allCoAuthors[x].coUser.user.title}',
//       ),
// );
//
// Widget allSlidesDreamList = DreamList(
//   itemCount: allSlides.length,
//   itemBuilder: (BuildContext c, int x) =>
//       DreamTile(
//         index: x,
//         info: '${allSlides[x].slideID}: index( ${allSlides[x].slideIndex} )',
//         icon: allSlides[x].picture,
//         verse: allSlides[x].headline,
//         secondLine: '${allSlides[x].flyerID}',
//       ),
// );
//
// Widget allHoruseeDreamList = DreamList(
//   itemCount: xHorusee.length,
//   itemBuilder: (BuildContext c, int x) =>
//       DreamTile(
//         index: x,
//         info: 'horusID : ${xHorusee[x].horusID}',
//         icon: xHorusee[x].horusID,
//         verse: 'slideID : ${xHorusee[x].slideID}',
//         secondLine: 'userID : ${xHorusee[x].userID}',
//       ),
// );
//
//
// class DatabaseViewerScreen extends StatefulWidget {
//
//
//
//   @override
//   _DatabaseViewerScreenState createState() => _DatabaseViewerScreenState();
// }
//
// class _DatabaseViewerScreenState extends State<DatabaseViewerScreen> {
//   String currentPage;
// // ----------------------------------------------------------------------------
//   List<Map<String, Object>> pages = [
//     {'title': 'Businesses', 'dreamList' : allBzzDreamList,},
//     {'title': 'Users'     , 'dreamList' : allUsersDreamList,},
//     {'title': 'Authors'   , 'dreamList' : allAuthorsDreamList,},
//     {'title': 'Slides'    , 'dreamList' : allSlidesDreamList,},
//     {'title': 'Horusee'   , 'dreamList' : allHoruseeDreamList,},
//   ];
// // ----------------------------------------------------------------------------
//   String layoutTitle(int i, List<Map<String, Object>> pages){
//     return pages[i]['title'];
//   }
// // ----------------------------------------------------------------------------
//   // void swipeLayout(int i){
//   //   setState(() {
//   //     currentPage = layoutTitle(i);
//   //   });
//   // }
// // ----------------------------------------------------------------------------
//   @override
//   void initState() {
//     currentPage = layoutTitle(0, pages);
//     super.initState();
//   }
// // ----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//
//   double screenWidth = superScreenWidth(context);
//     double screenHeight = superScreenHeight(context);
//
//     return MainLayout(
//       appBarType: AppBarType.Scrollable,
//       appBarRowWidgets: <Widget>[
//         SuperVerse(
//           verse: currentPage,
//           size: 3,
//           labelColor: Colorz.WhiteAir,
//           margin: 5,
//           color: Colorz.White,
//           shadow: true,
//         ),
//       ],
//       layoutWidget: SwiperLayout(
//         pagesLength: pages.length,
//         onIndexChanged: (int i){
//           setState(() {
//             currentPage = layoutTitle(i, pages);
//           });
//         },
//         itemBuilder: (BuildContext context, int i) {
//           return
//           Container(
//             width: screenWidth,
//             height: screenHeight,
//             child: pages[i]['dreamList'],
//           );
//         }
//       ),
//     );
//   }
// }
