// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/bzz_button/d_double_bzz_button.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/bzz_button/d_single_bz_button.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/bzz_button/e_many_bzz_button.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/nav_bar_methods.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:flutter/material.dart';
//
// class SmartBzNavBarLogos extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SmartBzNavBarLogos({
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: true);
//
//     return Container(
//         width: NavBar.circleWidth,
//         height: NavBar.circleWidth,
//         alignment: Alignment.center,
//         color: Colorz.nothing,
//         child:
//
//         _myBzz.length == 1 ?
//         const SingleBzButton()
//
//             :
//
//         _myBzz.length == 2 ?
//         const DoubleBzzButton()
//
//             :
//
//         const ManyBzzButton()
//
//     );
//
//   }
//
// }
