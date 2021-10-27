import 'dart:core';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/path_building_user.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/path_constructing_user.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/path_normal_user.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/path_planning_user.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/path_searching_user.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/path_selling_user.dart';
import 'package:flutter/material.dart';

abstract class Iconizer{
// -----------------------------------------------------------------------------
  static String sectionIconOn (Section section){
    return
      section == Section.NewProperties ? Iconz.BxNewPropertiesOn :
      section == Section.ResaleProperties ? Iconz.BxResalePropertiesOn :
      section == Section.RentalProperties ? Iconz.BxRentPropertiesOn :

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
      section == Section.NewProperties ? Iconz.BxNewPropertiesOff :
      section == Section.ResaleProperties ? Iconz.BxResalePropertiesOff :
      section == Section.RentalProperties ? Iconz.BxRentPropertiesOff :

      section == Section.Designs ? Iconz.BxDesignsOff :
      section == Section.Projects ? Iconz.BxProjectsOff :
      section == Section.Crafts ? Iconz.BxCraftsOff :

      section == Section.Products ? Iconz.BxProductsOff :
      section == Section.Equipment ? Iconz.BxEquipmentOff :

      section == Section.All ? Iconz.SavedFlyers :

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
    final String icon =
    bzType == BzType.developer ? Iconz.BxPropertiesOff :
    bzType == BzType.broker ? Iconz.BxPropertiesOff :
    bzType == BzType.manufacturer ? Iconz.BxProductsOff :
    bzType == BzType.supplier ? Iconz.BxProductsOff :
    bzType == BzType.designer ? Iconz.BxDesignsOff :
    bzType == BzType.contractor ? Iconz.BxProjectsOff :
    bzType == BzType.artisan ? Iconz.BxCraftsOff :
    null;
    return icon;
  }
// -----------------------------------------------------------------------------
  static String bzTypeIconOn (BzType bzType){
    final String icon =
    bzType == BzType.developer ? Iconz.BxPropertiesOn :
    bzType == BzType.broker ? Iconz.BxPropertiesOn :
    bzType == BzType.manufacturer ? Iconz.BxProductsOn :
    bzType == BzType.supplier ? Iconz.BxProductsOn :
    bzType == BzType.designer ? Iconz.BxDesignsOn :
    bzType == BzType.contractor ? Iconz.BxProjectsOn :
    bzType == BzType.artisan ? Iconz.BxCraftsOn :
    null;
    return icon;
  }
// -----------------------------------------------------------------------------
  static String flyerTypeIconOn (FlyerType flyerType){
    final String icon =
    flyerType == FlyerType.rentalProperty ? Iconz.BxPropertiesOn :
    flyerType == FlyerType.design ? Iconz.BxDesignsOn :
    flyerType == FlyerType.project ? Iconz.BxProjectsOn :
    flyerType == FlyerType.craft ? Iconz.BxCraftsOn :
    flyerType == FlyerType.product ? Iconz.BxProductsOn :
    flyerType == FlyerType.equipment ? Iconz.BxEquipmentOn :
    null;
    return icon;
  }
// -----------------------------------------------------------------------------
  static String flyerTypeIconOff (FlyerType flyerType){
    final String _icon =
    flyerType == FlyerType.newProperty ? Iconz.BxNewPropertiesOff :
    flyerType == FlyerType.resaleProperty ? Iconz.BxResalePropertiesOff :
    flyerType == FlyerType.rentalProperty ? Iconz.BxRentPropertiesOff :
    flyerType == FlyerType.design ? Iconz.BxDesignsOff :
    flyerType == FlyerType.project ? Iconz.BxProjectsOff :
    flyerType == FlyerType.craft ? Iconz.BxCraftsOff :
    flyerType == FlyerType.product ? Iconz.BxProductsOff :
    flyerType == FlyerType.equipment ? Iconz.BxEquipmentOff :
    null;
    return _icon;
  }
// -----------------------------------------------------------------------------
  static CustomClipper<Path> userBalloon(UserStatus userType) {
    final CustomClipper<Path> userBalloon =
    userType == UserStatus.normal ? NormalCircle() :
    userType == UserStatus.searching ? SearchingThinking() :
    userType == UserStatus.finishing ? FinishingBalloon() :
    userType == UserStatus.planning ? PlanningTalkingBalloon() :
    userType == UserStatus.building ? BuildingBalloon() :
    userType == UserStatus.selling ? SellingBalloon() :
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
      case ContactType.phone      :    return  Iconz.ComPhone;  break;
      case ContactType.email      :    return  Iconz.ComEmail;  break;
      case ContactType.website    :    return  Iconz.ComWebsite;  break;
      case ContactType.facebook   :    return  Iconz.ComFacebook;  break;
      case ContactType.linkedIn   :    return  Iconz.ComLinkedin;  break;
      case ContactType.youtube    :    return  Iconz.ComYoutube;  break;
      case ContactType.instagram  :    return  Iconz.ComInstagram;  break;
      case ContactType.pinterest  :    return  Iconz.ComPinterest;  break;
      case ContactType.tiktok     :    return  Iconz.ComTikTok;  break;
      case ContactType.twitter    :    return  Iconz.ComTwitter; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static bool iconIsContinent(String icon){
    final bool _iconIsContinent =
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
  static String getContinentIcon(Continent continent){

    final String _name = continent.name;

    switch (_name){
      case 'Africa' : return Iconz.ContAfrica; break;
      case 'Asia' : return Iconz.ContAsia; break;
      case 'Oceania' : return Iconz.ContAustralia; break;
      case 'Europe' : return Iconz.ContEurope; break;
      case 'North America' : return Iconz.ContNorthAmerica; break;
      case 'South America' : return Iconz.ContSouthAmerica; break;
      default: return null;
    }

  }
// -----------------------------------------------------------------------------
  static const List<Map<String, dynamic>> continentsMaps = const <Map<String, dynamic>>[
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
  static String valueIsNotNull(dynamic value){
    final String _icon = value == null ? Iconz.XSmall : Iconz.Check;
    return _icon;
  }
// -----------------------------------------------------------------------------
}