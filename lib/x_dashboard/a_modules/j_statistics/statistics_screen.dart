import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/bz_pg_counter.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
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
      pageTitle: Words.allahoAkbar(context),
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
                  verse: xPhrase(context, 'phid_businesses'),
                  count: _numberOfBzz,
                  icon: Iconz.bz,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_flyers'),
                  count: _numberOfFlyers,
                  icon: Iconz.gallery,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_slides'),
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

                SuperVerse(
                  verse: xPhrase(context, 'phid_bz_statistics'),
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: Ratioz.appBarMargin,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_realtors'),
                  count: 0,
                  icon: Iconz.bxPropertiesOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, Chain.propertyChainID),
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
                  verse: xPhrase(context, 'phid_designers'),
                  count: 0,
                  icon: Iconz.bxDesignsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, Chain.designChainID),
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
                  verse: xPhrase(context, 'phid_suppliers'),
                  count: 0,
                  icon: Iconz.bxEquipmentOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, Chain.productChainID),
                  count: 0,
                  icon: Iconz.flyer,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, Chain.equipmentChainID),
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
                  verse: xPhrase(context, 'phid_contractors'),
                  count: 0,
                  icon: Iconz.bxProjectsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_k_flyer_type_project'),
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
                  verse: xPhrase(context, 'phid_tradesmanship'),
                  count: 0,
                  icon: Iconz.bxTradesOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_k_flyer_type_trade'),
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
                  verse: '${xPhrase(context, 'phid_engagement_rates')} :-',
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: _screenWidth * 0.05,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_totalSaves'), // Wordz.saves
                  count: 0,
                  icon: Iconz.saveOn,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_views'),
                  count: 0,
                  icon: Iconz.viewsIcon,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_totalShares'), // Wordz.shares
                  count: 0,
                  icon: Iconz.share,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_followers'),
                  count: 0,
                  icon: Iconz.follow,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_bldrsConnected'),
                  count: 0,
                  icon: Iconz.handShake,
                  iconSizeFactor: 0.9,
                ),

                BzPgCounter(
                  flyerBoxWidth: _screenWidth,
                  verse: xPhrase(context, 'phid_contact_me_clicks'),
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
