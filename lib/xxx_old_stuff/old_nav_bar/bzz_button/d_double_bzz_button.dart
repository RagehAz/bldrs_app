// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/bzz_button/d_micro_bz_logo.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:flutter/material.dart';
//
// class DoubleBzzButton extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const DoubleBzzButton({
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: true);
//
//     return Stack(
//       children: <Widget>[
//
//         Positioned(
//           top: 0,
//           left: 0,
//           child: MicroBzLogo(
//             bzModel: _myBzz[0],
//           ),
//         ),
//
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: MicroBzLogo(
//             bzModel: _myBzz[1],
//           ),
//         ),
//
//       ],
//     );
//
//   }
// }
