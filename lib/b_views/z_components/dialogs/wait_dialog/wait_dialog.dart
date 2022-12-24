import 'dart:async';

import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';

void showWaitDialog(BuildContext context, {Verse verse}){
  WaitDialog.showUnawaitedWaitDialog(
    context: context,
    loadingVerse: verse,
  );
}

void closeWaitDialog(BuildContext context){
  unawaited(WaitDialog.closeWaitDialog(context));
}

class WaitDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WaitDialog({
    this.canManuallyGoBack = false,
    this.loadingVerse,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool canManuallyGoBack;
  final Verse loadingVerse;
  // -----------------------------------------------------------------------------
  ///
  static void showUnawaitedWaitDialog({
    @required BuildContext context,
    bool canManuallyGoBack = false,
    Verse loadingVerse,
  }) {

    // WaitDialog.showUnawaitedWaitDialog
    unawaited(showWaitDialog(
      context: context,
      loadingVerse: loadingVerse,
      canManuallyGoBack: canManuallyGoBack,
    ));

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showWaitDialog({
    @required BuildContext context,
    bool canManuallyGoBack = false,
    Verse loadingVerse,
  }) async {

    await showDialog(
      context: context,
      builder: (BuildContext ctx) => WaitDialog(
        canManuallyGoBack: canManuallyGoBack,
        loadingVerse: loadingVerse,
      ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeWaitDialog(BuildContext context) async {
    final BuildContext _context = BldrsAppStarter.navigatorKey.currentContext;
    await Nav.goBack(
      context: _context,
      invoker: 'closeWaitDialog',
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    return WillPopScope(
      onWillPop: () async {
        return !canManuallyGoBack;
      },
      child: Scaffold(
        backgroundColor: Colorz.black125,
        body: Stack(
          children: <Widget>[

            SizedBox(
              width: _screenWidth,
              height: _screenHeight,
              // color: Colorz.black125,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  const SuperVerse(
                    verse: Verse(
                      text: 'phid_loading',
                      casing: Casing.upperCase,
                      translate: true,
                    ),
                    size: 5,
                    scaleFactor: 2,
                    shadow: true,
                    italic: true,
                    weight: VerseWeight.black,
                    margin: 20,
                  ),

                  if (loadingVerse != null)
                    SizedBox(
                      width: _screenWidth * 0.8,
                      child: SuperVerse(
                        verse: loadingVerse,
                        size: 3,
                        shadow: true,
                        italic: true,
                        weight: VerseWeight.black,
                        maxLines: 5,
                        margin: 10,
                      ),
                    ),

                  const Loading(loading: true),


                ],
              ),
            ),

            const Pyramids(
              pyramidType: PyramidType.crystalYellow,
              loading: true,
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
