// import 'package:bldrs/a_models/bz/author_model.dart';
// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/editor/panel_button.dart';
// import 'package:bldrs/xxx_lab/xxx_old_stuff/old_flyer_stuff/old_flyer_zone_box.dart';
// import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
// import 'package:bldrs/b_views/z_components/sizing/expander.dart';
// import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class EditorPanel extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const EditorPanel({
//     @required this.superFlyer,
//     @required this.bzModel,
//     @required this.flyerBoxWidth,
//     @required this.panelWidth,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final SuperFlyer superFlyer;
//   final BzModel bzModel;
//   final double flyerBoxWidth;
//   final double panelWidth;
//
//   /// --------------------------------------------------------------------------
//   bool _authorButtonIsBlackAndWhite() {
//     bool _isBlackAndWhite;
//
//     if (superFlyer.flyerShowsAuthor == true) {
//       _isBlackAndWhite = false;
//     } else {
//       _isBlackAndWhite = true;
//     }
//
//     return _isBlackAndWhite;
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // print('draft picture screen');
//
//     // double _screenWidth = Scale.superScreenWidth(context);
//     // double _screenHeight = Scale.superScreenHeight(context);
//
//     final double _panelWidth = panelWidth;
//     final double _buttonSize =
//         panelWidth; //_panelWidth - (Ratioz.appBarMargin * 2);
//
//     final double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);
//
//     // double _panelButtonSize = _buttonSize * 0.8;
//
//     final double _panelHeight = _flyerZoneHeight;
//
//     final AuthorModel _author =
//         AuthorModel.getAuthorFromBzByAuthorID(bzModel, superFlyer?.authorID);
//
//     // BoxFit _currentPicFit = superFlyer?.currentPicFit;
//
//     // ImageSize _originalAssetSize = _assets.length == 0 || _assets == null ? null : ImageSize(
//     //   width: _assets[_draft.currentSlideIndex].originalWidth,
//     //   height: _assets[_draft.currentSlideIndex].originalHeight,
//     // );
//
//     final double _authorButtonHeight = Ratioz.xxflyerLogoWidth * flyerBoxWidth;
// // -----------------------------------------------------------------------------
//
//     return Container(
//       width: _panelWidth,
//       height: _panelHeight,
//       alignment: Alignment.topCenter,
//       // color: Colorz.White200,
//       child: Column(
//         // shrinkWrap: true,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           /// SHOW AUTHOR
//           DreamBox(
//             height: _authorButtonHeight,
//             // margins: EdgeInsets.symmetric(vertical: (Ratioz.xxflyerHeaderMiniHeight - Ratioz.xxflyerLogoWidth) * _flyerBoxWidth / 2),
//             width: _buttonSize,
//             color: superFlyer.flyerShowsAuthor == true
//                 ? Colorz.white80
//                 : Colorz.white80,
//             icon: _author?.pic,
//             iconSizeFactor: 0.5,
//             underLine: superFlyer.flyerShowsAuthor == true
//                 ? 'Author Shown'
//                 : 'Author Hidden',
//             underLineShadowIsOn: false,
//             underLineColor: superFlyer.flyerShowsAuthor == true
//                 ? Colorz.white255
//                 : Colorz.white80,
//             corners: Borderers.superLogoShape(
//                 context: context,
//                 zeroCornerEnIsRight: false,
//                 corner: Ratioz.xxflyerAuthorPicCorner * flyerBoxWidth),
//             blackAndWhite: _authorButtonIsBlackAndWhite(),
//             bubble: superFlyer.flyerShowsAuthor,
//             onTap: superFlyer.edit.onShowAuthorTap,
//           ),
//
//           /// SPACER
//           const Expander(),
//
//           // PanelButton.panelDot(panelButtonWidth: _panelButtonSize),
//
//           /// DELETE FLYER button
//           if (superFlyer.edit.editMode == true &&
//               superFlyer.edit.firstTimer == false)
//             PanelButton(
//               flyerBoxWidth: flyerBoxWidth,
//               icon: Iconz.xSmall,
//               iconSizeFactor: 0.5,
//               verse: 'Delete',
//
//               /// TASK : if all fields are valid should be green otherWise should be inActive
//               color: Colorz.red230,
//               onTap: superFlyer.edit.onDeleteFlyer,
//             ),
//
//           /// Publish button
//           if (superFlyer.edit.editMode == true)
//             PanelButton(
//               flyerBoxWidth: flyerBoxWidth,
//               icon: Iconz.arrowUp,
//               iconSizeFactor: 0.5,
//               verse: superFlyer.edit.firstTimer ? 'Publish' : 'Update',
//               verseColor:
//                   superFlyer.edit.editMode ? Colorz.black255 : Colorz.white255,
//
//               /// TASK : if all fields are valid should be green otherWise should be inActive
//               color: Colorz.green255,
//               onTap: superFlyer.edit.onPublishFlyer,
//             ),
//
//           /// TRIGGER EDIT MODE
//           PanelButton(
//             flyerBoxWidth: flyerBoxWidth,
//             icon: superFlyer.edit.editMode == true
//                 ? Iconz.gears
//                 : Iconz.viewsIcon,
//             iconSizeFactor: 0.5,
//             verse: superFlyer.edit.editMode == true ? 'Editing' : 'Viewing',
//             verseColor: superFlyer.edit.editMode == true
//                 ? Colorz.black255
//                 : Colorz.white255,
//             color: superFlyer.edit.editMode == true
//                 ? Colorz.yellow255
//                 : Colorz.white80,
//             onTap: superFlyer.edit.onTriggerEditMode,
//           ),
//         ],
//       ),
//     );
//   }
// }
