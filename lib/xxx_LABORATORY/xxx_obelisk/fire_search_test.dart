import 'dart:io';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/search_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/navigation_test/page_2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FireSearchTest extends StatefulWidget {

  @override
  _FireSearchTestState createState() => _FireSearchTestState();
}

class _FireSearchTestState extends State<FireSearchTest> {
  // List<Map<String, Object>> functions;
  String printVerse;
  File _dumFile;
  String _dumURL;
  List<SaveModel> _userSavesModels;
  Map<String, dynamic> _userSavesMap;
  List<SaveModel> _decipheredSavesModels;
  List<TinyFlyer> _tinyFlyers;
  List<FlyerModel> _allFLyers;
  String _picURL;
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
              provinceID: 'Cairo',
              areaID: '13'
          ),
          flyerType: FlyerType.Property,
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

        Expanded(child: Container(),),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'trigger loading',
          verseMaxLines: 2,
          boxMargins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verseScaleFactor: 0.5,
          boxFunction: (){
            _triggerLoading();
          },
        ),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'Clear Print',
          verseMaxLines: 2,
          boxMargins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verseScaleFactor: 0.5,
          boxFunction: (){
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
                    boxMargins: const EdgeInsets.all(5),
                    verseMaxLines: 3,
                    verseScaleFactor: 0.7,
                    verse: functions[index]['Name'],
                    color: Colorz.BloodTest,
                    boxFunction: functions[index]['function'],
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
                color: Colorz.WhiteGlass,
                corners: 0,
                boxMargins: const EdgeInsets.symmetric(vertical: 10),
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
                color: Colorz.BabyBlue,
              ),


                PyramidsHorizon(heightFactor: 10,),

            ],
          ),


          Positioned(
            bottom: 0,
            child: InPyramidsBubble(
              bubbleColor: Colorz.BlackBlack,
              centered: true,
              stretchy: false,
              columnChildren: <Widget>[
                SuperVerse(
                  verse: printVerse ?? 'print Area',
                  maxLines: 12,
                  weight: VerseWeight.thin,
                  color: printVerse == null ? Colorz.WhiteGlass : Colorz.White,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
