enum FlyerType {
  Property, // pp
  Design, // ds
  Product, // pd
  Project, // pj
  Craft, // cr
  Equipment, // eq
  General,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<FlyerType> flyerTypesList = [
  FlyerType.Property,
  FlyerType.Design,
  FlyerType.Product,
  FlyerType.Project,
  FlyerType.Craft,
  FlyerType.Equipment,
  FlyerType.General,
];

// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
FlyerType decipherFlyerType (int x){
  switch (x){
    case 1:   return  FlyerType.Property;     break;
    case 2:   return  FlyerType.Design;       break;
    case 3:   return  FlyerType.Product;      break;
    case 4:   return  FlyerType.Project;      break;
    case 5:   return  FlyerType.Craft;        break;
    case 6:   return  FlyerType.Equipment;    break;
    case 7:   return  FlyerType.General;      break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherFlyerType (FlyerType x){
  switch (x){
    case FlyerType.Property    :    return  1;  break;
    case FlyerType.Design      :    return  2;  break;
    case FlyerType.Product     :    return  3;  break;
    case FlyerType.Project     :    return  4;  break;
    case FlyerType.Craft       :    return  5;  break;
    case FlyerType.Equipment   :    return  6;  break;
    case FlyerType.General     :    return  7;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x

