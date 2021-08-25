import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/records/view_model.dart';
import 'package:bldrs/providers/sqflite/db_table_model.dart';
import 'package:bldrs/providers/sqflite/sqf.dart';
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

    _dbTable = ViewModel.flyerViewsDBTable();
  }
// -----------------------------------------------------------------------------
  Database _db;
  DBTable _dbTable;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> createDB() async {
    _db = await SQFLite.createDB(context: context, dbTable: _dbTable);
  }
// -----------------------------------------------------------------------------
  Future<void> insertToDB() async {
    await SQFLite.insertToDB(
      context: context,
      db: _db,
      dbTable: _dbTable,
    );
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

        ],
    );
  }
}
