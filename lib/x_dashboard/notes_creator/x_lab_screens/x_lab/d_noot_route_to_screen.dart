import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class NoteRouteToScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteRouteToScreen({
    @required this.receivedAction,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ReceivedAction receivedAction;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      title: Verse.plain('Note Route to Screen'),
      child: Column(
        children: <Widget>[

          const Stratosphere(),

          Container(
            width: 300,
            height: 400,
            color: Colorz.bloodTest,
            child: const SuperVerse(
              verse: Verse(
                id: 'Note auto route comes here',
                translate: false,
              ),
            ),
          ),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
