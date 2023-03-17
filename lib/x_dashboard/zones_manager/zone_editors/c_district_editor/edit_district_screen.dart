import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/district_preview_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_leveller.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/c_district_editor/district_editor_bubble.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/components/zone_stage_bubble.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:mapper/mapper.dart';

class EditDistrictScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EditDistrictScreen({
    @required this.zoneModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel zoneModel;

  @override
  State<EditDistrictScreen> createState() => _EditDistrictScreenState();
}

class _EditDistrictScreenState extends State<EditDistrictScreen> {
  // -----------------------------------------------------------------------------
  Staging _districtsStages;
  StageType _districtStageType;
  DistrictModel _districtModel;
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

        final Staging _stages = await StagingProtocols.fetchDistrictsStaging(
          cityID: widget.zoneModel.cityID,
        );

        if (_stages != null){

          final DistrictModel _district = await ZoneProtocols.fetchDistrict(
            districtID: widget.zoneModel.districtID,
          );

          setState(() {
            _districtsStages = _stages;
            _districtStageType = _stages.getTypeByID(widget.zoneModel.districtID);
            _districtModel = _district;
          });

        }

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

  /// DISTRICT STAGE TYPE

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSelectStageType(StageType type) async {

    if (_districtsStages != null){

      final bool _go = await Dialogs.confirmProceed(
        context: context,
        invertButtons: true,
        titleVerse: Verse.plain('Change District Stage'),
        bodyVerse: Verse.plain('Are you sure you want to change the district stage to $type?'),
      );

      if (_go == true){

        final Staging _newStages = await StagingLeveller.changeDistrictStageType(
          districtID: widget.zoneModel.districtID,
          newType: type,
        );

        setState(() {
          _districtsStages = _newStages;
          _districtStageType = type;
        });

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// UPDATE DISTRICT

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onUpdateDistrict(DistrictModel newDistrict) async {

    final bool _go = await Dialogs.confirmProceed(
      context: context,
      invertButtons: true,
    );

    if (_go == true){

      await ZoneProtocols.renovateDistrict(
        newDistrict: newDistrict,
        oldDistrict: _districtModel,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onDeleteDistrict() async {

    final bool _go = await Dialogs.confirmProceed(
      context: context,
      invertButtons: true,
    );

    if (_go == true){

      await ZoneProtocols.wipeDistrict(
        districtModel: _districtModel,
      );

      await Nav.goBack(
        context: context,
        passedData: 'districtIsDeleted',
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = BldrsAppBar.width(context);

    final List<Phrase> _namesWithoutEnglishName = <Phrase>[...?_districtModel?.phrases];
    _namesWithoutEnglishName.removeWhere((Phrase phrase) => phrase.langCode == 'en');

    return MainLayout(
      title: Verse.plain('District ( ${_districtModel?.id} )'),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          /// CITY PREVIEW BUBBLE
          if (_districtModel != null)
            DistrictPreviewBubble(
              districtModel: _districtModel,
              cityModel: widget.zoneModel.cityModel,
            ),

          const DotSeparator(),

          /// DISTRICT STAGE
          ZoneStageSwitcherBubble(
            stageType: _districtStageType,
            onSelectStageType: _onSelectStageType,
            zoneName: Phrase.searchFirstPhraseByLang(
                phrases: _districtModel?.phrases,
                langCode: 'en'
            )?.value,
          ),

          const DotSeparator(),

          /// PHRASES
          if (Mapper.checkCanLoopList(_namesWithoutEnglishName) == true)
            ...List.generate(_districtModel.phrases.length, (index){

              final Phrase _phrase = _districtModel.phrases[index];

              return DataStrip(
                color: Colorz.black50,
                dataKey: 'Name ${_phrase?.langCode}',
                dataValue: _phrase.value,
              );

            }),


          const DotSeparator(),

          /// DISTRICT EDITOR BUBBLE
          DistrictEditorBubble(
            districtModel: _districtModel,
            onSync: _onUpdateDistrict,
          ),

          /// DELETE CITY
          DreamBox(
            height: 50,
            width: _bubbleWidth,
            color: Colorz.bloodTest,
            verse: const Verse(
              id: 'Delete District',
              translate: false,
              casing: Casing.upperCase,
            ),
            verseItalic: true,
            onTap: onDeleteDistrict,
          ),

           /// CHAIN USAGE
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
