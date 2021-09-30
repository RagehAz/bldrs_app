import 'package:bldrs/controllers/drafters/timerz.dart';

class CallModel {
  final List<dynamic> slidesIndexes;
  final List<DateTime> timeStamps;

  const CallModel({
    this.slidesIndexes,
    this.timeStamps,
  });
// -----------------------------------------------------------------------------
  Map<String, Object> toMap(){
    return {
      'slidesIndexes' : slidesIndexes,
      'timeStamps' : Timers.cipherListOfDateTimes(timeStamps),
    };
  }
// -----------------------------------------------------------------------------
  static CallModel decipherCallMap(Map<String, dynamic> map){
    return CallModel(
      slidesIndexes: map['slidesIndexes'],
      timeStamps: Timers.decipherListOfDateTimesStrings(map['timeStamps']),
    );
  }
// -----------------------------------------------------------------------------
  static CallModel editCallModel(CallModel existingCallModel, int slideIndex){
    /// --- IF BZ WAS NEVER CALLED
    if (existingCallModel == null){

      /// create a new call model
      return CallModel(
        timeStamps: <DateTime>[DateTime.now()],
        slidesIndexes: <int>[slideIndex],
      );

    }
    // -----------------------------------------------
    /// --- IF BZ WAS CALLED BEFORE
    else {

      /// add new timeStamp and new slide index
      return CallModel(
        timeStamps: <DateTime>[...existingCallModel.timeStamps, DateTime.now()],
        slidesIndexes: <int>[...existingCallModel.slidesIndexes, slideIndex],
      );

    }
    // -----------------------------------------------
  }
// -----------------------------------------------------------------------------
}