import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class WaitDialog extends StatelessWidget {
// -----------------------------------------------------------------------------
  const WaitDialog({
    this.canManuallyGoBack = false,
    Key key
  }) : super(key: key);

  final bool canManuallyGoBack;
// -----------------------------------------------------------------------------
  static Future<void> showWaitDialog(BuildContext context) async {

    final bool _result = await showDialog(
      context: context,
      builder: (BuildContext ctx) => const WaitDialog(),
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
        body: SizedBox(
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

              const Loading(loading: true),


            ],
          ),
        ),
      ),
    );
  }
}
