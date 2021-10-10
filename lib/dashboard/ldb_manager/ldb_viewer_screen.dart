import 'package:bldrs/dashboard/widgets/sql_viewer.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class LDBViewerScreen extends StatefulWidget {
  final BLDB bldb;


  const LDBViewerScreen({
    @required this.bldb,
});

  @override
  State<LDBViewerScreen> createState() => _LDBViewerScreenState();
}

class _LDBViewerScreenState extends State<LDBViewerScreen> {
  String _bldbName;
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
    _bldbName = BLDBMethod.getDocName(widget.bldb);
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
  List<Map<String, Object>> _maps;
  Future<void> _readSembast() async {

    final List<Map<String, Object>> _sembastMaps = await BLDBMethod.readAll(
      bldb: widget.bldb,
    );

    setState(() {
      _maps = _sembastMaps;
      _loading = false;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _onRowTap(String id) async {


    print('Bldrs local data base : _bldbName : $_bldbName : row id : $id');

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(
      pageTitle: 'Local db : ${_bldbName}',
      loading: false,
      onBldrsTap: (){print(widget.bldb);},
      listWidgets: <Widget>[

        if (_maps != null && _maps.isNotEmpty)
          ...SQLViewer.rows(
            context: context,
            // color: Colorz.Green125,
            primaryKey: BLDBMethod.getPrimaryKey(widget.bldb),
            maps: _maps,
            onRowTap: (String id) => _onRowTap(id),
          ),

      ],
    );
  }
}
