import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/x_chains_manager_controllers.dart';
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
  final List<FlyerType> _selectedTypes = <FlyerType>[];
  void _onSelectFlyerType(FlyerType flyerType){

    final bool _isSelected = FlyerTyper.checkFlyerTypesIncludeThisType(
      flyerType: flyerType,
      flyerTypes: _selectedTypes,
    );

    if (_isSelected == true){
      setState(() {
        _selectedTypes.remove(flyerType);
      });
    }

    else {
      setState(() {
        _selectedTypes.insert(0, flyerType);
      });
    }

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
          selectCountryAndCityOnly: true,
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
        text: 'Showing all Chains : Can not Select a zone',
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

    List<String> _typesStrings = FlyerTyper.translateFlyerTypes(context: context, flyerTypes: _selectedTypes);
    _typesStrings = Stringer.sortAlphabetically2(_typesStrings);
    final String _typesString = Stringer.generateStringFromStrings(strings: _typesStrings) ?? 'All Flyer Types';

    final String _cityString = _onlyCityChains == true ? 'City Chains' : 'All Chains';

    final String _multipleString = _multipleSelectionMode == true ? 'Multiple Selection' : 'Single selection';

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
      flyerTypes: _selectedTypes,
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
      headerViewModel: const BubbleHeaderVM(
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
          headerViewModel: BubbleHeaderVM(
            headlineVerse: const Verse(
              text: 'Flyer Types',
              translate: false,
            ),
            headerWidth: Bubble.clearWidth(context) - 20,
          ),
          // bubbleColor: Colorz.white10,
          margins: 0,
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
                      flyerTypes: _selectedTypes,
                    );
                    return DreamBox(
                      height: 35,
                      verse: Verse(
                        text: FlyerTyper.getFlyerTypePhid(context: context, flyerType: _type),
                        translate: true,
                        casing: Casing.upperCase,
                      ),
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      verseItalic: true,
                      icon: FlyerTyper.flyerTypeIconOff(_type),
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
          headerViewModel: BubbleHeaderVM(
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
          margins: const EdgeInsets.only(top: 5),
          columnChildren: const <Widget>[],
        ),

        /// SWITCH MULTIPLE SELECTION - SINGLE SELECTION
        Bubble(
          width: Bubble.clearWidth(context),
          headerViewModel: BubbleHeaderVM(
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
          margins: const EdgeInsets.only(top: 5),
          columnChildren: const <Widget>[],
        ),

        /// ZONE SELECTION
        Bubble(
          width: Bubble.clearWidth(context),
          headerViewModel: BubbleHeaderVM(
            headlineVerse: _onlyCityChains == true ?
            ZoneModel.translateZoneString(context: context, zoneModel: _zone)
                :
            Verse.threeDots(),
            headerWidth: Bubble.clearWidth(context) - 20,
            leadingIcon: _onlyCityChains == true ? Flag.getFlagIcon(_zone.countryID) : Iconz.earth,
          ),
          bubbleColor: _onlyCityChains == true ? Colorz.white10 : Colorz.black50,
          margins: const EdgeInsets.only(top: 5),
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
