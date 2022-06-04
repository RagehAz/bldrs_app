import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/api/sembast_api.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/l_ldb_manager/ldb_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/l_ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';

class SembastReaderTestScreen extends StatefulWidget {

  const SembastReaderTestScreen({
    Key key
  }) : super(key: key);

  @override
  _SembastReaderTestScreenState createState() => _SembastReaderTestScreenState();
}

class _SembastReaderTestScreenState extends State<SembastReaderTestScreen> {
  final String _docName = 'test';
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {

    if (mounted) {
      if (function == null) {
        setState(() {
          _loading = !_loading;
        });
      } else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }
    }

    _loading == true ?
    blog('LOADING--------------------------------------')
        :
    blog('LOADING COMPLETE--------------------------------------');

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

    if (_isInit) {
      _triggerLoading().then((_) async {
        await _readSembast();
      });
    }
    _isInit = false;
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _search() async {

    final List<Map<String, dynamic>> _result = await LDBOps.searchLDBDocTrigram(
        searchValue: 'Cairo',
        docName: _docName,
        lingoCode: 'en',
    );

    Mapper.blogMaps(_result);
  }
// -----------------------------------------------------------------------------
  List<Map<String, Object>> _maps;

  Future<void> _readSembast() async {

    final List<Map<String, Object>> _readMaps = await Sembast.readAll(
      docName: _docName,
    );

    setState(() {
      _maps = _readMaps;
      _loading = false;
    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      pageTitle: 'Sembast test',
      onBldrsTap: () {
        blog('fuck this bobo');
      },
      listWidgets: <Widget>[

        /// LDB Buttons
        Row(
          children: <Widget>[

            /// READ AL  LDB
            SmallFuckingButton(
              verse: 'read all',
              onTap: _readSembast,
            ),

            /// REPLACE FROM LDB
            SmallFuckingButton(
              verse: 'Search',
              onTap: _search,
            ),

            /// INSERT FROM LDB
            SmallFuckingButton(
              verse: 'xxx',
              onTap: () async {

                // await LDBOps.insertMap(
                //     primaryKey: 'id',
                //     docName: _docName,
                //     input: {
                //       'id' : '${createRandomIndex()}',
                //       'data' : 'bitch',
                // },
                // );

                await _readSembast();

              },
            ),

            /// DELETE ALL LDB
            SmallFuckingButton(
              verse: 'DELETE ALL AT ONCE',
              onTap: () async {

                await Sembast.deleteAllAtOnce(
                  docName: _docName,
                );

                await _readSembast();

              },
            ),

          ],
        ),

        if (Mapper.canLoopList(_maps))
          ...LDBViewerScreen.rows(
            context: context,
            color: Colorz.green125,
            primaryKey: 'flyerID',
            maps: _maps,
            onRowTap: null,
          ),

      ],
    );
  }
}
