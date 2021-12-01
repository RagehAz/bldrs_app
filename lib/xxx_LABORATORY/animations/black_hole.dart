import 'dart:async';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';

class BlackHoleScreen extends StatefulWidget {
  const BlackHoleScreen({Key key}) : super(key: key);


  @override
  _BlackHoleScreenState createState() => _BlackHoleScreenState();
}

class _BlackHoleScreenState extends State<BlackHoleScreen> with TickerProviderStateMixin{
  AnimationController _blackHoleController;
  int _spinsDuration = 1;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _blackHoleController = AnimationController(
        duration: Duration(seconds: _spinsDuration),
        vsync: this
    );

  }
// ---------------------------------------------------------------------------
  @override
  void dispose() {
    _timoor()?.cancel();
    _blackHoleController.stop();
    _blackHoleController.dispose();
    super.dispose();
  }
// ---------------------------------------------------------------------------
  Timer _timoor(){
    Timer _timoor = Timer(Duration(seconds: _spinsDuration),

            (){
      if(mounted){
        _blackHoleController.reset();
      }

      if(mounted){
        _enterTheBlackHole();
      }

    }
    );
    return _timoor;
  }
// ---------------------------------------------------------------------------
  void _enterTheBlackHole(){
    print('ezayak el awwal');

    if(mounted){
      _blackHoleController.forward();
    }

    if(mounted){
      _timoor();
    }

  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pageTitle: 'Enter The Black-Hole',
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: const <Widget>[],
      skyType: SkyType.Night,
      layoutWidget: Center(
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 2.0).animate(_blackHoleController),
          child: DreamBox(
            height: 300.0,
            width: 300.0,
            icon: Iconz.DvBlackHole,
            iconSizeFactor: 0.95,
            margins: const EdgeInsets.symmetric(vertical: 25),
            corners: 150,
            color: Colorz.white10,
            verseScaleFactor: 0.8,
            onTap: _enterTheBlackHole,
          ),
        ),
      ),
    );
  }
}
