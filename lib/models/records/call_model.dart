class CallModel {
  final String callID;
  final String callerID;
  final String recieverID;
  final RecieverType recieverType;
  final String slideID;
  final DateTime callTime;
  // -------------------------
  CallModel({
    this.callID,
    this.callerID,
    this.recieverID,
    this.recieverType,
    this.slideID,
    this.callTime,
  });
// -------------------------
Map<String, Object> toMap(){
  return {
    'callID' : callID,
    'callerID' : callerID,
    'recieverID' : recieverID,
    'recieverType' : cipherRecieverType(recieverType),
    'slideID' : slideID,
    'callTime' : callTime,
  };
}
// -------------------------
}
enum RecieverType{
  bz,
  author,
}
// -------------------------
RecieverType decipherRecieverType(int recieverType) {
  switch (recieverType) {
    case 1: return RecieverType.bz;     break;
    case 2: return RecieverType.author; break;
    default : return null;
  }
}
// -------------------------
int cipherRecieverType(RecieverType recieverType){
  switch (recieverType) {
    case RecieverType.bz:     return 1;   break;
    case RecieverType.author: return 2;   break;
    default : return null;
  }
}
// -------------------------
