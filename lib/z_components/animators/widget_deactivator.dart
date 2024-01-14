// import 'package:flutter/material.dart';
//
// class WidgetDeactivator extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const WidgetDeactivator({
//     required this.deactivated,
//     required this.child,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final bool deactivated;
//   final Widget child;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return AbsorbPointer(
//       absorbing: deactivated,
//       child: Opacity(
//         opacity: deactivated ? 0.5 : 1,
//         child: child,
//       ),
//     );
//
//   }
// /// --------------------------------------------------------------------------
// }
