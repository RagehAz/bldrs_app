// import 'dart:async';
// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/b_views/x_screens/f_bz_editor/a_bz_editor_screen.dart';
// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
// import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/e_db/fire/ops/bz_fire_ops.dart' as FireBzOps;
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/router/navigators.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class DialogOfBzOptions extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const DialogOfBzOptions({
//     @required this.bzModel,
//     @required this.userModel,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final BzModel bzModel;
//   final UserModel userModel;
//
//   /// --------------------------------------------------------------------------
//   static const double buttonHeight = 50;
//   static const int numberOfButtons = 3;
//   static const double spacing = 5;
//
//   /// --------------------------------------------------------------------------
//   @override
//   State<DialogOfBzOptions> createState() => _DialogOfBzOptionsState();
//
//   /// --------------------------------------------------------------------------
//   static Future<void> show({
//     @required BuildContext context,
//     @required BzModel bzModel,
//     @required UserModel userModel
//   }) async {
//
//     const double _spacing = DialogOfBzOptions.buttonHeight * 0.1;
//     const double _height = (buttonHeight * numberOfButtons) + (_spacing * numberOfButtons) + 30;
//
//     await BottomDialog.showBottomDialog(
//       context: context,
//       draggable: true,
//       height: _height,
//       child: DialogOfBzOptions(
//         userModel: userModel,
//         bzModel: bzModel,
//       ),
//     );
//   }
//
//   /// --------------------------------------------------------------------------
// }
//
// class _DialogOfBzOptionsState extends State<DialogOfBzOptions> {
// // -----------------------------------------------------------------------------
//   /// --- FUTURE LOADING BLOCK
//   bool _loading = false;
//   Future<void> _triggerLoading({Function function}) async {
//     if (function == null) {
//       setState(() {
//         _loading = !_loading;
//       });
//     } else {
//       setState(() {
//         _loading = !_loading;
//         function();
//       });
//     }
//
//     _loading == true
//         ? blog('LOADING--------------------------------------')
//         : blog('LOADING COMPLETE--------------------------------------');
//   }
//
// // -----------------------------------------------------------------------------
//   Future<void> _deleteBzOnTap(BzModel bzModel) async {
//     // Nav.goBack(context);
//
//     final bool _dialogResult = await CenterDialog.showCenterDialog(
//       context: context,
//       title: '',
//       body: 'Are you sure you want to Delete ${bzModel.name} Business account ?',
//       boolDialog: true,
//     );
//
//     blog(_dialogResult);
//
//     /// if user chooses to stop ops
//     if (_dialogResult == false) {
//       blog('user cancelled ops');
//     }
//
//     /// if user chose to continue ops
//     else {
//       unawaited(_triggerLoading());
//
//       /// start delete bz ops
//       await FireBzOps.deleteBz(
//         context: context,
//         bzModel: bzModel,
//       );
//
//       // /// remove tinyBz from Local list
//       final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
//       // _prof.removeTinyBzFromLocalList(bzModel.bzID);
//
//       /// remove tinyBz from local userTinyBzz
//       await _bzzProvider.removeBzFromMyBzz(bzID: bzModel.id);
//
//       unawaited(_triggerLoading());
//
//       /// re-route back
//       Nav.goBack(context, argument: true);
//     }
//   }
//
// // -----------------------------------------------------------------------------
//   Future<void> _deactivateBzOnTap(BzModel bzModel) async {
//     /// close bottom sheet
//     Nav.goBack(context);
//
//     final bool _dialogResult = await CenterDialog.showCenterDialog(
//       context: context,
//       title: '',
//       body: 'Are you sure you want to Deactivate ${bzModel.name} Business account ?',
//       boolDialog: true,
//     );
//
//     blog(_dialogResult);
//
//     /// if user chooses to cancel ops
//     if (_dialogResult == false) {
//       blog('user cancelled ops');
//     }
//
//     /// if user chooses to continue ops
//     else {unawaited(_triggerLoading());
//
//       /// start deactivate bz ops
//       await FireBzOps.deactivateBz(
//         context: context,
//         bzModel: bzModel,
//       );
//
//       /// remove Bz from Local list
//       final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
//
//       await _bzzProvider.removeBzFromMyBzz(bzID: bzModel.id);
//
//       unawaited(_triggerLoading());
//
//       /// re-route back
//       Nav.goBack(context, argument: true);
//       // await null;
//
//     }
//   }
//
// // -----------------------------------------------------------------------------
//   Future<void> _editBzOnTap(BzModel bzModel) async {
//     final dynamic _result = await Navigator.push(
//         context,
//         MaterialPageRoute<BzEditorScreen>(
//             // maintainState: ,
//             // settings: ,
//             fullscreenDialog: true,
//             builder: (BuildContext context) {
//               return BzEditorScreen(
//                 userModel: widget.userModel,
//                 bzModel: bzModel,
//               );
//             }));
//
//     if (_result == true) {
//       setState(() {});
//     }
//
//     blog(_result);
//   }
//
// // -----------------------------------------------------------------------------
//   List<Widget> createButtons(
//       {@required BuildContext context,
//       @required BzModel bzModel,
//       @required UserModel userModel}) {
//     return <Widget>[
//       /// DELETE BZ
//       DreamBox(
//         height: DialogOfBzOptions.buttonHeight,
//         width: BottomDialog.clearWidth(context),
//         icon: Iconz.xSmall,
//         iconSizeFactor: 0.5,
//         iconColor: Colorz.red255,
//         verse: 'Delete Business Account',
//         verseScaleFactor: 1.2,
//         verseWeight: VerseWeight.black,
//         verseColor: Colorz.red255,
//         // verseWeight: VerseWeight.thin,
//         onTap: () => _deleteBzOnTap(bzModel),
//       ),
//
//       /// DEACTIVATE BZ
//       DreamBox(
//           height: DialogOfBzOptions.buttonHeight,
//           width: BottomDialog.clearWidth(context),
//           icon: Iconz.xSmall,
//           iconSizeFactor: 0.5,
//           iconColor: Colorz.red255,
//           verse: 'Deactivate Business Account',
//           verseScaleFactor: 1.2,
//           verseWeight: VerseWeight.black,
//           verseColor: Colorz.red255,
//           // verseWeight: VerseWeight.thin,
//           onTap: () => _deactivateBzOnTap(bzModel)),
//
//       /// EDIT BZ
//       DreamBox(
//         height: DialogOfBzOptions.buttonHeight,
//         width: BottomDialog.clearWidth(context),
//         icon: Iconz.gears,
//         iconSizeFactor: 0.5,
//         verse: 'Edit Business Account info',
//         verseScaleFactor: 1.2,
//         onTap: () => _editBzOnTap(bzModel),
//       ),
//     ];
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _buttons = createButtons(
//       context: context,
//       bzModel: widget.bzModel,
//       userModel: widget.userModel,
//     );
//
//     return ListView.builder(
//       itemCount: DialogOfBzOptions.numberOfButtons,
//       physics: const BouncingScrollPhysics(),
//       itemBuilder: (BuildContext ctx, int index) {
//         return Column(
//           children: <Widget>[
//             _buttons[index],
//             const SizedBox(height: DialogOfBzOptions.spacing),
//           ],
//         );
//       },
//     );
//   }
// }
