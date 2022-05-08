import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/foundation.dart';


  const bool _traceScreenBuild = true;
  const bool _traceWidgetBuild = true;
  const bool _traceSetState = false;
// -----------------------------------------------------------------------------
  void traceScreenBuild({@required String screenName, bool tracerIsOn = true}){
    if(_traceScreenBuild == true && tracerIsOn == true){
      blog('x - SB-------> $screenName');
    }
  }
// -----------------------------------------------------------------------------
  void traceWidgetBuild({@required String widgetName, @required String varName, @required dynamic varValue, bool tracerIsOn = true, int number}){
    if(_traceWidgetBuild == true && tracerIsOn == true){
      final String _numString = number == null ? 'x' : '$number';
      blog('$_numString - WB---> $widgetName : $varName : ${varValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  void traceSetState({@required String screenName, @required String varName, @required dynamic varNewValue, bool tracerIsOn = true}){
    if(_traceSetState == true && tracerIsOn == true){
      blog('x - ss-> $screenName : $varName : ${varNewValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  void traceMethod({@required String methodName, @required String varName,@required dynamic varNewValue, bool tracerIsOn = true}){
    if(_traceSetState == true && tracerIsOn == true){
      blog('x - mm-> $methodName : $varName : ${varNewValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  void blog(dynamic msg, {String methodName}){

    assert((){
      // ignore: avoid_print
      print(msg.toString());
      return true;
    }(), '_');

  }
// -----------------------------------------------------------------------------
  void blogLoading({@required bool loading}){

    if (loading == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }
  }
// -----------------------------------------------------------------------------
  void blogStrings(List<String> strings){

    if (strings == null){
      blog('Strings are null and can not be blogged');
    }
    else if (strings.isEmpty == true){
      blog('Strings are empty and can not be blogged');
    }
    else {

      for (int i = 0; i < strings.length; i++){
        blog('blog string [ ${i+1} / ${strings.length} ] : ( ${strings[i]} )');
      }

    }

  }
// -----------------------------------------------------------------------------
