import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/bz_pg_counter.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

class GeneralStatistics extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GeneralStatistics({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = MediaQuery.of(context).size.width;

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidType: PyramidType.crystalYellow,
      sectionButtonIsOn: false,
      pageTitleVerse: Verse.plain(Words.allahoAkbar(context)),
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
        stream: Fire.streamDoc(
          collName: FireColl.admin,
          docName: 'statistics',
        ),
        // initialData: null,
        builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {

          if (Streamer.connectionIsLoading(snapshot) == true) {
            return const Loading(
              loading: true,
            );
          }

          else {

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
                  verse: Verse(
                    text: 'General states :-',
                    translate: false,
                  ),
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: Ratioz.appBarMargin,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_users',
                    translate: true,
                  ),
                  count: _numberOfUsers,
                  icon: Iconz.normalUser,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'Countries',
                    translate: true,
                  ),
                  count: _numberOfCountries,
                  icon: Iconz.earth,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_businesses',
                    translate: true,
                  ),
                  count: _numberOfBzz,
                  icon: Iconz.bz,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_flyers',
                    translate: true,
                  ),
                  count: _numberOfFlyers,
                  icon: Iconz.gallery,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_slides',
                    translate: true,
                  ),
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
                  verse: Verse(
                    text: 'phid_bz_statistics',
                    translate: false,
                  ),
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: Ratioz.appBarMargin,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_realtors',
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.bxPropertiesOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: FlyerTyper.propertyChainID,
                    translate: true,
                  ),
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
                  verse: const Verse(
                    text: 'phid_designers',
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.bxDesignsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: FlyerTyper.designChainID,
                    translate: true,
                  ),
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
                  verse: const Verse(
                    text: 'phid_suppliers',
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.bxEquipmentOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: FlyerTyper.productChainID,
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.flyer,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: FlyerTyper.equipmentChainID,
                    translate: true,
                  ),
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
                  verse: const Verse(
                    text: 'phid_contractors',
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.bxProjectsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_k_flyer_type_project',
                    translate: true,
                  ),
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
                  verse: const Verse(
                    text: 'phid_tradesmanship',
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.bxTradesOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_k_flyer_type_trade',
                    translate: true,
                  ),
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
                  verse: const Verse(
                    text: 'phid_engagement_rates',
                    translate: true,
                  ),
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: _screenWidth * 0.05,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_totalSaves',
                    translate: true,
                  ), // Wordz.saves
                  count: 0,
                  icon: Iconz.saveOn,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_views',
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.viewsIcon,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_totalShares',
                    translate: true
                  ),
                  count: 0,
                  icon: Iconz.share,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_followers',
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.follow,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_bldrsConnected',
                    translate: true,
                  ),
                  count: 0,
                  icon: Iconz.handShake,
                  iconSizeFactor: 0.9,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: const Verse(
                    text: 'phid_contact_me_clicks',
                    translate: true,
                  ),
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
  /// --------------------------------------------------------------------------
}
