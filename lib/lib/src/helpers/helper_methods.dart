import 'package:flutter/material.dart';

class HelperMethods {
  // -----------------------------------------------------------------------------

  const HelperMethods._();

  // -----------------------------------------------------------------------------

  /// VALUE NOTIFIER SETTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static void setNotifier({
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
}
