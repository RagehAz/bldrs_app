enum FlyerState{
  Published,
  UnPublished,
  Deleted,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<FlyerState> flyerStatesList = [
  FlyerState.Published,
  FlyerState.UnPublished,
  FlyerState.Deleted,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
FlyerState decipherFlyerState (int x){
  switch (x){
    case 1:   return  FlyerState.Published;     break;
    case 2:   return  FlyerState.UnPublished;   break;
    case 3:   return  FlyerState.Deleted;       break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherFlyerState (FlyerState x){
  switch (x){
    case FlyerState.Published     :    return  1;  break;
    case FlyerState.UnPublished   :    return  2;  break;
    case FlyerState.Deleted       :    return  3;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
