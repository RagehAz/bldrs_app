import 'dart:async';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireCollStreamer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireCollStreamer({
    @required this.queryModel,
    @required this.builder,
    this.loadingWidget,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FireQueryModel queryModel;
  final Widget Function(BuildContext, List<Map<String, dynamic>>) builder;
  final Widget loadingWidget;
  /// --------------------------------------------------------------------------
  static StreamSubscription onStreamDataChanged({
    @required Stream<QuerySnapshot<Object>> stream,
    @required ValueNotifier<List<Map<String, dynamic>>> oldMaps,
    @required ValueChanged<List<Map<String, dynamic>>> onChange,
  }){

    final StreamSubscription _streamSubscription = stream.listen((QuerySnapshot<Object> snapshot) async {

      final List<Map<String, dynamic>> _newMaps = Mapper.getMapsFromQuerySnapshot(
        querySnapshot: snapshot,
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
      );

      final bool _mapsAreTheSame = Mapper.checkMapsListsAreIdentical(
        maps1: _newMaps,
        maps2: oldMaps.value,
      );

      if (_mapsAreTheSame == false){
        oldMaps.value = _newMaps;
        if (_newMaps != null){
            onChange(_newMaps);
        }
      }

    },

      cancelOnError: false,

      onDone: (){
        blog('FireCollStreamer : onStreamDataChanged done');
      },

      onError: (Object error){
        blog('FireCollStreamer : onStreamDataChanged error : $error');
      },

    );

    return _streamSubscription;
  }
  /// --------------------------------------------------------------------------
  @override
  State<FireCollStreamer> createState() => _FireCollStreamerState();
  /// --------------------------------------------------------------------------
}

class _FireCollStreamerState extends State<FireCollStreamer> {
  // -----------------------------------------------------------------------------
  Stream<QuerySnapshot<Object>> _stream;
  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = ValueNotifier(<Map<String, dynamic>>[]);
  StreamSubscription _sub;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _stream = Fire.streamCollection(
      queryModel: widget.queryModel,
    );

    _sub =  _stream.listen((event) { });

    FireCollStreamer.onStreamDataChanged(
      stream: _stream,
      oldMaps: _oldMaps,
      onChange: widget.queryModel.onDataChanged == null ?
      null
          :
          (List<Map<String, dynamic>> newMaps){

        if (mounted == true){
          widget.queryModel.onDataChanged(newMaps);
        }

          },
    );

  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {

    _oldMaps.dispose();
    _sub.cancel();

    // WidgetsBinding.instance.addPostFrameCallback((_){
    //
    //   /// do whatever the fuck you like to set state
    //   /// notifyListeners
    //   /// elly enta nefsak fih yaba
    //
    // });

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: _stream,
      initialData: widget.queryModel.initialMaps ?? <Map<String, dynamic>>[],
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
// -----------------------------------------------------------------------------
}
