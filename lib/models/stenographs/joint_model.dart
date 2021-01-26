// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class JointModel {
  final String jointID;
  final String requesterID;
  final DateTime requestTime;
  final String responderID;
  final DateTime responseTime;
  final JointState jointState;
// ###############################
  JointModel({
    this.jointID,
    this.requesterID,
    this.requestTime,
    this.responderID,
    this.responseTime,
    this.jointState,
});
// ###############################
  Map<String, Object> toMap(){
    return {
      'jointID' : jointID,
      'requesterID' : requesterID,
      'requestTime' : requestTime,
      'responderID' : responderID,
      'responseTime' : responseTime,
      'jointState' : cipherJointState(jointState),
  };
  }
// ###############################
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum JointState {
  Approved,
  Rejected,
  Seen,
  UnSeen,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<JointState> jointStatesList = [
  JointState.Approved,
  JointState.Rejected,
  JointState.Seen,
  JointState.UnSeen,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
JointState decipherJointState (int jointState){
  switch (jointState){
    case 1:   return  JointState.Approved;   break;
    case 2:   return  JointState.Rejected;   break;
    case 3:   return  JointState.Seen;       break;
    case 4:   return  JointState.UnSeen;     break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherJointState (JointState jointState){
  switch (jointState){
    case JointState.Approved:    return  1;  break;
    case JointState.Rejected:    return  2;  break;
    case JointState.Seen    :    return  3;  break;
    case JointState.UnSeen  :    return  4;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
