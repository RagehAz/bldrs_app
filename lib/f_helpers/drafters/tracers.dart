// import 'dart:developer';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BLOGGING

// --------------------
/// TESTED : WORKS PERFECT
void blog(dynamic msg, {String invoker}){

  assert((){
    // log(msg.toString());
    // ignore: avoid_print
    print(msg?.toString());
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
// --------------------
/// TESTED : WORKS PERFECT
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

/// VALUE NOTIFIER SETTER

// --------------------
/// TESTED : WORKS PERFECT
void setNotifier({
  @required ValueNotifier<dynamic> notifier,
  @required bool mounted,
  @required dynamic value,
  bool addPostFrameCallBack = false,
  Function onFinish,
  bool shouldHaveListeners = false,
}){

  if (mounted == true){
    // blog('setNotifier : setting to ${value.toString()}');

    if (notifier != null){

      if (value != notifier.value){

        /// ignore: invalid_use_of_protected_member
        if (shouldHaveListeners == false || notifier.hasListeners == true){

          if (addPostFrameCallBack == true){
            WidgetsBinding.instance.addPostFrameCallback((_){
              notifier.value  = value;
              if(onFinish != null){
                onFinish();
              }
            });
          }

          else {
            notifier.value  = value;
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
