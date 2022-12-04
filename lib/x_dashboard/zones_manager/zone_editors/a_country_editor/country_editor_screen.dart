import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/b_country/all_flags_list.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/country_preview_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_screen/keyboard_screen.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/b_city_editor/create_city_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/b_city_editor/edit_city_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/components/zone_stage_bubble.dart';
import 'package:flutter/material.dart';

class CountryEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountryEditorScreen({
    @required this.countryID,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String countryID;

  @override
  State<CountryEditorScreen> createState() => _CountryEditorScreenState();
}

class _CountryEditorScreenState extends State<CountryEditorScreen> {
  // -----------------------------------------------------------------------------
  ZoneStages _countriesStages;
  StageType _stageType;
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

        final ZoneStages _stages = await ZoneProtocols.readCountriesStages();

        setState(() {
          _countriesStages = _stages;
          _stageType = _stages.getStageTypeByID(widget.countryID);
        });

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

  /// COUNTRY STAGE TYPE

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSelectStageType(StageType type) async {

    if (_countriesStages != null){

      final bool _go = await Dialogs.confirmProceed(
        context: context,
        invertButtons: true,
        titleVerse: Verse.plain('Change Country Stage'),
        bodyVerse: Verse.plain('Are you sure you want to change the country stage to $type?'),
      );

      if (_go == true){

        final ZoneStages _newStages = await ZoneProtocols.updateCountryStage(
          countryID: widget.countryID,
          newType: type,
        );

        setState(() {
          _countriesStages = _newStages;
          _stageType = type;
        });

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// COUNTRY CITIES

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onGoToCitiesScreen({
    @required BuildContext context,
    @required CountryModel countryModel,
  }) async {

    blog('go to cities screen');

    final ZoneModel _zone = await Nav.goToNewScreen(
      context: context,
      screen: CitiesScreen(
        zoneViewingEvent: ZoneViewingEvent.admin,
        countryID: countryModel?.id,
        depth: ZoneDepth.district,
      ),
    );

    _zone?.blogZone(invoker: 'onGoToCitiesScreen');

    if (_zone != null && _zone.cityID != null){

      final String _return = await Nav.goToNewScreen(
          context: context,
          screen: EditCityScreen(
            zoneModel: _zone,
          ),
      );

      if (_return == 'cityIsDeleted'){

        setState(() {});

        await Dialogs.showSuccessDialog(
          context: context,
          firstLine: Verse.plain('City is Deleted'),
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// ADD NEW CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAddNewCity() async {

    final String _cityIDWithoutCountyID = await KeyboardScreen.goToKeyboardScreen(
      context: context,
      screenTitleVerse: Verse.plain('Add New city ID without countryID'),
    );

    if (TextCheck.isEmpty(_cityIDWithoutCountyID?.trim()) == false){

      await Nav.goToNewScreen(
        context: context,
        screen: CreateCityScreen(
          countryID: widget.countryID,
          cityName: _cityIDWithoutCountyID,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Flag _flag = Flag.getFlagFromFlagsByCountryID(
        flags: allFlags,
        countryID: widget.countryID,
    );

    final double _bubbleWidth = BldrsAppBar.width(context);

    return MainLayout(
      pageTitleVerse: Verse.plain(widget.countryID),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          /// COUNTRY PREVIEW BUBBLE
          CountryPreviewBubble(
            countryID: widget.countryID,
          ),

          const DotSeparator(),

          /// CITIES
          FutureBuilder(
              future: ZoneProtocols.fetchCountry(countryID: widget.countryID),
              builder: (_, AsyncSnapshot<CountryModel> snap){

                final CountryModel _countryModel = snap.data;
                final int _citiesCount = _countryModel?.citiesIDs?.getAllIDs()?.length ?? 0;

                return DreamBox(
                  height: 50,
                  width: _bubbleWidth,
                  margins: const EdgeInsets.only(bottom: 10),
                  verse: Verse(
                    text: '$_citiesCount Cities',
                    translate: false,
                    casing: Casing.upperCase,
                  ),
                  verseItalic: true,
                  onTap: () => onGoToCitiesScreen(
                    context: context,
                    countryModel: _countryModel,
                  ),
                );

              }
          ),

          /// ADD NEW CITY
          DreamBox(
            height: 50,
            width: _bubbleWidth,
            icon: Iconz.plus,
            iconSizeFactor: 0.6,
            verse: const Verse(
              text: 'Add new City',
              translate: false,
              casing: Casing.upperCase,
            ),

            verseItalic: true,
            onTap: _onAddNewCity,
          ),

          const DotSeparator(),

          /// COUNTRY STAGE
          ZoneStageSwitcherBubble(
            zoneName: Phrase.searchFirstPhraseByLang(phrases: _flag.phrases, langCode: 'en')?.value,
            stageType: _stageType,
            onSelectStageType: _onSelectStageType,
          ),

          const DotSeparator(),

          /// IDs
          DataStrip(
            width: _bubbleWidth,
            color: Colorz.black50,
            dataKey: 'IDs',
            dataValue: 'ISO3 : ${widget.countryID} : ISO2 : ${_flag.iso2}',
          ),

          /// REGION - CONTINENT
          DataStrip(
            width: _bubbleWidth,
            color: Colorz.black50,
            dataKey: 'Cont.',
            dataValue: '${_flag.region} - ${_flag.continent}',
          ),

          /// LANGUAGE
          DataStrip(
            width: _bubbleWidth,
            color: Colorz.black50,
            dataKey: 'Langs',
            dataValue: 'Main : [${_flag.language}] . Other : [${_flag.langCodes}]',
          ),

          /// PHONE CODE
          DataStrip(
            width: _bubbleWidth,
            color: Colorz.black50,
            dataKey: 'Phone code',
            dataValue: _flag.phoneCode,
          ),

          const DotSeparator(),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
