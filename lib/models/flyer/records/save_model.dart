import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class SaveModel with ChangeNotifier{
  final String userID;
  final String flyerID;
  final List<dynamic> slideIndexes;
  final SaveState saveState;
  final List<DateTime> timeStamps;

  SaveModel({
    this.userID,
    this.flyerID,
    this.slideIndexes,
    this.saveState,
    this.timeStamps,
});
// -----------------------------------------------------------------------------
Map<String, dynamic> toFlyerSaveMap(){
  return {
    'slideIndexes' : slideIndexes,
    'saveState' : cipherSaveState(saveState),
    'timeStamps' : Timers.cipherListOfDateTimes(timeStamps),
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
  static Future<Map<String, dynamic>> cipherSavesModelsToUser(List<SaveModel> saveModels) async {
    /// TASK : we shall save saveModels as this
    /// {
    ///   'userID' : {'slidesIndexes' : [2, 0, 1], 'saveState' : 1, 'timeStamps' : [{'0' : 'save1'}, {'1': 'unsave1'},{'2': 'save2'}] },
    ///   'userID' : {'slidesIndexes' : [2, 1, 0], 'saveState' : 1, 'timeStamps' : [{'0' : 'save1'}, {'1': 'unsave1'},{'2': 'save2'}] }
    /// }
    /// always keeping last index interaction as the slideIndex
    final Map<String, dynamic> _mapOfSaves = {};
    int _index = 0;
    await Future.forEach(saveModels, (saveModel){

      final String _flyerID = saveModels[_index].flyerID;
      final List<dynamic> slideIndexes = saveModels[_index].slideIndexes;
      final int _saveState = cipherSaveState(saveModels[_index].saveState);
      final List<String> _timeStamps = Timers.cipherListOfDateTimes(saveModels[_index].timeStamps);

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
  static List<SaveModel> decipherUserSavesMap(dynamic userSavesMap){
    final List<SaveModel> _savesModels = <SaveModel>[];

    final List<dynamic> _flyersIDs = userSavesMap.keys.toList();
    final List<dynamic> _savesMaps = userSavesMap.values.toList();

    for (int i = 0; i<_flyersIDs.length; i++){
      _savesModels.add(SaveModel(
        // userID: superUserID(), // no need for this
        flyerID: _flyersIDs[i],
        slideIndexes: _savesMaps[i]['slideIndexes'],
        saveState: SaveModel.decipherSaveState(_savesMaps[i]['saveState']),
        timeStamps: Timers.decipherListOfDateTimesStrings(_savesMaps[i]['timeStamps']),
      ));
    }

  return _savesModels;
  }
// -----------------------------------------------------------------------------
  static List<SaveModel> editSavesModels(List<SaveModel> originalSavesModels, String flyerID, int slideIndex){

    final List<SaveModel> _updatedSavesModels = <SaveModel>[];

    /// --- IF FLYER WAS NEVER SAVED
    if (_flyerIsSaved(originalSavesModels, flyerID) == null){

      /// create a new SaveModel
      final SaveModel _newSaveModel = SaveModel(
        flyerID: flyerID,
        slideIndexes: [slideIndex],
        saveState: SaveState.Saved,
        timeStamps: <DateTime>[DateTime.now()],
      );

      /// if userSaveModels is not initialized
      if(originalSavesModels == null || originalSavesModels.length == 0){
        _updatedSavesModels.add(_newSaveModel);
      }
      /// if userSaveModels is initialized and have other entries
      else {
        _updatedSavesModels.addAll(originalSavesModels);
        _updatedSavesModels.add(_newSaveModel);
      }

    }
    // -----------------------------------------------
    /// --- IF FLYER WAS SAVED THEN UNSAVED OR STILL SAVED
    else {

      /// get the SlideModel from the List
      final SaveModel _existingSaveModel = originalSavesModels.singleWhere((sm) => sm.flyerID == flyerID, orElse: () => null);

      /// TASK : check if _existingSaveModel = null, wtf will happen

      /// overwrite slideIndex with the new one, add new timeStamp, and change state to saved
      final SaveModel _updatedSaveModel = new SaveModel(
        flyerID: flyerID,
        slideIndexes: [...(_existingSaveModel.slideIndexes), slideIndex],
        saveState: _existingSaveModel.saveState == SaveState.Saved ? SaveState.UnSaved : SaveState.Saved,
        timeStamps: <DateTime>[...(_existingSaveModel.timeStamps), DateTime.now()],
      );

      /// update the List with the new Model
      final int _existingSaveModelIndex = originalSavesModels.indexWhere((sm) => sm.flyerID == flyerID);

      _updatedSavesModels.addAll(originalSavesModels);
      _updatedSavesModels.removeAt(_existingSaveModelIndex);
      _updatedSavesModels.insert(_existingSaveModelIndex, _updatedSaveModel);
    }
    // -----------------------------------------------

    return _updatedSavesModels;
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherSavedIDsList(List<String> savedIDs) {
    /// TASK : we shall saved Flyers IDs stored like this
    /// {
    ///   'flyerID' : true,
    ///   'flyerID' : true,
    /// }
    final Map<String, dynamic> _savedIDsMap = TextMod.getValueAndTrueMap(savedIDs);
    return _savedIDsMap;
  }
// -----------------------------------------------------------------------------
  static List<String> decipherSavedIDsMap(Map<String, dynamic> savedFlyersMap){
    final List<dynamic> _flyersIDs = TextMod.getValuesFromValueAndTrueMap(savedFlyersMap);
    return _flyersIDs;
  }
// -----------------------------------------------------------------------------
  static bool _flyerWasSavedOnce(List<SaveModel> originalSavesModels, String flyerID){
    bool _flyerWasSavedOnce;

    /// if user's saves list is null or empty
    if (originalSavesModels == null || originalSavesModels.length == 0){
      _flyerWasSavedOnce = false;
    } else {
      /// so user's saves list have some save models
      for (int i = originalSavesModels.length - 1; i >= 0; i--){

        if (originalSavesModels[i].flyerID == flyerID){
          /// we found a saveModel for this flyerID
          _flyerWasSavedOnce = true;
          break;
        } else {
          /// we didn't find this flyer in the list
          _flyerWasSavedOnce = false;
        }
      }

    }

    return _flyerWasSavedOnce;
  }
// -----------------------------------------------------------------------------
  static bool _flyerIsSaved(List<SaveModel> originalSavesModels, String flyerID){
    bool _flyerIsSaved;

    if (_flyerWasSavedOnce(originalSavesModels, flyerID) == true){

      final SaveModel _thisFlyersSaveModel = originalSavesModels.singleWhere((saveModel) => saveModel.flyerID == flyerID, orElse: () => null);

      if (_thisFlyersSaveModel.saveState == SaveState.Saved){
        _flyerIsSaved = true; // is saved
      } else {
        _flyerIsSaved = false; // was saved once but now its not
      }

    } else {
      _flyerIsSaved = null; // was never saved
    }

    return _flyerIsSaved;
  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
enum SaveState{
  Saved,
  UnSaved,
}
// -----------------------------------------------------------------------------
