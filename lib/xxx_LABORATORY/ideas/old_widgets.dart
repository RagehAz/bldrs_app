// class OLDSliverAppBarStrip extends StatelessWidget {
//   final List<Widget> rowWidgets;
//
//   OLDSliverAppBarStrip({
//     @required this.rowWidgets,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     double abPadding = Ratioz.ddAppBarMargin;
//     double abHeight = Ratioz.ddAppBarHeight;
//
//     return SliverPadding(
//       padding: EdgeInsets.only(top: 0),
//       sliver : SliverAppBar(
//         automaticallyImplyLeading: false,
//         pinned: true,
//         floating: true,
//         expandedHeight: abHeight + (abPadding ),
//         backgroundColor: Colorz.Nothing,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//             borderRadius:
//             BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner))),
//         titleSpacing: abPadding * 0,
//         toolbarHeight: abHeight + (abPadding * 2),
//
//         title: Padding(
//           padding: EdgeInsets.all(abPadding),
//
//           child: Stack(
//             alignment: Alignment.center,
//             children: <Widget>[
//
//               Container(
//                 width: double.infinity,
//                 height: abHeight,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
//                     boxShadow: [
//                       CustomBoxShadow(
//                           color: Colorz.BlackBlack,
//                           offset: Offset(0,0),
//                           blurRadius: abHeight * 0.18,
//                           blurStyle: BlurStyle.outer
//                       ),
//                       // CustomBoxShadow(
//                       //     color: Colorz.BlackSmoke,
//                       //     offset: Offset(0,0),
//                       //     blurRadius: abHeight * 0.0,
//                       //     blurStyle: BlurStyle.outer
//                       // ),
//
//                     ]
//                 ),
//               ),
//
//               Row(children: rowWidgets)
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
