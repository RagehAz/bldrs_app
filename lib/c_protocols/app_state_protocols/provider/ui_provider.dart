import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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

  // --------------------
  List<String> _localAssetsPaths = <String>[];
  List<String> get localAssetsPaths => _localAssetsPaths;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> getSetLocalAssetsPaths({
    @required bool notify,
  }) async {
    final List<String> _paths = await Iconizer.getLocalAssetsPaths();

    _setLocalAssetPaths(
      paths: _paths,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setLocalAssetPaths({
    @required List<String> paths,
    @required bool notify,
  }){

    _localAssetsPaths = paths;

    if (notify == true){
      notifyListeners();
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> proGetLocalAssetsPaths(BuildContext context){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    return _uiProvider.localAssetsPaths;
  }
  // -----------------------------------------------------------------------------

  /// --- AFTER HOME ROUTE

  // --------------------
  RouteSettings _afterHomeRoute;
  RouteSettings get afterHomeRoute => _afterHomeRoute;
  // --------------------
  /// TESTED : WORKS PERFECT
  static RouteSettings proGetAfterHomeRoute({
    @required BuildContext context,
    @required bool listen,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    return _uiProvider.afterHomeRoute;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proClearAfterHomeRoute({
    @required BuildContext context,
    @required bool notify,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    blog('proClearAfterHomeRoute : was : ${_uiProvider._afterHomeRoute}');
    _uiProvider.setAfterHomeRoute(
      settings: null,
      notify: notify,
    );
    blog('proClearAfterHomeRoute : now : ${_uiProvider._afterHomeRoute}');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetAfterHomeRoute({
    @required BuildContext context,
    @required String routeName,
    @required String arguments,
    @required bool notify,
  }){

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.setAfterHomeRoute(
      settings: RouteSettings(
        name:  routeName,
        arguments: arguments,
      ),
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setAfterHomeRoute({
    @required RouteSettings settings,
    @required bool notify,
  }){

    _afterHomeRoute = settings;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// --- LOADING

  // --------------------
  bool _loading = false;
  bool get isLoading => _loading;
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
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

  /// --- KEYBOARD

  // --------------------
  bool _keyboardIsOn = false;
  bool get keyboardIsOn => _keyboardIsOn;
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proGetKeyboardIsOn (BuildContext context) {
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    final bool _keyboardIsOn = _uiProvider.keyboardIsOn;
    return _keyboardIsOn;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setKeyboardIsOn({
    @required bool setTo,
    @required bool notify,
  }){

    if (setTo != _keyboardIsOn){

      _keyboardIsOn = setTo;

      if (notify == true){
        notifyListeners();
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// --- TEXT FIELD OBSCURED

  // --------------------
  void startController(Function controllerMethod) {

    _start().then((_) async {

      await controllerMethod();

    });

  }
  // --------------------
  Future<void> _start() async {}
  // -----------------------------------------------------------------------------

  /// --- TEXT FIELD OBSCURED

  // --------------------
  /// TESTED : WORKS PERFECT
  bool _textFieldsObscured = true;
  // --------------------
  /// TESTED : WORKS PERFECT
  bool get textFieldsObscured => _textFieldsObscured;
  // --------------------
  /// TESTED : WORKS PERFECT
  void triggerTextFieldsObscured({
    @required bool notify,
    bool setObscuredTo
  }){

    if (setObscuredTo == null){
      _textFieldsObscured = !_textFieldsObscured;
    }

    else {

      if(_textFieldsObscured != setObscuredTo){
        _textFieldsObscured = setObscuredTo;
      }

    }

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// --- SAVED FLYERS TAB CURRENT FLYER TYPE

  // --------------------
  FlyerType _currentSavedFlyerTypeTab = FlyerType.all;
  // --------------------
  FlyerType get currentSavedFlyerTypeTab => _currentSavedFlyerTypeTab;
  // --------------------
  void setCurrentFlyerTypeTab({
    @required FlyerType flyerType,
    @required bool notify,
  }){

    _currentSavedFlyerTypeTab = flyerType;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// --- MY BZ SCREEN CURRENT TAB

  // --------------------
  BzTab _currentBzTab = BzTab.flyers;
  // --------------------
  BzTab get currentBzTab => _currentBzTab;
  // --------------------
  void setCurrentBzTab({
    @required BzTab bzTab,
    @required bool notify,
  }){
    _currentBzTab = bzTab;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// --- USER SCREEN CURRENT TAB

  // --------------------
  UserTab _currentUserTab = UserTab.profile;
  // --------------------
  UserTab get currentUserTab => _currentUserTab;
  // --------------------
  void setCurrentUserTab({
    @required UserTab userTab,
    @required bool notify,
  }){
    _currentUserTab = userTab;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// --- FLYER TWEEN

  // --------------------
  double _flyerWidthFactor = 1;
  // --------------------
  double get flyerWidthFactor => _flyerWidthFactor;
  // --------------------
  void calculateSetFlyerWidthFactor({
    @required double tween,
    @required bool notify,
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

    _setFlyerWidthSizeFactor(
      widthFactor: _widthFactor,
      notify: notify,
    );

  }
  // --------------------
  void _setFlyerWidthSizeFactor({
    @required double widthFactor,
    @required bool notify,
  }){

    _flyerWidthFactor = widthFactor;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
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

  /// --- TOP DIALOG KEY

  // --------------------
  final GlobalKey _topDialogKey = GlobalKey();
  GlobalKey get topDialogKey => _topDialogKey;
  // --------------------
  /// TESTED : WORKS PERFECT
  static GlobalKey proGetTopDialogKey({
    @required BuildContext context,
    @required bool listen,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    return _uiProvider.topDialogKey;
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

    /// _localAssetsPaths
    _uiProvider._setLocalAssetPaths(paths: <String>[], notify: false);
    /// _loading
    _uiProvider.triggerLoading(callerName: 'WipeOut', notify: false, setLoadingTo: false);
    /// _keyboardModel
    // _uiProvider.setKeyboard(model: null, notify: false, invoker: 'Ui provider wipeOut');
    /// _keyboardIsOn
    _uiProvider.setKeyboardIsOn(setTo: false, notify: false);
    /// _textFieldsObscured
    _uiProvider.triggerTextFieldsObscured(setObscuredTo: true, notify: false);
    /// _currentSavedFlyerTypeTab
    _uiProvider.setCurrentFlyerTypeTab(flyerType: FlyerType.all, notify: false);
    /// _currentBzTab
    _uiProvider.setCurrentBzTab(bzTab: BzTab.flyers, notify: false);
    /// _currentUserTab
    _uiProvider.setCurrentUserTab(userTab: UserTab.profile, notify: false);
    /// _flyerWidthFactor
    _uiProvider._setFlyerWidthSizeFactor(widthFactor: 1,notify: true);

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
  final String _path = Iconizer.getLocalAssetPathFromLocalPaths(
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
  final String _path = Iconizer.getLocalAssetPathFromLocalPaths(
      allAssetsPaths: _localAssetsPaths,
      assetName: assetName
  );

  return _path;
}