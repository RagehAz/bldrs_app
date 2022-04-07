import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class WaitDialog extends StatelessWidget {
// -----------------------------------------------------------------------------
  const WaitDialog({
    this.canManuallyGoBack = false,
    this.loadingPhrase,
    Key key
  }) : super(key: key);

  final bool canManuallyGoBack;
  final String loadingPhrase;
// -----------------------------------------------------------------------------
  static Future<void> showWaitDialog({
    @required BuildContext context,
    bool canManuallyGoBack,
    String loadingPhrase,
  }) async {

    final bool _result = await showDialog(
      context: context,
      builder: (BuildContext ctx) => WaitDialog(
        canManuallyGoBack: canManuallyGoBack,
        loadingPhrase: loadingPhrase,
      ),
    );


  }
// -----------------------------------------------------------------------------
  static void closeWaitDialog(BuildContext context) {
    goBack(context);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeight(context);
    final double _screenWidth = Scale.superScreenWidth(context);

    return WillPopScope(
      onWillPop: () async {
        return canManuallyGoBack;
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

                  SuperVerse(
                    verse: superPhrase(context, 'phid_loading').toUpperCase(),
                    size: 5,
                    scaleFactor: 2,
                    shadow: true,
                    italic: true,
                    weight: VerseWeight.black,
                    margin: 20,
                  ),

                  if (loadingPhrase != null)
                    Container(
                      width: _screenWidth * 0.8,
                      child: SuperVerse(
                        verse: loadingPhrase,
                        size: 3,
                        scaleFactor: 1,
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
              pyramidsIcon: Iconz.pyramidzYellow,
            ),

          ],
        ),
      ),
    );
  }
}