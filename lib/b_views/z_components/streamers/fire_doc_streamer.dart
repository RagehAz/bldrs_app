import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireDocStreamer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireDocStreamer({
    @required this.collName,
    @required this.docName,
    @required this.builder,
    this.onDataChanged,
    this.initialMap,
    this.loadingWidget,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String collName;
  final String docName;
  final Widget Function(BuildContext, Map<String, dynamic>) builder;
  final Function(Map<String, dynamic>, Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic> initialMap;
  final Widget loadingWidget;
  /// --------------------------------------------------------------------------
  static Future<void> onStreamDataChanged({
    @required Stream<DocumentSnapshot<Object>> stream,
    @required ValueNotifier<Map<String, dynamic>> oldMap,
    @required Function(Map<String, dynamic>, Map<String, dynamic>) onChange,
  }) async {

    stream.listen((DocumentSnapshot<Object> snapshot) async {

      blog('xxx - onStreamDataChanged - snapshot : $snapshot');

      final Map<String, dynamic> _newMap = Mapper.getMapFromDocumentSnapshot(
        docSnapshot: snapshot,
        addDocID: true,
        addDocSnapshot: true,
      );

      blog('xxx - onStreamDataChanged - _newMap : $_newMap');
      blog('xxx - onStreamDataChanged - oldMap : ${oldMap.value}');

      final bool _mapsAreTheSame = Mapper.checkMapsAreTheSame(
        map1: oldMap.value,
        map2: _newMap,
      );

      blog('xxx - onStreamDataChanged - _mapsAreTheSame : $_mapsAreTheSame');


      if (_mapsAreTheSame == false){
        onChange(oldMap.value, _newMap);
        oldMap.value = _newMap;
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
  _FireDocStreamerState createState() => _FireDocStreamerState();
/// --------------------------------------------------------------------------
}

class _FireDocStreamerState extends State<FireDocStreamer> {
// -----------------------------------------------------------------------------
  Stream<DocumentSnapshot<Object>> _stream;
  final ValueNotifier<Map<String, dynamic>> _oldMap = ValueNotifier<Map<String, dynamic>>(null);
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _stream = Fire.streamDoc(
      collName: widget.collName,
      docName: widget.docName,
    );

    FireDocStreamer.onStreamDataChanged(
      stream: _stream,
      oldMap: _oldMap,
      onChange: widget.onDataChanged == null ?
      null
          :
          (Map<String, dynamic> oldMap, Map<String, dynamic> newMap) => widget.onDataChanged(oldMap, newMap),
    );


    super.initState();
  }

  @override
  void dispose() {
    _oldMap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: _stream,
      initialData: widget.initialMap,
      builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget ?? const Center(child: Loading(loading: true),);
        }

        else {

          final Map<String, dynamic> _map = Mapper.getMapFromDocumentSnapshot(
              docSnapshot: snapshot.data,
              addDocID: true,
              addDocSnapshot: true,
          );

          return widget.builder(ctx, _map);

        }

      },
    );

  }

}
