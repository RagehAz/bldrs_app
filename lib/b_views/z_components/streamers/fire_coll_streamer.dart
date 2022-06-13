import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireCollStreamer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireCollStreamer({
    @required this.queryParameters,
    @required this.builder,
    this.loadingWidget,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QueryParameters queryParameters;
  final Widget Function(BuildContext, List<Map<String, dynamic>>) builder;
  final Widget loadingWidget;
  /// --------------------------------------------------------------------------
  static void onStreamDataChanged({
    @required Stream<QuerySnapshot<Object>> stream,
    @required List<Map<String, dynamic>> oldMaps,
    @required Function(List<Map<String, dynamic>> newMaps) onChange,
  }){

    stream.listen((QuerySnapshot<Object> snapshot) async {

      final List<Map<String, dynamic>> _newMaps = Mapper.getMapsFromQuerySnapshot(
        querySnapshot: snapshot,
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
      );

      final bool _mapsAreTheSame = Mapper.checkMapsListsAreTheSame(
        maps1: _newMaps,
        maps2: oldMaps,
      );

      if (_mapsAreTheSame == false){
        await onChange(_newMaps);
      }

    },

      cancelOnError: false,

      onDone: (){
        blog('done');
      },

      onError: (Object error){
        blog('error : $error');
      },

    );


  }
  /// --------------------------------------------------------------------------
  @override
  State<FireCollStreamer> createState() => _FireCollStreamerState();
/// --------------------------------------------------------------------------
}

class _FireCollStreamerState extends State<FireCollStreamer> {
// -----------------------------------------------------------------------------
  Stream<QuerySnapshot<Object>> _stream;
  List<Map<String, dynamic>> _oldMaps = <Map<String, dynamic>>[];
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _stream = Fire.streamCollection(
      collName: widget.queryParameters.collName,
      limit: widget.queryParameters.limit ?? 100,
      orderBy: widget.queryParameters.orderBy,
      finders: widget.queryParameters.finders,
    );

    FireCollStreamer.onStreamDataChanged(
      stream: _stream,
      oldMaps: _oldMaps,
      onChange: widget.queryParameters.onDataChanged == null ?
      null
          :
          (List<Map<String, dynamic>> newMaps) => widget.queryParameters.onDataChanged(newMaps),
    );

  }
// -----------------------------------------------------------------------------

  @override
  void dispose() {

    WidgetsBinding.instance.addPostFrameCallback((_){

      /// do whatever the fuck you like to set state
      /// notifyListeners
      /// elly enta nefsak fih yaba

    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: _stream,
      initialData: widget.queryParameters.initialMaps ?? <Map<String, dynamic>>[],
      builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget ?? const Center(child: Loading(loading: true),);
        }

        else {

          final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQuerySnapshot(
            querySnapshot: snapshot.data,
            addDocsIDs: true,
            addDocSnapshotToEachMap: true,
          );

          _oldMaps = _maps;

          return widget.builder(ctx, _maps);

        }

      },
    );

  }

}
