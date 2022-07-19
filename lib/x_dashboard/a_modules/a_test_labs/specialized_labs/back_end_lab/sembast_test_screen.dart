import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/foundation/sembast_api.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/l_ldb_manager/ldb_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/l_ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';

class SembastReaderTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SembastReaderTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _SembastReaderTestScreenState createState() => _SembastReaderTestScreenState();
/// --------------------------------------------------------------------------
}

class _SembastReaderTestScreenState extends State<SembastReaderTestScreen> {
// -----------------------------------------------------------------------------
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

        await _deleteAll();
        await _readAllMaps();

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

  /// CRUD

  List<Map<String, Object>> _maps;

// ----------------------------------------
  Future<void> _createRandomMap() async {

    final Map<String, dynamic> _map = {
      'id' : 'x${Numeric.createRandomIndex(listLength: 10)}',
      'color' : cipherColor(createRandomColor()),
    };

    await LDBOps.insertMap(
      input: _map,
      docName: _docName,
    );

    await _readAllMaps();
  }
// ----------------------------------------
  Future<void> _createMultipleMaps() async {

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
    for (int i = 0; i < 6; i++){
      final Map<String, dynamic> _map = {
        'id' :'x$i',
        'color' : cipherColor(Colorz.red255),
      };
      _maps.add(_map);
    }

    await LDBOps.insertMaps(
      inputs: _maps,
      docName: _docName,
    );

    await _readAllMaps();
  }
// ----------------------------------------
  Future<void> _readAllMaps() async {

    final List<Map<String, Object>> _readMaps = await Sembast.readAll(
      docName: _docName,
    );

    setState(() {
      _maps = _readMaps;
      _loading = false;
    });

  }
// ----------------------------------------
  Future<void> _updateMap(Map<String, dynamic> map) async {

    final String _newID = await BottomDialog.keyboardDialog(
      context: context,
      hintText: 'Wtf is this',
      title: 'Add new ID instead of Old ( ${map['id']} )',
    );

    final Color _newColor = createRandomColor();

    final Map<String, dynamic> _newMap = {
      'id' : _newID,
      'color': cipherColor(_newColor),
    };

    await LDBOps.insertMap(
      docName: _docName,
      input: _newMap,
    );

    await _readAllMaps();

    Nav.goBack(context);
  }
// ----------------------------------------
  Future<void> _deleteAll() async {

    await LDBOps.deleteAllMapsAtOnce(
        docName: _docName,
    );

    await _readAllMaps();
  }
// ----------------------------------------
  Future<void> _deleteMap(Map<String, dynamic> map) async {

    await LDBOps.deleteMap(
        objectID: map['id'],
        docName: _docName,
    );

    await _readAllMaps();

  }
// ----------------------------------------
  Future<void> _onRowOptionsTap(Map<String, dynamic> map) async {

    Mapper.blogMap(map);

    final List<Widget> _buttons = <Widget>[

      BottomDialog.wideButton(
        context: context,
        verse: 'Delete',
        onTap: () => _deleteMap(map),
      ),

      BottomDialog.wideButton(
        context: context,
        verse: 'Update',
        onTap: () => _updateMap(map),
      ),

    ];

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: _buttons.length,
      builder: (_, PhraseProvider phrasePro){

        return _buttons;

      }
    );

  }
// ----------------------------------------
/*  Future<void> _search() async {

    final List<Map<String, dynamic>> _result = await LDBOps.searchLDBDocTrigram(
        searchValue: 'Cairo',
        docName: _docName,
        lingoCode: 'en',
    );

    Mapper.blogMaps(_result);
  }
 */
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
        Container(
          width: Scale.superScreenWidth(context),
          height: 50,
          color: Colorz.bloodTest,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: <Widget>[

              /// CREATE SINGLE
              SmallFuckingButton(
                  verse: 'Create single',
                  onTap: _createRandomMap
              ),

              /// CREATE RANDOM
              SmallFuckingButton(
                  verse: 'Create Multi',
                  onTap: _createMultipleMaps
              ),

              /// READ
              SmallFuckingButton(
                verse: 'read all',
                onTap: _readAllMaps,
              ),

              /// UPDATE
              SmallFuckingButton(
                verse: 'Update',
                onTap: _updateMap,
              ),

              /// DELETE ALL
              SmallFuckingButton(
                verse: 'Delete All',
                onTap: _deleteAll,
              ),

            ],
          ),
        ),

        if (Mapper.checkCanLoopList(_maps))
          ...LDBViewerScreen.rows(
            context: context,
            userColorField: true,
            maps: _maps,
            onRowOptionsTap: _onRowOptionsTap,
          ),

      ],
    );
  }
}
