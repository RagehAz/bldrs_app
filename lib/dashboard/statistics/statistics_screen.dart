import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/db/fire/firestore.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_pg_counter.dart';
import 'package:flutter/material.dart';

class GeneralStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = MediaQuery.of(context).size.width;

    return MainLayout(
      pyramids: Iconz.PyramidsYellow,
      appBarType: AppBarType.Basic,
      sky: Sky.Black,
      pageTitle: Wordz.allahoAkbar(context),
      appBarRowWidgets: const <Widget>[

        const Expander(),

        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
          child: const BldrsName(
              size: 40,
          ),
        ),

      ],
      layoutWidget:

      /// STREAM : DB / admin / statistics
      StreamBuilder(
        stream: Fire.streamDoc(FireColl.admin, 'statistics'),
        initialData: null,
        builder: (context, snapshot){

          if(StreamChecker.connectionIsLoading(snapshot) == true){
            return const Loading(loading: true,);

          } else {

            final dynamic map = snapshot.data;

            final int _numberOfUsers = map['numberOfUsers'];
            final int _numberOfCountries = map['numberOfCountries'];
            final int _numberOfBzz = map['numberOfBzz'];
            final int _numberOfFlyers = map['numberOfFlyers'];
            final int _numberOfSlides = map['numberOfSlides'];

            return
            ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: false,
              children: <Widget>[

                const Stratosphere(),

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
                  flyerBoxWidth: _screenWidth,
                  verse: 'Users',
                  count: _numberOfUsers,
                  icon: Iconz.NormalUser,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: 'Countries',
                  count: _numberOfCountries,
                  icon: Iconz.Earth,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.businesses(context),
                  count: _numberOfBzz,
                  icon: Iconz.Bz,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.flyers(context),
                  count: _numberOfFlyers,
                  icon: Iconz.Gallery,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: 'slides',//Wordz.slides,
                  count: _numberOfSlides,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                /// --- SECTION SEPARATOR
                Container(
                  width: _screenWidth,
                  height: _screenWidth * 0.002,
                  color: Colorz.yellow255,
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
                  flyerBoxWidth: _screenWidth,
                  verse: 'Realtors',
                  count: 0,
                  icon: Iconz.BxPropertiesOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.propertyFlyer(context),
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                /// -- SEPARATOR
                Center(
                  child: Container(
                    width: _screenWidth * 0.9,
                    height: _screenWidth * 0.001,
                    color: Colorz.yellow80,
                  ),
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.designers(context),
                  count: 0,
                  icon: Iconz.BxDesignsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.designFlyer(context),
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                /// -- SEPARATOR
                Center(
                  child: Container(
                    width: _screenWidth * 0.9,
                    height: _screenWidth * 0.001,
                    color: Colorz.yellow80,
                  ),
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.suppliers(context),
                  count: 0,
                  icon: Iconz.BxEquipmentOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.productFlyer(context),
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.equipmentFlyer(context),
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                /// -- SEPARATOR
                Center(
                  child: Container(
                    width: _screenWidth * 0.9,
                    height: _screenWidth * 0.001,
                    color: Colorz.yellow80,
                  ),
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.contractors(context),
                  count: 0,
                  icon: Iconz.BxProjectsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.projectFlyer(context),
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                /// -- SEPARATOR
                Center(
                  child: Container(
                    width: _screenWidth * 0.9,
                    height: _screenWidth * 0.001,
                    color: Colorz.yellow80,
                  ),
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.craftsmen(context),
                  count: 0,
                  icon: Iconz.BxCraftsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.craftFlyer(context),
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                /// --- SECTION SEPARATOR
                Container(
                  width: _screenWidth,
                  height: _screenWidth * 0.002,
                  color: Colorz.yellow255,
                  margin: EdgeInsets.only(top: _screenWidth * 0.05),
                ),

                SuperVerse(
                  verse: 'Engagement states :-',
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: _screenWidth * 0.05,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.totalSaves(context), // Wordz.saves
                  count: 0,
                  icon: Iconz.SaveOn,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.views(context),
                  count: 0,
                  icon: Iconz.Views,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.totalShares(context), // Wordz.shares
                  count: 0,
                  icon: Iconz.Share,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.followers(context),
                  count: 0,
                  icon: Iconz.Follow,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.bldrsConnected(context),
                  count: 0,
                  icon: Iconz.HandShake,
                  iconSizeFactor: 0.9,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: 'Contact me clicks',
                  count: 0,
                  icon: Iconz.ComPhone,
                  iconSizeFactor: 0.8,
                ),

                // --- THE END
                Container(
                  width: _screenWidth,
                  height: _screenWidth * 0.5,
                ),

              ],
            );
          }
        },
      ),




    );
  }
}
