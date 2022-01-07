import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

enum SearchingModel{
  country,
  city,
  district,
  flyersAndBzz
  // users,
}

// final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class UiProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// --- LOADING

// -------------------------------------
  bool _loading = false;
// -------------------------------------
  bool get isLoading => _loading;
// -------------------------------------
  void triggerLoading({bool setLoadingTo}) {
    /// trigger loading method should remain Future as it starts controllers of
    /// each screen like triggerLoading.then(()=>methods)
    /// in didChangeDependencies override

    if (setLoadingTo == null){
      _loading = !_loading;
      notifyListeners();
    }

    else {
      if (_loading != setLoadingTo){
        _loading = setLoadingTo;
        notifyListeners();
      }
    }

    if (_loading == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }

  }
// -------------------------------------
  /// --- LOADING SELECTOR TEMPLATE
  /*

  Selector<UiProvider, bool>(
            selector: (_, UiProvider uiProvider) => uiProvider.loading,
            child: WebsafeSvg.asset(widget.pyramidsIcon),
            // shouldRebuild: ,
            builder: (BuildContext context, bool loading, Widget child){

            return const SizeBox();

            }

   */
// -----------------------------------------------------------------------------

  /// --- TEXT FIELD OBSCURED

// -------------------------------------
  void startController(Function controllerMethod) {

    _start().then((_) async {

      await controllerMethod();

    });

  }
// -------------------------------------
  Future<void> _start() async {}
// -----------------------------------------------------------------------------

  /// --- TEXT FIELD OBSCURED

// -------------------------------------
  bool _textFieldsObscured = true;
// -------------------------------------
  bool get textFieldsObscured => _textFieldsObscured;
// -------------------------------------
  void triggerTextFieldsObscured({bool setObscuredTo}){

    if (setObscuredTo == null){
      _textFieldsObscured = !_textFieldsObscured;
      notifyListeners();
    }

    else {

      if(_textFieldsObscured != setObscuredTo){
        _textFieldsObscured = setObscuredTo;
        notifyListeners();
      }

    }

  }
// -----------------------------------------------------------------------------

  /// --- KEYWORDS DRAWER

// -------------------------------------
  bool _keywordsDrawerIsOn = false;
// -------------------------------------
  bool get keywordsDrawerIsOn => _keywordsDrawerIsOn;
// -------------------------------------
  void setKeywordsDrawerIsOn({@required bool setTo}){
    _keywordsDrawerIsOn = setTo;
    notifyListeners();
  }
// -------------------------------------
  void closeDrawerIfOpen(BuildContext context){
    if (_keywordsDrawerIsOn == true){
      goBack(context);
    }
  }
// -----------------------------------------------------------------------------

/// --- SAVED FLYERS TAB CURRENT FLYER TYPE

// -------------------------------------
  FlyerType _currentSavedFlyerTypeTab = FlyerType.all;
// -------------------------------------
  FlyerType get currentSavedFlyerTypeTab => _currentSavedFlyerTypeTab;
// -------------------------------------
  void setCurrentFlyerTypeTab(FlyerType flyerType){
    _currentSavedFlyerTypeTab = flyerType;
    notifyListeners();
  }
// -------------------------------------
}
