import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/dashboard/exotic_methods.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:flutter/material.dart';

class TestLab extends StatefulWidget {

  @override
  _TestLabState createState() => _TestLabState();
}

class _TestLabState extends State<TestLab> {
  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;

  ScrollController _ScrollController;

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

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

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _ScrollController = new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here

        _triggerLoading(
          function: (){
            /// set new values here
          }
        );
      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;


    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },

      appBarRowWidgets: <Widget>[

      ],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _ScrollController,
            children: <Widget>[

              const Stratosphere(),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'super bomb',
                  icon: Iconz.Share,
                  onTap: () async {

                    // _triggerLoading();
                    //
                    // /// do things here
                    //
                    // final List<dynamic> _maps = await Fire.readCollectionDocs(
                    //   limit: 400,
                    //   collName: 'old_zones',
                    //   addDocSnapshotToEachMap: false,
                    //   addDocsIDs: false,
                    //   orderBy: 'countryID',
                    // );
                    //
                    // print('LET THE GAMES BEGIN');
                    //
                    // List<CountryModel> _countries = CountryModel.decipherCountriesMaps(maps: _maps, fromJSON: false);
                    //
                    // /// countries stats
                    // final List<String> _allCountriesIDs = <String>[];
                    // int _numberOfCountries = 0;
                    // int _numberOfCities = 0;
                    //
                    // for (var country in _countries){
                    //
                    //   _allCountriesIDs.add(country.countryID);
                    //   _numberOfCountries++;
                    //
                    //   final List<String> _citiesIDs = <String>[];
                    //
                    //   for (CityModel city in country.cities){
                    //     _numberOfCities++;
                    //
                    //     final String _cityEnName = Name.getNameByLingoFromNames(names: city.names, lingoCode: 'en');
                    //     final String _cityID = CityModel.createCityID(countryID: city.countryID, cityEnName: _cityEnName);
                    //
                    //     _citiesIDs.add(_cityID);
                    //
                    //     final Map<String, dynamic> _cityMap = {
                    //       'countryID' : country.countryID,
                    //       'cityID' : _cityID,
                    //       'districts' : DistrictModel.cipherDistricts(city.districts),
                    //       'population' : city.population,
                    //       'isActivated' : false,
                    //       'isPublic' : false,
                    //       'names' : Name.cipherNames(city.names),
                    //       'position' : Atlas.cipherGeoPoint(point: city.position, toJSON: false),
                    //     };
                    //
                    //     // Mapper.printMap(_cityMap);
                    //
                    //     await Fire.createNamedSubDoc(
                    //       context: context,
                    //       collName: 'zones',
                    //       docName: 'cities',
                    //       subCollName: 'cities',
                    //       subDocName: _cityID,
                    //       input: _cityMap,
                    //     );
                    //
                    //   }
                    //
                    //   final Map<String, dynamic> _newMap = {
                    //     'countryID' : country.countryID,
                    //     'region' : country.region,
                    //     'continent' : country.continent,
                    //     'isActivated' : country.isActivated,
                    //     'isGlobal' : country.isGlobal,
                    //     'citiesIDs' : _citiesIDs,
                    //     'language' : country.language,
                    //     'names': Name.cipherNames(country.names),
                    //     'currency': country.currency,
                    //   };
                    //
                    //   // Mapper.printMap(_newMap);
                    //
                    //   await Fire.createNamedSubDoc(
                    //     context: context,
                    //     collName: 'zones',
                    //     docName: 'countries',
                    //     subCollName: 'countries',
                    //     subDocName: country.countryID,
                    //     input: _newMap,
                    //   );
                    //
                    //   await Fire.deleteDoc(context: context, collName: 'zones', docName: country.countryID);
                    //
                    //
                    //
                    //   print('done with ${Name.getNameByCurrentLingoFromNames(context, country.names)}');
                    //
                    // }
                    //
                    // await Fire.updateDocField(
                    //     context: context,
                    //     collName: 'zones',
                    //     docName: 'countries',
                    //     field: 'numberOfCountries',
                    //     input: _numberOfCountries,
                    // );
                    //
                    // await Fire.updateDocField(
                    //   context: context,
                    //   collName: 'zones',
                    //   docName: 'countries',
                    //   field: 'allCountriesIDs',
                    //   input: _allCountriesIDs,
                    // );
                    //
                    // // _numberOfCities
                    // await Fire.updateDocField(
                    //   context: context,
                    //   collName: 'zones',
                    //   docName: 'cities',
                    //   field: 'numberOfCities',
                    //   input: _numberOfCities,
                    // );
                    //
                    // /*
                    //
                    // [
                    // {code: en, value: Egypt, trigram: []},
                    //  {code: ar, value: مصر, trigram: []},
                    //  {code: es, value: Egipto, trigram: []},
                    //  {code: fr, value: Égypte, trigram: []},
                    //   {code: zh, value: 埃及, trigram: []},
                    //   {code: de, value: Ägypten, trigram: []}
                    //   ]
                    //
                    //  */
                    //
                    // _triggerLoading();

                  }
              ),

              WideButton(
                verse: 'LET THE GAMES BEGIN x b ',
                icon: Iconz.Share,
                onTap: () async {

                  print('LET THE GAMES BEGIN');

                  // final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
                  //
                  // final CountryModel _egy = await _zoneProvider.fetchCountryByID(context: context, countryID: 'egy');
                  //
                  // _egy.printCountry();

                  await ExoticMethods.updateAFieldInAllCollDocs(
                      context: context,
                      collName: FireColl.bzz,
                      field: 'zone',
                      input: Zone.dummyZone().toMap(),
                  );

                },
              ),



            ],
          ),
        ),
      ),
    );
  }


}