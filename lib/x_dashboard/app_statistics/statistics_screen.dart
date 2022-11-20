import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_back_end/c_real/widgets/real_doc_streamer.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/app_statistics/components/census_line.dart';
import 'package:flutter/material.dart';

class GeneralStatistics extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GeneralStatistics({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidType: PyramidType.crystalYellow,
      pageTitleVerse: Verse.plain('Statistics'),
      layoutWidget:

      /// STREAM : DB / admin / statistics
      RealDocStreamer(
        collName: 'statistics',
        docName: 'planet',
        // initialData: null,
        builder: (BuildContext context,  Map<String, dynamic> map) {

          if (map == null) {
            return const Loading(
              loading: true,
            );
          }

          else {

            final CensusModel _censusModel = CensusModel.decipher(map);

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[

                const Stratosphere(),

                // -------------------------------------------

                /// GENERAL STATISTICS
                InfoPageHeadline(
                  verse: const Verse(text: 'phid_general_statistics', translate: true,),
                  pageWidth: Scale.screenWidth(context),
                ),

                ///  TOTAL USERS
                CensusLine(
                  verse: const Verse(text: 'phid_users', translate: true),
                  icon: Iconz.normalUser,
                  count: _censusModel?.totalUsers,
                ),
                /// TOTAL COUNTRIES
                const CensusLine(
                  verse: Verse(text: 'phid_countries', translate: true,),
                  icon: Iconz.earth,
                  count: 0,
                ),
                /// TOTAL BZZ
                CensusLine(
                  verse: const Verse(text: 'phid_bzz', translate: true,),
                  icon: Iconz.bz,
                  count: _censusModel?.totalBzz,
                ),
                /// TOTAL AUTHORS
                CensusLine(
                  verse: const Verse(text: 'phid_authors', translate: true,),
                  icon: Iconz.bzWhite,
                  count: _censusModel?.totalAuthors,
                ),
                /// TOTAL FLYERS
                CensusLine(
                  verse: const Verse(text: 'phid_flyers', translate: true,),
                  icon: Iconz.gallery,
                  count: _censusModel?.totalFlyers,
                ),
                /// TOTAL SLIDES
                CensusLine(
                  verse: const Verse(text: 'phid_slides', translate: true,),
                  icon: Iconz.flyer,
                  count: _censusModel?.totalSlides,
                ),

                // -------------------------------------------

                /// BZZ AND FLYERS STATISTICS
                InfoPageHeadline(
                  verse: const Verse(text: 'phid_bzz_statistics', translate: true,),
                  pageWidth: Scale.screenWidth(context),
                ),

                /// BZ TYPE : DEVELOPERS
                CensusLine(
                  verse: const Verse(text: 'phid_developers', translate: true,),
                  count: _censusModel?.bzTypeDeveloper,
                  icon: Iconz.bxPropertiesOn,
                ),
                /// BZ TYPE : BROKERS
                CensusLine(
                  verse: const Verse(text: 'phid_brokers', translate: true,),
                  count: _censusModel?.bzTypeBroker,
                  icon: Iconz.bxPropertiesOn,
                ),
                /// FLYER TYPE : PROPERTY
                CensusLine(
                  verse: const Verse(text: FlyerTyper.propertyChainID, translate: true,),
                  count: _censusModel?.flyerTypeProperty,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                /// BZ TYPE : DESIGNERS
                CensusLine(
                  verse: const Verse(text: 'phid_designers', translate: true,),
                  count: _censusModel?.bzTypeDesigner,
                  icon: Iconz.bxDesignsOn,
                ),
                /// FLYER TYPE : DESIGN
                CensusLine(
                  verse: const Verse(text: FlyerTyper.designChainID, translate: true,),
                  count: _censusModel?.flyerTypeDesign,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                /// BZ TYPE : CONTRACTORS
                CensusLine(
                  verse: const Verse(text: 'phid_contractors', translate: true,),
                  count: _censusModel?.bzTypeContractor,
                  icon: Iconz.bxProjectsOn,
                ),
                /// FLYER TYPE : PROJECT
                CensusLine(
                  verse: const Verse(text: 'phid_project_flyer', translate: true,),
                  count: _censusModel?.flyerTypeProject,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                /// BZ TYPE : ARTISANS
                CensusLine(
                  verse: const Verse(text: 'phid_artisans', translate: true,),
                  count: _censusModel?.bzTypeArtisan,
                  icon: Iconz.bxTradesOn,
                ),
                /// FLYER TYPE : TRADE
                CensusLine(
                  verse: const Verse(text: FlyerTyper.tradesChainID, translate: true,),
                  count: _censusModel?.flyerTypeTrade,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                /// BZ TYPE : MANUFACTURER
                CensusLine(
                  verse: const Verse(text: 'phid_manufacturer', translate: true,),
                  count: _censusModel?.bzTypeManufacturer,
                  icon: Iconz.bxProductsOn,
                ),
                /// BZ TYPE : SUPPLIER
                CensusLine(
                  verse: const Verse(text: 'phid_supplier', translate: true,),
                  count: _censusModel?.bzTypeSupplier,
                  icon: Iconz.bxProductsOn,
                ),
                /// FLYER TYPE : PRODUCT
                CensusLine(
                  verse: const Verse(text: FlyerTyper.productChainID, translate: true,),
                  count: _censusModel?.flyerTypeProduct,
                  icon: Iconz.flyer,
                ),
                /// FLYER TYPE : EQUIPMENT
                CensusLine(
                  verse: const Verse(text: FlyerTyper.equipmentChainID, translate: true,),
                  count: _censusModel?.flyerTypeEquipment,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                // -------------------------------------------

                /// ENGAGEMENT RATES
                InfoPageHeadline(
                  verse: const Verse(text: 'phid_engagement_rates', translate: false,),
                  pageWidth: Scale.screenWidth(context),
                ),

                /// TOTAL SAVES
                const CensusLine(
                  verse: Verse(text: 'phid_totalSaves', translate: true,), // Wordz.saves
                  count: 0,
                  icon: Iconz.saveOn,
                ),
                /// TOTAL FOLLOWS
                const CensusLine(
                  verse: Verse(text: 'phid_follows', translate: true,),
                  count: 0,
                  icon: Iconz.follow,
                ),
                /// TOTAL CONTACTS
                const CensusLine(
                  verse: Verse(text: 'phid_contact_me_clicks', translate: true,),
                  count: 0,
                  icon: Iconz.comPhone,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                // -------------------------------------------

                const Horizon(),

              ],
            );

          }
        },
      ),

    );

  }
  /// --------------------------------------------------------------------------
}
