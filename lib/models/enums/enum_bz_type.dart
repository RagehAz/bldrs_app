import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:flutter/material.dart';

enum BzType {
  Developer, // dv -> pp (property flyer - property source flyer)
  Broker, // br -> pp (property flyer)

  Designer, // dr - ds (design flyer)
  Contractor, // cn - pj (project flyer)
  Artisan, // ar - cr (craft flyer)

  Manufacturer, // mn - pd (product flyer - product source flyer)
  Supplier, // sp - pd (product flyer)
}

List<BzType> bzTypesList = [
  BzType.Developer,
  BzType.Broker,

  BzType.Designer,
  BzType.Contractor,
  BzType.Artisan,

  BzType.Manufacturer,
  BzType.Supplier,
];


Map<String, Object> bzTypesMap = {
  'Title' : 'Business Types',
  'Strings' : [
    'developers',
    'brokers',
    'designers',
    'contractors',
    'artisans',
    'manufacturers',
    'suppliers',
  ],
  'Triggers' : [false, false, false, false, false, false, false],
};

// dunno why I couldn't access this class below in the above map by referring from it like BzTypeStrings.develops masalan,,
// but returned nulls,, maybe becuase of the context,, dunno
// i'm gonna skip this for now,, just wanted to add the pop up menu as an example as I previously designed its UI,,
// I don't like it anyways and it needs UI updates
// then it needs to be merged with MainLayout();
class BzTypeStrings {

  static String developers;
  static String brokers;
  static String designers;
  static String contractors;
  static String artisans;
  static String manufacturers;
  static String suppliers;

  static String developer;
  static String broker;
  static String designer;
  static String contractor;
  static String artisan;
  static String manufacturer;
  static String supplier;

  void init(BuildContext context){
    developers     = bzTypePluralStringer(context, BzType.Developer);
    brokers        = bzTypePluralStringer(context, BzType.Broker);
    designers      = bzTypePluralStringer(context, BzType.Designer);
    contractors    = bzTypePluralStringer(context, BzType.Contractor);
    artisans       = bzTypePluralStringer(context, BzType.Artisan);
    manufacturers  = bzTypePluralStringer(context, BzType.Manufacturer);
    suppliers      = bzTypePluralStringer(context, BzType.Supplier);

    developer      = bzTypeSingleStringer(context, BzType.Developer);
    broker         = bzTypeSingleStringer(context, BzType.Broker);
    designer       = bzTypeSingleStringer(context, BzType.Designer);
    contractor     = bzTypeSingleStringer(context, BzType.Contractor);
    artisan        = bzTypeSingleStringer(context, BzType.Artisan);
    manufacturer   = bzTypeSingleStringer(context, BzType.Manufacturer);
    supplier       = bzTypeSingleStringer(context, BzType.Supplier);
  }

}

// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
BzType decipherBzType (int x){
  switch (x){
  case 1:   return  BzType.Broker;        break;
  case 2:   return  BzType.Designer;      break;
  case 3:   return  BzType.Contractor;    break;
  case 4:   return  BzType.Artisan;       break;
  case 5:   return  BzType.Manufacturer;  break;
  case 6:   return  BzType.Supplier;      break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherBzType (BzType x){
  switch (x){
    case BzType.Broker:         return  1;  break;
    case BzType.Designer:       return  2;  break;
    case BzType.Contractor:     return  3;  break;
    case BzType.Artisan:        return  4;  break;
    case BzType.Manufacturer:   return  5;  break;
    case BzType.Supplier:       return  6;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
