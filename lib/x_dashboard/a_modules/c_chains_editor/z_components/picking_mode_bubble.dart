import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/a_chains_picking_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class ChainsPickingModeBubble extends StatefulWidget {

  const ChainsPickingModeBubble({
    Key key
  }) : super(key: key);

  @override
  _ChainsPickingModeBubbleState createState() => _ChainsPickingModeBubbleState();

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
  String _getGoButtonDescription(){

    List<String> _typesStrings = FlyerTyper.translateFlyerTypes(context: context, flyerTypes: _selectedTypes);
    _typesStrings = Stringer.sortAlphabetically2(_typesStrings);
    final String _typesString = Stringer.generateStringFromStrings(strings: _typesStrings) ?? 'All Flyer Types';

    final String _cityString = _onlyCityChains == true ? 'City Chains' : 'All Chains';

    final String _multipleString = _multipleSelectionMode == true ? 'Multiple Selection' : 'Single selection';

    final String _cityName = _onlyCityChains == true ? _zone.cityName : '';

    return '$_multipleString of $_cityName $_cityString :-\n$_typesString';
  }
  // -----------------------------------------------------------------------------
  Future<void> _onGoChainsPickingScreenButtonTap() async {

    final dynamic _received =  await Nav.goToNewScreen(
        context: context,
        screen: ChainsPickingScreen(
          flyerTypesChainFilters: _selectedTypes,
          onlyUseCityChains: _onlyCityChains,
          isMultipleSelectionMode: _multipleSelectionMode,
          pageTitleVerse: _getGoButtonDescription(),
          // onlyChainKSelection: false, /// TASK : WTF IS THIS DOING
          zone: _zone,
        )
    );

    if (_multipleSelectionMode == true){
      final List<SpecModel> _specs = _received;
      SpecModel.blogSpecs(_specs);
    }
    else {
      final String _phid = _received;
      blog(_phid);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      screenWidth: Scale.superScreenWidth(context),
      headerViewModel: const BubbleHeaderVM(
        headlineVerse: 'Picking mode',
        translateHeadline: false,
      ),
      bubbleColor: Colorz.bloodTest,
      columnChildren: <Widget>[

        /// SELECT FLYER TYPE
        Bubble(
          screenWidth: Bubble.bubbleWidth(context: context),
          headerViewModel: BubbleHeaderVM(
            headlineVerse: 'Flyer Types',
            translateHeadline: false,
            headerWidth: Bubble.bubbleWidth(context: context) - 20,
          ),
          bubbleColor: Colorz.black125,
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
                    return AppBarButton(
                      verse: FlyerTyper.translateFlyerType(context: context, flyerType: _type),
                      icon: FlyerTyper.flyerTypeIconOff(_type),
                      buttonColor: _isSelected == true ? Colorz.green255 : null,
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
          screenWidth: Bubble.bubbleWidth(context: context),
          headerViewModel: BubbleHeaderVM(
              headlineVerse: 'City Chains Only',
              translateHeadline: false,
              headerWidth: Bubble.bubbleWidth(context: context) - 20,
              switchIsOn: true,
              hasSwitch: true,
              onSwitchTap: _onSwitchShowCityChainsOnly,
          ),
          bubbleColor: Colorz.black125,
          margins: const EdgeInsets.only(top: 5),
          columnChildren: const <Widget>[],
        ),

        /// SWITCH MULTIPLE SELECTION - SINGLE SELECTION
        Bubble(
          screenWidth: Bubble.bubbleWidth(context: context),
          headerViewModel: BubbleHeaderVM(
              headlineVerse: 'Multiple Selection mode',
              translateHeadline: false,
              headerWidth: Bubble.bubbleWidth(context: context) - 20,
              switchIsOn: true,
              hasSwitch: true,
              onSwitchTap: _onSwitchMultipleSelectionMode
          ),
          bubbleColor: Colorz.black125,
          margins: const EdgeInsets.only(top: 5),
          columnChildren: const <Widget>[],
        ),

        /// ZONE SELECTION
        Bubble(
          screenWidth: Bubble.bubbleWidth(context: context),
          headerViewModel: BubbleHeaderVM(
            headlineVerse: _onlyCityChains == true ? ZoneModel.translateZoneString(context: context, zoneModel: _zone) : '...',
            translateHeadline: false,
            headerWidth: Bubble.bubbleWidth(context: context) - 20,
            leadingIcon: _onlyCityChains == true ? Flag.getFlagIcon(_zone.countryID) : Iconz.earth,
          ),
          bubbleColor: _onlyCityChains == true ? Colorz.black125 : Colorz.black50,
          margins: const EdgeInsets.only(top: 5),
          onBubbleTap: _onSelectNewZone,
          columnChildren: const <Widget>[],
        ),

        DreamBox(
          height: 80,
          verseCentered: false,
          width: Bubble.clearWidth(context),
          verse: 'Go to Chains Picking Screen',
          translateVerse: false,
          secondLine: _getGoButtonDescription(),
          secondVerseMaxLines: 3,
          translateSecondLine: false,
          onTap: _onGoChainsPickingScreenButtonTap,
          verseScaleFactor: 0.7,
          margins: const EdgeInsets.only(top: 5),
          secondLineScaleFactor: 1.1,
        ),

      ],
    );

  }

}
