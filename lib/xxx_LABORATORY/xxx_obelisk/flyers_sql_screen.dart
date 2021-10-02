import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/records/view_model.dart';
import 'package:bldrs/providers/local_db/models/ldb.dart';
import 'package:bldrs/providers/local_db/models/ldb_table.dart';
import 'package:bldrs/providers/local_db/sql_ops/flyer_sql.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FlyersSQLScreen extends StatefulWidget {


  @override
  _FlyersSQLScreenState createState() => _FlyersSQLScreenState();
}

class _FlyersSQLScreenState extends State<FlyersSQLScreen> {
  ScrollController _verticalController = ScrollController();
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
    super.didChangeDependencies();

    if(_isInit){
      _triggerLoading().then((_) async {

        await createFlyersLDB();


      });

    }
    _isInit = false;

  }
// -----------------------------------------------------------------------------
  LDBTable _flyersTable;
  Future<void> createFlyersLDB() async {

    _flyersTable = await FlyerSQL.createFlyersLDBTable(
      context: context,
      tableName: 'savedFlyers',
    );

    if (_flyersTable.db.isOpen == true){
      await _readLDB();
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _A_insertToLDB(FlyerModel flyer) async {

    print('1 - creating map');


    Map<String, Object> _map = FlyerModel.sqlCipherFlyerModel(flyer);

    print('2 - inserting table');

    await LDB.InsertRawToLDB(
      context: context,
      table: _flyersTable,
      input: _map,
    );

    await _readLDB();
    print('3 - done inserting table');

  }
// -----------------------------------------------------------------------------
  Future<void> _B_insertToDB(String id) async {

    ViewModel _newView = ViewModel(
      userID: 'xxx',
      slideIndex: 0,
      flyerID: 'xxx',
      viewTime: DateTime.now(),
      viewID: 21,
    );

    Map<String, Object> _newMap = _newView.toMap();
    print('new map');

    await LDB.insert(
      table: _flyersTable,
      input: _newMap,
    );
    print('inserted');

    await _readLDB();
    print('read done');

  }
// -----------------------------------------------------------------------------
  Future<void> _readLDB() async {

    List<Map<String, Object>> _maps = await LDB.readRawFromLDB(
      table: _flyersTable,
    );

    setState(() {
      _flyersTable.maps =  _maps;
      _loading = false;
    });

    await _scrollToBottomOfListView();

    return _maps;
  }
// -----------------------------------------------------------------------------
  Future<void> _deleteLDB() async {

    print('_deleteLDB : starting delete LDB : _table.tableName : ${_flyersTable.tableName}');

    await LDB.deleteLDB(
      context: context,
      table: _flyersTable,
    );

    print('_deleteLDB : deleted LDB');

    await _readLDB();

  }
// -----------------------------------------------------------------------------
  Future<void> _updateRow(int viewID) async {
    print('_updateRow : starting to update row');

    ViewModel _newView = ViewModel(
      viewID: 10,
      flyerID: 'kos o5tak',
      userID: 'abo omak',
      slideIndex: 4,
      viewTime: DateTime.now(),
    );

    await LDB.updateRow(
      context: context,
      table: _flyersTable,
      rowNumber: 22,
      input: _newView.toMap(),
    );

    await _readLDB();

    print('_updateRow : finished updating row');
  }
// -----------------------------------------------------------------------------
  Future<void> _deleteRow(int id) async {
    await LDB.deleteRow(
      context: context,
      table: _flyersTable,
      rowNumber: id,
    );

    await _readLDB();

  }
// -----------------------------------------------------------------------------
  Future<void> _scrollToBottomOfListView() async {

    if (_verticalController.hasClients == true){
      await Scrollers.scrollTo(
        controller: _verticalController,
        offset: _verticalController.position.maxScrollExtent,
      );
    }

// -----------------------------------------------------------------------------
  }
// -----------------------------------------------------------------------------
  Widget valueBox({String key, String value}){
    return
      Container(
        height: 40,
        width: 80,
        color: Colorz.BloodTest,
        margin: const EdgeInsets.all(2),
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

    final double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    return TestingLayout(
      screenTitle: 'SQL Test Screen',
      appbarButtonVerse: _loading == true ? 'xxx Loading ......... ' : _flyersTable.db.isOpen == true ? ' ---> Loaded' : 'LDB IS OFF',
      appbarButtonOnTap: (){
        print('Button');
        _triggerLoading();
        },
      listViewWidgets: <Widget>[

        /// LDB data
        Container(
          width: _screenWidth,
          height: 550,
          color: Colorz.White10,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _verticalController,
              itemCount: _flyersTable?.maps?.length ?? 0,
              itemBuilder: (ctx, index){

                Map<String, Object> _map = _flyersTable.maps[index];
                List<Object> _keys = _map.keys.toList();
                List<Object> _values = _map.values.toList();

                int _id = _map['viewID'];
                // int _idInt = Numberers.stringToInt(_id);

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
                          height: 37,
                          width: 37,
                          icon: Iconz.DumBusinessLogo,
                          // margins: EdgeInsets.all(5),
                        ),

                        DreamBox(
                          height: 40,
                          width: 40,
                          verse: '${index + 1}',
                          verseScaleFactor: 0.6,
                          margins: EdgeInsets.all(5),
                          onTap: () => _deleteRow(_id),
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

        /// LDB Buttons
          Row(
            children: <Widget>[

              /// CREATE LDB
              SmallFuckingButton(
                  verse: 'Create LDB',
                  onTap: createFlyersLDB,
              ),

              /// Delete LDB
              SmallFuckingButton(
                verse: 'Delete LDB',
                onTap: _deleteLDB,
              ),

              /// INSERT A
              SmallFuckingButton(
                verse: 'raw Insert A to LDB',
                onTap: _A_insertToLDB,
              ),

              /// INSERT B
              SmallFuckingButton(
                  verse: 'raw insert B To LDB',
                  onTap: () => _B_insertToDB('5'),
              ),

              /// Update row LDB
              SmallFuckingButton(
                verse: 'Update row',
                onTap: () => _updateRow(5),
              ),

              /// Delete row
              SmallFuckingButton(
                verse: 'Delete row',
                onTap: () => _deleteRow(11),
              ),

            ],
          ),

        ],
    );
  }
}


class SmallFuckingButton extends StatelessWidget {
  final String verse;
  final Function onTap;

  const SmallFuckingButton({
    @required this.verse,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _buttonWidth = _screenWidth / 8;

    return DreamBox(
      height: 30,
      width: _buttonWidth,
      color: Colorz.Blue80,
      margins: const EdgeInsets.symmetric(horizontal: 1),
      verse: verse,
      verseScaleFactor: 0.4,
      verseWeight: VerseWeight.thin,
      verseMaxLines: 2,
      onTap: onTap,
    );

  }
}
