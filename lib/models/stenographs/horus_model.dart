// ###############################
class SaveModel{
  final String saveID;
  final String userID;
  final String slideID;
  final DateTime viewTime;
// ###############################
  SaveModel({
  this.saveID,
  this.userID,
  this.slideID,
  this.viewTime,
});
// ###############################
Map<String, Object> toMap(){
  return {
    'saveID' : saveID,
    'userID' : userID,
    'slideID' : slideID,
    'viewTime' : viewTime,
  };
}
// ###############################
}

