import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';

enum FlyerType {
  newProperty,
  resaleProperty,
  rentalProperty,
  design,
  project,
  craft,
  product,
  equipment,
  non,
}
// -----------------------------------------------------------------------------

class FlyerTypeClass {
// -----------------------------------------------------------------------------
  static FlyerType getFlyerTypeBySection({Section section}){

    FlyerType _flyersTypes =
    section == Section.NewProperties ? FlyerType.rentalProperty :
    section == Section.ResaleProperties ? FlyerType.rentalProperty :
    section == Section.RentalProperties ? FlyerType.rentalProperty :
    section == Section.Designs ? FlyerType.design :
    section == Section.Projects ? FlyerType.project :
    section == Section.Crafts ? FlyerType.craft :
    section == Section.Products ? FlyerType.product :
    section == Section.Equipment ? FlyerType.equipment :
    null;

    return _flyersTypes;
  }
// -----------------------------------------------------------------------------
  static List<FlyerType> flyerTypesList = <FlyerType>[
    FlyerType.rentalProperty,
    FlyerType.design,
    FlyerType.product,
    FlyerType.project,
    FlyerType.craft,
    FlyerType.equipment,
    // FlyerType.General,
  ];
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static FlyerType decipherFlyerType (int x){
    switch (x){
      case 1:   return  FlyerType.rentalProperty;     break;
      case 2:   return  FlyerType.design;             break;
      case 3:   return  FlyerType.product;            break;
      case 4:   return  FlyerType.project;            break;
      case 5:   return  FlyerType.craft;              break;
      case 6:   return  FlyerType.equipment;          break;

      case 7:   return  FlyerType.newProperty;        break;
      case 8:   return  FlyerType.resaleProperty;     break;

      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherFlyerType (FlyerType x){
    switch (x){
      case FlyerType.rentalProperty   :    return  1;  break;
      case FlyerType.design           :    return  2;  break;
      case FlyerType.product          :    return  3;  break;
      case FlyerType.project          :    return  4;  break;
      case FlyerType.craft            :    return  5;  break;
      case FlyerType.equipment        :    return  6;  break;

      case FlyerType.newProperty      :    return  7;  break;
      case FlyerType.resaleProperty   :    return  8;  break;

      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static FlyerType concludeFlyerType(BzType bzType){
    switch (bzType){
      case BzType.Developer    :   return FlyerType.rentalProperty;   break;
      case BzType.Broker       :   return FlyerType.rentalProperty;   break;
      case BzType.Designer     :   return FlyerType.design;     break;
      case BzType.Contractor   :   return FlyerType.project;    break;
      case BzType.Artisan      :   return FlyerType.craft;      break;
      case BzType.Manufacturer :   return FlyerType.product;    break; // product or equipment for author to choose while creating flyer
      case BzType.Supplier     :   return FlyerType.product;    break; // product or equipment for author to choose while creating flyer
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static List<FlyerType> concludePossibleFlyerTypesForBz({BzType bzType}){
    switch (bzType){
      case BzType.Developer    :   return <FlyerType>[FlyerType.newProperty, FlyerType.rentalProperty, FlyerType.resaleProperty];   break;
      case BzType.Broker       :   return <FlyerType>[FlyerType.newProperty, FlyerType.rentalProperty, FlyerType.resaleProperty];   break;
      case BzType.Designer     :   return <FlyerType>[FlyerType.design];     break;
      case BzType.Contractor   :   return <FlyerType>[FlyerType.project];    break;
      case BzType.Artisan      :   return <FlyerType>[FlyerType.craft];      break;
      case BzType.Manufacturer :   return <FlyerType>[FlyerType.product, FlyerType.equipment];    break; // product or equipment for author to choose while creating flyer
      case BzType.Supplier     :   return <FlyerType>[FlyerType.product, FlyerType.equipment];    break; // product or equipment for author to choose while creating flyer
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
}