import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/xxx_LABORATORY/navigation_test/page_1.dart';
import 'package:bldrs/xxx_LABORATORY/navigation_test/page_2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
// -----------------------------------------------------------------------------
Future<void> resultDialog(BuildContext context, var _navResult) async {
  if (_navResult != null){
    await superDialog(
      context: context,
      title: 'dialog in NavTestHome',
      body: 'Nav Result is : $_navResult',
      boolDialog: false,
    );
  }
}
// -----------------------------------------------------------------------------
class NavTestHome extends StatefulWidget {
  @override
  _NavTestHomeState createState() => _NavTestHomeState();
}

class _NavTestHomeState extends State<NavTestHome> {
  int _numberOfBuilds = 0;
// -----------------------------------------------------------------------------
  void _rebuild(){
    setState(() {

    });
  }
// -----------------------------------------------------------------------------
  Widget _transitionButton({PageTransitionType type, int milliSeconds, Curve curve}){
    return DreamBox(
      verse: type.toString(),
      verseScaleFactor: 0.5,
      verseColor: Colorz.BlackBlack,
      height: 170,
      width: 130,
      color: Colorz.Yellow,
      // boxMargins: EdgeInsets.all(10),
      verseMaxLines: 2,
      onTap: () async {

        var _navResult = await Navigator.push(context,
          PageTransition(
            type: type,
            child: Page1(),
            duration: Duration(milliseconds: milliSeconds),
            reverseDuration: Duration(milliseconds: milliSeconds),
            curve: curve,
            alignment: Alignment.bottomLeft
          ),
        );

        // await resultDialog(context, _navResult);

      },
    );
  }
// -----------------------------------------------------------------------------
  List<Widget> _transitionButtons(){

    List<PageTransitionType> _types = <PageTransitionType>[
      PageTransitionType.fade,
      PageTransitionType.rightToLeft,
      PageTransitionType.leftToRight,
      PageTransitionType.topToBottom,
      PageTransitionType.bottomToTop,
      PageTransitionType.scale,
      PageTransitionType.rotate,
      PageTransitionType.size,
      PageTransitionType.rightToLeftWithFade,
      PageTransitionType.leftToRightWithFade,
      PageTransitionType.leftToRightJoined,
      PageTransitionType.rightToLeftJoined,
    ];

    List<Widget> _buttons = new List();

    for (var type in _types){
      _buttons.add(
        _transitionButton(
          type: type,
          curve: Curves.fastOutSlowIn,
          milliSeconds: 200
        )
      );
    }

    return _buttons;
  }


  @override
  Widget build(BuildContext context) {

    print('BUILDING NAV HOME ------------');

    setState(() {
      _numberOfBuilds = _numberOfBuilds + 1;
    });

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MainLayout(
        pyramids: Iconz.PyramidzWhite,
        // appBarBackButton: true,
        appBarType: AppBarType.Basic,
        pageTitle: 'Navigation Home : rebuilt $_numberOfBuilds times',
        sky: Sky.Night,
        tappingRageh: (){_rebuild();},
        layoutWidget: ListView(
          children: <Widget>[

            Stratosphere(),

            /// PUSH page 1
            DreamBox(
              verse: 'Push : page 1',
              verseScaleFactor: 1,
              height: 50,
              color: Colorz.BlackBlack,
              margins: EdgeInsets.all(5),
              onTap: () async {

                var _navResult = await Navigator.push(context,
                  new MaterialPageRoute(
                    builder: (context) => Page1(),
                  ),
                );

                await resultDialog(context, _navResult);

              },
            ),

            /// REPLACE Navigation Home with page 2 ---
            DreamBox(
              verse: 'REPLACE : Navigation Home with page 2',
              width: Scale.superScreenWidth(context) - 10,
              verseMaxLines: 2,
              secondLine: ' --- ',
              height: 100,
              verseScaleFactor: 1,
              color: Colorz.BlackBlack,
              margins: EdgeInsets.all(5),
              onTap: () async {

                var _navResult = Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => Page2(),
                    )
                );
              },
            ),

            // /// PUSH page 1
            // DreamBox(
            //   verse: 'Push : page 1',
            //   verseScaleFactor: 1,
            //   height: 50,
            //   color: Colorz.BlackBlack,
            //   boxMargins: EdgeInsets.all(5),
            //   boxFunction: () async {
            //
            //     var _navResult = await Navigator.pushAndRemoveUntil(context,
            //       new MaterialPageRoute(
            //         builder: (context) => Page1(),
            //       ),
            //     );
            //
            //     await superDialog(
            //       context: context,
            //       title: 'dialog in NavTestHome',
            //       body: 'Nav Result is : $_navResult',
            //       boolDialog: false,
            //     );
            //
            //   },
            // ),

            /// PUSH page 1 with transition
            Container(
              width: Scale.superScreenWidth(context),
              height: Scale.superScreenWidth(context) * 3,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: _transitionButtons(),
                childAspectRatio: 130/175,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
// -----------------------------------------------------------------------------