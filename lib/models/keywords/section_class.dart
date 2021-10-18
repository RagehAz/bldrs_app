import 'package:bldrs/models/bz/bz_model.dart';

/// TAXONOMIC HIERARCHY
/// Section / group / keyword

enum Section{
  All,
  NewProperties,
  ResaleProperties,
  RentalProperties,
  Designs,
  Projects,
  Crafts,
  Products,
  Equipment,
}
// -----------------------------------------------------------------------------
abstract class SectionClass{

  static const List<Section> SectionsList = const <Section>[
    Section.NewProperties,
    Section.ResaleProperties,
    Section.RentalProperties,
    Section.Designs,
    Section.Projects,
    Section.Crafts,
    Section.Products,
    Section.Equipment,
  ];
// -----------------------------------------------------------------------------
  static Section decipherSection (int x){
    switch (x){
      case 1:   return   Section.NewProperties;       break;
      case 2:   return   Section.ResaleProperties;    break;
      case 3:   return   Section.RentalProperties;    break;
      case 4:   return   Section.Designs;             break;
      case 5:   return   Section.Projects;            break;
      case 6:   return   Section.Crafts;              break;
      case 7:   return   Section.Products;            break;
      case 8:   return   Section.Equipment;           break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherSection (Section x){
    switch (x){
      case Section.NewProperties :    return 1; break;
      case Section.ResaleProperties : return 2; break;
      case Section.RentalProperties : return 3; break;
      case Section.Designs :          return 4; break;
      case Section.Projects :         return 5; break;
      case Section.Crafts :           return 6; break;
      case Section.Products :         return 7; break;
      case Section.Equipment :        return 8; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static Section getSectionByBzType(BzType bzType){
    switch (bzType){
      case BzType.developer:    return   Section.NewProperties;     break;
      case BzType.broker:       return   Section.ResaleProperties;  break;
      case BzType.designer:     return   Section.Designs;           break;
      case BzType.contractor:   return   Section.Projects;          break;
      case BzType.artisan:      return   Section.Crafts;            break;
      case BzType.manufacturer: return   Section.Products;          break;
      case BzType.supplier:     return   Section.Products;          break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
}
