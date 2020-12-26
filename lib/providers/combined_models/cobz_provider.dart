import 'package:bldrs/ambassadors/db_brain/db_controller.dart';
import 'package:flutter/material.dart';
import 'co_bz.dart';

class CoBzProvider with ChangeNotifier {
  List<CoBz> _downloadedBzz = getAllCoBz();

  List<CoBz> get hatAllBzz {
    return [..._downloadedBzz];
  }

}