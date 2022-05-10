import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/double_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/integer_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/price_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/spec_picker_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecPickerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreen({
    @required this.specPicker,
    @required this.allSelectedSpecs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final List<SpecModel> allSelectedSpecs;
  /// --------------------------------------------------------------------------
  static const double instructionBoxHeight = 50;
  /// --------------------------------------------------------------------------
  @override
  State<SpecPickerScreen> createState() => _SpecPickerScreenState();
  /// --------------------------------------------------------------------------
}

class _SpecPickerScreenState extends State<SpecPickerScreen> {

  // List<Spec> _selectedSpecs = [];
  final ValueNotifier<List<SpecModel>> _selectedSpecs = ValueNotifier<List<SpecModel>>(<SpecModel>[]); /// dispose
  // -----------------------------------------------------------------------------
  Chain _specChain;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    _selectedSpecs.value = widget.allSelectedSpecs;
    // Spec.getSpecsByListID(specsList: widget.allSelectedSpecs, specsListID: widget.specList.id)
    _specChain = superGetChain(context, widget.specPicker.chainID);

    super.initState();
  }
  // -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
    _selectedSpecs.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSpecTap(BuildContext context, String keywordID) async {
    blog('received kw id : $keywordID');

    // spec.printSpec();
    final SpecModel _spec = SpecModel(
      pickerChainID: widget.specPicker.chainID,
      value: keywordID,
    );

    final bool _alreadySelected = SpecModel.specsContainThisSpec(specs: _selectedSpecs.value, spec: _spec);
    final int _specIndex = _selectedSpecs.value.indexWhere((SpecModel sp) => sp.value == _spec.value);

    // ----------------------------------------------------------
    /// A - ALREADY SELECTED SPEC
    if (_alreadySelected == true) {
      /// A1 - CAN PICK MANY
      if (widget.specPicker.canPickMany == true) {
        final List<SpecModel> _specs = [..._selectedSpecs.value];
        _specs.removeAt(_specIndex);
        _selectedSpecs.value = _specs;

        // _selectedSpecs.value.removeAt(_specIndex);
      }

      /// A2 - CAN NOT PICK MANY
      else {
        final List<SpecModel> _specs = [..._selectedSpecs.value];
        _specs.removeAt(_specIndex);
        _selectedSpecs.value = _specs;

        // _selectedSpecs.value.removeAt(_specIndex);

      }
    }
    // ----------------------------------------------------------
    /// B - NEW SELECTED SPEC
    else {
      /// B1 - WHEN CAN PICK MANY
      if (widget.specPicker.canPickMany == true) {
        final List<SpecModel> _specs = [..._selectedSpecs.value, _spec];
        _selectedSpecs.value = _specs;

        // _selectedSpecs.value .add(_spec);

      }

      /// B2 - WHEN CAN NOT PICK MANY
      else {
        final int _specIndex = _selectedSpecs.value
            .indexWhere((SpecModel spec) => spec.pickerChainID == widget.specPicker.chainID);

        /// C1 - WHEN NO SPEC OF THIS KIND IS SELECTED
        if (_specIndex == -1) {
          final List<SpecModel> _specs = [..._selectedSpecs.value, _spec];
          _selectedSpecs.value = _specs;

          // _selectedSpecs.value.add(_spec);

        }

        /// C2 - WHEN A SPEC OF THIS KIND ALREADY EXISTS TO BE REPLACED
        else {
          final List<SpecModel> _specs = [..._selectedSpecs.value];
          _specs.removeAt(_specIndex);
          _specs.add(_spec);
          _selectedSpecs.value = _specs;

          // _selectedSpecs.value.removeAt(_specIndex);
          // _selectedSpecs.value.add(_spec);

        }
      }
    }
    // ----------------------------------------------------------

    // _selectedSpecs.notifyListeners();
  }
// -----------------------------------------------------------------------------
  void _onCurrencyChanged(CurrencyModel currency) {

    final SpecModel _currencySpec = SpecModel(
        pickerChainID: 'currency',
        value: currency.code,
    );

    final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: <SpecModel>[_currencySpec],
      canPickMany: false,
    );

    _selectedSpecs.value = _updatedList;
  }
// -----------------------------------------------------------------------------
  void _onPriceChanged(String price) {
    final double _priceDouble = Numeric.stringToDouble(price);
    final SpecModel _priceSpec = SpecModel(pickerChainID: widget.specPicker.chainID, value: _priceDouble);
    final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: <SpecModel>[_priceSpec],
      canPickMany: widget.specPicker.canPickMany,
    );
    _selectedSpecs.value = _updatedList;
  }
// -----------------------------------------------------------------------------
  void _onAddInteger(int integer) {

    blog('received integer : $integer');
    final SpecModel _integerSpec = SpecModel(
        pickerChainID: widget.specPicker.chainID,
        value: integer,
    );

    final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: <SpecModel>[_integerSpec],
      canPickMany: widget.specPicker.canPickMany,
    );

    _selectedSpecs.value = _updatedList;
  }
// -----------------------------------------------------------------------------
  void _onAddDouble(double num) {

    blog('received double : $num');
    final SpecModel _doubleSpec = SpecModel(
        pickerChainID: widget.specPicker.chainID,
        value: num,
    );

    final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: <SpecModel>[_doubleSpec],
      canPickMany: widget.specPicker.canPickMany,
    );

    _selectedSpecs.value = _updatedList;
  }
// -----------------------------------------------------------------------------
  void _onBack() {
    Nav.goBack(context, argument: _selectedSpecs.value);
    // await null;
  }
// -----------------------------------------------------------------------------
  String _getInstructions() {
    String _instructions;

    if (_specChain.sons.runtimeType == DataCreator) {
      _instructions = 'Specify this';
    }

    else {
      _instructions = widget.specPicker.canPickMany == true
          ? 'You may pick multiple specifications from this list'
          : 'You can pick only one specification from this list';
    }

    return _instructions;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    final double _listZoneHeight =
              _screenHeight
            - Ratioz.stratosphere
            - SpecPickerScreen.instructionBoxHeight;

    final String _instructions = _getInstructions();

    final String _pageTitle = superPhrase(context, widget.specPicker.chainID);

    blog('SpecPickerScreen : ${_specChain.id} : sons ${_specChain.sons} : sons type ${_specChain.sons.runtimeType}');

    /*
    [{id: phid_s_style, sons: [phid_s_arch_style_arabian, phid_s_arch_style_andalusian, phid_s_arch_style_asian, phid_s_arch_style_chinese, phid_s_arch_style_contemporary, phid_s_arch_style_classic, phid_s_arch_style_eclectic, phid_s_arch_style_english, phid_s_arch_style_farmhouse, phid_s_arch_style_french, phid_s_arch_style_gothic, phid_s_arch_style_greek, phid_s_arch_style_indian, phid_s_arch_style_industrial, phid_s_arch_style_japanese, phid_s_arch_style_mediterranean, phid_s_arch_style_midcentury, phid_s_arch_style_medieval, phid_s_arch_style_minimalist, phid_s_arch_style_modern, phid_s_arch_style_moroccan, phid_s_arch_style_rustic, phid_s_arch_style_scandinavian, phid_s_arch_style_shabbyChic, phid_s_arch_style_american, phid_s_arch_style_spanish, phid_s_arch_style_traditional, phid_s_arch_style_transitional, phid_s_arch_style_tuscan, phid_s_arch_style_tropical, phid_s_arch_style_victorian, phid_s_arch_style_vintage]}, {id: phid_s_color, sons: [phid_s_red, phid_s_orange, phid_s_yellow, phid_s_green, phid_s_blue, phid_s_indigo, phid_s_violet, phid_s_black, phid_s_white, phid_s_grey]}, {id: phid_s_contractType, sons: [phid_s_contractType_NewSale, phid_s_contractType_Resale, phid_s_contractType_Rent]}, {id: phid_s_paymentMethod, sons: [phid_s_payment_cash, phid_s_payment_installments]}, {id: phid_s_price, sons: DataCreator_price}, {id: phid_s_currency, sons: DataCreator_currency}, {id: phid_s_unitPriceInterval, sons: [phid_s_perHour, phid_s_perDay, phid_s_perWeek, phid_s_perMonth, phid_s_perYear]}, {id: phid_s_numberOfInstallments, sons: DataCreator_integerIncrementer}, {id: phid_s_installmentsDuration, sons: DataCreator_integerIncrementer}, {id: phid_s_installmentsDurationUnit, sons: [phid_s_installmentsDurationUnit_day, phid_s_installmentsDurationUnit_week, phid_s_installmentsDurationUnit_month, phid_s_installmentsDurationUnit_year]}, {id: phid_s_duration, sons: DataCreator_integerIncrementer}, {id: phid_s_durationUnit, sons: [phid_s_minute, phid_s_hour, phid_s_day, phid_s_week, phid_s_month, phid_s_year]}, {id: phid_s_propertyArea, sons: DataCreator_doubleCreator}, {id: phid_s_propertyAreaUnit, sons: [phid_s_square_meter, phid_s_square_feet]}, {id: phid_s_plotArea, sons: DataCreator_doubleCreator}, {id: phid_s_lotAreaUnit, sons: [phid_square_meter, phid_square_Kilometer, phid_square_feet, phid_square_yard, phid_acre, phid_hectare]}, {id: phid_s_propertyForm, sons: [phid_s_pf_fullFloor, phid_s_pf_halfFloor, phid_s_pf_partFloor, phid_s_pf_building, phid_s_pf_land, phid_s_pf_mobile]}, {id: phid_s_propertyLicense, sons: [phid_s_ppt_lic_residential, phid_s_ppt_lic_administration, phid_s_ppt_lic_educational, phid_s_ppt_lic_utilities, phid_s_ppt_lic_sports, phid_s_ppt_lic_entertainment, phid_s_ppt_lic_medical, phid_s_ppt_lic_retail, phid_s_ppt_lic_hotel, phid_s_ppt_lic_industrial]}, {id: phid_s_group_space_type, sons: [{id: phid_s_ppt_lic_administration, sons: [phid_s_pt_office, phid_s_space_kitchenette, phid_s_space_meetingRoom, phid_s_space_seminarHall, phid_s_space_conventionHall]}, {id: phid_s_ppt_lic_educational, sons: [phid_s_space_lectureRoom, phid_s_space_library]}, {id: phid_s_ppt_lic_entertainment, sons: [phid_s_space_theatre, phid_s_space_concertHall, phid_s_space_homeCinema]}, {id: phid_s_ppt_lic_medical, sons: [phid_s_space_spa]}, {id: phid_s_ppt_lic_residential, sons: [phid_s_space_lobby, phid_s_space_living, phid_s_space_bedroom, phid_s_space_kitchen, phid_s_space_bathroom, phid_s_space_reception, phid_s_space_salon, phid_s_space_laundry, phid_s_space_balcony, phid_s_space_toilet, phid_s_space_dining, phid_s_space_stairs, phid_s_space_attic, phid_s_space_corridor, phid_s_space_garage, phid_s_space_storage, phid_s_space_maid, phid_s_space_walkInCloset, phid_s_space_barbecue, phid_s_space_garden, phid_s_space_privatePool]}, {id: phid_s_ppt_lic_retail, sons: [phid_s_space_store]}, {id: phid_s_ppt_lic_sports, sons: [phid_s_space_gymnasium, phid_s_space_sportsCourt, phid_s_space_sportStadium]}, {id: phid_s_ppt_lic_utilities, sons: [phid_s_pFeature_elevator, phid_s_space_electricityRoom, phid_s_space_plumbingRoom, phid_s_space_mechanicalRoom]}]}, {id: phid_s_propertyFloorNumber, sons: DataCreator_integerIncrementer}, {id: phid_s_propertyDedicatedParkingSpaces, sons: DataCreator_integerIncrementer}, {id: phid_s_propertyNumberOfBedrooms, sons: DataCreator_integerIncrementer}, {id: phid_s_propertyNumberOfBathrooms, sons: DataCreator_integerIncrementer}, {id: phid_s_propertyView, sons: [phid_s_view_golf, phid_s_view_hill, phid_s_view_ocean, phid_s_view_city, phid_s_view_lake, phid_s_view_lagoon, phid_s_view_river, phid_s_view_mainStreet, phid_s_view_sideStreet, phid_s_view_corner, phid_s_view_back, phid_s_view_garden, phid_s_view_pool]}, {id: phid_s_sub_ppt_feat_indoor, sons: [phid_s_pFeature_disabilityFeatures, phid_s_pFeature_fireplace, phid_s_pFeature_energyEfficient, phid_s_pFeature_electricityBackup, phid_s_pFeature_centralAC, phid_s_pFeature_centralHeating, phid_s_pFeature_builtinWardrobe, phid_s_pFeature_kitchenAppliances, phid_s_pFeature_elevator, phid_s_pFeature_intercom, phid_s_pFeature_internet, phid_s_pFeature_tv]}, {id: phid_s_sub_ppt_feat_finishing, sons: [phid_s_finish_coreAndShell, phid_s_finish_withoutFinishing, phid_s_finish_semiFinished, phid_s_finish_lux, phid_s_finish_superLux, phid_s_finish_extraSuperLux]}, {id: phid_s_buildingNumberOfFloors, sons: DataCreator_integerIncrementer}, {id: phid_s_buildingAge, sons: DataCreator_integerIncrementer}, {id: phid_s_buildingTotalParkingLotsCount, sons: DataCreator_integerIncrementer}, {id: phid_s_buildingTotalPropertiesCount, sons: DataCreator_integerIncrementer}, {id: phid_s_sub_ppt_feat_compound, sons: [phid_s_in_compound, phid_s_not_in_compound]}, {id: phid_s_sub_ppt_feat_amenities, sons: [phid_s_am_laundry, phid_s_am_swimmingPool, phid_s_am_kidsPool, phid_s_am_boatFacilities, phid_s_am_gymFacilities, phid_s_am_clubHouse, phid_s_am_horseFacilities, phid_s_am_sportsCourts, phid_s_am_park, phid_s_am_golfCourse, phid_s_am_spa, phid_s_am_kidsArea, phid_s_am_cafeteria, phid_s_am_businessCenter, phid_s_am_lobby]}, {id: phid_s_sub_ppt_feat_services, sons: [phid_s_pService_houseKeeping, phid_s_pService_laundryService, phid_s_pService_concierge, phid_s_pService_securityStaff, phid_s_pService_securityCCTV, phid_s_pService_petsAllowed, phid_s_pService_doorMan, phid_s_pService_maintenance, phid_s_pService_wasteDisposal, phid_s_pFeature_atm]}, {id: phid_s_constructionActivityMeasurementMethod, sons: [phid_s_byLength, phid_s_byArea, phid_s_byVolume, phid_s_byCount, phid_s_byTime, phid_s_byLove]}, {id: phid_s_width, sons: DataCreator_doubleCreator}, {id: phid_s_length, sons: DataCreator_doubleCreator}, {id: phid_s_height, sons: DataCreator_doubleCreator}, {id: phid_s_thickness, sons: DataCreator_doubleCreator}, {id: phid_s_diameter, sons: DataCreator_doubleCreator}, {id: phid_s_radius, sons: DataCreator_doubleCreator}, {id: phid_s_linearMeasureUnit, sons: [phid_s_micron, phid_s_millimeter, phid_s_centimeter, phid_s_meter, phid_s_kilometer, phid_s_inch, phid_s_feet, phid_s_yard, phid_s_mile]}, {id: phid_s_footPrint, sons: DataCreator_doubleCreator}, {id: phid_s_areaMeasureUnit, sons: [phid_s_square_meter, phid_s_square_Kilometer, phid_s_square_feet, phid_s_square_yard, phid_s_acre, phid_s_hectare]}, {id: phid_s_volume, sons: DataCreator_doubleCreator}, {id: phid_s_volumeMeasurementUnit, sons: [phid_s_cubic_cm, phid_s_cubic_m, phid_s_millilitre, phid_s_litre, phid_s_fluidOunce, phid_s_gallon, phid_s_cubic_inch, phid_s_cubic_feet]}, {id: phid_s_weight, sons: DataCreator_doubleCreator}, {id: phid_s_weightMeasurementUnit, sons: [phid_s_ounce, phid_s_pound, phid_s_ton, phid_s_gram, phid_s_kilogram]}, {id: phid_s_count, sons: DataCreator_integerIncrementer}, {id: phid_s_size, sons: [phid_s_xxxSmall, phid_s_xxSmall, phid_s_xSmall, phid_s_small, phid_s_medium, phid_s_large, phid_s_xLarge, phid_s_xxLarge, phid_s_xxxLarge]}, {id: phid_s_wattage, sons: DataCreator_doubleCreator}, {id: phid_s_voltage, sons: DataCreator_doubleCreator}, {id: phid_s_ampere, sons: DataCreator_doubleCreator}, {id: phid_s_inStock, sons: DataCreator_boolSwitch}, {id: phid_s_deliveryAvailable, sons: DataCreator_boolSwitch}, {id: phid_s_deliveryMinDuration, sons: DataCreator_doubleCreator}, {id: phid_s_deliveryDurationUnit, sons: [phid_s_hour, phid_s_day, phid_s_week]}, {id: phid_s_madeIn, sons: DataCreator_country}, {id: phid_s_insuranceDuration, sons: DataCreator_doubleCreator}, {id: phid_s_warrantyDurationUnit, sons: [phid_s_hour, phid_s_day, phid_s_week, phid_s_year]}, {id: phid_s_PropertySalePrice, sons: DataCreator_price}, {id: phid_s_propertyRentPrice, sons: DataCreator_price}, {id: phid_s_propertyDecorationStyle, sons: [phid_s_arch_style_arabian, phid_s_arch_style_andalusian, phid_s_arch_style_asian, phid_s_arch_style_chinese, phid_s_arch_style_contemporary, phid_s_arch_style_classic, phid_s_arch_style_eclectic, phid_s_arch_style_english, phid_s_arch_style_farmhouse, phid_s_arch_style_french, phid_s_arch_style_gothic, phid_s_arch_style_greek, phid_s_arch_style_indian, phid_s_arch_style_industrial, phid_s_arch_style_japanese, phid_s_arch_style_mediterranean, phid_s_arch_style_midcentury, phid_s_arch_style_medieval, phid_s_arch_style_minimalist, phid_s_arch_style_modern, phid_s_arch_style_moroccan, phid_s_arch_style_rustic, phid_s_arch_style_scandinavian, phid_s_arch_style_shabbyChic, phid_s_arch_style_american, phid_s_arch_style_spanish, phid_s_arch_style_traditional, phid_s_arch_style_transitional, phid_s_arch_style_tuscan, phid_s_arch_style_tropical, phid_s_arch_style_victorian, phid_s_arch_style_vintage]}, {id: phid_s_group_dz_type, sons: [phid_k_designType_architecture, phid_k_designType_interior, phid_k_designType_facade, phid_k_designType_urban, phid_k_designType_furniture, phid_k_designType_lighting, phid_k_designType_landscape, phid_k_designType_structural, phid_k_designType_infrastructure, phid_k_designType_kiosk]}, {id: phid_s_projectCost, sons: DataCreator_price},
     {id: phid_s_constructionDuration, sons: DataCreator_integerIncrementer}]
     */

    return MainLayout(
      appBarType: AppBarType.basic,
      // appBarBackButton: true,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: _pageTitle,
      pyramidsAreOn: true,
      onBack: _onBack,
      layoutWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const Stratosphere(),

          /// INSTRUCTIONS BOX HEIGHT
          Container(
            width: _screenWidth,
            height: SpecPickerScreen.instructionBoxHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: SuperVerse(
              verse: _instructions,
              maxLines: 3,
              weight: VerseWeight.thin,
              italic: true,
              color: Colorz.white125,
            ),
            // color: Colorz.white10,
          ),

          /// SPECS PICKER SELECTOR
          if (_specChain.sons.runtimeType != DataCreator)
            ValueListenableBuilder<List<SpecModel>>(
                valueListenable: _selectedSpecs,
                builder: (BuildContext ctx, List<SpecModel> value, Widget child) {

                  return SpecPickerBubble(
                    bubbleHeight: _listZoneHeight,
                    specPicker: widget.specPicker,
                    selectedSpecs: SpecModel.getSpecsByPickerChainID(
                        specs: value,
                        pickerChainID: widget.specPicker.chainID,
                    ),
                    onSpecTap: (String keywordID) => _onSpecTap(context, keywordID),
                  );
                }
                ),

          /// PRICE SPECS CREATOR
          if (_specChain.sons == DataCreator.price)
            ValueListenableBuilder<List<SpecModel>>(
                valueListenable: _selectedSpecs,
                builder: (BuildContext ctx, List<SpecModel> value, Widget child) {
                  final List<SpecModel> _priceSpec = SpecModel.getSpecsByPickerChainID(
                      specs: value, pickerChainID: widget.specPicker.chainID);

                  final double _initialPriceValue = Mapper.canLoopList(_priceSpec) ?
                  _priceSpec[0].value
                      :
                  null;

                  return PriceDataCreator(
                    onCurrencyChanged: (CurrencyModel currency) => _onCurrencyChanged(currency),
                    onValueChanged: (String value) => _onPriceChanged(value),
                    initialPriceValue: _initialPriceValue,
                    onSubmitted: _onBack,
                  );
                }),

          /// INTEGER INCREMENTER SPECS CREATOR
          if (_specChain.sons == DataCreator.integerIncrementer)
            ValueListenableBuilder<List<SpecModel>>(
                valueListenable: _selectedSpecs,
                builder: (BuildContext ctx, List<SpecModel> value, Widget child) {
                  return IntegerDataCreator(
                    onIntegerChanged: (int integer) => _onAddInteger(integer),
                    initialValue: null,
                    onSubmitted: _onBack,
                    specList: widget.specPicker,
                  );
                }),

          /// DOUBLE DATA CREATOR
          if (_specChain.sons == DataCreator.doubleCreator)
            ValueListenableBuilder<List<SpecModel>>(
                valueListenable: _selectedSpecs,
                builder: (BuildContext ctx, List<SpecModel> value, Widget child) {
                  return DoubleDataCreator(
                    onDoubleChanged: (double num) => _onAddDouble(num),
                    initialValue: null,
                    onSubmitted: _onBack,
                    specList: widget.specPicker,
                  );
                }),

        ],
      ),
    );
  }
}

/*



 */
