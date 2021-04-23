import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    print('BUILDING PAGE 2 ------------');

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MainLayout(
        pyramids: Iconz.PyramidzWhite,
        appBarBackButton: true,
        appBarType: AppBarType.Basic,
        pageTitle: 'Page --- 2',
        sky: Sky.Night,
        tappingRageh: (){print('Rageh ------------');},
        layoutWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /// POP page 2 --- return true
            DreamBox(
              verse: 'POP : page 2',
              secondLine: 'And return true',
              height: 50,
              verseScaleFactor: 1,
              color: Colorz.BlackBlack,
              boxMargins: EdgeInsets.all(5),
              boxFunction: () async {

                var _navResult = Navigator.pop(context, true);
              },
            ),

            /// POP all ---
            DreamBox(
              verse: 'POP : all till home screen',
              // secondLine: '',
              height: 50,
              verseScaleFactor: 1,
              color: Colorz.BlackBlack,
              boxMargins: EdgeInsets.all(5),
              boxFunction: () async {

                var _navResult = Navigator.popUntil(context,
                ModalRoute.withName(Routez.Home)
                );
              },
            ),

            /// POP page 2 --- return string
            DreamBox(
              verse: 'POP : page 2',
              secondLine: 'And return string',
              height: 50,
              verseScaleFactor: 1,
              color: Colorz.BlackBlack,
              boxMargins: EdgeInsets.all(5),
              boxFunction: () async {

                var _navResult = Navigator.pop(context, 'String of strings');
              },
            ),





          ],
        ),
      ),
    );
  }
}
// -----------------------------------------------------------------------------