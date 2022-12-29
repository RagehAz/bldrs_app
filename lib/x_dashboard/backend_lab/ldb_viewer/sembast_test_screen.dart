import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/e_back_end/d_ldb/sembast_api.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';

import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_manager_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_viewer_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class SembastTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SembastTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _SembastTestScreenState createState() => _SembastTestScreenState();
/// --------------------------------------------------------------------------
}

class _SembastTestScreenState extends State<SembastTestScreen> {
  // -----------------------------------------------------------------------------
  final String _docName = 'test';
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _triggerLoading(setTo: true).then((_) async {

        await _deleteAll();
        await _readAllMaps();

        await _triggerLoading(setTo: false);
      });
    }
    _isInit = false;
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CRUD

  // --------------------
  List<Map<String, Object>> _maps;
  // --------------------
  Future<void> _createRandomMap() async {

    final Map<String, dynamic> _map = {
      'id' : 'x${Numeric.createRandomIndex(listLength: 10)}',
      'color' : Colorizer.cipherColor(Colorizer.createRandomColor()),
    };

    await LDBOps.insertMap(
      input: _map,
      docName: _docName,
    );

    await _readAllMaps();
  }
  // --------------------
  Future<void> _createMultipleMaps() async {

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
    for (int i = 0; i < 6; i++){
      final Map<String, dynamic> _map = {
        'id' :'x$i',
        'color' : Colorizer.cipherColor(Colorz.red255),
      };
      _maps.add(_map);
    }

    await LDBOps.insertMaps(
      inputs: _maps,
      docName: _docName,
    );

    await _readAllMaps();
  }
  // --------------------
  Future<void> _readAllMaps() async {

    final List<Map<String, Object>> _readMaps = await Sembast.readAll(
      docName: _docName,
    );

    setState(() {
      _maps = _readMaps;
    });

    setNotifier(notifier: _loading, mounted: mounted, value: false);

  }
  // --------------------
  Future<void> _updateMap(Map<String, dynamic> map) async {

    final String _newID = await Dialogs.keyboardDialog(
      context: context,
      keyboardModel: KeyboardModel.standardModel().copyWith(
        hintVerse: Verse.plain('Wtf is this'),
        titleVerse: Verse.plain('Add new ID instead of Old ( ${map['id']} )'),
      ),
    );

    final Color _newColor = Colorizer.createRandomColor();

    final Map<String, dynamic> _newMap = {
      'id' : _newID,
      'color': Colorizer.cipherColor(_newColor),
    };

    await LDBOps.insertMap(
      docName: _docName,
      input: _newMap,
    );

    await _readAllMaps();

    await Nav.goBack(
      context: context,
      invoker: 'SembastTestScreen._updateMap',
    );
  }
  // --------------------
  Future<void> _deleteAll() async {

    await LDBOps.deleteAllMapsAtOnce(
        docName: _docName,
    );

    await _readAllMaps();
  }
  // --------------------
  Future<void> _deleteMap(Map<String, dynamic> map) async {

    await LDBOps.deleteMap(
        objectID: map['id'],
        docName: _docName,
    );

    await _readAllMaps();

  }
  // --------------------
  Future<void> _onRowOptionsTap(Map<String, dynamic> map) async {

    Mapper.blogMap(map);

    final List<Widget> _buttons = <Widget>[

      BottomDialog.wideButton(
        context: context,
        verse:  Verse.plain('Delete'),
        onTap: () => _deleteMap(map),
      ),

      BottomDialog.wideButton(
        context: context,
        verse: Verse.plain('Update'),
        onTap: () => _updateMap(map),
      ),

    ];

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: _buttons.length,
        builder: (_){
          return _buttons;
        }
        );

  }
  // --------------------
  Future<void> _search() async {

    final List<Map<String, dynamic>> _result = await LDBOps.searchMultipleValues(
        docName: _docName,
        fieldToSortBy: 'id',
        searchField: 'id',
        searchObjects: ['x1', null],
    );

    Mapper.blogMaps(_result);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      pageTitle: 'Sembast test',
      onBldrsTap: () {
        blog('SembastReaderTestScreen on bldrs tap');
      },
      listWidgets: <Widget>[

        /// LDB Buttons
        Container(
          width: Scale.screenWidth(context),
          height: 50,
          color: Colorz.bloodTest,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: <Widget>[

              /// CREATE SINGLE
              SmallFuckingButton(
                  verse:  'Create single',
                  onTap: _createRandomMap
              ),

              /// CREATE RANDOM
              SmallFuckingButton(
                  verse:  'Create Multi',
                  onTap: _createMultipleMaps
              ),

              /// READ
              SmallFuckingButton(
                verse:  'read all',
                onTap: _readAllMaps,
              ),

              /// UPDATE
              SmallFuckingButton(
                verse:  'Update',
                onTap: _updateMap,
              ),

              /// DELETE ALL
              SmallFuckingButton(
                verse:  'Delete All',
                onTap: _deleteAll,
              ),

              /// SEARCH
              SmallFuckingButton(
                verse:  'SEARCH',
                onTap: _search,
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
  // -----------------------------------------------------------------------------
}
