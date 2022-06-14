// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
// import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
// import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:flutter/material.dart';
//
// class PersonButton extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const PersonButton({
//     @required this.totalHeight,
//     @required this.image,
//     @required this.name,
//     @required this.id,
//     @required this.onTap,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final double totalHeight;
//   final String image;
//   final String name;
//   final String id;
//   final ValueChanged<String> onTap;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double _imageHeight = totalHeight * 0.6;
//     final double _imageWidth = _imageHeight;
//     final double _nameHeight = totalHeight - _imageHeight;
//     final double _nameWidth = totalHeight * 0.6;
//
//     return Container(
//       width: _nameWidth,
//       height: _imageHeight,
//       margin: EdgeInsets.symmetric(horizontal: _imageWidth * 0.005),
//       decoration: BoxDecoration(
//         color: Colorz.black20,
//         borderRadius: Borderers.superBorderAll(context, _imageWidth * 0.25),
//       ),
//       child: Column(
//         children: <Widget>[
//
//           /// USER IMAGE
//           DreamBox(
//             height: _imageHeight * 0.90,
//             width: _imageWidth * 0.90,
//             margins: _imageWidth * 0.05,
//             icon: image,
//             underLine: name,
//             iconRounded: false,
//             bubble: false,
//             onTap: () => onTap(id),
//           ),
//
//           /// USER FIRST NAME
//           SizedBox(
//             width: _nameWidth,
//             height: _nameHeight,
//             // margin: EdgeInsets.symmetric(horizontal: _nameWidth * 0.2),
//             child: SuperVerse(
//               verse: TextMod.removeTextAfterFirstSpecialCharacter(name, ' '),
//               size: 1,
//               weight: VerseWeight.thin,
//               shadow: true,
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
