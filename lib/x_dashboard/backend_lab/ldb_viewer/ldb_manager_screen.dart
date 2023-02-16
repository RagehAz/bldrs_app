import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/customs/super_headline.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_viewer_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/sembast_test_screen.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class LDBViewersScreen extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LDBViewersScreen({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToLDBViewer(BuildContext context, String ldbDocName) async {
    await Nav.goToNewScreen(
        context: context,
        screen: LDBViewerScreen(
          ldbDocName: ldbDocName,
        )
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      title: Verse.plain('LDB viewers'),
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          icon: Iconz.lab,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const SembastTestScreen(),
            );

          },
        ),

      ],

      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        child: Column(
          children: <Widget>[

            ...List<Widget>.generate(LDBDoc.allDocs.length, (int index) {

              final dynamic ldbDoc = LDBDoc.allDocs[index];

              /// HEADLINE
              if (ldbDoc is Verse){
                return SuperHeadline(verse: ldbDoc);
              }

              /// BUTTON
              else {
                return WideButton(
                  verse: Verse.plain(ldbDoc), // notifications prefs, my user model
                  onTap: () => goToLDBViewer(context, ldbDoc),
                  icon: Iconz.info,
                );
              }
            }
            ),
          ],
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class SmallFuckingButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SmallFuckingButton({
    @required this.verse,
    @required this.onTap,
    this.width = 80,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Function onTap;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonWidth = width ?? Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: 4,
      boxWidth: BldrsAppBar.width(context),
    );

    return DreamBox(
      height: 50,
      width: _buttonWidth,
      color: Colorz.black255,
      margins: const EdgeInsets.symmetric(horizontal: 1),
      verse: Verse.plain(verse).copyWith(casing: Casing.upperCase),
      verseScaleFactor: 0.6,
      verseWeight: VerseWeight.black,
      verseMaxLines: 2,
      onTap: onTap,
      verseItalic: true,
    );
  }
  /// --------------------------------------------------------------------------
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('verse', verse));
  //   properties.add(DiagnosticsProperty<Function>('onTap', onTap));
  // }
  /// --------------------------------------------------------------------------
}
