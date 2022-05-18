import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  /// --- LOCAL ASSETS

// -------------------------------------
  List<String> _localAssetsPaths = <String>[];
// -------------------------------------
  List<String> get localAssetsPaths => _localAssetsPaths;
// -------------------------------------
  Future<void> getSetLocalAssetsPaths({
  @required bool notify,
}) async {
    final List<String> _paths = await getLocalAssetsPaths();
    if (notify == true){
      _localAssetsPaths = _paths;
    }
  }
// -----------------------------------------------------------------------------

  /// --- LOADING

// -------------------------------------
  bool _loading = false;
// -------------------------------------
  bool get isLoading => _loading;
// -------------------------------------
  void triggerLoading({
    @required String callerName,
    @required bool notify,
    bool setLoadingTo,
  }) {
    /// trigger loading method should remain Future as it starts controllers of
    /// each screen like triggerLoading.then(()=>methods)
    /// in didChangeDependencies override

    if (setLoadingTo == null){
      _loading = !_loading;
      if (notify == true) {
        notifyListeners();
      }
    }

    else {
      if (_loading != setLoadingTo){

        _loading = setLoadingTo;
        if (notify == true) {
          notifyListeners();
        }

      }
    }

    if (_loading == true) {
      blog('$callerName : LOADING --------------------------------------');
    } else {
      blog('$callerName : LOADING COMPLETE -----------------------------');
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
// -----------------------------------------------------------------------------

  /// --- MY BZ SCREEN CURRENT TAB

// -------------------------------------
  BzTab _currentBzTab = BzTab.flyers;
// -------------------------------------
  BzTab get currentBzTab => _currentBzTab;
// -------------------------------------
  void setCurrentBzTab(BzTab bzTab){
    _currentBzTab = bzTab;
    notifyListeners();
  }
// -----------------------------------------------------------------------------

  /// --- USER SCREEN CURRENT TAB

// -------------------------------------
  UserTab _currentUserTab = UserTab.profile;
// -------------------------------------
  UserTab get currentUserTab => _currentUserTab;
// -------------------------------------
  void setCurrentUserTab(UserTab userTab){
    _currentUserTab = userTab;
    notifyListeners();
  }
// -----------------------------------------------------------------------------

/// --- FLYER TWEEN

// -------------------------------------
  double _flyerWidthFactor = 1;
// -------------------------------------
  double get flyerWidthFactor => _flyerWidthFactor;
// -------------------------------------
  void setFlyerWidthFactor({
    @required double tween,
    double minFactor = 0.3,
    double maxFactor = 1,
  }){

    /// tween geos from 0 --> to 1, or inverse
    final double _widthFactor = _flyerWidthSizeFactor(
        tween: tween,
        minFactor: minFactor,
        maxFactor: maxFactor
    );

    blog('setFlyerWidthFactor : $_widthFactor');

    _flyerWidthFactor = _widthFactor;
    notifyListeners();
  }
// -------------------------------------
  double _flyerWidthSizeFactor({
    @required double tween,
    @required double minFactor,
    @required double maxFactor,
  }){
    /// EW3AAA
    final double _flyerWidthSizeFactor = minFactor + (tween * (maxFactor - minFactor));
    return _flyerWidthSizeFactor;
  }
// -----------------------------------------------------------------------------

}

void triggerUILoading({
  @required BuildContext context ,
  @required String callerName,
  bool listen = true,
}){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
  _uiProvider.triggerLoading(
    callerName: callerName,
    notify: true,
  );
}

/// TESTED : WORKS PERFECT
bool localAssetExists({
  @required BuildContext context,
  @required String assetName,
}){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final List<String> _localAssetsPaths = _uiProvider.localAssetsPaths;
  final String _path = getLocalAssetPathFromLocalPaths(
      allAssetsPaths: _localAssetsPaths,
      assetName: assetName
  );

  if (_path == null){
    return false;
  }
  else {
    return true;
  }
}

/// TESTED : WORKS PERFECT
String getLocalAssetPath({
  @required BuildContext context,
  @required String assetName,
}){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final List<String> _localAssetsPaths = _uiProvider.localAssetsPaths;
  final String _path = getLocalAssetPathFromLocalPaths(
      allAssetsPaths: _localAssetsPaths,
      assetName: assetName
  );

  return _path;
}
