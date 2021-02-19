import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/max_header_parts/bz_pg_counter.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/max_header_parts/bz_pg_verse.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class GeneralStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return MainLayout(
      layoutWidget: ListView(

        children: <Widget>[

          // ------------------------------------------------

          BzPgVerse(
            verse: Wordz.allahoAkbar(context),
            size: 5,
            flyerZoneWidth: screenWidth,
            maxLines: 1,
          ),

          Container(
            width: screenWidth * 0.6,
            height: screenWidth * 0.6,
            child: WebsafeSvg.asset(Iconz.BldrsNameEn),
          ),

          // ------------------------------------------------

          SuperVerse(
            verse: 'General states :-',
            size: 3,
            italic: true,
            shadow: true,
            weight: VerseWeight.black,
            centered: false,
            margin: screenWidth * 0.05,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: 'users',
            count: 1,
            icon: Iconz.NormalUser,
            iconSizeFactor: 0.95,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.businesses(context),
            count: 0,
            icon: Iconz.Bz,
            iconSizeFactor: 0.95,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.flyers(context),
            count: 0,
            icon: Iconz.Gallery,
            iconSizeFactor: 0.8,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: 'slides',//Wordz.slides,
            count: 0,
            icon: Iconz.Flyer,
            iconSizeFactor: 0.8,
          ),

          // ------------------------------------------------
          // --- SECTION SEPARATOR
          Container(
            width: screenWidth,
            height: screenWidth * 0.002,
            color: Colorz.Yellow,
            margin: EdgeInsets.only(top: screenWidth * 0.05),
          ),

          SuperVerse(
            verse: 'Bz states :-',
            size: 3,
            italic: true,
            shadow: true,
            weight: VerseWeight.black,
            centered: false,
            margin: screenWidth * 0.05,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: 'Realtors',
            count: 0,
            icon: Iconz.BxPropertiesOn,
            iconSizeFactor: 0.95,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.propertyFlyer(context),
            count: 0,
            icon: Iconz.Flyer,
            iconSizeFactor: 0.8,
          ),

          // ------------------------------------------------
          // -- SEPARATOR
          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenWidth * 0.001,
              color: Colorz.YellowSmoke,
            ),
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.designers(context),
            count: 0,
            icon: Iconz.BxDesignsOn,
            iconSizeFactor: 0.95,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.designFlyer(context),
            count: 0,
            icon: Iconz.Flyer,
            iconSizeFactor: 0.8,
          ),

          // ------------------------------------------------
          // -- SEPARATOR
          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenWidth * 0.001,
              color: Colorz.YellowSmoke,
            ),
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.suppliers(context),
            count: 0,
            icon: Iconz.BxEquipmentOn,
            iconSizeFactor: 0.95,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.productFlyer(context),
            count: 0,
            icon: Iconz.Flyer,
            iconSizeFactor: 0.8,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.equipmentFlyer(context),
            count: 0,
            icon: Iconz.Flyer,
            iconSizeFactor: 0.8,
          ),

          // ------------------------------------------------
          // -- SEPARATOR
          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenWidth * 0.001,
              color: Colorz.YellowSmoke,
            ),
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.contractors(context),
            count: 0,
            icon: Iconz.BxProjectsOn,
            iconSizeFactor: 0.95,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.projectFlyer(context),
            count: 0,
            icon: Iconz.Flyer,
            iconSizeFactor: 0.8,
          ),

          // ------------------------------------------------
          // -- SEPARATOR
          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenWidth * 0.001,
              color: Colorz.YellowSmoke,
            ),
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.craftsmen(context),
            count: 0,
            icon: Iconz.BxCraftsOn,
            iconSizeFactor: 0.95,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.craftFlyer(context),
            count: 0,
            icon: Iconz.Flyer,
            iconSizeFactor: 0.8,
          ),

          // ------------------------------------------------
          // --- SECTION SEPARATOR
          Container(
            width: screenWidth,
            height: screenWidth * 0.002,
            color: Colorz.Yellow,
            margin: EdgeInsets.only(top: screenWidth * 0.05),
          ),

          SuperVerse(
            verse: 'Engagement states :-',
            size: 3,
            italic: true,
            shadow: true,
            weight: VerseWeight.black,
            centered: false,
            margin: screenWidth * 0.05,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.totalSaves(context), // Wordz.saves
            count: 0,
            icon: Iconz.SaveOn,
            iconSizeFactor: 0.8,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.views(context),
            count: 0,
            icon: Iconz.Views,
            iconSizeFactor: 0.8,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.totalShares(context), // Wordz.shares
            count: 0,
            icon: Iconz.Share,
            iconSizeFactor: 0.8,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.followers(context),
            count: 0,
            icon: Iconz.Follow,
            iconSizeFactor: 0.8,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: Wordz.bldrsConnected(context),
            count: 0,
            icon: Iconz.HandShake,
            iconSizeFactor: 0.9,
          ),

          BzPgCounter(
            flyerZoneWidth: screenWidth,
            verse: 'Contact me clicks',
            count: 0,
            icon: Iconz.ComPhone,
            iconSizeFactor: 0.8,
          ),

          // --- THE END
          Container(
            width: screenWidth,
            height: screenWidth * 0.5,
          ),

        ],
      ),
    );
  }
}
