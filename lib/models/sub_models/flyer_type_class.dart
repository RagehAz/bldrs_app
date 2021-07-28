// -----------------------------------------------------------------------------
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';

enum FlyerType {
  Property,
  Design,
  Project,
  Craft,
  Product,
  Equipment,
  Non,
}
// -----------------------------------------------------------------------------

class FlyerTypeClass {
// -----------------------------------------------------------------------------
  static FlyerType getFlyerTypeBySection({Section section}){

    FlyerType _flyersTypes =
    section == Section.NewProperties ? FlyerType.Property :
    section == Section.ResaleProperties ? FlyerType.Property :
    section == Section.RentalProperties ? FlyerType.Property :
    section == Section.Designs ? FlyerType.Design :
    section == Section.Projects ? FlyerType.Project :
    section == Section.Crafts ? FlyerType.Craft :
    section == Section.Products ? FlyerType.Product :
    section == Section.Equipment ? FlyerType.Equipment :
    null;

    return _flyersTypes;
  }
// -----------------------------------------------------------------------------
  static List<FlyerType> flyerTypesList = <FlyerType>[
    FlyerType.Property,
    FlyerType.Design,
    FlyerType.Product,
    FlyerType.Project,
    FlyerType.Craft,
    FlyerType.Equipment,
    // FlyerType.General,
  ];
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static FlyerType decipherFlyerType (int x){
    switch (x){
      case 1:   return  FlyerType.Property;     break;
      case 2:   return  FlyerType.Design;       break;
      case 3:   return  FlyerType.Product;      break;
      case 4:   return  FlyerType.Project;      break;
      case 5:   return  FlyerType.Craft;        break;
      case 6:   return  FlyerType.Equipment;    break;
    // case 7:   return  FlyerType.General;      break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherFlyerType (FlyerType x){
    switch (x){
      case FlyerType.Property    :    return  1;  break;
      case FlyerType.Design      :    return  2;  break;
      case FlyerType.Product     :    return  3;  break;
      case FlyerType.Project     :    return  4;  break;
      case FlyerType.Craft       :    return  5;  break;
      case FlyerType.Equipment   :    return  6;  break;
    // case FlyerType.General     :    return  7;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static FlyerType concludeFlyerType(BzType bzType){
    switch (bzType){
      case BzType.Developer    :   return FlyerType.Property;   break;
      case BzType.Broker       :   return FlyerType.Property;   break;
      case BzType.Designer     :   return FlyerType.Design;     break;
      case BzType.Contractor   :   return FlyerType.Project;    break;
      case BzType.Artisan      :   return FlyerType.Craft;      break;
      case BzType.Manufacturer :   return FlyerType.Product;    break; // product or equipment for author to choose while creating flyer
      case BzType.Supplier     :   return FlyerType.Product;    break; // product or equipment for author to choose while creating flyer
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
}