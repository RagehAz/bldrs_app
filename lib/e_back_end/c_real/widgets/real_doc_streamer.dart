import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class RealDocStreamer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RealDocStreamer({
    @required this.collName,
    @required this.docName,
    @required this.builder,
    this.loadingWidget,
    this.noValueWidget,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String collName;
  final String docName;
  final Widget loadingWidget;
  final Widget noValueWidget;
  final Widget Function(BuildContext, Map<String, dynamic>) builder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('$collName/$docName').onValue,
        builder: (_, snapshot){

          /// LOADING
          if (snapshot.connectionState == ConnectionState.waiting){
            return loadingWidget ?? const Loading(loading: true);
          }

          /// NO DATA
          else if (snapshot.hasData == false){
            return noValueWidget ?? const SizedBox();
          }

          /// RECEIVED DATA
          else {

            final DatabaseEvent _event = snapshot.data;
            final DataSnapshot _snap = _event.snapshot;
            final Map<String, dynamic> _map = Mapper.getMapFromDataSnapshot(
              snapshot: _snap,
            );

            /// NO DATA
            if (_map == null){
              return noValueWidget ?? const SizedBox();
            }

            /// DATA IS GOOD
            else {
              return builder(context, _map);
            }

          }

        }
    );

  }
/// --------------------------------------------------------------------------
}
