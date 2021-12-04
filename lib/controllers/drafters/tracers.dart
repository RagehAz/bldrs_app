import 'package:flutter/foundation.dart';


  const bool _traceScreenBuild = true;
  const bool _traceWidgetBuild = true;
  const bool _traceSetState = false;
// -----------------------------------------------------------------------------
  void traceScreenBuild({@required String screenName, bool tracerIsOn = true}){
    if(_traceScreenBuild == true && tracerIsOn == true){
      print('x - SB-------> ${screenName}');
    }
  }
// -----------------------------------------------------------------------------
  void traceWidgetBuild({@required String widgetName, @required String varName, @required dynamic varValue, bool tracerIsOn = true, int number}){
    if(_traceWidgetBuild == true && tracerIsOn == true){
      final String _numString = number == null ? 'x' : '$number';
      print('${_numString} - WB---> ${widgetName} : ${varName} : ${varValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  void traceSetState({@required String screenName, @required String varName, @required dynamic varNewValue, bool tracerIsOn = true}){
    if(_traceSetState == true && tracerIsOn == true){
      print('x - ss-> ${screenName} : ${varName} : ${varNewValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  void traceMethod({@required String methodName, @required String varName,@required dynamic varNewValue, bool tracerIsOn = true}){
    if(_traceSetState == true && tracerIsOn == true){
      print('x - mm-> ${methodName} : ${varName} : ${varNewValue.toString()}');
    }
  }
