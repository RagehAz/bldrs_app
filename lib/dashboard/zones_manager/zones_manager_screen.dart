import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/dashboard/zones_manager/country_screen.dart';
import 'package:bldrs/db/fire/methods/firestore.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ZonesManagerScreen extends StatefulWidget {

  @override
  _ZonesManagerScreenState createState() => _ZonesManagerScreenState();
}

class _ZonesManagerScreenState extends State<ZonesManagerScreen> {
  List<CountryModel> _countries;
  ScrollController _ScrollController;
  QueryDocumentSnapshot _lastSnap;
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


        _readMoreCountries();

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
  Future<void> _readMoreCountries() async {

    if (_loading == false){
      setState(() {
        _loading = true;
      });
    }

    List<Map<String, dynamic>> _maps = await Fire.readSubCollectionDocs(
      context: context,
      addDocsIDs: false,
      collName: FireColl.zones,
      docName: 'countries',
      subCollName: 'countries',
      limit: 5,
      orderBy: 'id',
      startAfter: _lastSnap,
      addDocSnapshotToEachMap: true,
    );


    List<CountryModel> _countriesModels = CountryModel.decipherCountriesMaps(maps: _maps, fromJSON: false);

    QueryDocumentSnapshot _snap = _maps[_maps.length - 1]['docSnapshot'];

    setState(() {
      _countries = _countriesModels;
      _lastSnap = _snap;
      _loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      pageTitle: 'Zones Manager',
      // appBarBackButton: true,
      sky: Sky.Black,
      layoutWidget:

        Mapper.canLoopList(_countries) == false ?

        Container()

            :

        ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _ScrollController,
          shrinkWrap: false,
          padding: const EdgeInsets.only(top: Ratioz.stratosphere),
          itemCount: _countries?.length,
          itemBuilder: (context, index){

            final CountryModel _countryModel = _countries[index];
            final String _countryName = Name.getNameByCurrentLingoFromNames(context, _countryModel.names);

            return
              DreamBox(
                height: 100,
                width: _screenWidth - (Ratioz.appBarMargin * 2),
                icon: Flag.getFlagIconByCountryID(_countries[index].id),
                verse: _countryName,
                bubble: false,
                color: Colorz.white20,
                verseMaxLines: 2,
                verseScaleFactor: 0.6,
                margins: const EdgeInsets.all(7.5),
                onTap: () => Nav.goToNewScreen(context, CountryEditorScreen(country: _countries[index])),
              );

          },
        )

    );
  }
}
