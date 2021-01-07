import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:flutter/material.dart';

enum BzType {
  Developer, // dv -> pp (property flyer - property source flyer)
  Broker, // br -> pp (property flyer)

  Manufacturer, // mn - pd (product flyer - product source flyer)
  Supplier, // sp - pd (product flyer)

  Designer, // dr - ds (design flyer)
  Contractor, // cn - pj (project flyer)
  Artisan, // ar - cr (craft flyer)
}

List<BzType> bzTypesList = [
  BzType.Developer,
  BzType.Broker,

  BzType.Manufacturer,
  BzType.Supplier,

  BzType.Designer,
  BzType.Contractor,
  BzType.Artisan,
];


Map<String, Object> bzTypesMap = {
  'Title' : 'Business Types',
  'Strings' : [
    'developers',
    'brokers',
    'manufacturers',
    'suppliers',
    'designers',
    'contractors',
    'artisans',
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
  static String manufacturers;
  static String suppliers;
  static String designers;
  static String contractors;
  static String artisans;

  static String developer;
  static String broker;
  static String manufacturer;
  static String supplier;
  static String designer;
  static String contractor;
  static String artisan;

  void init(BuildContext context){
    developers     = bzTypePluralStringer(context, BzType.Developer);
    brokers        = bzTypePluralStringer(context, BzType.Broker);
    manufacturers  = bzTypePluralStringer(context, BzType.Manufacturer);
    suppliers      = bzTypePluralStringer(context, BzType.Supplier);
    designers      = bzTypePluralStringer(context, BzType.Designer);
    contractors    = bzTypePluralStringer(context, BzType.Contractor);
    artisans       = bzTypePluralStringer(context, BzType.Artisan);

    developer      = bzTypeSingleStringer(context, BzType.Developer);
    broker         = bzTypeSingleStringer(context, BzType.Broker);
    manufacturer   = bzTypeSingleStringer(context, BzType.Manufacturer);
    supplier       = bzTypeSingleStringer(context, BzType.Supplier);
    designer       = bzTypeSingleStringer(context, BzType.Designer);
    contractor     = bzTypeSingleStringer(context, BzType.Contractor);
    artisan        = bzTypeSingleStringer(context, BzType.Artisan);
  }

}
