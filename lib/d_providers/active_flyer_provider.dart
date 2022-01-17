import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/fire/search/flyer_search.dart' as FlyerSearch;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// THIS CONTROLLERS ACTIVE FLYER STATES
// final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
class ActiveFlyerProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// NOTIFIER
  void _notify(bool notify){
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// CURRENT SLIDE INDEX

// -------------------------------------
  int _currentSlideIndex = 0;
// -------------------------------------
  int get currentSlideIndex => _currentSlideIndex;
// -------------------------------------
  void setCurrentSlideIndex({@required int setIndexTo, bool notify = true}){
    _currentSlideIndex = setIndexTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

/// PROGRESS BAR OPACITY

// -------------------------------------
  int _progressBarOpacity = 1;
// -------------------------------------
  int get progressBarOpacity => _progressBarOpacity;
// -------------------------------------
  void setProgressBarOpacity({@required int setOpacityTo, bool notify = true}){
    _progressBarOpacity = setOpacityTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

/// HEADER IS EXPANDED

// -------------------------------------
  bool _headerIsExpanded = false;
// -------------------------------------
  bool get headerIsExpanded => _headerIsExpanded;
// -------------------------------------
  void setHeaderIsExpanded({@required bool setHeaderIsExpandedTo, bool notify = true}){
    _headerIsExpanded = setHeaderIsExpandedTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

/// HEADER PAGE OPACITY

// -------------------------------------
  int _headerPageOpacity = 0;
// -------------------------------------
  int get headerPageOpacity => _headerPageOpacity;
// -------------------------------------
  void setHeaderPageOpacity({@required int setOpacityTo, bool notify = true}){
    _headerPageOpacity = setOpacityTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

}
