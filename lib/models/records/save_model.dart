import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class SaveModel with ChangeNotifier{
  final String flyerID;
  final List<int> slideIndexes;
  final SaveState saveState;
  final List<DateTime> timeStamps;

  SaveModel({
    this.flyerID,
    this.slideIndexes,
    this.saveState,
    this.timeStamps,
});
// -----------------------------------------------------------------------------
Map<String, dynamic> toMap(){
  return {
    'flyerID' : flyerID,
    'slideIndexes' : slideIndexes,
    'saveState' : cipherSaveState(saveState),
    'timeStamps' : cipherListOfDateTimes(timeStamps),
  };
}
// -----------------------------------------------------------------------------
  static SaveState decipherSaveState (int saveState){
    switch (saveState){
      case 1:   return  SaveState.Saved;       break;
      case 2:   return  SaveState.UnSaved;     break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherSaveState (SaveState saveState){
    switch (saveState){
      case SaveState.Saved      :    return  1;  break;
      case SaveState.UnSaved    :    return  2;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static Future<Map<String, dynamic>> cipherSavesModels(List<SaveModel> saveModels) async {
    /// we shall save saveModels as this
    /// {
    ///   'flyerID' : {'slideIndex' : 2, 'saveState' : 0, 'timeStamps' : [{'0' : 'save1'}, {'1': 'unsave1'},{'2': 'save2'}] },
    ///   'flyerID' : {'slideIndex' : 2, 'saveState' : 0, 'timeStamps' : [{'0' : 'save1'}, {'1': 'unsave1'},{'2': 'save2'}] }
    /// }
    /// always keeping last index interaction as the slideIndex
    Map<String, dynamic> _mapOfSaves = {};
    int _index = 0;
    await Future.forEach(saveModels, (saveModel){

      String _flyerID = saveModels[_index].flyerID;
      List<int> slideIndexes = saveModels[_index].slideIndexes;
      int _saveState = cipherSaveState(saveModels[_index].saveState);
      List<String> _timeStamps = cipherListOfDateTimes(saveModels[_index].timeStamps);

      _mapOfSaves.addAll({

        _flyerID : {
          'slideIndexes' : slideIndexes,
          'saveState' : _saveState,
          'timeStamps' : _timeStamps,
        },

      });

      _index++;

    });

    return _mapOfSaves;
  }
// -----------------------------------------------------------------------------
  static SaveModel decipherSaveMap(Map<String, dynamic> map){
  return SaveModel(
    slideIndexes: map['slideIndexes'],
    saveState: decipherSaveState(map['saveState']),
    timeStamps: decipherListOfDateTimesStrings(map['timeStamps']),
  );
  }
// -----------------------------------------------------------------------------
  static List<SaveModel> decipherSavesMaps(List<dynamic> maps){
  List<SaveModel> _savesModel = new List();

  for (var map in maps){
    _savesModel.add(decipherSaveMap(map));
  }

  return _savesModel;
  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
enum SaveState{
  Saved,
  UnSaved,
}
// -----------------------------------------------------------------------------
