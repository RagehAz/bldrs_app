import 'package:bldrs/controllers/drafters/timerz.dart';

class CallModel {
  final List<dynamic> slidesIndexes;
  final List<DateTime> timeStamps;

  CallModel({
    this.slidesIndexes,
    this.timeStamps,
  });
// -----------------------------------------------------------------------------
  Map<String, Object> toMap(){
    return {
      'slidesIndexes' : slidesIndexes,
      'timeStamps' : cipherListOfDateTimes(timeStamps),
    };
  }
// -----------------------------------------------------------------------------
  static CallModel decipherCallMap(Map<String, dynamic> map){
    return CallModel(
      slidesIndexes: map['slidesIndexes'],
      timeStamps: decipherListOfDateTimesStrings(map['timeStamps']),
    );
  }
// -----------------------------------------------------------------------------
  static CallModel editCallModel(CallModel existingCallModel, int slideIndex){
    /// --- IF BZ WAS NEVER CALLED
    if (existingCallModel == null){

      /// create a new call model
      return CallModel(
        timeStamps: [DateTime.now()],
        slidesIndexes: [slideIndex],
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
  RecieverType decipherRecieverType(int recieverType) {
    switch (recieverType) {
      case 1: return RecieverType.bz;     break;
      case 2: return RecieverType.author; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  int cipherRecieverType(RecieverType recieverType){
    switch (recieverType) {
      case RecieverType.bz:     return 1;   break;
      case RecieverType.author: return 2;   break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
}

enum RecieverType{
  bz,
  author,
}
