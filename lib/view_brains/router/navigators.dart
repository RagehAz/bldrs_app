import 'package:flutter/material.dart';

goToNewScreen (BuildContext context, Widget screen){
Navigator.of(context).push(MaterialPageRoute(builder: (_){return screen;},),);
  }