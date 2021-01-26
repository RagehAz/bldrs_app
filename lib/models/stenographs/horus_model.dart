// ###############################
class HorusModel{
  final String horusID;
  final String userID;
  final String slideID;
  final DateTime viewTime;
// ###############################
  HorusModel({
  this.horusID,
  this.userID,
  this.slideID,
  this.viewTime,
});
// ###############################
Map<String, Object> toMap(){
  return {
    'horusID' : horusID,
    'userID' : userID,
    'slideID' : slideID,
    'viewTime' : viewTime,
  };
}
// ###############################
}

