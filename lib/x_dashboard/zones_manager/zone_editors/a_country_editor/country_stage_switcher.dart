import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/components/zone_stage_bubble.dart';
import 'package:flutter/material.dart';

class CountryStageSwitcher extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountryStageSwitcher({
    @required this.countryID,
    Key key
  }) : super(key: key);

  final String countryID;
  /// --------------------------------------------------------------------------
  @override
  _CountryStageSwitcherState createState() => _CountryStageSwitcherState();
/// --------------------------------------------------------------------------
}

class _CountryStageSwitcherState extends State<CountryStageSwitcher> {
  // -----------------------------------------------------------------------------
  ZoneStages _zoneStages;
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
          _zoneStages = _stages;
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
  ///
  Future<void> _onSelectStageType(StageType type) async {

    if (_zoneStages != null){

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
          _zoneStages = _newStages;
          _stageType = type;
        });

      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ZoneStageSwitcherBubble(
      countryID: widget.countryID,
      stageType: _stageType,
      onSelectStageType: _onSelectStageType,
    );

  }
/// --------------------------------------------------------------------------
}
