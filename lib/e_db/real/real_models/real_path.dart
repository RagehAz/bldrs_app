import 'package:flutter/foundation.dart';

class RealNode {
// -----------------------------------------------------------------------------
  const RealNode({
    @required this.collName,
    @required this.docName,
    @required this.map,
  });
// -----------------------------------------------------------------------------
  final String collName;
  final String docName;
  final Map<String, dynamic> map;
// -----------------------------------------------------------------------------
  String generatePath(){
    return '$collName/$docName';
  }
// -----------------------------------------------------------------------------
}
