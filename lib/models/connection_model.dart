import 'package:flutter/foundation.dart';

import 'enums/enum_connection_state.dart';

class ConnectionModel {
  final String connectionID;
  final String requesterID;
  // final DateTime requestTime;
  final ConnectionState connectionState;
  final String responderID;
  // final DateTime responseTime;

  ConnectionModel({
    @required this.connectionID,
    @required this.requesterID,
    // @required this.requestTime,
    @required this.connectionState,
    @required this.responderID,
    // @required this.responseTime,
});
}
