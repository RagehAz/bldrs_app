import 'package:flutter/material.dart';
// ----------------------------------------------------------------------------
bool connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){
  return
    snapshot.connectionState == ConnectionState.waiting? true : false;
}
// ----------------------------------------------------------------------------
