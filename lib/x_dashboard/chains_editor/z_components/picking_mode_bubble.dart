import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/x_dashboard/chains_editor/x_chains_manager_controllers.dart';
import 'package:flutter/material.dart';

class ChainsPickingModeBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsPickingModeBubble({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ChainsPickingModeBubbleState createState() => _ChainsPickingModeBubbleState();
  /// --------------------------------------------------------------------------
}

class _ChainsPickingModeBubbleState extends State<ChainsPickingModeBubble> {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _zone = ZoneProvider.proGetCurrentZone(context: context, listen: false);
  }
  // -----------------------------------------------------------------------------
  static const List<FlyerType> _allTypes = <FlyerType>[
    // null,
    ...FlyerTyper.flyerTypesList,
  ];
  // -----------------------------------------------------------------------------
  FlyerType _selectedType;
  void _onSelectFlyerType(FlyerType flyerType){

      setState(() {
        _selectedType = flyerType;
      });

  }
  // --------------------
  bool _onlyCityChains = false;
  void _onSwitchShowCityChainsOnly(bool value){

    setState(() {
      _onlyCityChains = value;
    });

  }
  // --------------------
  ZoneModel _zone;
  Future<void> _onSelectNewZone() async {

    if (_onlyCityChains == true){

      final ZoneModel _selectedZone = await Nav.goToNewScreen(
        context: context,
        screen: const CountriesScreen(
          zoneViewingEvent: ViewingEvent.admin,
          depth: ZoneDepth.district,
          // selectCountryAndCityOnly: true,
          // selectCountryIDOnly: false,
          // settingCurrentZone: false,
        ),
      );

      if (_selectedZone != null){
        setState(() {
          _zone = _selectedZone;
        });
      }

    }

    else {
      await Dialogs.topNotice(
        context: context,
        verse: Verse.plain('Showing all Chains : Can not Select a zone'),
      );
    }


  }
  // --------------------
  bool _multipleSelectionMode = false;
  void _onSwitchMultipleSelectionMode(bool value){

    setState(() {
      _multipleSelectionMode = value;
    });

  }
  // --------------------
  Verse _getGoButtonDescription(){

    List<String> _typesStrings = FlyerTyper.translateFlyerTypes(
        context: context,
        flyerTypes: [_selectedType],
    );

    _typesStrings = Stringer.sortAlphabetically2(_typesStrings);
    final String _typesString = Stringer.generateStringFromStrings(strings: _typesStrings) ?? 'All Flyer Types';

    final String _cityString = _onlyCityChains == true ? 'City Chains' : 'All Chains';

    final String _multipleString = _multipleSelectionMode == true ? 'Multi-Select' : 'Single-select';

    final String _cityName = _onlyCityChains == true ? _zone.cityName : '';

    return Verse(
      text: '$_multipleString of $_cityName $_cityString :-\n$_typesString',
      translate: false,
    );

  }
  // -----------------------------------------------------------------------------
  Future<void> _onGoChainsPickingScreenButtonTap() async {

    final dynamic _received = await goToChainsPickingScreen(
      context: context,
      flyerType: _selectedType,
      onlyUseCityChains: _onlyCityChains,
      isMultipleSelectionMode: _multipleSelectionMode,
      pageTitleVerse: _getGoButtonDescription(),
      // onlyChainKSelection: false, /// TASK : WTF IS THIS DOING
      zone: _zone,
    );

    if (_received != null){

      if (_multipleSelectionMode == true){
        final List<SpecModel> _specs = _received;
        SpecModel.blogSpecs(_specs);
      }
      else {
        final String _phid = _received;
        blog(_phid);
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleHeaderVM: const BubbleHeaderVM(
        headlineVerse: Verse(
          text: 'Picking mode',
          translate: false,
        ),
      ),
      bubbleColor: Colorz.white20,
      columnChildren: <Widget>[

        /// SELECT FLYER TYPE
        Bubble(
          width: Bubble.clearWidth(context),
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: const Verse(
              text: 'Flyer Types',
              translate: false,
            ),
            headerWidth: Bubble.clearWidth(context) - 20,
          ),
          // bubbleColor: Colorz.white10,
          margin: 0,
          columnChildren: <Widget>[
            SizedBox(
              width: Bubble.clearWidth(context) - 20,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [

                  ...List.generate(_allTypes.length, (index){
                    final FlyerType _type = _allTypes[index];
                    final bool _isSelected = FlyerTyper.checkFlyerTypesIncludeThisType(
                      flyerType: _type,
                      flyerTypes: [_selectedType],
                    );
                    return DreamBox(
                      height: 35,
                      verse: Verse(
                        text: FlyerTyper.getFlyerTypePhid(flyerType: _type),
                        translate: true,
                        casing: Casing.upperCase,
                      ),
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      verseItalic: true,
                      icon: FlyerTyper.flyerTypeIcon(
                        flyerType: _type,
                        isOn: false,
                      ),
                      color: _isSelected == true ? Colorz.green255 : null,
                      iconSizeFactor: 0.8,
                      onTap: () => _onSelectFlyerType(_type),
                    );
                  }),

                ],
              ),
            ),
          ],
        ),

        /// SWITCH CITY CHAIN ONLY - ALL BLDRS CHAINS
        Bubble(
          width: Bubble.clearWidth(context),
          bubbleHeaderVM: BubbleHeaderVM(
              headlineVerse: const Verse(
                text: 'City Chains Only',
                translate: false,
              ),
              headerWidth: Bubble.clearWidth(context) - 20,
              switchValue: _onlyCityChains,
              hasSwitch: true,
              onSwitchTap: _onSwitchShowCityChainsOnly,
          ),
          // bubbleColor: Colorz.white10,
          margin: const EdgeInsets.only(top: 5),
          columnChildren: const <Widget>[],
        ),

        /// SWITCH MULTIPLE SELECTION - SINGLE SELECTION
        Bubble(
          width: Bubble.clearWidth(context),
          bubbleHeaderVM: BubbleHeaderVM(
              headlineVerse: const Verse(
                text: 'Multiple Selection mode',
                translate: false,
              ),
              headerWidth: Bubble.clearWidth(context) - 20,
              switchValue: _multipleSelectionMode,
              hasSwitch: true,
              onSwitchTap: _onSwitchMultipleSelectionMode
          ),
          // bubbleColor: Colorz.white10,
          margin: const EdgeInsets.only(top: 5),
          columnChildren: const <Widget>[],
        ),

        /// ZONE SELECTION
        Bubble(
          width: Bubble.clearWidth(context),
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: _onlyCityChains == true ?
            ZoneModel.generateInZoneVerse(context: context, zoneModel: _zone)
                :
            Verse.threeDots(),
            headerWidth: Bubble.clearWidth(context) - 20,
            leadingIcon: _onlyCityChains == true ? Flag.getCountryIcon(_zone.countryID) : Iconz.earth,
          ),
          bubbleColor: _onlyCityChains == true ? Colorz.white10 : Colorz.black50,
          margin: const EdgeInsets.only(top: 5),
          onBubbleTap: _onSelectNewZone,
          columnChildren: const <Widget>[],
        ),

        DreamBox(
          height: 80,
          color: Colorz.blue80,
          verseCentered: false,
          width: Bubble.clearWidth(context),
          verse: const Verse(
            text: 'Go to Chains Picking Screen',
            translate: false,
          ),
          secondLine: _getGoButtonDescription(),
          secondVerseMaxLines: 3,
          onTap: _onGoChainsPickingScreenButtonTap,
          verseScaleFactor: 0.7,
          margins: const EdgeInsets.only(top: 5),
          secondLineScaleFactor: 1.1,
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
