import 'package:bldrs/ambassadors/db_brain/db_controller.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_bz.dart';
import 'package:flutter/material.dart';

class CoBzProvider with ChangeNotifier {
  List<CoBz> _downloadedBzz = getAllCoBz();

  List<CoBz> get hatAllBzz {
    return [..._downloadedBzz];
  }

}