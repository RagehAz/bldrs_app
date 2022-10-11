import 'dart:async';

import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealStream {
  // -----------------------------------------------------------------------------

  const RealStream();

  // -----------------------------------------------------------------------------

  /// STREAMING

  // --------------------
  static StreamSubscription streamOnChildAddedToPath({
    @required String path,
    @required ValueChanged<dynamic> onChildAdded,
  }){
    final DatabaseReference _ref = Real.getRefByPath(path: path);

    final StreamSubscription _sub = _ref.onChildAdded.listen((DatabaseEvent event) {
      final dynamic _data = event.snapshot.value;
      onChildAdded(_data);
    },
      // cancelOnError:,
      // onDone: (){},
      // onError: (Object error){
      //
      // }
    );

    return _sub;
  }
  // --------------------
  static StreamSubscription streamOnChildChangedInPath({
    @required String path,
    @required ValueChanged<dynamic> onChildChanged,
  }){
    final DatabaseReference _ref = Real.getRefByPath(path: path);

    final StreamSubscription _sub = _ref.onChildChanged.listen((DatabaseEvent event) {
      final dynamic _data = event.snapshot.value;
      onChildChanged(_data);
    },
      // cancelOnError:,
      // onDone: (){},
      // onError: (Object error){
      //
      // }
    );

    return _sub;
  }
  // --------------------
  static StreamSubscription streamOnChildMovedInPath({
    @required String path,
    @required ValueChanged<dynamic> onChildMoved,
  }){
    final DatabaseReference _ref = Real.getRefByPath(path: path);

    final StreamSubscription _sub = _ref.onChildMoved.listen((DatabaseEvent event) {
      final dynamic _data = event.snapshot.value;
      onChildMoved(_data);
    },
      // cancelOnError:,
      // onDone: (){},
      // onError: (Object error){
      //
      // }
    );

    return _sub;
  }
  // --------------------
  static StreamSubscription streamOnChildRemovedFromPath({
    @required String path,
    @required ValueChanged<dynamic> onChildRemoved,
  }){
    final DatabaseReference _ref = Real.getRefByPath(path: path);

    final StreamSubscription _sub = _ref.onChildRemoved.listen((DatabaseEvent event) {
      final dynamic _data = event.snapshot.value;
      onChildRemoved(_data);
    },
      // cancelOnError:,
      // onDone: (){},
      // onError: (Object error){
      //
      // }
    );

    return _sub;
  }
  // --------------------
  static StreamSubscription streamOnValueOfPath({
    @required String path,
    @required ValueChanged<dynamic> onValue,
  }){
    final DatabaseReference _ref = Real.getRefByPath(path: path);

    final StreamSubscription _sub = _ref.onValue.listen((DatabaseEvent event) {
      final dynamic _data = event.snapshot.value;
      onValue(_data);
    },
      // cancelOnError:,
      // onDone: (){},
      // onError: (Object error){
      //
      // }
    );

    return _sub;
  }
  // -----------------------------------------------------------------------------
}
