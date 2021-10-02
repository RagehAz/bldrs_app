import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/firestore/aggredocs.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/helpers/map_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
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
//   int _numberOfFields = 0;
// -----------------------------------------------------------------------------
  List<MapModel> _theData = <MapModel>[];
  Future<void> _createBlocks() async {

    _triggerLoading();

    List<MapModel> _data = <MapModel>[];
    int numberOfFields = 10001;
    for (int i = 0; i < numberOfFields; i++){
      final String _numString = Numeric.separateKilos(number: i+1);

      final String _value = 'num -> $_numString';
      final String _key = '$i';

      final MapModel _mapModel = MapModel(key: _key, value: _value);

      _data.add(_mapModel);
    }

    setState(() {
      _theData = _data;
    });

    _triggerLoading();

    print('fuk');

  }
// -----------------------------------------------------------------------------
  Future<void> _uploadBlocks() async {


    _triggerLoading();

    /// receive the input
    List<MapModel> _data = _theData;

    /// see length of input
    int _inputLength = _data.length;

    /// create list of blocks
    List<Map<String, dynamic>> _docs = <Map<String, dynamic>>[];
    const int _blockLength = 500;

    /// add data
    for (int i = 0; i < _inputLength; i++){

      final MapModel _mapModel = _data[i];

      final int docIndex = (i / _blockLength).floor();

      if(_docs.length <= docIndex){
        _docs.add({});
      }

      // Map<String, dynamic> _block = {};
      Mapper.insertPairInMap(map: _docs[docIndex], key: _mapModel.key, value: _mapModel.value);

    }

    print(_docs.toString());

    for (int i = 0; i < _docs.length; i++){

      await Fire.createNamedSubDoc(
        context: context,
        collName: FireCollection.admin,
        docName: 'test',
        subCollName: 'blocks',
        subDocName: 'doc_$i',
        input: _docs[i],
      );

    }

    _triggerLoading();

  }
// -----------------------------------------------------------------------------
  Future<void> _uploadTinyFlyers() async {

    _triggerLoading();

    final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];

    for (int i = 0; i < 1000; i++){
      _tinyFlyers.add(TinyFlyer.dummyTinyFlyer('id_$i'));
    }

    Aggredocs _aggredocs = Aggredocs.createAggredocsFromTinyFlyers(
      tinyFlyers: _tinyFlyers,
    );

    await Aggredocs.uploadAggredocs(
      context: context,
      aggredocs: _aggredocs,
      collName: FireCollection.admin,
      docName: 'test',
      subCollName: 'tinyFlyers',
    );


    _triggerLoading();

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
                verse: 'Save blocks to db/admin/test/blocks/{docs}',
                icon: Iconz.Save,
                onTap: _createBlocks,
              ),

              WideButton(
                color: Colorz.BloodTest,
                verse: 'upload blocks',
                icon: Iconz.Share,
                onTap: _uploadBlocks,
              ),

              WideButton(
                color: Colorz.BloodTest,
                verse: 'upload flyers',
                icon: Iconz.FlyerCollection,
                onTap: _uploadTinyFlyers,
              ),


              Container(
                width: Scale.superScreenWidth(context),
                alignment: Alignment.center,
                child: Container(
                  width: Scale.superScreenWidth(context) * 0.8,
                  height: 400,
                  color: Colorz.BloodTest,
                  child: Scroller(
                    controller: _ScrollController,
                    child: ListView.builder(
                        itemCount: _theData.length,
                        itemBuilder: (ctx , index){

                          final String key = _theData[index].key;
                          final String value = _theData[index].value;

                          final string = '$key : $value';

                          return
                            DreamBox(
                              height: 30,
                              width: Scale.superScreenWidth(context) - 100,
                              verse: '   $string',
                              verseScaleFactor: 0.6,
                              verseWeight: VerseWeight.thin,
                              verseItalic: true,
                              verseCentered: false,
                              margins: 3,
                            );

                        }),
                  ),
                ),
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