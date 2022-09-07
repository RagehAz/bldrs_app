import 'dart:async';

import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class Streamer {
  // -----------------------------------------------------------------------------

  const Streamer();

  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){

    /// this page has all functions that are related to streams checking
    bool _isWaiting;

    if (snapshot.connectionState == ConnectionState.waiting){
      _isWaiting = true;
    }
    else {
      _isWaiting = false;
    }

    return _isWaiting;
  }
  // -----------------------------------------------------------------------------
  /*
  bool _connectionHasData(AsyncSnapshot<dynamic> snapshot){
    return snapshot?.hasData ;
  }
 */
  // --------------------
  /*
  bool valueIsLoading(dynamic value){

    bool _isLoading;

    if (value == null){
      _isLoading = true;
    }

    else {
      _isLoading = false;
    }

    return _isLoading;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool connectionIsLoading(AsyncSnapshot<dynamic> snapshot){
    bool _isLoading;

    if (
    _connectionIsWaiting(snapshot) == true
    //     ||
    // _connectionHasData(snapshot) == false
    //     ||
    // snapshot.error == null
    ){
      _isLoading = true;
    }
    else {
      _isLoading = false;
    }

    return _isLoading;
  }
  // -----------------------------------------------------------------------------

  /// STREAM SUBSCRIPTION

  // --------------------
  static Future<void> disposeStreamSubscriptions(List<StreamSubscription> subs) async {

    if (Mapper.checkCanLoopList(subs) == true){

      for (final StreamSubscription sub in subs){

        if (sub != null){
          await sub.cancel();
        }

      }

    }

  }
  // -----------------------------------------------------------------------------
}
