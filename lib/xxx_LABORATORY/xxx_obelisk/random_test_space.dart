import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/super_methods.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/helpers/map_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
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

  int _numberOfFields = 0;

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
            controller: ScrollController(),
            children: <Widget>[

              Stratosphere(),

              DreamBox(
                height: 50,
                width: 200,
                verse: 'testing max firebase upload _numberOfFields : $_numberOfFields fields',
                verseScaleFactor: 0.7,
                onTap: () async {

                  Map<String, dynamic> _map = {};

                  for (int i = 0; i < 1000; i++){
                    _map = Mapper.insertPairInMap(
                      map: _map,
                      key: 'key$i',
                      value: '$i : ${DateTime.now().millisecondsSinceEpoch}',
                    );
                  }

                  await Fire.createNamedDoc(
                    context: context,
                    collName: FireCollection.admin,
                    docName: 'test',
                    input: _map,
                  );

                  Map<String, dynamic> doc = await Fire.readDoc(
                    context: context,
                    collName: FireCollection.admin,
                    docName: 'test',
                  );

                  List<MapModel> _mapModels = MapModel.getModelsFromMap(doc);

                  setState(() {
                    _numberOfFields = _mapModels.length;
                  });

                },
              ),

              WideButton(
                verse: 'add the _priceTagIsOn to all flyers',
                onTap: () async {

                  List<FlyerModel> _flyers = await SuperBldrsMethod.readAllFlyers(
                    context: context,
                    limit: 300,
                  );

                  for (int i = 0; i < _flyers.length; i++){

                    bool _priceTagIsOn;

                    if (i.isEven == true){
                      _priceTagIsOn = true;
                    } else {
                      _priceTagIsOn = false;
                    }

                    await Fire.updateDocField(
                      context: context,
                      collName: FireCollection.flyers,
                      docName: _flyers[i].flyerID,
                      field: 'priceTagIsOn',
                      input: _priceTagIsOn,
                    );

                    await Fire.updateDocField(
                      context: context,
                      collName: FireCollection.tinyFlyers,
                      docName: _flyers[i].flyerID,
                      field: 'priceTagIsOn',
                      input: _priceTagIsOn,
                    );

                    print('Done with $i : ${_flyers[i].flyerID}');

                  }



                },
              ),


              Column(
                children: <Widget>[

                  // BottomDialogRow(dataKey: 'space', dataValue: _spaceTime['space']),
                  // BottomDialogRow(dataKey: 'dateTime', dataValue: _spaceTime['dateTime'].toDate()),
                  // BottomDialogRow(dataKey: 'string', dataValue: _spaceTime['string']),
                  // BottomDialogRow(dataKey: 'iso', dataValue: _spaceTime['iso']),
                  // BottomDialogRow(dataKey: 'decipherDateTimeIso8601', dataValue: Timers.decipherDateTimeIso8601(_spaceTime['iso'])),
                  // BottomDialogRow(dataKey: 'dateTime normal', dataValue: DateTime.now()),
                ],
              ),



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