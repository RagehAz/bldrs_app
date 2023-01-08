import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/customs/super_headline.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/protocols/census_protocols.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';


import 'package:bldrs/x_dashboard/bzz_manager/components/census_field_line.dart';
import 'package:bldrs/x_dashboard/bzz_manager/lab/census_lab_screen.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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
  ZoneModel _zone;
  ZoneDepth _zoneDepth;
  CensusModel _censusModel;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await _readCensus();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _readCensus() async {

    await _triggerLoading(setTo: true);

    CensusModel _output;

    if (_zone == null){
      _output = await CensusProtocols.fetchPlanetCensus();
    }

    else {

      if (_zoneDepth == null){

      }

      else if (_zoneDepth == ZoneDepth.country){
        _output = await CensusProtocols.fetchCountryCensus(countryID: _zone.countryID);
      }

      else if (_zoneDepth == ZoneDepth.city){
        _output = await CensusProtocols.fetchCityCensus(cityID: _zone.cityID);
      }

      else if (_zoneDepth == ZoneDepth.district){
        _output = await CensusProtocols.fetchDistrictCensus(districtID: _zone.districtID);
      }


    }

      setState(() {
        _censusModel = _output;

        if (_censusModel == null){
          _zoneDepth = null;
        }

      });

    await _triggerLoading(setTo: false);
  }
  // -----------------------------------------------------------------------------
  String _getHeadline(){

    if (_zone == null){
      return 'Planet';
    }
    else {
      switch (_zoneDepth){
        case ZoneDepth.country:   return 'Country';   break;
        case ZoneDepth.city:      return 'city';      break;
        case ZoneDepth.district:  return 'district';  break;
        default: return 'Nothing found';
      }
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _lineWidth = Bubble.clearWidth(context);

    const double _depthButtonHeight = 35;
    final double _depthButtonsBoxWith = TileBubble.childWidth(context: context);
    final double _depthButtonWidth = Scale.getUniformRowItemWidth(
        context: context,
        numberOfItems: 3,
        boxWidth: _depthButtonsBoxWith,
    );

    Widget _depthButton({
      @required String text,
      @required ZoneDepth depth,
    }){
      return DreamBox(
        isDeactivated: _zone == null,
        height: _depthButtonHeight,
        width: _depthButtonWidth,
        verse: Verse.plain(text),
        color: _zoneDepth == depth ? Colorz.yellow255 : null,
        verseColor: _zoneDepth == depth ? Colorz.black255 : Colorz.white255,
        verseWeight: VerseWeight.thin,
        verseScaleFactor: 0.6,
        onTap: () async {

          setState(() {_zoneDepth = depth;});

          await _readCensus();

        },
        onLongTap: () async {

          setState(() {
            _zoneDepth = null;
            _zone = null;
          });

          await _readCensus();

        },
      );
    }

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidType: PyramidType.crystalYellow,
      title: const Verse(text: 'phid_statistics', translate: true),
      loading: _loading,
      pyramidButtons: <Widget>[

        /// CENSUS LAB SCREEN
        PyramidFloatingButton(
          icon: Iconz.lab,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const CensusLabScreen(),
            );
          },
        ),
        
      ],
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          icon: Iconz.xLarge,
          isDeactivated: _zone == null || _zone == null,
          verse: Verse.plain('Clear'),
          onTap: () async {

            setState(() {
              _zoneDepth = null;
              _zone = null;
            });

            await _readCensus();

          },
        ),

      ],
      child: Scroller(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: Stratosphere.stratosphereSandwich,
          children: <Widget>[

            /// ZONE BUBBLE
            ZoneSelectionBubble(
              zoneViewingEvent: ViewingEvent.admin,
              depth: ZoneDepth.district,
              currentZone: _zone ?? const ZoneModel(
                countryID: null,
                // cityID: null,
                // districtID: null,
              ),
              titleVerse:  const Verse(
                text: 'Select a zone',
                translate: false,
              ),
              onZoneChanged: (ZoneModel zone) async {

                zone?.blogZone(invoker: 'ZONE Received from bubble');

                if (zone != null){
                  setState(() {
                    _zone = zone;
                    _zoneDepth = ZoneDepth.country;
                  });

                  await _readCensus();

                }

              },
            ),

            /// DEPTH BUTTONS
            TileBubble(
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: Verse.plain('Depth'),
              ),
              child: SizedBox(
                width: _depthButtonsBoxWith,
                height: _depthButtonHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    _depthButton(
                      text: _zone?.countryID,
                      depth: ZoneDepth.country,
                    ),

                    _depthButton(
                      text: _zone?.cityID,
                      depth: ZoneDepth.city,
                    ),

                    _depthButton(
                      text: _zone?.districtID,
                      depth: ZoneDepth.district,
                    ),


                  ],
                ),
              ),
            ),

            /// DEPTH HEADLINE
            SuperHeadline(
                verse: Verse.plain(_getHeadline()),
            ),

            /// CENSUS BUILDER
            if (_censusModel != null)
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _scrollController,
              shrinkWrap: true,
              children: <Widget>[

                // -------------------------------------------

                /// GENERAL STATISTICS
                InfoPageHeadline(
                  verse: const Verse(text: 'phid_general_statistics', translate: true,),
                  pageWidth: Scale.screenWidth(context),
                ),

                ///  TOTAL USERS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_users',
                  icon: Iconz.normalUser,
                  count: _censusModel?.totalUsers,
                ),
                /// TOTAL BZZ
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_bzz',
                  icon: Iconz.bz,
                  count: _censusModel?.totalBzz,
                ),
                /// TOTAL AUTHORS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_authors',
                  icon: Iconz.bzWhite,
                  count: _censusModel?.totalAuthors,
                ),
                /// TOTAL FLYERS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_flyers',
                  icon: Iconz.gallery,
                  count: _censusModel?.totalFlyers,
                ),
                /// TOTAL SLIDES
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_slides',
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
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_realestate_developers',
                  count: _censusModel?.bzTypeDeveloper,
                  icon: Iconz.bxPropertiesOn,
                ),
                /// BZ TYPE : BROKERS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_realestate_brokers',
                  count: _censusModel?.bzTypeBroker,
                  icon: Iconz.bxPropertiesOn,
                ),
                /// FLYER TYPE : PROPERTY
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_properties_flyers',
                  count: _censusModel?.flyerTypeProperty,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                // --------------------

                /// BZ TYPE : DESIGNERS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_designers',
                  count: _censusModel?.bzTypeDesigner,
                  icon: Iconz.bxDesignsOn,
                ),
                /// FLYER TYPE : DESIGN
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_design_flyers',
                  count: _censusModel?.flyerTypeDesign,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                // --------------------

                /// BZ TYPE : CONTRACTORS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_contractors',
                  count: _censusModel?.bzTypeContractor,
                  icon: Iconz.bzUndertakingOn,
                ),
                /// FLYER TYPE : PROJECT
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_undertaking_flyers',
                  count: _censusModel?.flyerTypeUndertaking,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                // --------------------

                /// BZ TYPE : ARTISANS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_artisans',
                  count: _censusModel?.bzTypeArtisan,
                  icon: Iconz.bxTradesOn,
                ),
                /// FLYER TYPE : TRADE
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_trade_flyers',
                  count: _censusModel?.flyerTypeTrade,
                  icon: Iconz.flyer,
                ),

                /// SEPARATOR
                const SeparatorLine(),

                // --------------------

                /// BZ TYPE : MANUFACTURER
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_manufacturers',
                  count: _censusModel?.bzTypeManufacturer,
                  icon: Iconz.bxProductsOn,
                ),
                /// BZ TYPE : SUPPLIER
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_suppliers',
                  count: _censusModel?.bzTypeSupplier,
                  icon: Iconz.bxProductsOn,
                ),
                /// FLYER TYPE : PRODUCT
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_product_flyers',
                  count: _censusModel?.flyerTypeProduct,
                  icon: Iconz.flyer,
                ),
                /// FLYER TYPE : EQUIPMENT
                CensusFieldLine(
                  width: _lineWidth,
                  phid: 'phid_total_equipment_flyers',
                  count: _censusModel?.flyerTypeEquipment,
                  icon: Iconz.flyer,
                ),

                // -------------------------------------------

                /// SAVES
                InfoPageHeadline(
                  verse: const Verse(text: 'phid_saves_statistics', translate: true),
                  pageWidth: Scale.screenWidth(context),
                ),

                /// GENERAL SAVES
                CensusFieldLine(
                  width: _lineWidth,
                  phid: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.general),
                  count: _censusModel?.savesGeneral,
                  icon: Iconz.flyer,
                ),
                /// PROPERTIES SAVES
                CensusFieldLine(
                  width: _lineWidth,
                  phid: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.property),
                  count: _censusModel?.savesProperties,
                  icon: Iconz.bxPropertiesOn,
                ),
                /// DESIGNS SAVES
                CensusFieldLine(
                  width: _lineWidth,
                  phid: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.design),
                  count: _censusModel?.savesDesigns,
                  icon: Iconz.bxDesignsOn,
                ),
                /// UNDERTAKINGS SAVES
                CensusFieldLine(
                  width: _lineWidth,
                  phid: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.undertaking),
                  count: _censusModel?.savesUndertakings,
                  icon: Iconz.bzUndertakingOn,
                ),
                /// TRADE SAVES
                CensusFieldLine(
                  width: _lineWidth,
                  phid: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.trade),
                  count: _censusModel?.savesTrades,
                  icon: Iconz.bxTradesOn,
                ),
                /// PRODUCTS SAVES
                CensusFieldLine(
                  width: _lineWidth,
                  phid: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.product),
                  count: _censusModel?.savesProducts,
                  icon: Iconz.bxProductsOn,
                ),
                /// EQUIPMENT SAVES
                CensusFieldLine(
                  width: _lineWidth,
                  phid: FlyerTyper.getFlyerTypePhid(flyerType: FlyerType.equipment),
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
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.developer),
                  count: _censusModel?.followsDevelopers,
                  icon: Iconz.bxPropertiesOff,
                ),
                /// BROKERS FOLLOWS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.broker),
                  count: _censusModel?.followsBrokers,
                  icon: Iconz.bxPropertiesOff,
                ),
                /// DESIGNERS FOLLOWS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.designer),
                  count: _censusModel?.followsDesigners,
                  icon: Iconz.bxDesignsOff,
                ),
                /// CONTRACTORS FOLLOWS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.contractor),
                  count: _censusModel?.followsContractors,
                  icon: Iconz.bxUndertakingOff,
                ),
                /// ARTISANS FOLLOWS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.artisan),
                  count: _censusModel?.followsArtisans,
                  icon: Iconz.bxTradesOff,
                ),
                /// MANUFACTURERS FOLLOWS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.manufacturer),
                  count: _censusModel?.followsManufacturers,
                  icon: Iconz.bxProductsOff,
                ),
                /// SUPPLIERS FOLLOWS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.supplier),
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
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.developer),
                  count: _censusModel?.callsDevelopers,
                  icon: Iconz.bxPropertiesOff,
                ),
                /// BROKERS CALLS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.broker),
                  count: _censusModel?.callsBrokers,
                  icon: Iconz.bxPropertiesOff,
                ),
                /// DESIGNERS CALLS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.designer),
                  count: _censusModel?.callsDesigners,
                  icon: Iconz.bxDesignsOff,
                ),
                /// CONTRACTORS CALLS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.contractor),
                  count: _censusModel?.callsContractors,
                  icon: Iconz.bxUndertakingOff,
                ),
                /// ARTISANS CALLS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.artisan),
                  count: _censusModel?.callsArtisans,
                  icon: Iconz.bxTradesOff,
                ),
                /// MANUFACTURERS CALLS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.manufacturer),
                  count: _censusModel?.callsManufacturers,
                  icon: Iconz.bxProductsOff,
                ),
                /// SUPPLIERS CALLS
                CensusFieldLine(
                  width: _lineWidth,
                  phid: BzTyper.getBzTypePhid(bzType: BzType.supplier),
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
                CensusFieldLine(
                  width: _lineWidth,
                  phid: NeedModel.getNeedTypePhid(NeedType.seekProperty),
                  count: _censusModel?.needTypeSeekProperty,
                  icon: Iconz.bxNewPropertiesOn,
                ),
                /// PLANNING CONSTRUCTION
                CensusFieldLine(
                  width: _lineWidth,
                  phid: NeedModel.getNeedTypePhid(NeedType.planConstruction),
                  count: _censusModel?.needTypePlanConstruction,
                  icon: Iconz.bzUndertakingOn,
                ),
                /// FINISHING CONSTRUCTION
                CensusFieldLine(
                  width: _lineWidth,
                  phid: NeedModel.getNeedTypePhid(NeedType.finishConstruction),
                  count: _censusModel?.needTypeFinishConstruction,
                  icon: Iconz.bxUndertakingOff,
                ),
                /// FURNISH PROPERTY
                CensusFieldLine(
                  width: _lineWidth,
                  phid: NeedModel.getNeedTypePhid(NeedType.furnish),
                  count: _censusModel?.needTypeFurnish,
                  icon: Iconz.yellowAlert,
                ),
                /// OFFER PROPERTY
                CensusFieldLine(
                  width: _lineWidth,
                  phid: NeedModel.getNeedTypePhid(NeedType.offerProperty),
                  count: _censusModel?.needTypeOfferProperty,
                  icon: Iconz.yellowAlert,
                ),

                /// SEPARATOR
                const SeparatorLine(),

              ],
            ),

          ],
        ),
      ),

    );

  }
}
