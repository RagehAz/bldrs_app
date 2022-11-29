import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/city_preview_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/components/zone_stage_bubble.dart';
import 'package:flutter/material.dart';

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
  String _countryID;
  ZoneStages _citiesStages;
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

        final ZoneStages _stages = await ZoneProtocols.readCitiesStages(widget.zoneModel.countryID);

        setState(() {
          _citiesStages = _stages;
          _stageType = _stages.getStageTypeByID(widget.zoneModel.cityID);
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

        final ZoneStages _newStages = await ZoneProtocols.updateCityStage(
          cityID: widget.zoneModel.cityID,
          newType: type,
        );

        setState(() {
          _citiesStages = _newStages;
          _stageType = type;
        });

      }

    }

  }
  // --------------------
  ///
  Future<void> onGoToDistrictsScreen({
    @required BuildContext context,
    @required CityModel cityModel,
  }) async {

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final CityModel _city = widget.zoneModel?.cityModel;

    final double _bubbleWidth = BldrsAppBar.width(context);

    final List<Phrase> _namesWithoutEnglishName = <Phrase>[..._city.phrases];
    _namesWithoutEnglishName.removeWhere((Phrase phrase) => phrase.langCode == 'en');

    return MainLayout(
      pageTitleVerse: Verse.plain(_city.cityID),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          CityPreviewBubble(
            cityModel: _city,
          ),

          const DotSeparator(),

          /// STAGE
          ZoneStageSwitcherBubble(
            zoneID: _city.getCountryID(),
            zoneName: Phrase.searchFirstPhraseByLang(phrases: _city.phrases, langCode: 'en')?.value,
            stageType: _stageType,
            onSelectStageType: _onSelectStageType,
          ),

          const DotSeparator(),

          /// PHRASES
          if (Mapper.checkCanLoopList(_namesWithoutEnglishName) == true)
            ...List.generate(_city.phrases.length, (index){

              final Phrase _phrase = _city.phrases[index];

              return DataStrip(
                dataKey: 'Name ${_phrase?.langCode}',
                dataValue: _phrase.value,
              );

            }),

          /// POSITION
          DataStrip(
            dataKey: 'Position',
            dataValue: 'Lat: ${_city?.position?.latitude} , Lng: ${_city?.position?.longitude}',
          ),

          const DotSeparator(),


          /// CITIES
          FutureBuilder(
              future: ZoneProtocols.fetchCityDistrictsByStage(
                cityID: _city.cityID,
              ),
              builder: (_, AsyncSnapshot<List<DistrictModel>> snap){

                final List<DistrictModel> _districtModels = snap.data;
                final int _count = _districtModels?.length ?? 0;

                return DreamBox(
                  height: 50,
                  width: _bubbleWidth,
                  verse: Verse(
                    text: '$_count Districts',
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

          const SeparatorLine(
            width: 300,
          ),

          /// CHAIN USAGE
          if (_city?.cityID != null)
            FutureBuilder(
                future: Real.readDocOnce(
                  collName: RealColl.chainsUsage,
                  docName: _city.cityID,
                ),
                builder: (_, AsyncSnapshot<dynamic> snapshot){
                  final Map<String, dynamic> _map = snapshot.data;

                  if (Streamer.connectionIsLoading(snapshot) == true){
                    return const Loading(loading: true);
                  }

                  else {

                    final CityPhidsModel _countersModel = CityPhidsModel.decipherCityPhids(
                      map: _map,
                      cityID: _city.cityID,
                    );

                    List<MapModel> keywords = _countersModel.phidsMapModels;
                    keywords = MapModel.removeMapsWithThisValue(
                      mapModels: keywords,
                      value: 0,
                    );
                    keywords = MapModel.removeMapsWithThisValue(
                      mapModels: keywords,
                      value: _city.cityID,
                    );

                    return Column(
                      children: <Widget>[

                        if (Mapper.checkCanLoopList(keywords) == true)
                          ...List.generate(keywords.length, (index){

                            final MapModel _kw = keywords[index];

                            return DreamBox(
                              height: 30,
                              width: PageBubble.clearWidth(context),
                              icon: ChainsProvider.proGetPhidIcon(context: context, son: _kw.key),
                              verse: Verse.plain('${_kw.value} : ${_kw.key}'),
                              verseScaleFactor: 0.6,
                              verseWeight: VerseWeight.thin,
                              verseCentered: false,
                            );

                          },


                          )
                      ],

                    );

                  }

                }),

          const Horizon(),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
