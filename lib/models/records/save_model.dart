import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class SaveModel with ChangeNotifier{
  final String saveID;
  final String userID;
  final String slideID;
  final SaveState saveState;
  final DateTime saveTime;
  final DateTime updateTime;
// ###############################
  SaveModel({
    this.saveID,
    this.userID,
    this.slideID,
    this.saveState,
    this.saveTime,
    this.updateTime,
});
// ###############################
Map<String, Object> toMap(){
  return {
    'saveID' : saveID,
    'userID' : userID,
    'slideID' : slideID,
    'saveState' : cipherSaveState(saveState),
    'saveTime' : cipherDateTimeToString(saveTime),
    'updateTime' : cipherDateTimeToString(updateTime),
  };
}
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum SaveState{
  Saved,
  UnSaved,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
SaveState decipherSaveState (int saveState){
  switch (saveState){
    case 1:   return  SaveState.Saved;       break;
    case 2:   return  SaveState.UnSaved;     break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherSaveState (SaveState saveState){
  switch (saveState){
    case SaveState.Saved      :    return  1;  break;
    case SaveState.UnSaved    :    return  2;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class SavedFlyers {
  final String userID;
  final List<dynamic> savedFlyersIDs;

  SavedFlyers({
    @required this.userID,
    @required this.savedFlyersIDs,
  });

  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'savedFlyersIDs' : savedFlyersIDs,
    };
  }

  // -----------------------------------------------------------------------------
  static SavedFlyers decipherSavedFlyersMaps(Map<String, dynamic> map){
    return SavedFlyers(
        userID: map['userID'],
        savedFlyersIDs: map['savedFlyersIDs']
    );
  }


}
// -----------------------------------------------------------------------------

