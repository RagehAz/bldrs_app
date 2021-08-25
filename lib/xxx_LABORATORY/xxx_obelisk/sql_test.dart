import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/records/view_model.dart';
import 'package:bldrs/providers/local_db/ldb.dart';
import 'package:bldrs/providers/local_db/ldb_column.dart';
import 'package:bldrs/providers/local_db/ldb_table.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SQLTestScreen extends StatefulWidget {


  @override
  _SQLTestScreenState createState() => _SQLTestScreenState();
}

class _SQLTestScreenState extends State<SQLTestScreen> {

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _dbTable = ViewModel.createLDBTable();
  }
// -----------------------------------------------------------------------------
  Database _db;
  LDBTable _dbTable;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> createDB() async {
    _db = await LDB.createLDB(context: context, table: _dbTable);
  }
// -----------------------------------------------------------------------------
  Future<void> insertToDB() async {

    Map<String, dynamic> _map = {};

    LDBColumn _newColumn = LDBColumn(key: null, type: null,);

    _dbTable = LDBTable(
        tableName: null,
        columns: null,
      maps: [],
    );

    await LDB.InsertRawToLDB(
      context: context,
      db: _db,
      dbTable: _dbTable,
      input: _map,
    );
  }
// -----------------------------------------------------------------------------
  Future<List<Map>> readFromDB() async {
    List<Map> _maps = await LDB.readRawFromLDB(
      db: _db,
      tableName: _dbTable.tableName,
    );

    return _maps;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    return TestLayout(
        screenTitle: 'SQL Test Screen',
        appbarButtonVerse: 'Button',
        appbarButtonOnTap: (){
          print('Button');
        },
      scaffoldKey: scaffoldKey,
        listViewWidgets: <Widget>[

          Container(
            width: _screenWidth,
            height: 100,
            color: Colorz.BloodTest,
          ),

          DreamBox(
            height: 30,
            width: 150,
            verse: 'Insert to DB',
            verseScaleFactor: 0.7,
            onTap: () async {

              await insertToDB();

            },
          ),

          DreamBox(
            height: 30,
            width: 150,
            verse: 'Create db',
            verseScaleFactor: 0.7,
            onTap: () async {

              await createDB();

              print('db created successfully isa');

            },
          ),

          DreamBox(
            height: 30,
            width: 150,
            verse: 'read from db',
            verseScaleFactor: 0.7,
            onTap: () async {

              List<Map> _maps = await readFromDB();

              _maps.forEach((map) {
                print('reading db : map is : $map');
              });


            },
          ),

        ],
    );
  }
}
