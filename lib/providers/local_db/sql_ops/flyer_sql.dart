import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/providers/local_db/models/ldb.dart';
import 'package:bldrs/providers/local_db/models/ldb_column.dart';
import 'package:bldrs/providers/local_db/models/ldb_table.dart';
import 'package:flutter/material.dart';

class FlyerSQL{
// -----------------------------------------------------------------------------
  static Future<LDBTable> createFlyersLDBTable({BuildContext context, String tableName}) async {

    /// CREATE FLYERS LDB
    final List<LDBColumn> _FlyersColumns = FlyerModel.createFlyersLDBColumns();
    final LDBTable _flyersLDB = await LDB.createAndSetLDB(
      context: context,
      tableName: tableName,
      columns: _FlyersColumns,
    );

    /// CREATE SLIDES SLAVE LDB FOR PREVIOUS FLYERS LDB
    final List<LDBColumn> _slidesColumns = SlideModel.createSlidesLDBColumns();
    await LDB.createAndSetLDB(
      context: context,
      tableName: '${tableName}_slides',
      columns: _slidesColumns,
    );

    return _flyersLDB;
  }
// -----------------------------------------------------------------------------
}