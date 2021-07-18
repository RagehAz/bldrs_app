import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class FollowModel{
   final List<DateTime> timeStamps;
   final FollowState followState;

   FollowModel({
     this.timeStamps,
     this.followState,
 });
// -----------------------------------------------------------------------------
   Map<String, Object> toMap(){
     return {
       'timeStamps': cipherListOfDateTimes(timeStamps),
       'followState': cipherFollowState(followState),
     };
   }
// -----------------------------------------------------------------------------
  static FollowState decipherFollowState (int followState){
    switch (followState){
      case 1:   return  FollowState.following;     break;
      case 2:   return  FollowState.unfollowing;     break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherFollowState (FollowState followState){
    switch (followState){
      case FollowState.following      :    return  1;  break;
      case FollowState.unfollowing    :    return  2;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherUserFollows (List<String> followedBzIDs){
     Map<String, dynamic> _userFollowsMap = TextMod.getValueAndTrueMap(followedBzIDs);
     return _userFollowsMap;
  }
// -----------------------------------------------------------------------------
  static List<String> decipherUserFollowsMap (Map<String, dynamic> map){
     List<dynamic> _followedBzzIds = TextMod.getValuesFromValueAndTrueMap(map);
     return _followedBzzIds;
  }
// -----------------------------------------------------------------------------
  static FollowModel decipherBzFollowMap(Map<String, dynamic> map){
     return FollowModel(
       timeStamps: decipherListOfDateTimesStrings(map['timeStamps']),
       followState: decipherFollowState(map['followState']),
     );
  }
// -----------------------------------------------------------------------------
  static List<String> editFollows(List<String> existingFollowsList, String bzID){
     List<String> _updatedBzzFollows = new List();

     /// --- IF BZ IS NOT FOLLOWED
     if (existingFollowsList == null || existingFollowsList.contains(bzID) == false){

       /// add bzID to the follows list
       _updatedBzzFollows = existingFollowsList == null ? <String>[bzID] : <String>[...existingFollowsList, bzID];

     }
     // -----------------------------------------------
     /// --- IF BZ IS FOLLOWED
        else {

          /// REMOVE BZID FROM THE LIST
       int _bzIDIndex = existingFollowsList.indexWhere((id) => id == bzID);
       existingFollowsList.removeAt(_bzIDIndex);
       _updatedBzzFollows = <String>[...existingFollowsList];
        }
        // -----------------------------------------------

     return _updatedBzzFollows;
   }
// -----------------------------------------------------------------------------
  static FollowModel editFollowModel(FollowModel follow){
    /// --- IF BZ WAS NEVER FOLLOWED
    if (follow == null){

      /// create a new follow model
      return FollowModel(
        timeStamps: [DateTime.now()],
        followState: FollowState.following,
      );

    }
    // -----------------------------------------------
    /// --- IF BZ IS FOLLOWED
    else if (follow.followState == FollowState.following){

      /// add new timeStamp and unfollow the bz
      return FollowModel(
        timeStamps: <DateTime>[...follow.timeStamps, DateTime.now()],
        followState: FollowState.unfollowing,
      );

    }
    // -----------------------------------------------
    /// --- IF BZ IN UNFOLLOWED
    else {

      /// add new timeStamp and unfollow the bz
      return FollowModel(
        timeStamps: <DateTime>[...follow.timeStamps, DateTime.now()],
        followState: FollowState.following,
      );

    }
  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
enum FollowState {
  following,
  unfollowing,
}
// -----------------------------------------------------------------------------
class FollowedBzz {
  final String userID;
  final List<TinyBz> followedBz;

  FollowedBzz({
    @required this.userID,
    @required this.followedBz,
  });
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'followedBz' : TinyBz.cipherTinyBzzModels(followedBz),
    };
  }

  // -----------------------------------------------------------------------------
  static FollowedBzz decipherFollowedBzzMaps(Map<String, dynamic> map){
    return FollowedBzz(
      userID : map['userID'],
      followedBz : map['followedBz'],
    );
  }

}

