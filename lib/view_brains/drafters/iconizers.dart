import 'dart:core';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/sliver_home_appbar.dart';
import 'package:flutter/material.dart';


String sectionIcon (BldrsSection section){
    return
        section == BldrsSection.RealEstate ? Iconz.BxPropertiesOff :
        section == BldrsSection.Construction ? Iconz.BxProjectsOff :
        section == BldrsSection.Supplies ? Iconz.BxProductsOff :
            Iconz.Bz;
  }

String superArrowENRight (BuildContext context){
  if (getTranslated(context, 'Text_Direction') == 'ltr')
    {return Iconz.ArrowRight;}
  else
    {return Iconz.ArrowLeft;}
  }

String superArrowENLeft (BuildContext context){
  if (getTranslated(context, 'Text_Direction') == 'ltr')
    {return Iconz.ArrowLeft;}
  else
    {return Iconz.ArrowRight;}
  }

// ----------------------------------------------------

// MediaQueryData data = MediaQuery.of(context);
// double ratio = data.devicePixelRatio;
//
// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

// If the platform is not iOS, you would implement the buckets in your code. Combining the logic into one method:
String imageDir(String prefix, String fileName, double pixelRatio, bool isIOS) {
    String directory = '/';
    if (!isIOS) {
        if (pixelRatio >= 1.5) {
            directory = '/2.0x/';
        }
        else if (pixelRatio >= 2.5) {
            directory = '/3.0x/';
        }
        else if (pixelRatio >= 3.5) {
            directory = '/4.0x/';
        }
    }
    return '$prefix$directory$fileName';
}
// double markerScale;
    // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    // if (isIOS){markerScale = 0.7;}else{markerScale = 1;}

  // ----------------------------------------------------
