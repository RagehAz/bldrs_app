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
  final Function(BuildContext, Map<String, dynamic>, Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic> initialMap;
  final Widget loadingWidget;
  /// --------------------------------------------------------------------------
  static Future<void> onStreamDataChanged({
    @required Stream<DocumentSnapshot<Object>> stream,
    @required Map<String, dynamic> oldMap,
    @required bool mounted,
    @required Function(Map<String, dynamic>, Map<String, dynamic>) onChange,
  }) async {

    stream.listen((DocumentSnapshot<Object> snapshot) async {

      blog('xxx - onStreamDataChanged - snapshot : $snapshot');

      final Map<String, dynamic> _newMap = Mapper.getMapFromDocumentSnapshot(
        docSnapshot: snapshot,
        addDocID: true,
        addDocSnapshot: true,
      );

      final bool _mapsAreTheSame = Mapper.checkMapsAreTheSame(
        map1: oldMap,
        map2: _newMap,
      );

      blog('FireDocStreamer - onStreamDataChanged - _oldMap == _newMap : $_mapsAreTheSame');


      if (_mapsAreTheSame == false){
        if (mounted == true){
          onChange(oldMap, _newMap);
        }
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
  ValueNotifier<Map<String, dynamic>> _oldMap;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _oldMap = ValueNotifier<Map<String, dynamic>>(null);

    _stream = Fire.streamDoc(
      collName: widget.collName,
      docName: widget.docName,
    );

    FireDocStreamer.onStreamDataChanged(
      stream: _stream,
      oldMap: _oldMap.value,
      mounted: mounted,
      onChange:
      widget.onDataChanged == null ? null
          :
          (Map<String, dynamic> oldMap, Map<String, dynamic> newMap){

        if (mounted == true){
          widget.onDataChanged(context, oldMap, newMap);
          _oldMap.value = oldMap;
        }

        },
    );


    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
      blog('FireDocStreamer : DISPOSING THE FUCKING PAGE');
    _oldMap.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      key: const ValueKey<String>('FireDocStreamer'),
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