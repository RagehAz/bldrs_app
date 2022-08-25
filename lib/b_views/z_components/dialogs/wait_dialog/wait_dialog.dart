import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class WaitDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WaitDialog({
    this.canManuallyGoBack = false,
    this.loadingPhrase,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool canManuallyGoBack;
  final String loadingPhrase;
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showWaitDialog({
    @required BuildContext context,
    bool canManuallyGoBack = false,
    String loadingVerse,
  }) async {

    await showDialog(
      context: context,
      builder: (BuildContext ctx) => WaitDialog(
        canManuallyGoBack: canManuallyGoBack,
        loadingPhrase: loadingVerse,
      ),
    );

  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void closeWaitDialog(BuildContext context) {
    Nav.goBack(
      context: context,
      invoker: 'closeWaitDialog',
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeight(context);
    final double _screenWidth = Scale.superScreenWidth(context);

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
                    verse: 'phid_loading',
                    verseCasing: VerseCasing.upperCase,
                    size: 5,
                    scaleFactor: 2,
                    shadow: true,
                    italic: true,
                    weight: VerseWeight.black,
                    margin: 20,
                  ),

                  if (loadingPhrase != null)
                    SizedBox(
                      width: _screenWidth * 0.8,
                      child: SuperVerse(
                        verse: loadingPhrase,
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

            Pyramids(
              pyramidType: PyramidType.crystalYellow,
              loading: ValueNotifier(true),
              onPyramidTap: null,
            ),

          ],
        ),
      ),
    );
  }
}
