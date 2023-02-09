import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/lib/bubbles.dart';
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
      title: const Verse(
        id: 'Dialogs',
        translate: false,
      ),
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain(''),
        ),

      ],
      child: FloatingList(
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

          /// BOTTOM DIALOG
          WideButton(
            verse: Verse.plain('Bottom Dialog'),
            onTap: () async {

              await BottomDialog.showBottomDialog(
                  context: context,
                  draggable: true,
                  titleVerse: Verse.plain('Bottom Dialog'),
                  child: const Center(
                    child: DreamBox(
                      width: 200,
                      height: 100,
                      color: Colorz.bloodTest,
                    ),
                  ),
              );

            },
          ),

          const DotSeparator(),

          /// WAIT DIALOG
          WideButton(
            verse: Verse.plain('Wait Dialog'),
            onTap: () async {

              WaitDialog.showUnawaitedWaitDialog(
                context: context,
                canManuallyGoBack: true,
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
