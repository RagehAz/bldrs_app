import 'dart:io';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/search_ops.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FireSearchTest extends StatefulWidget {

  @override
  _FireSearchTestState createState() => _FireSearchTestState();
}

class _FireSearchTestState extends State<FireSearchTest> {
  // List<Map<String, Object>> functions;
  String printVerse;
  // File _dumFile;
  // String _dumURL;
  // List<SaveModel> _userSavesModels;
  // Map<String, dynamic> _userSavesMap;
  // List<SaveModel> _decipheredSavesModels;
  List<TinyFlyer> _tinyFlyers;
  // List<FlyerModel> _allFLyers;
  // String _picURL;
  File _filePic;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();
  }
  // -----------------------------------------------------------------------
  void printResult(String verse){
    setState(() {printVerse = verse;});
    print(verse);
  }
  // ---------------------------------------------------------------------------

  // Query khara(){
  //   Query _khara = .where('flyerType', isEqualTo: 2);
  //
  //
  //   return _khara;
  // }

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> functions = <Map<String, dynamic>>[

      {'Name' : 'search tiny flyers', 'function' : () async {
        _triggerLoading();

        List<TinyFlyer> _searchedTinyFlyers = await FireSearch.flyersByZoneAndFlyerType(
          context: context,
          zone: Zone(
              countryID: 'egy',
              cityID: 'Cairo',
              districtID: '13'
          ),
          flyerType: FlyerType.rentalProperty,
        );

        printResult('_tinyFlyers : ${_searchedTinyFlyers?.length} : ${_searchedTinyFlyers?.toString()}');

        setState(() {
          _tinyFlyers = _searchedTinyFlyers;
        });

        _triggerLoading();

      }
      }
    // -----------------------------------------------------------------------
    ];


    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      pageTitle: 'Firebase Testers',
      loading: _loading,
      appBarRowWidgets: <Widget>[

        Expander(),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'trigger loading',
          verseMaxLines: 2,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verseScaleFactor: 0.5,
          onTap: (){
            _triggerLoading();
          },
        ),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'Clear Print',
          verseMaxLines: 2,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verseScaleFactor: 0.5,
          onTap: (){
            printResult('');
          },
        ),

      ],

      layoutWidget: Stack(
        children: <Widget>[

          ListView(
            children: <Widget>[

              Stratosphere(),

              ...List.generate(
                  functions.length, (index){
                return
                  DreamBox(
                    height: 60,
                    width: 300,
                    margins: const EdgeInsets.all(5),
                    verseMaxLines: 3,
                    verseScaleFactor: 0.7,
                    verse: functions[index]['Name'],
                    color: Colorz.BloodTest,
                    onTap: functions[index]['function'],
                  );
              }),

              // _theSlides('flyerA'),
              //
              // _theSlides('flyerB'),
              //
              // _theSlides('flyerC'),
              //
              // ..._savesWidgets(_userSavesModels),

              DreamBox(
                width: Scale.superScreenWidth(context) * 0.95,
                height: 2.5,
                color: Colorz.White20,
                corners: 0,
                margins: const EdgeInsets.symmetric(vertical: 10),
              ),

              // ..._savesWidgets(_decipheredSavesModels),

              SuperVerse(
                verse: _tinyFlyers == null ? 'saved flyers' : 'dbFlyers',
              ),

              if (_tinyFlyers != null)
              FlyersGrid(
                gridZoneWidth: Scale.superScreenWidth(context),
                scrollable: false,
                stratosphere: false,
                numberOfColumns: 6,
                tinyFlyers: _tinyFlyers,
              ),

                /// test url from asset
              if(_filePic !=null)
              DreamBox(
                height: 100,
                width: 100,
                // icon: _filePic,
                iconFile: _filePic,
                iconSizeFactor: 1,
                color: Colorz.Blue225,
              ),


                PyramidsHorizon(),

            ],
          ),


          Positioned(
            bottom: 0,
            child: Bubble(
              bubbleColor: Colorz.Black230,
              centered: true,
              stretchy: false,
              columnChildren: <Widget>[
                SuperVerse(
                  verse: printVerse ?? 'print Area',
                  maxLines: 12,
                  weight: VerseWeight.thin,
                  color: printVerse == null ? Colorz.White20 : Colorz.White255,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
