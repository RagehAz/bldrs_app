import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_counter.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/pyramids/bldrs_name.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class GeneralStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return MainLayout(
      pyramids: Iconz.PyramidsYellow,
      appBarType: AppBarType.Basic,
      sky: Sky.Black,
      pageTitle: Wordz.allahoAkbar(context),
      tappingRageh: () async {

        FlyerModel _flyer = await FlyerOps().readFlyerOps(
          context: context,
          flyerID: 'dlfd1m7S28ND2GIuEA1r',
        );

        FlyerModel _testFlyer = FlyerModel(
          flyerID: '000000000000xxxxxx1saaa',
          flyerType: _flyer.flyerType,
          flyerState: _flyer.flyerState,
          keywords: _flyer.keywords,
          flyerShowsAuthor: _flyer.flyerShowsAuthor,
          flyerURL: _flyer.flyerURL,
          flyerZone: _flyer.flyerZone,
          tinyAuthor: _flyer.tinyAuthor,
          tinyBz: _flyer.tinyBz,
          publishTime: _flyer.publishTime,
          flyerPosition: _flyer.flyerPosition,
          ankhIsOn: _flyer.ankhIsOn,
          slides: [..._flyer.slides,..._flyer.slides,..._flyer.slides],
          flyerIsBanned: _flyer.flyerIsBanned,
          deletionTime: _flyer.deletionTime,
          specs: _flyer.specs,
          info: _flyer.info,
          times: _flyer.times,
        );

        print('the fucking fucking slides length is : ${_testFlyer.slides.length}');

        await Fire.createNamedDoc(
          context: context,
          collName: FireCollection.flyers,
          docName: '000000000000xxxxxx1saaa',
          input: _testFlyer.toMap(),
        );

        print('done bitch');

      },
      appBarRowWidgets: <Widget>[

        Expander(),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
          child: BldrsName(
              size: 40,
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
                  flyerBoxWidth: screenWidth,
                  verse: 'Users',
                  count: _numberOfUsers,
                  icon: Iconz.NormalUser,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
                  verse: 'Countries',
                  count: _numberOfCountries,
                  icon: Iconz.Earth,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.businesses(context),
                  count: _numberOfBzz,
                  icon: Iconz.Bz,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.flyers(context),
                  count: _numberOfFlyers,
                  icon: Iconz.Gallery,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
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
                  flyerBoxWidth: screenWidth,
                  verse: 'Realtors',
                  count: 0,
                  icon: Iconz.BxPropertiesOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
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
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.designers(context),
                  count: 0,
                  icon: Iconz.BxDesignsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
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
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.suppliers(context),
                  count: 0,
                  icon: Iconz.BxEquipmentOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.productFlyer(context),
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
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
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.contractors(context),
                  count: 0,
                  icon: Iconz.BxProjectsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
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
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.craftsmen(context),
                  count: 0,
                  icon: Iconz.BxCraftsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
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
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.totalSaves(context), // Wordz.saves
                  count: 0,
                  icon: Iconz.SaveOn,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.views(context),
                  count: 0,
                  icon: Iconz.Views,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.totalShares(context), // Wordz.shares
                  count: 0,
                  icon: Iconz.Share,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.followers(context),
                  count: 0,
                  icon: Iconz.Follow,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
                  verse: Wordz.bldrsConnected(context),
                  count: 0,
                  icon: Iconz.HandShake,
                  iconSizeFactor: 0.9,
                ),

                BzPgCounter(
                  flyerBoxWidth: screenWidth,
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
