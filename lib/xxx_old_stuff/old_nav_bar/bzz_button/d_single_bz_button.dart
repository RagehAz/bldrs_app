// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/secondary_models/note_model.dart';
// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/components/note_red_dot.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/nav_bar_methods.dart';
// import 'package:bldrs/b_views/z_components/streamers/fire_coll_streamer.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:flutter/material.dart';
//
// class SingleBzButton extends StatelessWidget {
//
//   const SingleBzButton({
//     Key key
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: true);
//
//
//     const double _logoWidth = NavBar.circleWidth;
//     final Widget _logo = DreamBox (
//       width: _logoWidth,
//       height: _logoWidth,
//       icon: _myBzz[0].logo,
//       corners: _logoWidth * 0.5,
//     );
//
//     return FireCollStreamer(
//         queryParameters: BzModel.unseenBzNotesQueryParameters(
//           bzModel: _myBzz[0],
//           context: context,
//         ),
//         loadingWidget: _logo,
//         builder: (_, List<Map<String, dynamic>> maps){
//
//           final List<NoteModel> _notes = NoteModel.decipherNotesModels(
//             maps: maps,
//             fromJSON: false,
//           );
//
//           final bool _isOn = NoteModel.checkThereAreUnSeenNotes(_notes);
//           final int _count = _notes.length;
//
//           return NoteRedDotWrapper(
//             redDotIsOn: _isOn,
//             count: _count,
//             childWidth: _logoWidth,
//             child: _logo,
//           );
//
//         }
//     );
//
//   }
// }
