enum BldrsSection{
  Home,
  RealEstate,
  Construction,
  Supplies,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<BldrsSection> bldrsSectionsList = [
  BldrsSection.RealEstate,
  BldrsSection.Construction,
  BldrsSection.Supplies,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
BldrsSection decipherBldrsSection (int x){
  switch (x){
    case 1:   return   BldrsSection.Home;           break;
    case 2:   return   BldrsSection.RealEstate;     break;
    case 3:   return   BldrsSection.Construction;   break;
    case 4:   return   BldrsSection.Supplies;       break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherBldrsSection (BldrsSection x){
  switch (x){
    case BldrsSection.Home:         return 1; break;
    case BldrsSection.RealEstate:   return 2; break;
    case BldrsSection.Construction: return 3; break ;
    case BldrsSection.Supplies:     return 4; break ;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
