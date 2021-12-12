import 'package:bldrs/helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class UiProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// --- LOADING
  bool _loading = false;
// -------------------------------------
  bool get loading => _loading;
// -------------------------------------
  Future<void> triggerLoading() async {
    /// trigger loading method should remain Future as it starts controllers of
    /// each screen like triggerLoading.then(()=>methods)
    /// in didChangeDependencies override

    _loading = !_loading;

    if(_loading == true){
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }

    notifyListeners();
  }
// -----------------------------------------------------------------------------
}
