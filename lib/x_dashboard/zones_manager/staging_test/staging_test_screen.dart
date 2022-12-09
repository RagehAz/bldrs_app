import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class StagingTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StagingTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _StagingTestScreenState createState() => _StagingTestScreenState();
/// --------------------------------------------------------------------------
}

class _StagingTestScreenState extends State<StagingTestScreen> {

  Staging _countriesStages;
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

        final Staging _countriesStagesRead = await ZoneProtocols.readCountriesStaging();

        setState(() {
          _countriesStages = _countriesStagesRead;
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
  @override
  Widget build(BuildContext context) {

    final List<String> _countries = _countriesStages.getIDsByType(_stageType);

    final double _clearWidth = Bubble.bubbleWidth(context);

    return MainLayout(
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitleVerse: Verse.plain('Staging Test'),
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          SizedBox(
            width: _clearWidth,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                ...List.generate(Staging.zoneStagesList.length, (index){

                  final StageType _type = Staging.zoneStagesList[index];
                  final bool _isSelected = _stageType == _type;

                  return DreamBox(
                    height: 50,
                    width: Scale.getUniformRowItemWidth(
                        context: context,
                        numberOfItems: Staging.zoneStagesList.length,
                        boxWidth: _clearWidth,
                    ),
                    verse: Verse.plain(Staging.cipherStageType(_type)),
                    verseScaleFactor: 0.7,
                    color: _isSelected == true ? Colorz.yellow255 : null,
                    onTap: (){

                      setState(() {
                        _stageType = _type;
                      });

                    },
                  );

                }),

              ],
            ),
          ),

          if (Mapper.checkCanLoopList(_countries) == true)
          SizedBox(
            height: 600,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: false,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 14,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  // childAspectRatio: 1,
                  // mainAxisExtent: PageBubble.width(context),
                ),
                itemCount: _countries.length,
                itemBuilder: (_, int index){

                  final String _countryID = _countries[index];

                  return FlagBox(
                    countryID: _countryID,
                    size: 15,
                  );

                }
            ),
          ),

        ]
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

// who sees what when ?
// who : which user type
// sees : which viewing event
// what : which zone
// when : at which stage
