import 'dart:developer';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
  const bool _traceScreenBuild = true;
  const bool _traceWidgetBuild = true;
  const bool _traceSetState = false;
// -----------------------------------------------------------------------------
  void traceScreenBuild({
    @required String screenName,
    bool tracerIsOn = true,
  }){
    if(_traceScreenBuild == true && tracerIsOn == true){
      blog('x - SB-------> $screenName');
    }
  }
// -----------------------------------------------------------------------------
  void traceWidgetBuild({
    @required String widgetName,
    @required String varName,
    @required dynamic varValue,
    bool tracerIsOn = true,
    int number,
  }){
    if(_traceWidgetBuild == true && tracerIsOn == true){
      final String _numString = number == null ? 'x' : '$number';
      blog('$_numString - WB---> $widgetName : $varName : ${varValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  void traceSetState({
    @required String screenName,
    @required String varName,
    @required dynamic varNewValue,
    bool tracerIsOn = true,
  }){
    if(_traceSetState == true && tracerIsOn == true){
      blog('x - ss-> $screenName : $varName : ${varNewValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  void traceMethod({
    @required String methodName,
    @required String varName,
    @required dynamic varNewValue,
    bool tracerIsOn = true,
  }){
    if(_traceSetState == true && tracerIsOn == true){
      blog('x - mm-> $methodName : $varName : ${varNewValue.toString()}');
    }
  }
// -----------------------------------------------------------------------------
  void blog(dynamic msg, {String methodName}){

    assert((){
      // ignore: avoid_print
      log(msg.toString());
      return true;
    }(), '_');

    /// NOUR IDEA
    /*
    extension Printer on dynamic {
      void log() {
        return dev.log(toString());
      }
    }
     */

  }
// -----------------------------------------------------------------------------
  void blogLoading({
    @required bool loading,
    @required String callerName,
  }){
    if (loading == true) {
      blog('$callerName : LOADING --------------------------------------');
    }

    else {
      blog('$callerName : LOADING COMPLETE -----------------------------');
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
// ---------------------------------------
/// TESTED : WORKS PERFECT
void setNotifier({
  @required ValueNotifier<dynamic> notifier,
  @required bool mounted,
  @required dynamic value,
  @required bool addPostFrameCallBack,
  Function onFinish,
  bool shouldHaveListeners = false,
}){

  if (mounted == true){
    // blog('setNotifier : setting to ${value.toString()}');
    if (value != notifier.value){

      if (notifier != null){

        /// ignore: invalid_use_of_protected_member
        if (shouldHaveListeners == false || notifier.hasListeners == true){

          if (addPostFrameCallBack == true){
            WidgetsBinding.instance.addPostFrameCallback((_){
              notifier.value = value;
              if(onFinish != null){
                onFinish();
              }
            });
          }

          else {
            notifier.value = value;
            if(onFinish != null){
              onFinish();
            }
          }

        }

      }

    }

  }

}


// -----------------------------------------------------------------------------
