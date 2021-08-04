import 'package:flutter/foundation.dart';

class Tracer{

  static bool _traceScreenBuild = true;
  static bool _traceWidgetBuild = true;
  static bool _traceSetState = false;
// -----------------------------------------------------------------------------
  static void traceScreenBuild({@required String screenName, bool tracerIsOn = true}){
    if(_traceScreenBuild == true && tracerIsOn == true){
      print('x - SB-------> ${screenName}');
    }
  }
// -----------------------------------------------------------------------------
  static void traceWidgetBuild({@required String widgetName, @required String varName, @required dynamic varValue, bool tracerIsOn = true, int number}){
    if(_traceWidgetBuild == true && tracerIsOn == true){
      String _numString = number == null ? 'x' : '$number';
      print('${_numString} - WB---> ${widgetName} : ${varName} : ${varValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  static void traceSetState({@required screenName, @required String varName, @required dynamic varNewValue, bool tracerIsOn = true}){
    if(_traceSetState == true && tracerIsOn == true){
      print('x - ss-> ${screenName} : ${varName} : ${varNewValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
}