import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/nav_bar/components/note_red_dot.dart';
import 'package:bldrs/b_views/z_components/nav_bar/nav_bar.dart';
import 'package:bldrs/b_views/z_components/streamers/fire_coll_streamer.dart';
import 'package:flutter/material.dart';

class NanoBzLogo extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NanoBzLogo({
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _logoWidth = NavBar.circleWidth * 0.47;
    final Widget _logo = DreamBox(
      height: _logoWidth,
      width: _logoWidth,
      corners: _logoWidth * 0.25,
      icon: bzModel.logo,
    );

    return FireCollStreamer(
        queryParameters: BzModel.unseenBzNotesQueryParameters(bzModel),
        loadingWidget: _logo,
        builder: (_, List<Map<String, dynamic>> maps){

          final List<NoteModel> _notes = NoteModel.decipherNotesModels(
            maps: maps,
            fromJSON: false,
          );

          final bool _isOn = NoteModel.checkThereAreUnSeenNotes(_notes);
          final int _count = _notes.length;

          return NoteRedDotWrapper(
            redDotIsOn: _isOn,
            count: _count,
            isNano: true,
            shrinkChild: true,
            childWidth: _logoWidth,
            child: _logo,
          );

        }
    );


  }
}
