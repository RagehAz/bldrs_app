import 'package:flutter/foundation.dart';

abstract class Tracer{

  static const bool _traceScreenBuild = true;
  static const bool _traceWidgetBuild = true;
  static const bool _traceSetState = false;
// -----------------------------------------------------------------------------
  static void traceScreenBuild({@required String screenName, bool tracerIsOn = true}){
    if(_traceScreenBuild == true && tracerIsOn == true){
      print('x - SB-------> ${screenName}');
    }
  }
// -----------------------------------------------------------------------------
  static void traceWidgetBuild({@required String widgetName, @required String varName, @required dynamic varValue, bool tracerIsOn = true, int number}){
    if(_traceWidgetBuild == true && tracerIsOn == true){
      final String _numString = number == null ? 'x' : '$number';
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
  static void traceMethod({@required methodName, @required String varName,@required dynamic varNewValue, bool tracerIsOn = true}){
    if(_traceSetState == true && tracerIsOn == true){
      print('x - mm-> ${methodName} : ${varName} : ${varNewValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
}