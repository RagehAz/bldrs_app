import 'dart:core';
import 'package:bldrs/models/enums/enum_bldrs_section.dart';
import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/models/enums/enum_user_type.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_building_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_constructing_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_normal_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_planning_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_searching_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_selling_user.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
String sectionIcon (BldrsSection section){
    return
        section == BldrsSection.RealEstate ? Iconz.BxPropertiesOff :
        section == BldrsSection.Construction ? Iconz.BxProjectsOff :
        section == BldrsSection.Supplies ? Iconz.BxProductsOff :
            Iconz.Bz;
  }
// === === === === === === === === === === === === === === === === === === ===
String superArrowENRight (BuildContext context){
  if (Wordz.textDirection(context) == 'ltr')
    {return Iconz.ArrowRight;}
  else
    {return Iconz.ArrowLeft;}
  }
// === === === === === === === === === === === === === === === === === === ===
String superArrowENLeft (BuildContext context){
  if (Wordz.textDirection(context) == 'ltr')
    {return Iconz.ArrowLeft;}
  else
    {return Iconz.ArrowRight;}
  }
// === === === === === === === === === === === === === === === === === === ===
String bzTypeIconOff (BzType bzType){
  String icon =
  bzType == BzType.Developer ? Iconz.BxPropertiesOff :
  bzType == BzType.Broker ? Iconz.BxPropertiesOff :
  bzType == BzType.Manufacturer ? Iconz.BxProductsOff :
  bzType == BzType.Supplier ? Iconz.BxProductsOff :
  bzType == BzType.Designer ? Iconz.BxDesignsOff :
  bzType == BzType.Contractor ? Iconz.BxProjectsOff :
  bzType == BzType.Artisan ? Iconz.BxCraftsOff :
  null;
  return icon;
  }
// === === === === === === === === === === === === === === === === === === ===
String bzTypeIconOn (BzType bzType){
  String icon =
  bzType == BzType.Developer ? Iconz.BxPropertiesOn :
  bzType == BzType.Broker ? Iconz.BxPropertiesOn :
  bzType == BzType.Manufacturer ? Iconz.BxProductsOn :
  bzType == BzType.Supplier ? Iconz.BxProductsOn :
  bzType == BzType.Designer ? Iconz.BxDesignsOn :
  bzType == BzType.Contractor ? Iconz.BxProjectsOn :
  bzType == BzType.Artisan ? Iconz.BxCraftsOn :
  null;
  return icon;
}
// === === === === === === === === === === === === === === === === === === ===
CustomClipper<Path> userBalloon(UserType userType) {
  CustomClipper<Path> userBalloon =
  userType == UserType.NormalUser ? NormalUserBalloon() :
  userType == UserType.SearchingUser ? SearchingUserBalloon() :
  userType == UserType.ConstructingUser ? ConstructingUserBalloon() :
  userType == UserType.PlanningUser ? PlanningUserBalloon() :
  userType == UserType.BuildingUser ? BuildingUserBalloon() :
  userType == UserType.SellingUser ? SellingUserBalloon() :
  NormalUserBalloon();
  return userBalloon;
}
// === === === === === === === === === === === === === === === === === === ===
/// MediaQueryData data = MediaQuery.of(context);
/// double ratio = data.devicePixelRatio;
///
/// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
///
/// If the platform is not iOS, you would implement the buckets in your code. Combining the logic into one method:
///
/// double markerScale;
/// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
/// if (isIOS){markerScale = 0.7;}else{markerScale = 1;}
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
// === === === === === === === === === === === === === === === === === === ===
