import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:flutter/material.dart';

import '../mabwala.dart';

class RandomTestSpace extends StatefulWidget {
final double flyerBoxWidth;

RandomTestSpace({
  @required this.flyerBoxWidth,
});

  @override
  _RandomTestSpaceState createState() => _RandomTestSpaceState();
}

class _RandomTestSpaceState extends State<RandomTestSpace> {
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

              // WideButton(
              //   color: Colorz.BloodTest,
              //   verse: 'add cities',
              //   icon: Iconz.Share,
              //   onTap: () async {
              //
              //     List<dynamic> _maps = await Fire.readCollectionDocs(
              //       limit: 300,
              //       addDocID: true,
              //       orderBy: 'countryID',
              //       collectionName: 'zones',
              //       addDocSnapshotToEachMap: false,
              //     );
              //
              //     for (var map in _maps){
              //
              //     }
              //
              //   },
              // ),

              WideButton(
                color: Colorz.BloodTest,
                verse: 'add cities palestine',
                icon: Iconz.DvBlackHole,
                onTap: () async {

                  _triggerLoading();

                  final List<CityModel> _raw = RawCities.and();

                  final List<CityModel> _fixed = RawCities.getFixedCities(_raw);

                  final List<String> _countriesIDs = <String>[];

                  for (var city in _fixed){
                    if (!_countriesIDs.contains(city.countryID)){
                      _countriesIDs.add(city.countryID);
                    }
                  }

                  for (String id in _countriesIDs){

                    List<CityModel> _citiesOfThisCountry = <CityModel>[];

                    for (CityModel city in _fixed){

                      if (city.countryID == id){
                        _citiesOfThisCountry.add(city);
                      }

                    }

                    await Fire.updateDocField(
                        context: context,
                        collName: 'zones',
                        docName: id,
                        field: 'cities',
                        input: CityModel.cipherCities(cities: _citiesOfThisCountry, toJSON: false),
                    );

                  }


                  // print('tamam with country : ${_fixed[0].countryID}, uploaded ${_fixed.length} cities');

                  _triggerLoading();

                },
              ),
              


            ],
          ),
        ),
      ),
    );
  }


}