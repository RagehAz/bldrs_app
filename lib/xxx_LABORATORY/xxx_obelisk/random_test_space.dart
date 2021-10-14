import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:flutter/material.dart';

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

              // DreamBox(
              //   height: 50,
              //   width: 200,
              //   verse: 'testing max firebase upload _numberOfFields : $_numberOfFields fields',
              //   verseScaleFactor: 0.7,
              //   onTap: () async {
              //
              //     Map<String, dynamic> _map = {};
              //
              //     for (int i = 0; i < 1000; i++){
              //       _map = Mapper.insertPairInMap(
              //         map: _map,
              //         key: 'key$i',
              //         value: '$i : ${DateTime.now().millisecondsSinceEpoch}',
              //       );
              //     }
              //
              //     await Fire.createNamedDoc(
              //       context: context,
              //       collName: FireCollection.admin,
              //       docName: 'test',
              //       input: _map,
              //     );
              //
              //     Map<String, dynamic> doc = await Fire.readDoc(
              //       context: context,
              //       collName: FireCollection.admin,
              //       docName: 'test',
              //     );
              //
              //     List<MapModel> _mapModels = MapModel.getModelsFromMap(doc);
              //
              //     setState(() {
              //       _numberOfFields = _mapModels.length;
              //     });
              //
              //   },
              // ),

              WideButton(
                color: Colorz.BloodTest,
                verse: 'fix zoneszz',
                icon: Iconz.Share,
                onTap: () async {

                  List<dynamic> _maps = await Fire.readCollectionDocs(
                    limit: 300,
                    addDocID: true,
                    orderBy: 'countryID',
                    collectionName: 'zones',
                    addDocSnapshotToEachMap: false,
                  );

                  for (var map in _maps){


                    final CountryModel _country = CountryModel.decipherCountryMap(map);

                    if (map['countryKey'] != null){

                      await Fire.deleteDoc(
                        context: context,
                        collName: 'zones',
                        docName: map['countryKey'],
                      );

                      await Fire.createNamedDoc(
                        context: context,
                        collName: 'zones',
                        docName: _country.countryID,
                        input: _country.toMap(),
                      );

                    }


                      print('tamam with ${_country.countryID}');



                  }

                },
              ),

              WideButton(
                color: Colorz.BloodTest,
                verse: 'fix life',
                icon: Iconz.DvBlackHole,
                onTap: () async {

                },
              ),
              

              WideButton(
                color: Colorz.BloodTest,
                verse: 'object is timestamp',
                icon: Iconz.DvBlackHole,
                onTap: () async {

                  final String flyerID = '1eFVUCIodzzX6dTL49FS';

                  dynamic map = await Fire.readDoc(context: context, collName: FireCollection.flyers , docName: flyerID);

                  dynamic _createdAt = map['deletionTime'];

                  bool isTimestamp = ObjectChecker.objectIsTimeStamp(_createdAt);

                  print('done with all isTimestamp : $isTimestamp');


                },
              ),

              // Container(
              //   width: Scale.superScreenWidth(context),
              //   alignment: Alignment.center,
              //   child: Container(
              //     width: Scale.superScreenWidth(context) * 0.8,
              //     height: 400,
              //     color: Colorz.BloodTest,
              //     child: Scroller(
              //       controller: _ScrollController,
              //       child: ListView.builder(
              //           itemCount: _theData.length,
              //           itemBuilder: (ctx , index){
              //
              //             final String key = _theData[index].key;
              //             final String value = _theData[index].value;
              //
              //             final string = '$key : $value';
              //
              //             return
              //               DreamBox(
              //                 height: 30,
              //                 width: Scale.superScreenWidth(context) - 100,
              //                 verse: '   $string',
              //                 verseScaleFactor: 0.6,
              //                 verseWeight: VerseWeight.thin,
              //                 verseItalic: true,
              //                 verseCentered: false,
              //                 margins: 3,
              //               );
              //
              //           }),
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }


}

/*

clean cdCn0xNwoGaxWOgTc3gvN6sr6BH2
qEmHQl1d5wM0lORHSGopNhFvkg82
OhkyYuCTdOX6X3pnOPUc6kTigYH3
bFMwW4QaJqNwFznjtg6YoZ5jMmC2

 */