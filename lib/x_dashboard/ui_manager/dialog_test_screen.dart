import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class DialogsTestScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DialogsTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitleVerse: const Verse(
        text: 'Notes',
        translate: false,
      ),
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain(''),
        ),

      ],
      layoutWidget: Container(),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
