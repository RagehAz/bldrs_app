import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_counter.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_verse.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/pyramids/bldrs_name.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class GeneralStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return MainLayout(
      pyramids: Iconz.PyramidsYellow,
      appBarType: AppBarType.Basic,
      sky: Sky.Black,
      pageTitle: Wordz.allahoAkbar(context),
      appBarRowWidgets: <Widget>[

        Expander(),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
          child: BldrsName(
              width: 40,
              height: 40
          ),
        ),

      ],
      layoutWidget:

      /// STREAM : DB / admin / statistics
      StreamBuilder(
        stream: Fire.streamDoc(FireCollection.admin, 'statistics'),
        initialData: null,
        builder: (context, snapshot){

          if(StreamChecker.connectionIsLoading(snapshot) == true){
            return Loading(loading: true,);

          } else {
            dynamic map = snapshot.data;

            int _numberOfUsers = map['numberOfUsers'];
            int _numberOfCountries = map['numberOfCountries'];
            int _numberOfBzz = map['numberOfBzz'];
            int _numberOfFlyers = map['numberOfFlyers'];
            int _numberOfSlides = map['numberOfSlides'];

            return
            ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: false,
              children: <Widget>[

                Stratosphere(),

                SuperVerse(
                  verse: 'General states :-',
                  size: 2,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: Ratioz.appBarMargin,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Users',
                  count: _numberOfUsers,
                  icon: Iconz.NormalUser,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Countries',
                  count: _numberOfCountries,
                  icon: Iconz.Earth,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: Wordz.businesses(context),
                  count: _numberOfBzz,
                  icon: Iconz.Bz,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: Wordz.flyers(context),
                  count: _numberOfFlyers,
                  icon: Iconz.Gallery,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'slides',//Wordz.slides,
                  count: _numberOfSlides,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                /// --- SECTION SEPARATOR
                Container(
                  width: screenWidth,
                  height: screenWidth * 0.002,
                  color: Colorz.Yellow255,
                  // margin: EdgeInsets.only(top: screenWidth * 0.05),
                ),

                SuperVerse(
                  verse: 'Bz states :-',
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: Ratioz.appBarMargin,
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
                    color: Colorz.Yellow80,
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
                    color: Colorz.Yellow80,
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
                    color: Colorz.Yellow80,
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
                    color: Colorz.Yellow80,
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
                  color: Colorz.Yellow255,
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
            );
          }
        },
      ),




    );
  }
}
