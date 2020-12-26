import 'package:bldrs/models/enums/enum_bz_form.dart';
import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/sliver_home_appbar.dart';
import 'package:flutter/material.dart';
// ----------------------------------------------------------------------------
TextDirection superTextDirection(BuildContext context){
  if (getTranslated(context, 'Text_Direction') == 'ltr')
    {return TextDirection.ltr;}
  else
    {return TextDirection.rtl;}
}
// ----------------------------------------------------------------------------
double verseLabelHeight (int verseSize, double screenHeight){
      return
    (verseSize == 0) ? screenHeight * Ratioz.fontSize0 * 1.42 // -- 8 -- A77A
        :
    (verseSize == 1) ? screenHeight * Ratioz.fontSize1 * 1.42 // -- 10 -- Nano
        :
    (verseSize == 2) ? screenHeight * Ratioz.fontSize2 * 1.42 // -- 12 -- Micro
        :
    (verseSize == 3) ? screenHeight * Ratioz.fontSize3 * 1.42 // -- 14 -- Mini
        :
    (verseSize == 4) ? screenHeight * Ratioz.fontSize4 * 1.42 // -- 16 -- Medium
        :
    (verseSize == 5) ? screenHeight * Ratioz.fontSize5 * 1.42 // -- 20 -- Macro
        :
    (verseSize == 6) ? screenHeight * Ratioz.fontSize6 * 1.42 // -- 24 -- Big
        :
    (verseSize == 7) ? screenHeight * Ratioz.fontSize7 * 1.42 // -- 28 -- Massive
        :
    (verseSize == 8) ? screenHeight * Ratioz.fontSize8 * 1.42 // -- 28 -- Gigantic
        :
    screenHeight * Ratioz.fontSize1 * 1.42
    ;
    }
// ----------------------------------------------------------------------------
String sectionStringer (BuildContext context, BldrsSection section){
  return
        section == BldrsSection.RealEstate ? 'Real-Estate' :
        section == BldrsSection.Construction ? 'Construction' :
        section == BldrsSection.Supplies ? 'Supplies' :
            'Home';
    }
// ----------------------------------------------------------------------------
String bzTypeStringer (BuildContext context, BzType bzType){
  return
        bzType == BzType.Developer ? 'Real-Estate Developer' :
        bzType == BzType.Broker ? 'Real-Estate Broker' :
        bzType == BzType.Designer ? 'Designer' :
        bzType == BzType.Contractor ? 'Contractor' :
        bzType == BzType.Artisan ? 'Artisan' :
        bzType == BzType.Manufacturer ? 'Manufacturer' :
        bzType == BzType.Supplier ? 'Supplier' :
            'Builder';
    }
// ----------------------------------------------------------------------------
String flyerTypeSingleStringer (BuildContext context, FlyerType flyerType){

  return
    flyerType == FlyerType.Property   ? getTranslated(context, 'Property')  :
    flyerType == FlyerType.Design     ? getTranslated(context, 'Design')  :
    flyerType == FlyerType.Product    ? getTranslated(context, 'Product')  :
    flyerType == FlyerType.Project    ? getTranslated(context, 'Project')  :
    flyerType == FlyerType.Equipment  ? getTranslated(context, 'Equipment')  :
    flyerType == FlyerType.Craft      ? getTranslated(context, 'Craft')  :
    flyerType == FlyerType.General    ? getTranslated(context, 'Bldrs_Short_Name')  :
    'Builder';
}
// ----------------------------------------------------------------------------
String flyerTypePluralStringer (BuildContext context, FlyerType flyerType){
  return
    flyerType == FlyerType.Property   ? getTranslated(context, 'Properties')  :
    flyerType == FlyerType.Design     ? getTranslated(context, 'Designs')  :
    flyerType == FlyerType.Product    ? getTranslated(context, 'Products')  :
    flyerType == FlyerType.Project    ? getTranslated(context, 'Projects')  :
    flyerType == FlyerType.Equipment  ? getTranslated(context, 'Equipments')  :
    flyerType == FlyerType.Craft      ? getTranslated(context, 'Crafts')  :
    flyerType == FlyerType.General    ? getTranslated(context, 'Bldrs_Short_Name')  :
    getTranslated(context, 'Bldrs_Short_Name');
}
// ----------------------------------------------------------------------------
String bzFormStringer (BuildContext context, BzForm bzForm){
return
  bzForm == BzForm.Company ? 'Company' :
  bzForm == BzForm.Individual ? 'Individual' :
  'impossible bzForm';

}
// ----------------------------------------------------------------------------
String localeStringer (BuildContext context, String city, String country){
String verse = '${getTranslated(context, 'In')} $city, $country';
return verse;
}
// ----------------------------------------------------------------------------


