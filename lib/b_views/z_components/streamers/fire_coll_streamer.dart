import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;

class FireCollStreamer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireCollStreamer({
    @required this.collName,
    @required this.builder,
    this.limit,
    this.orderBy,
    this.finders,
    this.onDataChanged,
    this.startAfter,
    this.initialMaps,
    this.loadingWidget,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String collName;
  final Widget Function(BuildContext, List<Map<String, dynamic>>) builder;
  final int limit;
  final Fire.QueryOrderBy orderBy;
  final List<FireFinder> finders;
  final ValueChanged<List<Map<String, dynamic>>> onDataChanged;
  final QueryDocumentSnapshot startAfter;
  final List<Map<String, dynamic>> initialMaps;
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

      final bool _mapsAreTheSame = Mapper.mapsListsAreTheSame(
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
  List<Map<String, dynamic>> _oldMaps;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _stream = Fire.streamCollection(
      collName: widget.collName,
      limit: widget.limit,
      orderBy: widget.orderBy,
      startAfter: widget.startAfter,
      finders: widget.finders,
    );

    FireCollStreamer.onStreamDataChanged(
      stream: _stream,
      oldMaps: _oldMaps,
      onChange: widget.onDataChanged == null ?
      null
          :
          (List<Map<String, dynamic>> newMaps) => widget.onDataChanged(newMaps),
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: _stream,
      initialData: widget.initialMaps,
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

          return widget.builder(ctx, _maps);
        }

      },
    );

  }

}
