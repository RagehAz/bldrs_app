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
