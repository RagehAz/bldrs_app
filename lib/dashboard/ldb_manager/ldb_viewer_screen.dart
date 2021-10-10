import 'package:bldrs/dashboard/widgets/sql_viewer.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LDBViewerScreen extends StatefulWidget {
  final String ldbDocName;


  const LDBViewerScreen({
    @required this.ldbDocName,
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
    _bldbName = widget.ldbDocName;
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

    final List<Map<String, Object>> _sembastMaps = await LDBOps.readAllMaps(
      docName: widget.ldbDocName,
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
      onBldrsTap: () async {

        // print(widget.ldbDocName);

        // dynamic _result = await LDBOps.searchMap(
        //   docName: widget.ldbDocName,
        //   searchValue: 'f002',
        //   searchField: 'flyerID',
        //   fieldToSortBy: 'flyerID',
        // );
        final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
        FlyerModel _result = await _flyersProvider.fetchFlyerByID(context: context, flyerID: 'f003');

        // var store = StoreRef.main();
        // var _result = await store.record(widget.ldbDocName).get(await Sembast.instance.database) as String;
        //
        print('_result is : $_result');

        },

      listWidgets: <Widget>[

        if (_maps != null && _maps.isNotEmpty)
          ...SQLViewer.rows(
            context: context,
            // color: Colorz.Green125,
            primaryKey: LDBOps.getPrimaryKey(widget.ldbDocName),
            maps: _maps,
            onRowTap: (String id) => _onRowTap(id),
          ),

      ],
    );
  }
}
