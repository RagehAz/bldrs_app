import 'package:bldrs/models/planet/area_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/models/planet/province_model.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'db_areas.dart';
import 'db_countries.dart';
import 'db_provinces.dart';

class ZonesManager extends StatefulWidget {

  @override
  _ZonesManagerState createState() => _ZonesManagerState();
}

class _ZonesManagerState extends State<ZonesManager> {
  final List<Country> _countries = dbCountries;
  final List<Province> _provinces = dbProvinces;
  final List<Area> _areas = dbAreas;
  final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  CollectionReference _countriesCollection;
  bool _loading = false;

  @override
  void initState() {
    _countriesCollection = _fireInstance.collection('countries');
    super.initState();
  }


  Future<void> _uploadCountriesToFirebase() async {
    print('starting countries uploading');
    try {
      Map<String, dynamic> _postData = geebCountryByIso3('egy').toMap();

      /// this specifies country name as Firestore document's id
      await _countriesCollection.doc(_postData['name']).set(_postData);

    } catch(error) {
      superDialog(context, error);
    }
  }

  void _triggerLoading(){
    setState(() {
      _loading = !_loading;
    });
    _loading == true?
    print('LOADING') : print('LOADING COMPLETE');
  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      pageTitle: 'Zones Manager',
      sky: Sky.Black,
      loading: _loading,
      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: ListView(
          children: <Widget>[

            Stratosphere(),

            DreamBox(
              width: _screenWidth * 0.9,
              height: _screenWidth * 0.3,
              color: Colorz.Yellow,
              verse: 'Upload Countries to Firebase',
              verseMaxLines: 3,
              verseColor: Colorz.BlackBlack,
              verseWeight: VerseWeight.black,
              boxFunction: _uploadCountriesToFirebase,
            ),

            DreamBox(
              height: 50,
              verse: 'trigger loading',
              icon: Iconz.Clock,
              color: _loading ? Colorz.Green : Colorz.Grey,
              boxMargins: EdgeInsets.all(20),
              boxFunction: _triggerLoading,
            ),

          ],
        ),
      ),
    );
  }
}
