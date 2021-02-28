import 'package:bldrs/ambassadors/services/firestore.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/models/planet/province_model.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CountryScreen extends StatefulWidget {
  final Country country;

  CountryScreen({@required this.country});

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  String _countriesCollectionName = 'countries';
  CollectionReference _countriesCollection;
  final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  String _name;
  String _region;
  String _continent;
  String _flag;
  bool _isActivated;
  bool _isGlobal;
  List<Province> _provinces;
  String _language;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING') : print('LOADING COMPLETE');
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _countriesCollection = _fireInstance.collection('countries');
    _name = widget.country.name;
    _region = widget.country.region;
    _continent = widget.country.continent;
    _flag = widget.country.flag;
    _isActivated = widget.country.isActivated;
    _isGlobal = widget.country.isGlobal;
    _provinces = widget.country.provinces;
    _language = widget.country.language;
    super.initState();
  }
// ---------------------------------------------------------------------------
  Future <void> _updateCountryFieldOnFirestore(String _field, dynamic _input) async {
    _triggerLoading();
    await updateFieldOnFirestore(
      context: context,
      collectionName: _countriesCollectionName,
      documentName: widget.country.iso3,
      field: _field,
      input: _input,
    );
    _triggerLoading();
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);

    List<String> _provincesNames = getProvincesNamesFromCountryModel(widget.country);

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
          boxMargins: EdgeInsets.all(7.5),
          boxFunction: () => superDialog(context, widget.country.iso3, 'Country ISO3'),
        ),

      ],
      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Stratosphere(),

            // --- ISO3
            TileBubble(
               verse: '${widget.country.name}\'s ISO3 is : ( ${widget.country.iso3} )',
               icon: Iconz.Info,
             verseColor: Colorz.Yellow,
             iconBoxColor: Colorz.GreyZircon,
           ),

            BubblesSeparator(),

            // --- NAME
            TextFieldBubble(
              title: 'Country Name',
              textOnChanged: (val) => setState(() {_name = val;}),
              fieldIsRequired: true,
              fieldIsFormField: true,
              initialTextValue: _name,
              bubbleColor: Colorz.WhiteGlass,
              actionBtIcon: Iconz.Check,
              actionBtFunction: () => _updateCountryFieldOnFirestore('name', _name),
            ),

            // --- Language
            TextFieldBubble(
              title: 'Main language',
              textOnChanged: (val) => setState(() {_language = val;}),
              fieldIsRequired: true,
              fieldIsFormField: true,
              initialTextValue: _language,
              bubbleColor: Colorz.WhiteGlass,
              actionBtIcon: Iconz.Check,
              actionBtFunction: () => _updateCountryFieldOnFirestore('language', _language),
            ),

            // --- FLAG
            TextFieldBubble(
              title: 'flag',
              textOnChanged: (val) => setState(() {_flag = val;}),
              fieldIsRequired: true,
              fieldIsFormField: true,
              initialTextValue: _flag,
              bubbleColor: Colorz.WhiteGlass,
              actionBtIcon: Iconz.Check,
              actionBtFunction: () => _updateCountryFieldOnFirestore('flag', _flag),
              leadingIcon: _flag,
            ),

            BubblesSeparator(),

            // --- REGION
            TextFieldBubble(
              title: 'Region',
              textOnChanged: (val) => setState(() {_region = val;}),
              fieldIsRequired: true,
              fieldIsFormField: true,
              initialTextValue: _region,
              bubbleColor: Colorz.WhiteGlass,
              actionBtIcon: Iconz.Check,
              actionBtFunction: () => _updateCountryFieldOnFirestore('region', _region),
            ),

            // --- CONTINENT
            TextFieldBubble(
              title: 'Continent',
              textOnChanged: (val) => setState(() {_continent = val;}),
              fieldIsRequired: true,
              fieldIsFormField: true,
              initialTextValue: _continent,
              bubbleColor: Colorz.WhiteGlass,
              actionBtIcon: Iconz.Check,
              actionBtFunction: () => _updateCountryFieldOnFirestore('continent', _continent),
            ),

            BubblesSeparator(),

            // --- IS ACTIVATED
            TileBubble(
              verse: 'Country is Activated ?',
              secondLine: 'When Country is Deactivated, only business authors may see it while creating business profile',
              icon: _flag,
              verseColor: Colorz.White,
              iconBoxColor: Colorz.GreyZircon,
              iconSizeFactor: 1,
              switchIsOn: _isActivated,
              switching: (val){
                setState(() {_isActivated = val;});
                _updateCountryFieldOnFirestore('isActivated', _isActivated);
                print(val);
              },
            ),

            // --- IS GLOBAL
            TileBubble(
              verse: 'Country is Global ?',
              secondLine: 'When Country is not Global, only users of this country will see its businesses and flyers',
              icon: _flag,
              verseColor: Colorz.White,
              iconBoxColor: Colorz.GreyZircon,
              iconSizeFactor: 1,
              switchIsOn: _isGlobal,
              switching: (val){
                setState(() {_isGlobal = val;});
                _updateCountryFieldOnFirestore('isGlobal', _isGlobal);
                print(val);
              },
            ),

            BubblesSeparator(),
            
            WordsBubble(
              title: '${_provincesNames.length} Provinces',
              bubbles: true,
              words: _provincesNames,
              onTap: (val) {print(val);},
            ),

            PyramidsHorizon(heightFactor: 10,),

          ],
        ),
      ),
    );
  }
}
