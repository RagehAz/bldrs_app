import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
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
      layoutWidget: FloatingCenteredList(
        columnChildren: [

          WideButton(
            verse: Verse.plain('Center'),
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
