// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class GroupsPage extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const GroupsPage({
//     @required this.groups,
//     @required this.onTap,
//     @required this.selectedGroup,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final List<String> groups;
//   final Function onTap;
//   final String selectedGroup;
//
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: groups.length,
//         padding: const EdgeInsets.all(Ratioz.appBarMargin),
//         itemBuilder: (BuildContext context, int groupIndex) {
//           final String _group = groups[groupIndex];
//           final Color _color =
//               selectedGroup == _group ? Colorz.yellow255 : Colorz.nothing;
//
//           return DreamBox(
//             height: 70,
//             // width: 120,
//             color: _color,
//             margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
//             verse: _group,
//             onTap: () => onTap(_group),
//           );
//         });
//   }
// }
