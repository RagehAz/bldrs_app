import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class UiProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// --- LOADING
  bool _loading = false;
// -------------------------------------
  bool get loading => _loading;
// -------------------------------------
  void triggerLoading({bool setLoadingTo}) {
    /// trigger loading method should remain Future as it starts controllers of
    /// each screen like triggerLoading.then(()=>methods)
    /// in didChangeDependencies override

    _loading = !_loading;

    if (_loading == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }

    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void startController(Function controllerMethod) {

    _start().then((_) async {

      await controllerMethod();

    });

  }
// -----------------------------------------------------------------------------
  Future<void> _start() async {}
// -----------------------------------------------------------------------------
}
