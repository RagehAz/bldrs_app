import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
/// this page has all functions that are related to streams checking

class StreamChecker{
// -----------------------------------------------------------------------------
  static bool _connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){
    return
      snapshot.connectionState == ConnectionState.waiting? true : false;
  }
// -----------------------------------------------------------------------------
//   static bool _connectionHasNoData(AsyncSnapshot<dynamic> snapshot){
//     return
//       snapshot.hasData == false ? true : false;
//   }
// -----------------------------------------------------------------------------
  static bool valueIsLoading(dynamic value){
    return
      value == null ? true : false;
  }
// -----------------------------------------------------------------------------
  static bool connectionIsLoading(AsyncSnapshot<dynamic> snapshot){
    bool _isLoading =
    // _connectionHasNoData(snapshot) == true
    //     ||
    _connectionIsWaiting(snapshot) == true
    //     ||
    // snapshot.error == null
        ?
    true : false;

    return _isLoading;
  }
// -----------------------------------------------------------------------------
}




