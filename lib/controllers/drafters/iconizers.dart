import 'dart:core';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/models/kw/section_class.dart' as SectionClass;
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

// -----------------------------------------------------------------------------
  String sectionIconOn (SectionClass.Section section){
    return
      section == SectionClass.Section.properties ? Iconz.bxPropertiesOn :

      section == SectionClass.Section.designs ? Iconz.bxDesignsOn :
      section == SectionClass.Section.projects ? Iconz.bxProjectsOn :
      section == SectionClass.Section.crafts ? Iconz.bxCraftsOn :

      section == SectionClass.Section.products ? Iconz.bxProductsOn :
      section == SectionClass.Section.equipment ? Iconz.bxEquipmentOn :

      Iconz.bz;
  }
// -----------------------------------------------------------------------------
  String sectionIconOff (SectionClass.Section section){
    return
      section == SectionClass.Section.properties ? Iconz.bxPropertiesOff :

      section == SectionClass.Section.designs ? Iconz.bxDesignsOff :
      section == SectionClass.Section.projects ? Iconz.bxProjectsOff :
      section == SectionClass.Section.crafts ? Iconz.bxCraftsOff :

      section == SectionClass.Section.products ? Iconz.bxProductsOff :
      section == SectionClass.Section.equipment ? Iconz.bxEquipmentOff :

      section == SectionClass.Section.all ? Iconz.savedFlyers :

      Iconz.bz;
  }
// -----------------------------------------------------------------------------
  String superArrowENRight (BuildContext context){
    if (Wordz.textDirection(context) == 'ltr')
    {return Iconz.arrowRight;}
    else
    {return Iconz.arrowLeft;}
  }
// -----------------------------------------------------------------------------
  String superArrowENLeft (BuildContext context){
    if (Wordz.textDirection(context) == 'ltr')
    {return Iconz.arrowLeft;}
    else
    {return Iconz.arrowRight;}
  }
// -----------------------------------------------------------------------------
  String bzTypeIconOff (BzType bzType){
    final String icon =
    bzType == BzType.developer ? Iconz.bxPropertiesOff :
    bzType == BzType.broker ? Iconz.bxPropertiesOff :
    bzType == BzType.manufacturer ? Iconz.bxProductsOff :
    bzType == BzType.supplier ? Iconz.bxProductsOff :
    bzType == BzType.designer ? Iconz.bxDesignsOff :
    bzType == BzType.contractor ? Iconz.bxProjectsOff :
    bzType == BzType.artisan ? Iconz.bxCraftsOff :
    null;
    return icon;
  }
// -----------------------------------------------------------------------------
  String bzTypeIconOn (BzType bzType){
    final String icon =
    bzType == BzType.developer ? Iconz.bxPropertiesOn :
    bzType == BzType.broker ? Iconz.bxPropertiesOn :
    bzType == BzType.manufacturer ? Iconz.bxProductsOn :
    bzType == BzType.supplier ? Iconz.bxProductsOn :
    bzType == BzType.designer ? Iconz.bxDesignsOn :
    bzType == BzType.contractor ? Iconz.bxProjectsOn :
    bzType == BzType.artisan ? Iconz.bxCraftsOn :
    null;
    return icon;
  }
// -----------------------------------------------------------------------------
  String flyerTypeIconOn (FlyerTypeClass.FlyerType flyerType){
    final String icon =
    flyerType == FlyerTypeClass.FlyerType.property ? Iconz.bxPropertiesOn :
    flyerType == FlyerTypeClass.FlyerType.design ? Iconz.bxDesignsOn :
    flyerType == FlyerTypeClass.FlyerType.project ? Iconz.bxProjectsOn :
    flyerType == FlyerTypeClass.FlyerType.craft ? Iconz.bxCraftsOn :
    flyerType == FlyerTypeClass.FlyerType.product ? Iconz.bxProductsOn :
    flyerType == FlyerTypeClass.FlyerType.equipment ? Iconz.bxEquipmentOn :
    null;
    return icon;
  }
// -----------------------------------------------------------------------------
  String flyerTypeIconOff (FlyerTypeClass.FlyerType flyerType){
    final String _icon =
    flyerType == FlyerTypeClass.FlyerType.property ? Iconz.bxPropertiesOff :
    flyerType == FlyerTypeClass.FlyerType.design ? Iconz.bxDesignsOff :
    flyerType == FlyerTypeClass.FlyerType.project ? Iconz.bxProjectsOff :
    flyerType == FlyerTypeClass.FlyerType.craft ? Iconz.bxCraftsOff :
    flyerType == FlyerTypeClass.FlyerType.product ? Iconz.bxProductsOff :
    flyerType == FlyerTypeClass.FlyerType.equipment ? Iconz.bxEquipmentOff :
    null;
    return _icon;
  }
// -----------------------------------------------------------------------------
  CustomClipper<Path> userBalloon(UserStatus userType) {
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
  String imageDir({
    @required String prefix,
    @required String fileName,
    @required double pixelRatio,
    @required bool isIOS,
  }) {
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
  String superBackIcon(BuildContext context){
    return appIsLeftToRight(context) ? Iconz.back : Iconz.backArabic;
  }
// -----------------------------------------------------------------------------
  String superInverseBackIcon(BuildContext context){
    return appIsLeftToRight(context) ? Iconz.backArabic : Iconz.back;
  }
// -----------------------------------------------------------------------------
  String superContactIcon(ContactType contactType){
    switch (contactType){
      case ContactType.phone      :    return  Iconz.comPhone;  break;
      case ContactType.email      :    return  Iconz.comEmail;  break;
      case ContactType.website    :    return  Iconz.comWebsite;  break;
      case ContactType.facebook   :    return  Iconz.comFacebook;  break;
      case ContactType.linkedIn   :    return  Iconz.comLinkedin;  break;
      case ContactType.youtube    :    return  Iconz.comYoutube;  break;
      case ContactType.instagram  :    return  Iconz.comInstagram;  break;
      case ContactType.pinterest  :    return  Iconz.comPinterest;  break;
      case ContactType.tiktok     :    return  Iconz.comTikTok;  break;
      case ContactType.twitter    :    return  Iconz.comTwitter; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  bool iconIsContinent(String icon){
    bool _iconIsContinent;

    if (icon == Iconz.contAfrica ||
        icon == Iconz.contAsia ||
        icon == Iconz.contSouthAmerica ||
        icon == Iconz.contNorthAmerica ||
        icon == Iconz.contEurope ||
        icon == Iconz.contAustralia){
      _iconIsContinent = true;
    }

    else {
      _iconIsContinent = false;
    }

    return _iconIsContinent;
  }
// -----------------------------------------------------------------------------
  String getContinentIcon(Continent continent){

    final String _name = continent.name;

    switch (_name){
      case 'Africa' : return Iconz.contAfrica; break;
      case 'Asia' : return Iconz.contAsia; break;
      case 'Oceania' : return Iconz.contAustralia; break;
      case 'Europe' : return Iconz.contEurope; break;
      case 'North America' : return Iconz.contNorthAmerica; break;
      case 'South America' : return Iconz.contSouthAmerica; break;
      default: return null;
    }

  }
// -----------------------------------------------------------------------------
  const List<Map<String, dynamic>> continentsMaps = <Map<String, dynamic>>[
    <String, dynamic>{
      'name' : 'Africa',
      'icon' : Iconz.contAfrica,
    },
    <String, dynamic>{
      'name' : 'Asia',
      'icon' : Iconz.contAsia,
    },
    <String, dynamic>{
      'name' : 'Oceania',
      'icon' : Iconz.contAustralia,
    },
    <String, dynamic>{
      'name' : 'Europe',
      'icon' : Iconz.contEurope,
    },
    <String, dynamic>{
      'name' : 'North America',
      'icon' : Iconz.contNorthAmerica,
    },
    <String, dynamic>{
      'name' : 'South America',
      'icon' : Iconz.contSouthAmerica,
    },
  ];
// -----------------------------------------------------------------------------
  String valueIsNotNull(dynamic value){
    final String _icon = value == null ? Iconz.xSmall : Iconz.check;
    return _icon;
  }
// -----------------------------------------------------------------------------
