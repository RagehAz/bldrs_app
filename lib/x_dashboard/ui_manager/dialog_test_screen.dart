import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
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
      layoutWidget: FloatingList(
        columnChildren: [

          /// TOP DIALOG
          WideButton(
            verse: Verse.plain('Top Dialog'),
            onTap: () async {

              await TopDialog.showTopDialog(
                context: context,
                firstVerse: Verse.plain('fuck you\nBitch\n hhoho'),
                secondVerse: Verse.plain('shit bitch fuc'),
                milliseconds: 50000,
              );

            },
          ),

          /// CLOSE TOP DIALOG
          WideButton(
            verse: Verse.plain('close Top Dialog'),
            onTap: () async {

              await TopDialog.closeTopDialog(context);

            },
          ),

          const DotSeparator(),

          /// CENTER DIALOG
          WideButton(
            verse: Verse.plain('Center Dialog'),
            onTap: () async {

              await CenterDialog.showCenterDialog(
                context: context,
                titleVerse: Verse.plain('What the fuck ?'),
                bodyVerse: Verse.plain('fuck the fucking mother fucking bitches'),
                boolDialog: true,
                invertButtons: true
              );

            },
          ),

        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
