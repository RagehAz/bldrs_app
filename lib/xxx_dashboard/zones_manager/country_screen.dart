import 'dart:async';

import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/specific/keywords/keywords_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class CountryEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountryEditorScreen({
    @required this.country,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final CountryModel country;
  /// --------------------------------------------------------------------------
  @override
  _CountryEditorScreenState createState() => _CountryEditorScreenState();

  /// --------------------------------------------------------------------------
}

class _CountryEditorScreenState extends State<CountryEditorScreen> {
  // static const String _countriesCollectionName = 'countries';
  // CollectionReference _countriesCollection;
  // final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  String _name;
  String _region;
  String _continent;
  String _flag;
  bool _isActivated;
  bool _isGlobal;
  List<CityModel> _cities;
  String _language;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (function == null) {
      setState(() {
        _loading = !_loading;
      });
    } else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // _countriesCollection = _fireInstance.collection('countries');
    _name =
        'blah'; //Name.getNameByCurrentLingoFromNames(context, widget.country.names);
    _region = widget.country.region;
    _continent = widget.country.continent;
    _flag = Flag.getFlagIconByCountryID(widget.country.id);
    _isActivated = widget.country.isActivated;
    _isGlobal = widget.country.isGlobal;
    // _cities = widget.country.cities;
    _language = widget.country.language;
  }

// ---------------------------------------------------------------------------
  Future<void> _updateCountryFieldOnFirestore(
      String _field, dynamic _input) async {
    unawaited(_triggerLoading());

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    /// TASK : update country field method
    // await Fire.updateDocField(
    //   context: context,
    //   collName: FireColl.zones,
    //   docName: widget.country.id,
    //   field: _field,
    //   input: _input,
    // );

    unawaited(_triggerLoading());
  }

// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final List<String> _citiesNames = <String>[];
    // CityModel.getCitiesNamesFromCountryModelByCurrentLingo(
    //   context: context,
    //   country: widget.country,
    // );

    final String _countryName =
        Name.getNameByCurrentLingoFromNames(context: context, names: widget.country.names)?.value;

    return MainLayout(
      skyType: SkyType.black,
      pyramidsAreOn: true,
      // loading: _loading,
      appBarType: AppBarType.scrollable,
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
              body: widget.country.id,
            );
          },
        ),
      ],
      layoutWidget: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          const Stratosphere(),

          /// --- ISO3
          TileBubble(
            verse: "$_countryName's ISO3 is : ( ${widget.country.id} )",
            icon: Iconz.info,
            verseColor: Colorz.yellow255,
            iconBoxColor: Colorz.grey50,
          ),

          const BubblesSeparator(),

          /// --- NAME
          TextFieldBubble(
            title: 'Country Name',
            textOnChanged: (String val) => setState(() {
              _name = val;
            }),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _name,
            actionBtIcon: Iconz.check,
            actionBtFunction: () =>
                _updateCountryFieldOnFirestore('name', _name),
          ),

          /// --- Language
          TextFieldBubble(
            title: 'Main language',
            textOnChanged: (String val) => setState(() {
              _language = val;
            }),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _language,
            actionBtIcon: Iconz.check,
            actionBtFunction: () =>
                _updateCountryFieldOnFirestore('language', _language),
          ),

          /// --- FLAG
          TextFieldBubble(
            title: 'flag',
            textOnChanged: (String val) => setState(() {
              _flag = val;
            }),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _flag,
            actionBtIcon: Iconz.check,
            actionBtFunction: () =>
                _updateCountryFieldOnFirestore('flag', _flag),
            leadingIcon: _flag,
          ),

          const BubblesSeparator(),

          /// --- REGION
          TextFieldBubble(
            title: 'Region',
            textOnChanged: (String val) => setState(() {
              _region = val;
            }),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _region,
            actionBtIcon: Iconz.check,
            actionBtFunction: () =>
                _updateCountryFieldOnFirestore('region', _region),
          ),

          /// --- CONTINENT
          TextFieldBubble(
            title: 'Continent',
            textOnChanged: (String val) => setState(() {
              _continent = val;
            }),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _continent,
            actionBtIcon: Iconz.check,
            actionBtFunction: () =>
                _updateCountryFieldOnFirestore('continent', _continent),
          ),

          const BubblesSeparator(),

          /// --- IS ACTIVATED
          TileBubble(
            verse: 'Country is Activated ?',
            secondLine:
                'When Country is Deactivated, only business authors may see it while creating business profile',
            icon: _flag,
            iconBoxColor: Colorz.grey50,
            iconSizeFactor: 1,
            switchIsOn: _isActivated,
            switching: (bool val) {
              setState(() {
                _isActivated = val;
              });
              _updateCountryFieldOnFirestore('isActivated', _isActivated);
              blog(val);
            },
          ),

          /// --- IS GLOBAL
          TileBubble(
            verse: 'Country is Global ?',
            secondLine:
                'When Country is not Global, only users of this country will see its businesses and flyers',
            icon: _flag,
            iconBoxColor: Colorz.grey50,
            iconSizeFactor: 1,
            switchIsOn: _isGlobal,
            switching: (bool val) {
              setState(() {
                _isGlobal = val;
              });
              _updateCountryFieldOnFirestore('isGlobal', _isGlobal);
              blog(val);
            },
          ),

          const BubblesSeparator(),

          KeywordsBubble(
            title: '${_citiesNames.length} Provinces',
            keywords: CityModel.getKeywordsFromCities(context: context, cities: _cities),
            onTap: () {
              blog('bubble tapped');
            },
            onKeywordTap: (KW kw) {
              kw.blogKeyword();
            },
            selectedWords: const <dynamic>[],
            addButtonIsOn: false,
          ),

          const Horizon(),
        ],
      ),
    );
  }
}
