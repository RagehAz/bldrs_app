import 'dart:async';

import 'package:basics/animators/widgets/scroller.dart';
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/g_zoning/a_states_screen/aa_states_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/a_states_screen/aa_states_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:flutter/material.dart';

class StatesScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const StatesScreen({
    required this.zoneViewingEvent,
    required this.depth,
    required this.viewerZone,
    required this.selectedZone,
    super.key
  });
  // --------------------
  final ViewingEvent zoneViewingEvent;
  final ZoneDepth depth;
  final ZoneModel? viewerZone;
  final ZoneModel? selectedZone;
  // --------------------
  @override
  _StatesScreenState createState() => _StatesScreenState();
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSearchState({
    required String? val,
    required ValueNotifier<bool> isSearching,
    required bool mounted,
    required ValueNotifier<bool> loading,
    required ValueNotifier<List<Phrase>?> foundCountries,
  }) async {

    TextCheck.triggerIsSearchingNotifier(
      text: val,
      isSearching: isSearching,
      mounted: mounted,
      minCharLimit: 2
    );

    /// WHILE SEARCHING
    if (isSearching.value  == true){

      /// START LOADING
      setNotifier(
        notifier: loading,
        mounted: mounted,
        value: true,
      );

      /// CLEAR PREVIOUS SEARCH RESULTS
      setNotifier(
        notifier: foundCountries,
        mounted: mounted,
        value: <Phrase>[],
      );

      final List<Phrase> _byName = America.searchStatesByName(
        text: val,
        withISO2: America.useISO2,
      );
      final List<Phrase> _byID = America.searchStatesByISO2(
        text: val,
      );

       setNotifier(
         notifier: foundCountries,
         mounted: mounted,
         value: Phrase.insertPhrases(
           insertIn: _byName,
           phrasesToInsert: _byID,
           overrideDuplicateID: true,
           allowDuplicateIDs: false,
         ),
       );

       /// CLOSE LOADING
      setNotifier(
        notifier: loading,
        mounted: mounted,
        value: false,
      );

    }

  }
  // --------------------------------------------------------------------------
}

class _StatesScreenState extends State<StatesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>?> _foundStates = ValueNotifier<List<Phrase>?>(null);
  // --------------------
  List<String> _shownStatesIDs = <String>[];
  List<String> _notShownStatesIDs = <String>[];
  // --------------------
  List<CensusModel>? _censuses;
  CensusModel? _usaCensus;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
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
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        await Future.delayed(const Duration(milliseconds: 400));

        await _loadStates();

        await _triggerLoading(setTo: false);
      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _isSearching.dispose();
    _foundStates.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadStates() async {

    /// COUNTRIES STAGES
    StagingModel? _countriesStages = await StagingProtocols.fetchCountriesStaging();

    final List<String> _countriesIDs = Flag.getAllCountriesIDs();
    _countriesStages = _countriesStages?.copyWith(
      id: _countriesStages.id,
      emptyStageIDs: Stringer.removeStringsFromStrings(
          removeFrom: _countriesStages.emptyStageIDs,
          removeThis: _countriesIDs,
      ),
      bzzStageIDs: Stringer.removeStringsFromStrings(
          removeFrom: _countriesStages.bzzStageIDs,
          removeThis: _countriesIDs,
      ),
      flyersStageIDs: Stringer.removeStringsFromStrings(
          removeFrom: _countriesStages.flyersStageIDs,
          removeThis: _countriesIDs,
      ),
      publicStageIDs: Stringer.removeStringsFromStrings(
          removeFrom: _countriesStages.publicStageIDs,
          removeThis: _countriesIDs,
      ),
    );

    // _countriesStages?.blogStaging();

    /// SHOWN IDS
    List<String>? _shownIDs = _countriesStages?.getIDsByViewingEvent(
      event: widget.zoneViewingEvent,
      countryID: null,
      viewerCountryID: widget.viewerZone?.countryID,
    );
    _shownIDs = StagingModel.addMyStateIDToShownStates(
        shownStatesIDs: _shownIDs,
        myCountryID: widget.viewerZone?.countryID,
        event: widget.zoneViewingEvent,
    );

    blog('CountriesScreen._loadCountries() : _shownIDs : $_shownIDs');

    /// NOT SHOWN IDS
    final List<String> _notShownIDs = Stringer.removeStringsFromStrings(
      removeFrom: America.getStatesIDs(),
      removeThis: _shownIDs,
    );

    /// FINAL IDS
    final List<String> _shown = America.sortStatesIDsByName(
      statesIDs: _shownIDs,
    );

    final List<String> _notShown = America.sortStatesIDsByName(
      statesIDs: _notShownIDs,
    );

    /// CENSUS
    // final List<CensusModel> _countriesCensuses = await  CensusProtocols.fetchStatesCensusesByIDs(
    //     countriesIDs: [..._shownIDs, ..._notShownIDs],
    // );
    // final CensusModel? _fetchedPlanetCensus = await CensusProtocols.fetchUSACensus();

    if (mounted) {
      setState(() {

        _shownStatesIDs = _shown;
        _notShownStatesIDs = _notShown;

        // _censuses = _countriesCensuses;
        // _usaCensus = _fetchedPlanetCensus;

      });
    }


  }
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchState(String? val) async {

    blog('searching state');

    await StatesScreen.onSearchState(
      mounted: mounted,
      foundCountries: _foundStates,
      isSearching: _isSearching,
      loading: _loading,
      val: val,
    );

  }
  // -----------------------------------------------------------------------------

  /// NAVIGATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onStateTap(String stateID) async {

    await Nav.goBack(
      context: context,
      passedData: stateID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAmericaTap() async {

    await Nav.goBack(
      context: context,
      passedData: 'usa',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedCountryTap(String? countryID) async {

    await Dialogs.zoneIsNotAvailable();

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      searchButtonIsOn: false,
      onSearchSubmit: _onSearchState,
      onSearchChanged: _onSearchState,
      title: const Verse(
        id: 'phid_select_a_state',
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: () => Nav.goBack(
        context: context,
        invoker: 'SelectCountryScreen.BACK with null',
      ),
      searchHintVerse: const Verse(
        id: 'phid_search_states',
        translate: true,
      ),
      loading: _loading,
      child: ValueListenableBuilder(
          valueListenable: _loading,
          builder: (BuildContext context, bool loading, Widget? child){

            if (loading == true){
              return const LoadingFullScreenLayer();
            }

            else {

              return WidgetFader(
                fadeType: FadeType.fadeIn,
                child: Scroller(
                  child: ValueListenableBuilder(
                    valueListenable: _isSearching,
                    builder: (BuildContext context, bool isSearching, Widget? child){

                      /// WHILE SEARCHING
                      if (isSearching == true){

                        return StatesScreenSearchView(
                          foundStates: _foundStates,
                          shownStatesIDs: _shownStatesIDs,
                          statesCensus: _censuses,
                          selectedZone: widget.selectedZone,
                          onStateTap: _onStateTap,
                          onDisabledStateTap: _onDeactivatedCountryTap,
                        );

                      }

                      /// NOT SEARCHING
                      else {

                        return StatesScreenBrowseView(
                          shownStateIDs: _shownStatesIDs,
                          notShownStatesIDs: _notShownStatesIDs,
                          statesCensus: _censuses,
                          onStateTap: _onStateTap,
                          onDisabledStateTap: _onDeactivatedCountryTap,
                          showAmericaButton: StagingModel.checkMayShowViewAllZonesButton(
                            zoneViewingEvent: widget.zoneViewingEvent,
                          ),
                          americaCensus: _usaCensus,
                          selectedZone: widget.selectedZone,
                          onAmericaTap: _onAmericaTap,
                        );

                      }

                      },
                  ),
                ),
              );

            }

        }
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
