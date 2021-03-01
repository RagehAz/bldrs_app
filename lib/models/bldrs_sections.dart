// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
import 'package:bldrs/models/bz_model.dart';

enum BldrsSection{
  Home,
  RealEstate,
  Construction,
  Supplies,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<BldrsSection> bldrsSectionsList = <BldrsSection>[
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
BldrsSection getBldrsSectionByBzType(BzType bzType){
  switch (bzType){
    case BzType.Developer:    return   BldrsSection.RealEstate;     break;
    case BzType.Broker:       return   BldrsSection.RealEstate;     break;
    case BzType.Designer:     return   BldrsSection.Construction;   break;
    case BzType.Contractor:   return   BldrsSection.Construction;   break;
    case BzType.Artisan:      return   BldrsSection.Construction;   break;
    case BzType.Manufacturer: return   BldrsSection.Supplies;       break;
    case BzType.Supplier:     return   BldrsSection.Supplies;       break;
    default : return   null;
}
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
