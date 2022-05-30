import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
/// this page has all functions that are related to streams checking

  bool _connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){

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
  bool _connectionHasData(AsyncSnapshot<dynamic> snapshot){
    return snapshot?.hasData ;
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  bool connectionIsLoading(AsyncSnapshot<dynamic> snapshot){
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
