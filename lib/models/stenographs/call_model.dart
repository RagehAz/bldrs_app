class CallModel {
  final String callID;
  final String callerID;
  final String slideID;
  final DateTime callTime;
  // -------------------------
  CallModel({
    this.callID,
    this.callerID,
    this.slideID,
    this.callTime,
  });
// -------------------------
Map<String, Object> toMap(){
  return {
    'callID' : callID,
    'callerID' : callerID,
    'slideID' : slideID,
    'callTime' : callTime,
  };
}
// -------------------------
}
