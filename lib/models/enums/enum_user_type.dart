enum UserType {
  NormalUser,
  SearchingUser,
  ConstructingUser,
  PlanningUser,
  BuildingUser,
  SellingUser,
  BzAuthor,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<UserType> userTypesList = [
  UserType.NormalUser,
  UserType.SearchingUser,
  UserType.ConstructingUser,
  UserType.PlanningUser,
  UserType.BuildingUser,
  UserType.SellingUser,
  UserType.BzAuthor,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
UserType decipherUserType (int x){
  switch (x){
    case 1:   return   UserType.NormalUser;         break;
    case 2:   return   UserType.SearchingUser;      break;
    case 3:   return   UserType.ConstructingUser;   break;
    case 4:   return   UserType.PlanningUser;       break;
    case 5:   return   UserType.BuildingUser;       break;
    case 6:   return   UserType.SellingUser;        break;
    case 7:   return   UserType.BzAuthor;           break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherUserType (UserType x){
  switch (x){
    case UserType.NormalUser       :  return 1; break ;
    case UserType.SearchingUser    :  return 2; break ;
    case UserType.ConstructingUser :  return 3; break ;
    case UserType.PlanningUser     :  return 4; break ;
    case UserType.BuildingUser     :  return 5; break ;
    case UserType.SellingUser      :  return 6; break ;
    case UserType.BzAuthor         :  return 7; break ;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
