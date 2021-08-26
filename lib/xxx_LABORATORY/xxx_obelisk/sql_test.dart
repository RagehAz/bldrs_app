import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/records/view_model.dart';
import 'package:bldrs/providers/local_db/ldb.dart';
import 'package:bldrs/providers/local_db/ldb_column.dart';
import 'package:bldrs/providers/local_db/ldb_table.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SQLTestScreen extends StatefulWidget {


  @override
  _SQLTestScreenState createState() => _SQLTestScreenState();
}

class _SQLTestScreenState extends State<SQLTestScreen> {

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

    _dbTable = ViewModel.createLDBTable();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_isInit){
      _triggerLoading().then((_) async {

        await createDB();
        List<Map<String, Object>> _maps = await readFromDB();

        _triggerLoading(function: (){
            _dbTable.maps = _maps;
        });

      });

    }
    _isInit = false;

  }
// -----------------------------------------------------------------------------
  Database _db;
  LDBTable _dbTable;

  Future<void> createDB() async {
    _db = await LDB.createLDB(context: context, table: _dbTable);
  }
// -----------------------------------------------------------------------------
  Future<void> insertToDB() async {

    // print('1 - creating map');

    ViewModel _viewModel = ViewModel(
      viewID: '1',
      viewTime: DateTime.now(),
      userID: 'ana',
      flyerID: 'flyer',
      slideIndex: 0,
    );

    Map<String, Object> _map = _viewModel.toMap();

    // print('2 - inserting table');

    await LDB.InsertRawToLDB(
      context: context,
      db: _db,
      dbTable: _dbTable,
      input: _map,
    );

    // print('3 - done inserting table');

  }
// -----------------------------------------------------------------------------
  Future<List<Map<String, Object>>> readFromDB() async {

    List<Map<String, Object>> _maps = await LDB.readRawFromLDB(
      db: _db,
      tableName: _dbTable.tableName,
    );

    return _maps;
  }
// -----------------------------------------------------------------------------
  Widget valueBox({String key, String value}){
    return
      Container(
        height: 40,
        width: 80,
        color: Colorz.BloodTest,
        margin: EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperVerse(
              verse: key,
              weight: VerseWeight.thin,
              italic: true,
              size: 1,
            ),

            SuperVerse(
              verse: value,
              weight: VerseWeight.bold,
              italic: false,
              size: 1,
            ),

          ],
        ),
      );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    return TestLayout(
      screenTitle: 'SQL Test Screen',
      appbarButtonVerse: _loading == true ? 'xxx Loading ......... ' : ' ---> Loaded',
      appbarButtonOnTap: (){
        print('Button');
        _triggerLoading();
        },
      listViewWidgets: <Widget>[

        Container(
          width: _screenWidth,
          height: 550,
          color: Colorz.White10,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _dbTable.maps.length,
              itemBuilder: (ctx, index){

                Map<String, Object> _map = _dbTable.maps[index];
                List<Object> _keys = _map.keys.toList();
                List<Object> _values = _map.values.toList();

                return
                  Container(
                    width: _screenWidth,
                    height: 42,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[

                        DreamBox(
                          height: 40,
                          width: 40,
                          verse: '$index',
                          verseScaleFactor: 0.6,
                          margins: EdgeInsets.all(5),
                        ),

                        ...List.generate(
                            _values.length,
                                (i){

                              String _key = _keys[i];
                              String _value = _values[i].toString();

                              return
                                valueBox(
                                  key: _key,
                                  value: _value,
                                );

                            }
                            ),
                      ],
                    ),
                  );
              }
              ),
        ),

          Row(
            children: <Widget>[

              /// CREATE
              DreamBox(
                height: 30,
                width: _screenWidth / 2,
                verse: 'Create db',
                verseScaleFactor: 0.7,
                onTap: () async {

                  await createDB();

                  print('db created successfully isa');

                },
              ),
              /// INSERT
              DreamBox(
                height: 30,
                width: _screenWidth / 2,
                verse: 'Insert to DB',
                verseScaleFactor: 0.7,
                onTap: () async {

                  await insertToDB();
                  await readFromDB();


                },
              ),

            ],
          ),
        ],
    );
  }
}
