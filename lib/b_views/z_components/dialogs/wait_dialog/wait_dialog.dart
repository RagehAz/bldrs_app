import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basics/helpers/classes/space/scale.dart';

void pushWaitDialog({
  Verse? verse,
  bool canManuallyGoBack = false,
}){
  WaitDialog.showUnawaitedWaitDialog(
    verse: verse,
    canManuallyGoBack: canManuallyGoBack,
  );
}

void closeWaitDialog(){
  unawaited(WaitDialog.closeWaitDialog());
}

class WaitDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WaitDialog({
    this.canManuallyGoBack = false,
    this.loadingVerse,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool? canManuallyGoBack;
  final Verse? loadingVerse;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void showUnawaitedWaitDialog({
    bool canManuallyGoBack = false,
    Verse? verse,
  }) {

    unawaited(_showWaitDialog(
      loadingVerse: verse,
      canManuallyGoBack: canManuallyGoBack,
    ));

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _showWaitDialog({
    bool canManuallyGoBack = false,
    Verse? loadingVerse,
  }) async {

    await showDialog(
      context: getMainContext(),
      builder: (BuildContext ctx) => WaitDialog(
        canManuallyGoBack: canManuallyGoBack,
        loadingVerse: loadingVerse,
      ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeWaitDialog() async {
    UiProvider.clearLoadingVerse();
    await Nav.goBack(
      context: getMainContext(),
      invoker: 'closeWaitDialog',
    );
  }
  // --------------------
  static void setVerse({
    required Verse verse,
  }){
    UiProvider.proSetLoadingVerse(verse: verse);
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
        if (canManuallyGoBack == null){
          return true;
        }
        else {
          return !canManuallyGoBack!;
        }
      },
      child: Scaffold(
        backgroundColor: Colorz.black125,
        body: Stack(
          children: <Widget>[

            SizedBox(
              width: _screenWidth,
              height: _screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  BldrsText(
                    verse: const Verse(
                      id: 'phid_loading',
                      casing: Casing.upperCase,
                      translate: true,
                    ),
                    size: 4,
                    scaleFactor: _screenWidth * 0.004,
                    shadow: true,
                    italic: true,
                    weight: VerseWeight.black,
                    margin: 20,
                  ),

                  if (loadingVerse != null)
                    SizedBox(
                      width: _screenWidth * 0.8,
                      child: BldrsText(
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

                  /// LOADING VERSE
                  Selector<UiProvider, Verse?>(
                    selector: (_, UiProvider uiProvider) => uiProvider.loadingVerse,
                    builder: (BuildContext context, Verse? verse, Widget? child) {
                      if (verse == null) {
                        return const SizedBox();
                      } else {
                        return BldrsText(
                          verse: verse,
                          color: Colorz.yellow200,
                        );
                      }
                    },
                  ),

                ],
              ),
            ),

            Pyramids(
              pyramidType: PyramidType.crystalYellow,
              loading: true,
              // onPyramidTap: canManuallyGoBack == null ? null : () => Nav.goBack(context: context),
              onPyramidDoubleTap: () async {

                if (Mapper.boolIsTrue(canManuallyGoBack) == true){
                  await Nav.goBack(context: context);
                }

              },
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
