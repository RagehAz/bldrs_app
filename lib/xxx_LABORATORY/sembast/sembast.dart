import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
// -----------------------------------------------------------------------------
  /// private constructor to create instances of this class only in itself
  AppDatabase._thing();
// -----------------------------------------------------------------------------
  /// Singleton instance
  static final AppDatabase _singleton = AppDatabase._thing();
// -----------------------------------------------------------------------------
  /// Singleton accessor
  static AppDatabase get instance => _singleton;
// -----------------------------------------------------------------------------
  /// to transform from synchronous into asynchronous
  Completer<Database> _dbOpenCompleter;
// -----------------------------------------------------------------------------
  /// db object accessor
  Future<Database> get database async {

    if (_dbOpenCompleter == null){
      _dbOpenCompleter = Completer();

      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }
// -----------------------------------------------------------------------------
  Future<void> _openDatabase() async {

    final Directory _appDocDir = await getApplicationDocumentsDirectory();

    final String _dbPath = join(_appDocDir.path, 'bldrs_sembast.db');

    final Database _db = await databaseFactoryIo.openDatabase(_dbPath);

    _dbOpenCompleter.complete(_db);

    return _db;

  }
// -----------------------------------------------------------------------------

}