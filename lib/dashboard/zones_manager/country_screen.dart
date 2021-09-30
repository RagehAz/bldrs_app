import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/specific/keywords/keywords_bubble.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class CountryEditorScreen extends StatefulWidget {
  final Country country;

  CountryEditorScreen({@required this.country});

  @override
  _CountryEditorScreenState createState() => _CountryEditorScreenState();
}

class _CountryEditorScreenState extends State<CountryEditorScreen> {
  String _countriesCollectionName = 'countries';
  // CollectionReference _countriesCollection;
  // final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  String _name;
  String _region;
  String _continent;
  String _flag;
  bool _isActivated;
  bool _isGlobal;
  List<City> _provinces;
  String _language;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // _countriesCollection = _fireInstance.collection('countries');
    _name = widget.country.name;
    _region = widget.country.region;
    _continent = widget.country.continent;
    _flag = widget.country.flag;
    _isActivated = widget.country.isActivated;
    _isGlobal = widget.country.isGlobal;
    _provinces = widget.country.cities;
    _language = widget.country.language;
  }
// ---------------------------------------------------------------------------
  Future <void> _updateCountryFieldOnFirestore(String _field, dynamic _input) async {
    _triggerLoading();

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await Fire.updateDocField(
      context: context,
      collName: _countriesCollectionName,
      docName: widget.country.iso3,
      field: _field,
      input: _input,
    );
    _triggerLoading();
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<String> _provincesNames = City.getCitiesNamesFromCountryModel(widget.country);

    return MainLayout(
      sky: Sky.Black,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      appBarType: AppBarType.Scrollable,
      appBarRowWidgets: <Widget>[

        DreamBox(
          height: 35,
          icon: _flag,
          verse: _name,
          verseMaxLines: 2,
          iconSizeFactor: 0.8,
          bubble: false,
          margins: const EdgeInsets.all(7.5),
          onTap: () async {
              await CenterDialog.showCenterDialog(
                context: context,
                title: 'Country ISO3',
                body: widget.country.iso3,
                boolDialog: false,
              );},
        ),

      ],
      layoutWidget: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          const Stratosphere(),

          /// --- ISO3
          TileBubble(
             verse: '${widget.country.name}\'s ISO3 is : ( ${widget.country.iso3} )',
             icon: Iconz.Info,
           verseColor: Colorz.Yellow255,
           iconBoxColor: Colorz.Grey50,
         ),

          const BubblesSeparator(),

          /// --- NAME
          TextFieldBubble(
            title: 'Country Name',
            textOnChanged: (val) => setState(() {_name = val;}),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _name,
            bubbleColor: Colorz.White20,
            actionBtIcon: Iconz.Check,
            actionBtFunction: () => _updateCountryFieldOnFirestore('name', _name),
          ),

          /// --- Language
          TextFieldBubble(
            title: 'Main language',
            textOnChanged: (val) => setState(() {_language = val;}),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _language,
            bubbleColor: Colorz.White20,
            actionBtIcon: Iconz.Check,
            actionBtFunction: () => _updateCountryFieldOnFirestore('language', _language),
          ),

          /// --- FLAG
          TextFieldBubble(
            title: 'flag',
            textOnChanged: (val) => setState(() {_flag = val;}),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _flag,
            bubbleColor: Colorz.White20,
            actionBtIcon: Iconz.Check,
            actionBtFunction: () => _updateCountryFieldOnFirestore('flag', _flag),
            leadingIcon: _flag,
          ),

          const BubblesSeparator(),

          /// --- REGION
          TextFieldBubble(
            title: 'Region',
            textOnChanged: (val) => setState(() {_region = val;}),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _region,
            bubbleColor: Colorz.White20,
            actionBtIcon: Iconz.Check,
            actionBtFunction: () => _updateCountryFieldOnFirestore('region', _region),
          ),

          /// --- CONTINENT
          TextFieldBubble(
            title: 'Continent',
            textOnChanged: (val) => setState(() {_continent = val;}),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _continent,
            bubbleColor: Colorz.White20,
            actionBtIcon: Iconz.Check,
            actionBtFunction: () => _updateCountryFieldOnFirestore('continent', _continent),
          ),

          const BubblesSeparator(),

          /// --- IS ACTIVATED
          TileBubble(
            verse: 'Country is Activated ?',
            secondLine: 'When Country is Deactivated, only business authors may see it while creating business profile',
            icon: _flag,
            verseColor: Colorz.White255,
            iconBoxColor: Colorz.Grey50,
            iconSizeFactor: 1,
            switchIsOn: _isActivated,
            switching: (val){
              setState(() {_isActivated = val;});
              _updateCountryFieldOnFirestore('isActivated', _isActivated);
              print(val);
            },
          ),

          /// --- IS GLOBAL
          TileBubble(
            verse: 'Country is Global ?',
            secondLine: 'When Country is not Global, only users of this country will see its businesses and flyers',
            icon: _flag,
            verseColor: Colorz.White255,
            iconBoxColor: Colorz.Grey50,
            iconSizeFactor: 1,
            switchIsOn: _isGlobal,
            switching: (val){
              setState(() {_isGlobal = val;});
              _updateCountryFieldOnFirestore('isGlobal', _isGlobal);
              print(val);
            },
          ),

          const BubblesSeparator(),

          KeywordsBubble(
            title: '${_provincesNames.length} Provinces',
            keywords: City.getKeywordsFromCities(context, _provinces),
            onTap: (val) {print(val);},
            selectedWords: <dynamic>[],
            addButtonIsOn: false,
          ),

          const PyramidsHorizon(),

        ],
      ),
    );
  }
}
