import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/dashboard/widgets/ldb_viewer.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:bldrs/xxx_LABORATORY/sembast/sembast_ops.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/flyers_sql_screen.dart';
import 'package:flutter/material.dart';

class SembastTestScreen extends StatefulWidget {

  @override
  _SembastTestScreenState createState() => _SembastTestScreenState();
}

class _SembastTestScreenState extends State<SembastTestScreen> {

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
    // TODO: implement initState
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_isInit){
      _triggerLoading().then((_) async {

        await _readSembast();

      });

    }
    _isInit = false;

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _insert() async {

    TinyBz _tinyBz = TinyBz.dummyTinyBz('bolbol');
    Map<String, Object> _map = _tinyBz.toMap();

    await SembastOps.insert(
      docName: 'blah',
      inputs: [_map],
    );

    await _readSembast();

  }
// -----------------------------------------------------------------------------
  Future<void> _onTinyFlyerRowTap(String id) async {
    print('the id is : $id');
  }
// -----------------------------------------------------------------------------
  List<Map<String, Object>>_tinyFlyersMaps;
  Future<void> _readSembast() async {

    final List<Map<String, Object>> _maps = await SembastOps.readAll(
      docName: 'blah',
    );

    setState(() {
      _tinyFlyersMaps = _maps;
      _loading = false;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _delete() async {

    await SembastOps.delete(
      docName: 'blah',
      searchPrimaryValue: 'bolbol',
      searchPrimaryKey: 'bzID',
    );

    await _readSembast();

  }
// -----------------------------------------------------------------------------
  Future<void> _replace() async {

    Map<String, Object> _map = TinyBz.dummyTinyBz('gogo').toMap();

    await SembastOps.update(
      docName: 'blah',
      searchPrimaryKey: 'bzID',
      searchPrimaryValue: 'bolbol',
      map: _map,
    );

    await _readSembast();

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TestingLayout(
      screenTitle: 'Sembast test',
      appbarButtonVerse: 'thing',
      appbarButtonOnTap: (){print('fuck');},
      listViewWidgets: <Widget>[

        /// LDB Buttons
        Row(
          children: <Widget>[

            /// INSERT TO LDB
            SmallFuckingButton(
              verse: 'insert',
              onTap: _insert,
            ),

            /// READ AL  LDB
            SmallFuckingButton(
              verse: 'read all',
              onTap: _readSembast,
            ),

            /// DELETE FROM LDB
            SmallFuckingButton(
              verse: 'Delete',
              onTap: _delete,
            ),

            /// REPLACE FROM LDB
            SmallFuckingButton(
              verse: 'Replace',
              onTap: _replace,
            ),

          ],
        ),



        if (_tinyFlyersMaps != null && _tinyFlyersMaps.isNotEmpty)
        ...LDBViewer.rows(
          context: context,
          color: Colorz.Green125,
          primaryKey: 'flyerID',
          maps: _tinyFlyersMaps,
          onRowTap: (String id) => _onTinyFlyerRowTap(id),
        ),

      ],
    );
  }
}
