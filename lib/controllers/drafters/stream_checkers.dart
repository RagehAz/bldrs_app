import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
/// this page has all functions that are related to streams checking

abstract class StreamChecker{
// -----------------------------------------------------------------------------
  static bool _connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){

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
//   static bool _connectionHasNoData(AsyncSnapshot<dynamic> snapshot){
//     return
//       snapshot.hasData == false ? true : false;
//   }
// -----------------------------------------------------------------------------
  static bool valueIsLoading(dynamic value){

    bool _isLoading;

    if (value == null){
      _isLoading = true;
    }

    else {
      _isLoading = false;
    }

    return _isLoading;
  }
// -----------------------------------------------------------------------------
  static bool connectionIsLoading(AsyncSnapshot<dynamic> snapshot){
    bool _isLoading;

    if (
    // _connectionHasNoData(snapshot) == true
    //     ||
    _connectionIsWaiting(snapshot) == true
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
}




