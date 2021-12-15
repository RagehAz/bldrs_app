import 'package:bldrs/b_views/widgets/components/expander.dart';
import 'package:bldrs/b_views/widgets/components/stratosphere.dart';
import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_counter.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class GeneralStatistics extends StatelessWidget {
  const GeneralStatistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    return MainLayout(
      pyramids: Iconz.pyramidsYellow,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pageTitle: Wordz.allahoAkbar(context),
      appBarRowWidgets: const <Widget>[
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
        stream: Fire.streamDoc(FireColl.admin, 'statistics'),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
          if (StreamChecker.connectionIsLoading(snapshot) == true) {
            return const Loading(
              loading: true,
            );
          } else {
            final dynamic map = snapshot.data;

            final int _numberOfUsers = map['numberOfUsers'];
            final int _numberOfCountries = map['numberOfCountries'];
            final int _numberOfBzz = map['numberOfBzz'];
            final int _numberOfFlyers = map['numberOfFlyers'];
            final int _numberOfSlides = map['numberOfSlides'];

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[

                const Stratosphere(),

                const SuperVerse(
                  verse: 'General states :-',
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
                  icon: Iconz.normalUser,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: 'Countries',
                  count: _numberOfCountries,
                  icon: Iconz.earth,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.businesses(context),
                  count: _numberOfBzz,
                  icon: Iconz.bz,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.flyers(context),
                  count: _numberOfFlyers,
                  icon: Iconz.gallery,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: 'slides', //Wordz.slides,
                  count: _numberOfSlides,
                  icon: Iconz.flyer,
                  iconSizeFactor: 0.8,
                ),

                /// --- SECTION SEPARATOR
                Container(
                  width: _screenWidth,
                  height: _screenWidth * 0.002,
                  color: Colorz.yellow255,
                  // margin: EdgeInsets.only(top: screenWidth * 0.05),
                ),

                const SuperVerse(
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
                  icon: Iconz.bxPropertiesOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.propertyFlyer(context),
                  count: 0,
                  icon: Iconz.flyer,
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
                  icon: Iconz.bxDesignsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.designFlyer(context),
                  count: 0,
                  icon: Iconz.flyer,
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
                  icon: Iconz.bxEquipmentOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.productFlyer(context),
                  count: 0,
                  icon: Iconz.flyer,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.equipmentFlyer(context),
                  count: 0,
                  icon: Iconz.flyer,
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
                  icon: Iconz.bxProjectsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.projectFlyer(context),
                  count: 0,
                  icon: Iconz.flyer,
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
                  icon: Iconz.bxCraftsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.craftFlyer(context),
                  count: 0,
                  icon: Iconz.flyer,
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
                  icon: Iconz.saveOn,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.views(context),
                  count: 0,
                  icon: Iconz.viewsIcon,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.totalShares(context), // Wordz.shares
                  count: 0,
                  icon: Iconz.share,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.followers(context),
                  count: 0,
                  icon: Iconz.follow,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: Wordz.bldrsConnected(context),
                  count: 0,
                  icon: Iconz.handShake,
                  iconSizeFactor: 0.9,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: 'Contact me clicks',
                  count: 0,
                  icon: Iconz.comPhone,
                  iconSizeFactor: 0.8,
                ),

                /// --- THE END
                SizedBox(
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
