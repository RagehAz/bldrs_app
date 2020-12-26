import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:websafe_svg/websafe_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
//  @override
//void initState(){
//    super.initState();
//    Timer(Duration(seconds:3), ()=>print('Timeout'));
//  }

//  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * .75,
        child: WebsafeSvg.asset('assets/art_works/bldrs_name_en.svg'));
  }
}
