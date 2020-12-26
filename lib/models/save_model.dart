import 'package:flutter/foundation.dart';

enum SaveState{
  Saved,
  UnSaved,
}

class SaveModel with ChangeNotifier{
  final String saveID;
  final String userID;
  final String slideID;
  final SaveState saveState;
  // final DateTime saveTime;
  // final DateTime updateTime;

  SaveModel({
    @required this.saveID,
    @required this.userID,
    @required this.slideID,
    @required this.saveState,
  // @required this.saveTime,
    // required this.updateTime,
});
}
