// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class ShareModel{
  final String shareID;
  final String userID;
  final String slideID;
  final DateTime shareTime;
  final String sharedTo;
// ###############################
  ShareModel({
  this.shareID,
  this.userID,
  this.slideID,
  this.shareTime,
  this.sharedTo,
  });
// ###############################
  Map<String, Object> toMap(){
    return {
      'shareID' : shareID,
      'userID' : userID,
      'slideID' : slideID,
      'shareTime' : shareTime,
      'sharedTo' : sharedTo,
    };
  }
// ###############################
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x