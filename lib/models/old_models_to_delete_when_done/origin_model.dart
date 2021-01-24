import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:flutter/foundation.dart';

class OriginModel{
  final String originID;
  final FlyerType originType;
  final String authorID;
  final String originName;
  final String originPic;
  // final DateTime saveTime;

  OriginModel({
    @required this.originID,
    @required this.originType,
    @required this.authorID,
    @required this.originName,
    @required this.originPic,
    // @required this.saveTime,
  });
}
