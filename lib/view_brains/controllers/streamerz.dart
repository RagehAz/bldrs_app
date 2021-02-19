import 'package:flutter/material.dart';
// ----------------------------------------------------------------------------
/// this page has all functions that are related to streams & device connectivity
// ----------------------------------------------------------------------------
bool connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){
  return
    snapshot.connectionState == ConnectionState.waiting? true : false;
}
// ----------------------------------------------------------------------------
