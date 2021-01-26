// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class FollowModel{
   final String followID;
   final String userID;
   final String bzID;
   final DateTime timeStamp;
   final FollowState followState;
// ###############################
   FollowModel({
     this.followID,
     this.userID,
     this.bzID,
     this.timeStamp,
     this.followState,
 });
// ###############################
   Map<String, Object> toMap(){
     return {
       'followID': followID,
       'userID': userID,
       'bzID': bzID,
       'timeStamp': timeStamp,
       'followState': cipherFollowState(followState),
     };
   }
// ###############################
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum FollowState {
  accepted,
  declined,
  pending,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
FollowState decipherFollowState (int followState){
  switch (followState){
    case 1:   return  FollowState.accepted;     break;
    case 2:   return  FollowState.declined;     break;
    case 3:   return  FollowState.pending;      break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherFollowState (FollowState followState){
  switch (followState){
    case FollowState.accepted    :    return  1;  break;
    case FollowState.declined    :    return  2;  break;
    case FollowState.pending     :    return  3;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


