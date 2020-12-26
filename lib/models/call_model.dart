import 'package:flutter/foundation.dart';

class CallModel {
  final String callID;
  final String callerID;
  final String slideID;
  // final DateTime callTime;

  CallModel({
    @required this.callID,
    @required this.callerID,
    @required this.slideID,
    // @required this.callTime,
  });
}
