import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/swiper_layout.dart';
import 'package:bldrs/views/widgets/zone/zones_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class ChangeZoneScreen extends StatefulWidget {

  @override
  _ChangeZoneScreenState createState() => _ChangeZoneScreenState();
}

class _ChangeZoneScreenState extends State<ChangeZoneScreen> {
  String _chosenCountryID;
  String _chosenProvinceID;
  String _chosenAreaID;
  CountryProvider _countryPro;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    super.initState();
  }
// -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _continents = [
    {
      'name' : 'Africa',
      'icon' : Iconz.ContAfrica,
    },
    {
      'name' : 'Asia',
      'icon' : Iconz.ContAsia,
    },
    {
      'name' : 'Oceania',
      'icon' : Iconz.ContAustralia,
    },
    {
      'name' : 'Europe',
      'icon' : Iconz.ContEurope,
    },
    {
      'name' : 'North America',
      'icon' : Iconz.ContNorthAmerica,
    },
    {
      'name' : 'South America',
      'icon' : Iconz.ContSouthAmerica,
    },

  ];
// -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _generatePages(){
    List<Map<String, dynamic>> _pages = new List();

    _continents.forEach((cont) {

      List<String> _countriesIDs = _countryPro.getCountriesIDsByContinent(
        context: context,
        continent: cont['name'],
      );

      _pages.add(

        {

          'title' : cont['name'],

          'widget' :
          ZonesPage(
            title: cont['name'],
            continentIcon: cont['icon'],
            countriesIDs: _countriesIDs,
            buttonTap: (countryID) async {

              print('countryID is : $countryID');

              await superDialog(
                context: context,
                body: '$countryID',
              );


            },
          ),

        },

      );
    });

    return _pages;
  }
// -----------------------------------------------------------------------------
  void _tapCountry(String countryID, CountryProvider _countryPro){
    setState(() {
      _chosenCountryID = countryID;
      // _localizerPage = LocalizerPage.Province;
    });
    _countryPro.changeCountry(countryID);
    _countryPro.changeProvince('...');
    _countryPro.changeArea('...');
    print('selected country id is : $countryID');
  }
// -----------------------------------------------------------------------------
  void _tapProvince(String provinceID, CountryProvider _countryPro){
    setState(() {
      // _localizerPage = LocalizerPage.Area;
      _chosenProvinceID = provinceID;
    });
    _countryPro.changeProvince(provinceID);
    print('selected province id is : $provinceID');

  }
// -----------------------------------------------------------------------------
  void _tapArea(String areaID, CountryProvider _countryPro){
    setState(() {
      _chosenAreaID = areaID;
    });
    print('selected city id is : $areaID');
    _countryPro.changeArea(areaID);
    // _exitLocalizer();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
// //     CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
// // -----------------------------------------------------------------------------
//     List<Map<String,String>> _flags = _countryPro.getAvailableCountries(context);
//     List<Map<String,String>> _provinces = _countryPro.getProvincesNamesByIso3(context, _chosenCountryID);//_chosenCountry);
//     List<Map<String,String>> _areas = _countryPro.getAreasNamesByProvinceID(context, _chosenProvinceID);//_chosenProvince);

    List<String> _countriesIDs = _countryPro.getCountriesIDsByContinent(
      context: context,
      continent: 'Africa',
    );

    return

        SwiperLayoutScreen(
          swiperPages: _generatePages(),
        );


  }
}


