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
  following,
  unfollowing,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
FollowState decipherFollowState (int followState){
  switch (followState){
    case 1:   return  FollowState.following;     break;
    case 2:   return  FollowState.unfollowing;     break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherFollowState (FollowState followState){
  switch (followState){
    case FollowState.following      :    return  1;  break;
    case FollowState.unfollowing    :    return  2;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


