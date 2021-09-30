import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/zones_manager/country_screen.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ZonesManagerScreen extends StatefulWidget {

  @override
  _ZonesManagerScreenState createState() => _ZonesManagerScreenState();
}

class _ZonesManagerScreenState extends State<ZonesManagerScreen> {
  // final List<Country> _countries = dbCountries;
  // final List<Province> _provinces = dbProvinces;
  // final List<Area> _areas = dbAreas;
  final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  CollectionReference _countriesCollection;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  // void _triggerLoading(){
  //   setState(() {_loading = !_loading;});
  //   _loading == true?
  //   print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  // }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _countriesCollection = _fireInstance.collection('countries');
  }
// ---------------------------------------------------------------------------
//   Future<void> _uploadCountriesToFirebase() async {
//     print('starting countries uploading');
//     _triggerLoading();
//     try {
//       Map<String, dynamic> _postData = DbCountries.getCountryByIso3('egy').toMap();
//
//       /// this specifies country name as Firestore document's id
//       await _countriesCollection.doc(_postData['iso3']).set(_postData);
//
//     } catch(error) {
//
//           await superDialog(
//             context: context,
//             title: 'Uploading error',
//             body: error,
//             boolDialog: false,
//           );
//
//     }
//     _triggerLoading();
//   }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _countriesList = _countriesCollection.snapshots();
    // List<Country> _countriesList = dbCountries;

    final double _screenWidth = Scale.superScreenWidth(context);

    final double _countryButtonWidth = _screenWidth - superVerseRealHeight(context, 2, 1, null);

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      pageTitle: 'Zones Manager',
      // appBarBackButton: true,
      sky: Sky.Black,
      loading: _loading,
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          // DreamBox(
          //   width: _screenWidth * 0.9,
          //   height: _screenWidth * 0.3,
          //   color: Colorz.Yellow255,
          //   verse: 'Upload Countries to Firebase',
          //   verseMaxLines: 3,
          //   verseColor: Colorz.Black230,
          //   verseWeight: VerseWeight.black,
          //   onTap: _uploadCountriesToFirebase,
          //   margins: const EdgeInsets.all(10),
          // ),

          Bubble(
            centered: true,
            bubbleColor: Colorz.White20,
            columnChildren: <Widget>[

              Container(
                width: _screenWidth,
                height: _screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SuperVerse(
                      verse: 'Countries in FireStore',
                      size: 2,
                      weight: VerseWeight.bold,
                      italic: true,
                      centered: true,
                    ),

                    Container(
                      width: _screenWidth,
                      height: _countryButtonWidth,
                      child: StreamBuilder(
                        stream: _countriesList,
                        builder: (ctx, streamSnapshots){
                          List<dynamic> _countriesMaps = streamSnapshots?.data?.docs;
                          List<Country> _countries = Country.decipherCountriesMaps(_countriesMaps);

                          if (StreamChecker.connectionIsLoading(streamSnapshots)){
                            return Loading(loading: _loading,);
                          }
                          return ListView.builder(
                            itemCount: _countries.length,
                            itemBuilder: (context, index){

                              return
                                DreamBox(
                                  height: _countryButtonWidth * 0.12,
                                  width: _countryButtonWidth - _screenWidth * 0.2,
                                  icon: _countries[index].flag,
                                  verse: _countries[index].name,
                                  verseMaxLines: 2,
                                  verseScaleFactor: 0.6,
                                  margins: const EdgeInsets.all(7.5),
                                  onTap: () => Nav.goToNewScreen(context, CountryEditorScreen(country: _countries[index])),
                                );

                            },
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
