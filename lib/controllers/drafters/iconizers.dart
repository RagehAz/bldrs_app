import 'dart:core';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/section_class.dart' show Section;
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
  static String sectionIconOn (Section section){
    return
      section == Section.NewProperties ? Iconz.BxPropertiesOn :
      section == Section.ResaleProperties ? Iconz.BxPropertiesOn :
      section == Section.RentalProperties ? Iconz.BxPropertiesOn :

      section == Section.Designs ? Iconz.BxDesignsOn :
      section == Section.Projects ? Iconz.BxProjectsOn :
      section == Section.Crafts ? Iconz.BxCraftsOn :

      section == Section.Products ? Iconz.BxProductsOn :
      section == Section.Equipment ? Iconz.BxEquipmentOn :

      Iconz.Bz;
  }
// -----------------------------------------------------------------------------
  static String sectionIconOff (Section section){
    return
      section == Section.NewProperties ? Iconz.BxPropertiesOff :
      section == Section.ResaleProperties ? Iconz.BxPropertiesOff :
      section == Section.RentalProperties ? Iconz.BxPropertiesOff :

      section == Section.Designs ? Iconz.BxDesignsOff :
      section == Section.Projects ? Iconz.BxProjectsOff :
      section == Section.Crafts ? Iconz.BxCraftsOff :

      section == Section.Products ? Iconz.BxProductsOff :
      section == Section.Equipment ? Iconz.BxEquipmentOff :

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
  static String flyerTypeIconOff (FlyerType flyerType){
    String icon =
    flyerType == FlyerType.Property ? Iconz.BxPropertiesOff :
    flyerType == FlyerType.Design ? Iconz.BxDesignsOff :
    flyerType == FlyerType.Project ? Iconz.BxProjectsOff :
    flyerType == FlyerType.Craft ? Iconz.BxCraftsOff :
    flyerType == FlyerType.Product ? Iconz.BxProductsOff :
    flyerType == FlyerType.Equipment ? Iconz.BxEquipmentOff :
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
  static bool iconIsContinent(String icon){
    bool _iconIsContinent =
            icon == Iconz.ContAfrica ||
            icon == Iconz.ContAsia ||
            icon == Iconz.ContSouthAmerica ||
            icon == Iconz.ContNorthAmerica ||
            icon == Iconz.ContEurope ||
            icon == Iconz.ContAustralia ?

            true : false;

    return _iconIsContinent;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> continentsMaps = [
    {
      'name' : 'Africa',
      'icon' : Iconz.ContAfrica,
    },
    {
      'name' : 'Asia',
      'icon' : Iconz.ContAsia,
    },
    {
      'name' : 'Oceania',
      'icon' : Iconz.ContAustralia,
    },
    {
      'name' : 'Europe',
      'icon' : Iconz.ContEurope,
    },
    {
      'name' : 'North America',
      'icon' : Iconz.ContNorthAmerica,
    },
    {
      'name' : 'South America',
      'icon' : Iconz.ContSouthAmerica,
    },
  ];
// -----------------------------------------------------------------------------

}