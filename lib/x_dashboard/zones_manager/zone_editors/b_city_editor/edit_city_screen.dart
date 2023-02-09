import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/g_zoning/c_districts_screen/a_districts_screen.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/city_preview_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_screen/keyboard_screen.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_leveller.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/b_city_editor/city_editor_bubble.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/c_district_editor/create_district_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/c_district_editor/edit_district_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/components/zone_stage_bubble.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';

class EditCityScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EditCityScreen({
    @required this.zoneModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel zoneModel;

  @override
  State<EditCityScreen> createState() => _EditCityScreenState();
}

class _EditCityScreenState extends State<EditCityScreen> {
  // -----------------------------------------------------------------------------
  Staging _citiesStages;
  StageType _cityStageType;
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

        final Staging _stages = await StagingProtocols.fetchCitiesStaging(
          countryID: widget.zoneModel.countryID,
        );

        setState(() {
          _citiesStages = _stages;
          _cityStageType = _stages.getTypeByID(widget.zoneModel.cityID);
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

  /// CITY STAGE TYPE

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSelectStageType(StageType type) async {

    if (_citiesStages != null){

      final bool _go = await Dialogs.confirmProceed(
        context: context,
        invertButtons: true,
        titleVerse: Verse.plain('Change City Stage'),
        bodyVerse: Verse.plain('Are you sure you want to change the city stage to $type?'),
      );

      if (_go == true){

        final Staging _newStages = await StagingLeveller.changeCityStageType(
          cityID: widget.zoneModel.cityID,
          newType: type,
        );

        setState(() {
          _citiesStages = _newStages;
          _cityStageType = type;
        });

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// CITY DISTRICTS STAGES RESET

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onResetDistrictsStages() async {

    final bool _go = await Dialogs.confirmProceed(
      context: context,
      invertButtons: true,
    );

    if (_go == true){

      await StagingProtocols.resetDistrictsStaging(
        cityID: widget.zoneModel.cityID,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// SELECT CITY DISTRICT

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onGoToDistrictsScreen({
    @required BuildContext context,
    @required CityModel cityModel,
  }) async {

    final ZoneModel _zone = await Nav.goToNewScreen(
      context: context,
      screen: DistrictsScreen(
        zoneViewingEvent: ViewingEvent.admin,
        country: widget.zoneModel.countryModel,
        city: cityModel,
      ),
    );

    if (_zone != null){

      final String _return = await Nav.goToNewScreen(
        context: context,
        screen: EditDistrictScreen(
          zoneModel: _zone,
        ),
      );

      if (_return == 'districtIsDeleted'){

        setState(() {});

        await Dialogs.showSuccessDialog(
          context: context,
          firstLine: Verse.plain('City is Deleted'),
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// UPDATE CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onUpdateCity(CityModel newCity) async {

    final bool _go = await Dialogs.confirmProceed(
      context: context,
      invertButtons: true,
    );

    if (_go == true){

      await ZoneProtocols.renovateCity(
        newCity: newCity,
        oldCity: widget.zoneModel?.cityModel,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onDeleteCity() async {

    final bool _go = await Dialogs.confirmProceed(
      context: context,
      invertButtons: true,
    );

    if (_go == true){

      await ZoneProtocols.wipeCity(
        cityModel: widget.zoneModel?.cityModel,
      );

      await Nav.goBack(
        context: context,
        passedData: 'cityIsDeleted',
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// ADD NEW DISTRICT

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAddNewDistrict() async {

    final String _districtNameEn = await KeyboardScreen.goToKeyboardScreen(
      context: context,
      screenTitleVerse: Verse.plain('Add New District en Name without countryID or city ID'),
    );

    if (TextCheck.isEmpty(_districtNameEn?.trim()) == false){

      await Nav.goToNewScreen(
        context: context,
        screen: CreateDistrictScreen(
          cityID: widget.zoneModel.cityID,
          districtName: _districtNameEn,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final CityModel _city = widget.zoneModel?.cityModel;

    final double _bubbleWidth = BldrsAppBar.width(context);

    final List<Phrase> _namesWithoutEnglishName = <Phrase>[...?_city?.phrases];
    _namesWithoutEnglishName.removeWhere((Phrase phrase) => phrase.langCode == 'en');

    return MainLayout(
      title: Verse.plain('City : ( ${_city?.cityID} )'),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          /// CITY PREVIEW BUBBLE
          if (_city != null)
          CityPreviewBubble(
            cityModel: _city,
          ),

          const DotSeparator(),

          /// DISTRICTS BUTTON
          FutureBuilder(
              future: ZoneProtocols.fetchDistrictsOfCity(
                cityID: _city?.cityID,
              ),
              builder: (_, AsyncSnapshot<List<DistrictModel>> snap){

                final List<DistrictModel> _districtModels = snap.data;
                final int _count = _districtModels?.length ?? 0;

                return DreamBox(
                  height: 50,
                  width: _bubbleWidth,
                  verse: Verse(
                    id: '$_count Districts',
                    translate: false,
                    casing: Casing.upperCase,
                  ),
                  verseItalic: true,
                  onTap: () => onGoToDistrictsScreen(
                    context: context,
                    cityModel: _city,
                  ),
                );


              }
          ),

          /// ADD NEW DISTRICT
          DreamBox(
            height: 50,
            width: _bubbleWidth,
            icon: Iconz.plus,
            iconSizeFactor: 0.6,
            verse: const Verse(
              id: 'Add new District',
              translate: false,
              casing: Casing.upperCase,
            ),
            verseItalic: true,
            onTap: _onAddNewDistrict,
          ),

          const DotSeparator(),

          /// CITY STAGE
          ZoneStageSwitcherBubble(
            stageType: _cityStageType,
            onSelectStageType: _onSelectStageType,
            zoneName: Phrase.searchFirstPhraseByLang(
                phrases: _city?.phrases,
                langCode: 'en',
            )?.value,
          ),

          const DotSeparator(),

          /// PHRASES
          if (Mapper.checkCanLoopList(_namesWithoutEnglishName) == true)
            ...List.generate(_city.phrases.length, (index){

              final Phrase _phrase = _city.phrases[index];

              return DataStrip(
                color: Colorz.black50,
                dataKey: 'Name ${_phrase?.langCode}',
                dataValue: _phrase.value,
              );

            }),

          /// POSITION
          DataStrip(
            color: Colorz.black50,
            dataKey: 'Position',
            dataValue: 'Lat: ${_city?.position?.latitude} , Lng: ${_city?.position?.longitude}',
          ),

          const DotSeparator(),

          /// CITY EDITOR BUBBLE
          if (_city != null)
          CityEditorBubble(
            cityModel: _city,
            onSync: _onUpdateCity,
          ),

          /// DELETE CITY
          DreamBox(
            height: 50,
            width: _bubbleWidth,
            color: Colorz.bloodTest,
            verse: const Verse(
              id: 'Delete city',
              translate: false,
              casing: Casing.upperCase,
            ),
            verseItalic: true,
            onTap: () => onDeleteCity(),
          ),

          /// RESET CITY DISTRICTS STAGES
          DreamBox(
            height: 50,
            width: _bubbleWidth,
            color: Colorz.bloodTest,
            verse: Verse(
              id: 'Reset Districts Stages of ${_city?.cityID}',
              translate: false,
              casing: Casing.upperCase,
            ),
            verseScaleFactor: 0.6,
            verseItalic: true,
            onTap: () => onResetDistrictsStages(),
          ),

          // /// CHAIN USAGE
          // if (_city?.cityID != null)
          //   FutureBuilder(
          //       future: Real.readDocOnce(
          //         collName: RealColl.chainsUsage,
          //         docName: _city.cityID,
          //       ),
          //       builder: (_, AsyncSnapshot<dynamic> snapshot){
          //         final Map<String, dynamic> _map = snapshot.data;
          //
          //         if (Streamer.connectionIsLoading(snapshot) == true){
          //           return const Loading(loading: true);
          //         }
          //
          //         else {
          //
          //           final CityPhidsModel _countersModel = CityPhidsModel.decipherCityPhids(
          //             map: _map,
          //             cityID: _city.cityID,
          //           );
          //
          //           List<MapModel> keywords = _countersModel.phidsMapModels;
          //           keywords = MapModel.removeMapsWithThisValue(
          //             mapModels: keywords,
          //             value: 0,
          //           );
          //           keywords = MapModel.removeMapsWithThisValue(
          //             mapModels: keywords,
          //             value: _city.cityID,
          //           );
          //
          //           return Column(
          //             children: <Widget>[
          //
          //               if (Mapper.checkCanLoopList(keywords) == true)
          //                 ...List.generate(keywords.length, (index){
          //
          //                   final MapModel _kw = keywords[index];
          //
          //                   return DreamBox(
          //                     height: 30,
          //                     width: PageBubble.clearWidth(context),
          //                     icon: ChainsProvider.proGetPhidIcon(context: context, son: _kw.key),
          //                     verse: Verse.plain('${_kw.value} : ${_kw.key}'),
          //                     verseScaleFactor: 0.6,
          //                     verseWeight: VerseWeight.thin,
          //                     verseCentered: false,
          //                   );
          //
          //                 },
          //
          //
          //                 )
          //             ],
          //
          //           );
          //
          //         }
          //
          //       }),

          const Horizon(),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
