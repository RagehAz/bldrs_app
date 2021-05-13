// -----------------------------------------------------------------------------
class ViewModel{
  final String viewID;
  final String userID;
  final String slideID;
  final DateTime viewTime;
// -----------------------------------------------------------------------------
  ViewModel({
  this.viewID,
  this.userID,
  this.slideID,
  this.viewTime,
});
// -----------------------------------------------------------------------------
Map<String, Object> toMap(){
  return {
    'saveID' : viewID,
    'userID' : userID,
    'slideID' : slideID,
    'viewTime' : viewTime,
  };
}
// -----------------------------------------------------------------------------
}

