// -----------------------------------------------------------------------------
import 'package:bldrs/models/bz_model.dart';

enum Section{
  Home,
  RealEstate,
  Construction,
  Supplies,
}
// -----------------------------------------------------------------------------
class SectionClass{

  static List<Section> SectionsList = <Section>[
    Section.RealEstate,
    Section.Construction,
    Section.Supplies,
  ];
// -----------------------------------------------------------------------------
  static Section decipherSection (int x){
    switch (x){
      case 1:   return   Section.Home;           break;
      case 2:   return   Section.RealEstate;     break;
      case 3:   return   Section.Construction;   break;
      case 4:   return   Section.Supplies;       break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherSection (Section x){
    switch (x){
      case Section.Home:         return 1; break;
      case Section.RealEstate:   return 2; break;
      case Section.Construction: return 3; break ;
      case Section.Supplies:     return 4; break ;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static Section getSectionByBzType(BzType bzType){
    switch (bzType){
      case BzType.Developer:    return   Section.RealEstate;     break;
      case BzType.Broker:       return   Section.RealEstate;     break;
      case BzType.Designer:     return   Section.Construction;   break;
      case BzType.Contractor:   return   Section.Construction;   break;
      case BzType.Artisan:      return   Section.Construction;   break;
      case BzType.Manufacturer: return   Section.Supplies;       break;
      case BzType.Supplier:     return   Section.Supplies;       break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
}
