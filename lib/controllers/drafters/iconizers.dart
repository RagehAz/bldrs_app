import 'dart:core';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bldrs_sections.dart' show BldrsSection;
import 'package:bldrs/models/bz_model.dart' show BzType;
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart' show ContactType;
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_building_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_constructing_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_normal_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_planning_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_searching_user.dart';
import 'package:bldrs/views/widgets/buttons/balloons/path_selling_user.dart';
import 'package:flutter/material.dart';

class Iconizer{
// -----------------------------------------------------------------------------
  static String sectionIcon (BldrsSection section){
    return
      section == BldrsSection.RealEstate ? Iconz.BxPropertiesOff :
      section == BldrsSection.Construction ? Iconz.BxProjectsOff :
      section == BldrsSection.Supplies ? Iconz.BxProductsOff :
      Iconz.Bz;
  }
// -----------------------------------------------------------------------------
  static String superArrowENRight (BuildContext context){
    if (Wordz.textDirection(context) == 'ltr')
    {return Iconz.ArrowRight;}
    else
    {return Iconz.ArrowLeft;}
  }
// -----------------------------------------------------------------------------
  static String superArrowENLeft (BuildContext context){
    if (Wordz.textDirection(context) == 'ltr')
    {return Iconz.ArrowLeft;}
    else
    {return Iconz.ArrowRight;}
  }
// -----------------------------------------------------------------------------
  static String bzTypeIconOff (BzType bzType){
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
// -----------------------------------------------------------------------------
  static String bzTypeIconOn (BzType bzType){
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
// -----------------------------------------------------------------------------
  static String flyerTypeIconOn (FlyerType flyerType){
    String icon =
    flyerType == FlyerType.Property ? Iconz.BxPropertiesOn :
    flyerType == FlyerType.Design ? Iconz.BxDesignsOn :
    flyerType == FlyerType.Project ? Iconz.BxProjectsOn :
    flyerType == FlyerType.Craft ? Iconz.BxCraftsOn :
    flyerType == FlyerType.Product ? Iconz.BxProductsOn :
    flyerType == FlyerType.Equipment ? Iconz.BxEquipmentOn :
    null;
    return icon;
  }
// -----------------------------------------------------------------------------
  static CustomClipper<Path> userBalloon(UserStatus userType) {
    CustomClipper<Path> userBalloon =
    userType == UserStatus.Normal ? NormalCircle() :
    userType == UserStatus.SearchingThinking ? SearchingThinking() :
    userType == UserStatus.Finishing ? FinishingBalloon() :
    userType == UserStatus.PlanningTalking ? PlanningTalkingBalloon() :
    userType == UserStatus.Building ? BuildingBalloon() :
    userType == UserStatus.Selling ? SellingBalloon() :
    userType == null ? NormalCircle() :
    NormalCircle();
    return userBalloon;
  }
// -----------------------------------------------------------------------------
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
  static String imageDir(String prefix, String fileName, double pixelRatio, bool isIOS) {
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
// -----------------------------------------------------------------------------
  static String superBackIcon(BuildContext context){
    return appIsLeftToRight(context) ? Iconz.Back : Iconz.BackArabic;
  }
// -----------------------------------------------------------------------------
  static String superInverseBackIcon(BuildContext context){
    return appIsLeftToRight(context) ? Iconz.BackArabic : Iconz.Back;
  }
// -----------------------------------------------------------------------------
  static String superContactIcon(ContactType contactType){
    switch (contactType){
      case ContactType.Phone      :    return  Iconz.ComPhone;  break;
      case ContactType.Email      :    return  Iconz.ComEmail;  break;
      case ContactType.WebSite    :    return  Iconz.ComWebsite;  break;
      case ContactType.Facebook   :    return  Iconz.ComFacebook;  break;
      case ContactType.LinkedIn   :    return  Iconz.ComLinkedin;  break;
      case ContactType.YouTube    :    return  Iconz.ComYoutube;  break;
      case ContactType.Instagram  :    return  Iconz.ComInstagram;  break;
      case ContactType.Pinterest  :    return  Iconz.ComPinterest;  break;
      case ContactType.TikTok     :    return  Iconz.ComTikTok;  break;
      case ContactType.Twitter    :    return  Iconz.ComTwitter; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
}