// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page_parts/person_button.dart';
// import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class RecordBubble extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const RecordBubble({
//     @required this.flyerBoxWidth,
//     @required this.bubbleTitle,
//     @required this.bubbleIcon,
//     @required this.users,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   final String bubbleTitle;
//   final String bubbleIcon;
//   final List<UserModel> users;
//
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     final double _bubbleWidth = flyerBoxWidth - (Ratioz.appBarPadding * 2);
//     const EdgeInsets _bubbleMargins = EdgeInsets.only(
//         top: Ratioz.appBarPadding,
//         left: Ratioz.appBarPadding,
//         right: Ratioz.appBarPadding);
//     final BorderRadius _bubbleCorners = Borderers.superBorderAll(
//         context, flyerBoxWidth * Ratioz.xxflyerTopCorners);
//     final double _peopleBubbleBoxHeight =
//         flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 1.2;
//
//     return Bubble(
//       key: key,
//       width: _bubbleWidth,
//       margins: _bubbleMargins,
//       corners: _bubbleCorners,
//       title: bubbleTitle,
//       leadingIcon: bubbleIcon,
//       leadingAndActionButtonsSizeFactor: 1,
//       columnChildren: <Widget>[
//         /// PEOPLE BOX
//         Container(
//             width: _bubbleWidth,
//             height: _peopleBubbleBoxHeight,
//             // color: Colorz.Yellow80,
//             alignment: Alignment.center,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: users.length,
//                 itemBuilder: (BuildContext ctx, int index) {
//                   return PersonButton(
//                     totalHeight: _peopleBubbleBoxHeight,
//                     image: users[index].pic,
//                     id: users[index].id,
//                     name: users[index].name,
//                     onTap: (String userID) {
//                       blog('id is : $userID');
//                     },
//                   );
//                 })),
//       ],
//     );
//   }
// }
