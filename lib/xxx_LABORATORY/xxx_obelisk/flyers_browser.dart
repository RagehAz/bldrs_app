import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/nav_bar/bar_button.dart';
import 'package:bldrs/views/widgets/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';

class FlyerBrowserScreen extends StatefulWidget {
  const FlyerBrowserScreen({Key key}) : super(key: key);

  @override
  _FlyerBrowserScreenState createState() => _FlyerBrowserScreenState();
}

class _FlyerBrowserScreenState extends State<FlyerBrowserScreen> {
List<String> _keywords = new List();
bool _browserIsOn = false;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _triggerBrowser(){
    setState(() {
      _browserIsOn = !_browserIsOn;
    });
  }
// -----------------------------------------------------------------------------
  List<Widget> _browserAppBarWidgets(){
    return
      <Widget>[

        ...List.generate(_keywords.length, (index) => zorar(
          functionName: _keywords[index],
          function: (){
            print(_keywords[index]);
          },
        )),

        Container(
          height: 40,
          width: 50,
        ),

      ];
  }

  @override
  Widget build(BuildContext context) {

    double _buttonPadding = Ratioz.ddAppBarPadding * 1.5;

    double _browserMinZoneHeight = 40 + _buttonPadding * 2 + superVerseRealHeight(context, 0, 0.95, null);
    double _browserMaxZoneHeight = Scale.superScreenHeight(context) * 0.38;

    double _browserMinZoneWidth = 40 + _buttonPadding * 2;
    double _browserMaxZoneWidth = Scale.superScreenWidth(context);

    double _browserZoneHeight = _browserIsOn == true ? _browserMaxZoneHeight : _browserMinZoneHeight;
    double _browserZoneWidth = _browserIsOn == true ? _browserMaxZoneWidth : _browserMinZoneWidth;
    double _browserZoneMargins = _browserIsOn == true ? 0 : _buttonPadding;
    BorderRadius _browserZoneCorners = _browserIsOn == true ? null : Borderers.superBorderAll(context, Ratioz.ddAppBarCorner);

    double _browserScrollZoneWidth = _browserIsOn == true ? _browserZoneWidth - _buttonPadding * 2 : _browserMinZoneWidth;
    double _browserScrollZoneHeight = _browserZoneHeight - _buttonPadding * 2;

    return MainLayout(
      pyramids: _browserIsOn == true ? Iconz.DvBlankSVG : null,
      appBarType: _browserIsOn == true ? AppBarType.Scrollable : AppBarType.Main,
      loading: _loading,
      appBarBackButton: false,
      appBarRowWidgets: _browserIsOn == true ? _browserAppBarWidgets() : null,
      layoutWidget: Stack(
        children: <Widget>[

          Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: _triggerBrowser,
                child: AnimatedContainer(
                  height: _browserZoneHeight,
                  width: _browserZoneWidth,
                  duration: Ratioz.slidingTransitionDuration,

                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: _browserZoneCorners,
                    color: Colorz.BloodRedZircon,

                  ),
                  margin: EdgeInsets.all(_browserZoneMargins),
                  alignment: Alignment.center,
                  child:
                  _browserIsOn != null ?

                  /// browser contents
                  AnimatedContainer(
                    duration: Ratioz.slidingTransitionDuration,
                    width: _browserScrollZoneWidth,
                    height: _browserScrollZoneHeight,
                    color: Colorz.Nothing,
                    child: Row(
                      children: <Widget>[

                        Flexible(
                          flex: 1,
                          child: AnimatedContainer(
                            duration: Ratioz.slidingTransitionDuration,
                            width: (_browserScrollZoneWidth - _buttonPadding) / 2,
                            height: _browserScrollZoneHeight,
                            color: Colorz.BabyBlueSmoke,
                          ),
                        ),

                        SizedBox(width: _buttonPadding,),

                        Flexible(
                          flex: 1,
                          child: AnimatedContainer(
                            duration: Ratioz.slidingTransitionDuration,
                            width: (_browserScrollZoneWidth - _buttonPadding) / 2,
                            height: _browserScrollZoneHeight,
                            color: Colorz.BabyBlueSmoke,
                          ),
                        ),

                      ],
                    ),
                  )

                      :

                  /// the icon

                  BarButton(
                    width: _browserMinZoneWidth,
                    text: 'Browse',
                    iconSizeFactor: 0.7,
                    icon: Iconz.FlyerGrid,
                    onTap: _triggerBrowser,
                    barType: BarType.minWithText,
                    corners: Ratioz.ddAppBarButtonCorner,
                  ),

                ),
              ),
          )

        ],
      ),
    );
  }
}
