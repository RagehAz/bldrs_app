import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/navigation_test/nav_test_home.dart';
import 'package:bldrs/xxx_LABORATORY/navigation_test/page_2.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  dynamic _string;
  int _numberOfBuilds = 0;
// -----------------------------------------------------------------------------
  void _rebuild(){
    setState(() {

    });
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    print('BUILDING PAGE 1 ------------');

    setState(() {
      _numberOfBuilds = _numberOfBuilds + 1;
    });

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MainLayout(
        pyramids: Iconz.PyramidzYellow,
        // appBarBackButton: true,
        appBarType: AppBarType.Basic,
        pageTitle: 'Page 1 : rebuilt $_numberOfBuilds times',
        sky: Sky.Night,
        tappingRageh: (){_rebuild();},
        layoutWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /// POP page 1 --- return true
            DreamBox(
              verse: 'POP : page 1',
              secondLine: 'And return true',
              height: 50,
              verseScaleFactor: 1,
              color: Colorz.Black225,
              margins: EdgeInsets.all(5),
              onTap: () async {

                var _navResult = Navigator.pop(context, true);
              },
            ),

            /// POP page 1 --- return false
            DreamBox(
              verse: 'POP : page 1',
              secondLine: 'And return false',
              height: 50,
              verseScaleFactor: 1,
              color: Colorz.Black225,
              margins: EdgeInsets.all(5),
              onTap: () async {

                var _navResult = Navigator.pop(context, false);
              },
            ),

            /// PUSH page 2
            DreamBox(
              verse: 'Push : page 2',
              verseScaleFactor: 1,
              height: 50,
              color: Colorz.Black225,
              margins: EdgeInsets.all(5),
              onTap: () async {

                var _navResult = await Navigator.push(context,
                  new MaterialPageRoute(
                    builder: (context) => Page2(),
                  ),
                );

                setState(() {
                  _string = _navResult;
                });

                await resultDialog(context, _navResult);

              },
            ),

            /// REPLACE page 1 with 2 ---
            DreamBox(
              verse: 'REPLACE : page 1 with 2',
              secondLine: ' --- ',
              height: 50,
              verseScaleFactor: 1,
              color: Colorz.Black225,
              margins: EdgeInsets.all(5),
              onTap: () async {

                var _navResult = await Navigator.pushReplacement(
                  context,
                    new MaterialPageRoute(
                      builder: (context) => Page2(),
                    )
                );

              },
            ),

            SuperVerse(
              verse: _string.toString(),
              labelColor: Colorz.Black200,
              size: 3,
              maxLines: 2,
              margin: 20,
              shadow: true,
              color: Colorz.Yellow225,
            ),

          ],
        ),
      ),
    );
  }
}
// -----------------------------------------------------------------------------
