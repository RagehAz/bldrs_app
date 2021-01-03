import 'package:flutter/material.dart';

goToNewScreen (BuildContext context, Widget screen){
Navigator.of(context).push(MaterialPageRoute(builder: (_){return screen;},),);
  }

  goToRoute(BuildContext context, String routezName){
    Navigator.pushNamed(context, routezName);
  }