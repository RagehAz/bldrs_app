import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_back_end/c_real/widgets/real_doc_streamer.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/app_statistics/components/census_line.dart';
import 'package:flutter/material.dart';

class GeneralStatistics extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GeneralStatistics({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<GeneralStatistics> createState() => _GeneralStatisticsState();
  /// --------------------------------------------------------------------------
}

class _GeneralStatisticsState extends State<GeneralStatistics> {
  // --------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidType: PyramidType.crystalYellow,
      pageTitleVerse: const Verse(text: 'phid_statistics', translate: true),
      layoutWidget:

      /// STREAM : DB / admin / statistics
      RealDocStreamer(
        collName: 'statistics',
        docName: 'planet',
        // initialData: null,
        builder: (BuildContext context,  Map<String, dynamic> map) {

          final CensusModel _censusModel = CensusModel.decipher(map);

          return ListView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
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
                verse: const Verse(text: 'phid_total_users', translate: true),
                icon: Iconz.normalUser,
                count: _censusModel?.totalUsers,
              ),
              /// TOTAL BZZ
              CensusLine(
                verse: const Verse(text: 'phid_total_bzz', translate: true,),
                icon: Iconz.bz,
                count: _censusModel?.totalBzz,
              ),
              /// TOTAL AUTHORS
              CensusLine(
                verse: const Verse(text: 'phid_total_authors', translate: true,),
                icon: Iconz.bzWhite,
                count: _censusModel?.totalAuthors,
              ),
              /// TOTAL FLYERS
              CensusLine(
                verse: const Verse(text: 'phid_total_flyers', translate: true,),
                icon: Iconz.gallery,
                count: _censusModel?.totalFlyers,
              ),
              /// TOTAL SLIDES
              CensusLine(
                verse: const Verse(text: 'phid_total_slides', translate: true,),
                icon: Iconz.flyer,
                count: _censusModel?.totalSlides,
              ),

              /// ===
              // /// TOTAL COUNTRIES
              // const CensusLine(
              //   verse: Verse(text: 'phid_countries', translate: true,),
              //   icon: Iconz.earth,
              //   count: 0,
              // ),
              /// ===

              // -------------------------------------------

              /// BZZ STATISTICS
              InfoPageHeadline(
                verse: const Verse(text: 'phid_bz_statistics', translate: true,),
                pageWidth: Scale.screenWidth(context),
              ),

              /// BZ TYPE : DEVELOPERS
              CensusLine(
                verse: const Verse(text: 'phid_total_realestate_developers', translate: true,),
                count: _censusModel?.bzTypeDeveloper,
                icon: Iconz.bxPropertiesOn,
              ),
              /// BZ TYPE : BROKERS
              CensusLine(
                verse: const Verse(text: 'phid_total_realestate_brokers', translate: true,),
                count: _censusModel?.bzTypeBroker,
                icon: Iconz.bxPropertiesOn,
              ),
              /// FLYER TYPE : PROPERTY
              CensusLine(
                verse: const Verse(text: 'phid_total_properties_flyers', translate: true,),
                count: _censusModel?.flyerTypeProperty,
                icon: Iconz.flyer,
              ),

              /// SEPARATOR
              const SeparatorLine(),

              // --------------------

              /// BZ TYPE : DESIGNERS
              CensusLine(
                verse: const Verse(text: 'phid_total_designers', translate: true,),
                count: _censusModel?.bzTypeDesigner,
                icon: Iconz.bxDesignsOn,
              ),
              /// FLYER TYPE : DESIGN
              CensusLine(
                verse: const Verse(text: 'phid_total_design_flyers', translate: true,),
                count: _censusModel?.flyerTypeDesign,
                icon: Iconz.flyer,
              ),

              /// SEPARATOR
              const SeparatorLine(),

              // --------------------

              /// BZ TYPE : CONTRACTORS
              CensusLine(
                verse: const Verse(text: 'phid_total_contractors', translate: true,),
                count: _censusModel?.bzTypeContractor,
                icon: Iconz.bzUndertakingOn,
              ),
              /// FLYER TYPE : PROJECT
              CensusLine(
                verse: const Verse(text: 'phid_total_undertaking_flyers', translate: true,),
                count: _censusModel?.flyerTypeUndertaking,
                icon: Iconz.flyer,
              ),

              /// SEPARATOR
              const SeparatorLine(),

              // --------------------

              /// BZ TYPE : ARTISANS
              CensusLine(
                verse: const Verse(text: 'phid_total_artisans', translate: true,),
                count: _censusModel?.bzTypeArtisan,
                icon: Iconz.bxTradesOn,
              ),
              /// FLYER TYPE : TRADE
              CensusLine(
                verse: const Verse(text: 'phid_total_trade_flyers', translate: true,),
                count: _censusModel?.flyerTypeTrade,
                icon: Iconz.flyer,
              ),

              /// SEPARATOR
              const SeparatorLine(),

              // --------------------

              /// BZ TYPE : MANUFACTURER
              CensusLine(
                verse: const Verse(text: 'phid_total_manufacturers', translate: true,),
                count: _censusModel?.bzTypeManufacturer,
                icon: Iconz.bxProductsOn,
              ),
              /// BZ TYPE : SUPPLIER
              CensusLine(
                verse: const Verse(text: 'phid_total_suppliers', translate: true,),
                count: _censusModel?.bzTypeSupplier,
                icon: Iconz.bxProductsOn,
              ),
              /// FLYER TYPE : PRODUCT
              CensusLine(
                verse: const Verse(text: 'phid_total_product_flyers', translate: true,),
                count: _censusModel?.flyerTypeProduct,
                icon: Iconz.flyer,
              ),
              /// FLYER TYPE : EQUIPMENT
              CensusLine(
                verse: const Verse(text: 'phid_total_equipment_flyers', translate: true,),
                count: _censusModel?.flyerTypeEquipment,
                icon: Iconz.flyer,
              ),

              // -------------------------------------------

              /// SAVES
              InfoPageHeadline(
                verse: const Verse(text: 'phid_saves_statistics', translate: true,),
                pageWidth: Scale.screenWidth(context),
              ),

              /// GENERAL SAVES
              CensusLine(
                verse: Verse(text: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.general), translate: true,), // Wordz.saves
                count: _censusModel?.savesGeneral,
                icon: Iconz.flyer,
              ),
              /// PROPERTIES SAVES
              CensusLine(
                verse: Verse(text: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.property), translate: true,), // Wordz.saves
                count: _censusModel?.savesProperties,
                icon: Iconz.bxPropertiesOn,
              ),
              /// DESIGNS SAVES
              CensusLine(
                verse: Verse(text: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.design), translate: true,), // Wordz.saves
                count: _censusModel?.savesDesigns,
                icon: Iconz.bxDesignsOn,
              ),
              /// UNDERTAKINGS SAVES
              CensusLine(
                verse: Verse(text: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.undertaking), translate: true,), // Wordz.saves
                count: _censusModel?.savesUndertakings,
                icon: Iconz.bzUndertakingOn,
              ),
              /// TRADE SAVES
              CensusLine(
                verse: Verse(text: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.trade), translate: true,), // Wordz.saves
                count: _censusModel?.savesTrades,
                icon: Iconz.bxTradesOn,
              ),
              /// PRODUCTS SAVES
              CensusLine(
                verse: Verse(text: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.product), translate: true,), // Wordz.saves
                count: _censusModel?.savesProducts,
                icon: Iconz.bxProductsOn,
              ),
              /// EQUIPMENT SAVES
              CensusLine(
                verse: Verse(text: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.equipment), translate: true,), // Wordz.saves
                count: _censusModel?.savesEquipments,
                icon: Iconz.bxEquipmentOn,
              ),

              // -------------------------------------------

              /// FOLLOWS
              InfoPageHeadline(
                verse: const Verse(text: 'phid_follows_statistics', translate: true,),
                pageWidth: Scale.screenWidth(context),
              ),

              /// DEVELOPERS FOLLOWS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.developer), translate: true,),
                count: _censusModel?.followsDevelopers,
                icon: Iconz.bxPropertiesOff,
              ),
              /// BROKERS FOLLOWS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.broker), translate: true,),
                count: _censusModel?.followsBrokers,
                icon: Iconz.bxPropertiesOff,
              ),
              /// DESIGNERS FOLLOWS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.designer), translate: true,),
                count: _censusModel?.followsDesigners,
                icon: Iconz.bxDesignsOff,
              ),
              /// CONTRACTORS FOLLOWS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.contractor), translate: true,),
                count: _censusModel?.followsContractors,
                icon: Iconz.bxUndertakingOff,
              ),
              /// ARTISANS FOLLOWS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.artisan), translate: true,),
                count: _censusModel?.followsArtisans,
                icon: Iconz.bxTradesOff,
              ),
              /// MANUFACTURERS FOLLOWS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.manufacturer), translate: true,),
                count: _censusModel?.followsManufacturers,
                icon: Iconz.bxProductsOff,
              ),
              /// SUPPLIERS FOLLOWS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.supplier), translate: true,),
                count: _censusModel?.followsSuppliers,
                icon: Iconz.bxProductsOff,
              ),

              /// SEPARATOR
              const SeparatorLine(),

              // -------------------------------------------

              /// CALLS
              InfoPageHeadline(
                verse: const Verse(text: 'phid_calls_statistics', translate: true,),
                pageWidth: Scale.screenWidth(context),
              ),

              /// DEVELOPERS CALLS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.developer), translate: true,),
                count: _censusModel?.callsDevelopers,
                icon: Iconz.bxPropertiesOff,
              ),
              /// BROKERS CALLS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.broker), translate: true,),
                count: _censusModel?.callsBrokers,
                icon: Iconz.bxPropertiesOff,
              ),
              /// DESIGNERS CALLS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.designer), translate: true,),
                count: _censusModel?.callsDesigners,
                icon: Iconz.bxDesignsOff,
              ),
              /// CONTRACTORS CALLS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.contractor), translate: true,),
                count: _censusModel?.callsContractors,
                icon: Iconz.bxUndertakingOff,
              ),
              /// ARTISANS CALLS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.artisan), translate: true,),
                count: _censusModel?.callsArtisans,
                icon: Iconz.bxTradesOff,
              ),
              /// MANUFACTURERS CALLS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.manufacturer), translate: true,),
                count: _censusModel?.callsManufacturers,
                icon: Iconz.bxProductsOff,
              ),
              /// SUPPLIERS CALLS
              CensusLine(
                verse: Verse(text: BzTyper.getBzTypePhid(bzType: BzType.supplier), translate: true,),
                count: _censusModel?.callsSuppliers,
                icon: Iconz.bxProductsOff,
              ),


              // -------------------------------------------

              /// NEEDS
              InfoPageHeadline(
                verse: const Verse(text: 'phid_needs_statistics', translate: true,),
                pageWidth: Scale.screenWidth(context),
              ),

              /// SEEKING PROPERTY
              CensusLine(
                verse: Verse(text: NeedModel.getNeedTypePhid(NeedType.seekProperty), translate: true,),
                count: _censusModel?.needTypeSeekProperty,
                icon: Iconz.bxNewPropertiesOn,
              ),
              /// PLANNING CONSTRUCTION
              CensusLine(
                verse: Verse(text: NeedModel.getNeedTypePhid(NeedType.planConstruction), translate: true,),
                count: _censusModel?.needTypePlanConstruction,
                icon: Iconz.bzUndertakingOn,
              ),
              /// FINISHING CONSTRUCTION
              CensusLine(
                verse: Verse(text: NeedModel.getNeedTypePhid(NeedType.finishConstruction), translate: true,),
                count: _censusModel?.needTypeFinishConstruction,
                icon: Iconz.bxUndertakingOff,
              ),
              /// FURNISH PROPERTY
              CensusLine(
                verse: Verse(text: NeedModel.getNeedTypePhid(NeedType.furnish), translate: true,),
                count: _censusModel?.needTypeFurnish,
                icon: Iconz.yellowAlert,
              ),
              /// OFFER PROPERTY
              CensusLine(
                verse: Verse(text: NeedModel.getNeedTypePhid(NeedType.offerProperty), translate: true,),
                count: _censusModel?.needTypeOfferProperty,
                icon: Iconz.yellowAlert,
              ),

              /// SEPARATOR
              const SeparatorLine(),

              const Horizon(),

            ],
          );

        },
      ),

    );

  }
}
