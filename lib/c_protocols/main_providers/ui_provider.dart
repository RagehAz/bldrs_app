import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/a_models/x_ui/ui_image_cache_model.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// MAIN NAV KEY SUPER GLOBAL KEY

// --------------------
/// THIS HAS TO BE ASSIGNED TO MATERIAL APP IN THE MAIN FILE
final GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>();
BuildContext? superContext;
// --------------------
/// TESTED : WORKS PERFECT
BuildContext getMainContext() {
  return mainNavKey.currentContext ?? superContext!;
}
// -----------------------------------------------------------------------------

bool sessionStarted = false;

// -----------------------------------------------------------------------------
/// => TAMAM
// final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class UiProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// APP DIRECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAppIsLeftToRight() {

    if (Localizer.textDirection() == 'ltr') {
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection getAppTextDir() {

    if (Localizer.textDirection() == 'ltr') {
      return TextDirection.ltr;
    }

    else {
      return TextDirection.rtl;
    }
  }
  // -----------------------------------------------------------------------------

  /// SCREEN DIMENSIONS

  // --------------------
  Dimensions? _screenDims;
  Dimensions? get screenDims => _screenDims;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions? proGetScreenDimensions({
    required BuildContext context,
    required bool listen,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    return _uiProvider.screenDims;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetScreenDimensions({
    required bool notify,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider.getSetScreenDimensions(
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void getSetScreenDimensions({
    required bool notify,
  }){

    _screenDims = Dimensions(
        width: Scale.screenWidth(getMainContext()),
        height: Scale.screenHeight(getMainContext())
    );

    if (notify == true){
      notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// LOCAL ASSETS

  // --------------------
  List<String> _localAssetsPaths = <String>[];
  List<String> get localAssetsPaths => _localAssetsPaths;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> getSetLocalAssetsPaths({
    required bool notify,
  }) async {
    final List<String> _paths = await Filers.getLocalAssetsPaths();

    _setLocalAssetPaths(
      paths: _paths,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setLocalAssetPaths({
    required List<String> paths,
    required bool notify,
  }){

    _localAssetsPaths = paths;

    if (notify == true){
      notifyListeners();
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> proGetLocalAssetsPaths(){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    return _uiProvider.localAssetsPaths;
  }
  // -----------------------------------------------------------------------------

  /// AFTER HOME ROUTE

  // --------------------
  RouteSettings? _afterHomeRoute;
  RouteSettings? get afterHomeRoute => _afterHomeRoute;
  // --------------------
  /// TESTED : WORKS PERFECT
  static RouteSettings? proGetAfterHomeRoute({
    required BuildContext context,
    required bool listen,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    return _uiProvider.afterHomeRoute;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proClearAfterHomeRoute({
    required bool notify,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
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
    required String? routeName,
    required String? arguments,
    required bool notify,
  }){

    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
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
    required RouteSettings? settings,
    required bool notify,
  }){

    _afterHomeRoute = settings;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// KEYBOARD

  // --------------------
  bool _keyboardIsOn = false;
  bool get keyboardIsOn => _keyboardIsOn;
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proGetKeyboardIsOn () {
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    final bool _keyboardIsOn = _uiProvider.keyboardIsOn;
    return _keyboardIsOn;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setKeyboardIsOn({
    required bool setTo,
    required bool notify,
  }){

    if (setTo != _keyboardIsOn){

      _keyboardIsOn = setTo;

      if (notify == true){
        notifyListeners();
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SAVED FLYERS TAB CURRENT FLYER TYPE

  // --------------------
  FlyerType _currentSavedFlyerTypeTab = FlyerType.general;
  // --------------------
  FlyerType get currentSavedFlyerTypeTab => _currentSavedFlyerTypeTab;
  // --------------------
  /// TESTED : WORKS PERFECT
  void setCurrentFlyerTypeTab({
    required FlyerType flyerType,
    required bool notify,
  }){

    _currentSavedFlyerTypeTab = flyerType;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// MY BZ SCREEN CURRENT TAB

  // --------------------
  BzTab _currentBzTab = BzTab.flyers;
  // --------------------
  BzTab get currentBzTab => _currentBzTab;
  // --------------------
  /// TESTED : WORKS PERFECT
  void setCurrentBzTab({
    required BzTab bzTab,
    required bool notify,
  }){
    _currentBzTab = bzTab;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// USER SCREEN CURRENT TAB

  // --------------------
  UserTab _currentUserTab = UserTab.profile;
  // --------------------
  UserTab get currentUserTab => _currentUserTab;
  // --------------------
  /// TESTED : WORKS PERFECT
  void setCurrentUserTab({
    required UserTab userTab,
    required bool notify,
  }){
    _currentUserTab = userTab;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// FLYER TWEEN

  // --------------------
  double _flyerWidthFactor = 1;
  // --------------------
  double get flyerWidthFactor => _flyerWidthFactor;
  // --------------------
  /// TESTED : WORKS PERFECT
  void calculateSetFlyerWidthFactor({
    required double tween,
    required bool notify,
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
  /// TESTED : WORKS PERFECT
  void _setFlyerWidthSizeFactor({
    required double widthFactor,
    required bool notify,
  }){

    _flyerWidthFactor = widthFactor;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _flyerWidthSizeFactor({
    required double tween,
    required double minFactor,
    required double maxFactor,
  }){
    /// EW3AAA
    final double _flyerWidthSizeFactor = minFactor + (tween * (maxFactor - minFactor));
    return _flyerWidthSizeFactor;
  }
  // -----------------------------------------------------------------------------

  /// TOP DIALOG KEY

  // --------------------
  final GlobalKey _topDialogKey = GlobalKey();
  GlobalKey get topDialogKey => _topDialogKey;
  // --------------------
  /// TESTED : WORKS PERFECT
  static GlobalKey proGetTopDialogKey({
    required BuildContext context,
    required bool listen,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    return _uiProvider.topDialogKey;
  }
  // -----------------------------------------------------------------------------

  /// PYRAMID IS EXPANDED

  // --------------------
  bool _pyramidsAreExpanded = false;
  bool get pyramidsAreExpanded => _pyramidsAreExpanded;
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setPyramidsAreExpanded({
    required bool setTo,
    required bool notify,
  }){

    if (_pyramidsAreExpanded != setTo){

      _pyramidsAreExpanded = setTo;

      if (notify == true) {
        notifyListeners();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetPyramidsAreExpanded({
    required bool setTo,
    required bool notify,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider._setPyramidsAreExpanded(
        setTo: setTo,
        notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proGetPyramidsAreExpanded({
    required BuildContext context,
    required bool listen,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    return _uiProvider.pyramidsAreExpanded;
  }
  // -----------------------------------------------------------------------------

  /// LAYOUT IS VISIBLE

  // --------------------
  bool _layoutIsVisible = true;
  bool get layoutIsVisible => _layoutIsVisible;
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setLayoutIsVisible({
    required bool setTo,
    required bool notify,
  }){

    if (_layoutIsVisible != setTo){

      _layoutIsVisible = setTo;

      if (notify == true) {
        notifyListeners();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetLayoutIsVisible({
    required bool setTo,
    required bool notify,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider._setLayoutIsVisible(
        setTo: setTo,
        notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proGetLayoutIsVisible({
    required BuildContext context,
    required bool listen,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    return _uiProvider.layoutIsVisible;
  }
  // -----------------------------------------------------------------------------

  /// NAV ON DYNAMIC LINK

  // --------------------
  bool _canNavOnDynamicLink = true;
  bool get canNavOnDynamicLink => _canNavOnDynamicLink;
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setCanDynamicNav({
    required bool setTo,
    required bool notify,
  }){

    if (_canNavOnDynamicLink != setTo){
      _canNavOnDynamicLink = setTo;
    }

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetCanNavOnDynamicLink({
    required bool setTo,
    required bool notify,
  }){

    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider._setCanDynamicNav(
      setTo: setTo,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proGetCanNavOnDynamicLink(){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    return _uiProvider.canNavOnDynamicLink;
  }
  // -----------------------------------------------------------------------------

  /// LOADING VERSE

  // --------------------
  Verse? _loadingVerse;
  Verse? get loadingVerse => _loadingVerse;
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setLoadingVerse({
    required Verse? verse,
    required bool notify,
  }){

    if (_loadingVerse != verse) {
      _loadingVerse = verse;

      if (notify == true) {
        notifyListeners();
      }
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetLoadingVerse({
    required Verse? verse,
    bool notify = true,
  }){

    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider._setLoadingVerse(
      verse: verse,
      notify: notify,
    );

  }
  // --------------------
  ///
  static void clearLoadingVerse() {
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider._setLoadingVerse(
      verse: null,
      notify: true,
    );
  }
  // -----------------------------------------------------------------------------

  /// IMAGES

  // --------------------
  List<Cacher> _cachers = const <Cacher>[];
  List<Cacher> get cacher => _cachers;
  // --------------------
  ///
  Cacher? getCacher(String cacherID){
    return Cacher.getCacherFromCachers(
        cachers: _cachers,
        cacherID: cacherID
    );
  }
  // --------------------
  ///
  void storeCacher({
    required Cacher cacher,
    required bool notify,
  }){

    _cachers = Cacher.addCacherToCachers(
      cachers: _cachers,
      cacher: cacher,
      overrideExisting: false,
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  ///
  void _disposeCacher({
    required String cacherID,
    required bool notify,
}){

    _cachers = Cacher.disposeCacherInCachers(
      cachers: _cachers,
      cacherID: cacherID,
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  ///
  static Cacher? proGetCacher({
    required bool listen,
    required String cacherID,
  }){
    return null;
    // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    // return _uiProvider._getCacher(cacherID);
  }
  // --------------------
  ///
  static void proStoreCacher({
    required Cacher cacher,
    required bool notify,
  }){
      // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      // _uiProvider._storeCacher(
      //   cacher: cacher,
      //   notify: notify,
      // );
    }
  // --------------------
  ///
  static void proDisposeCacher({
    required String cacherID,
    required bool notify,
  }){

    final UiProvider _uiProvider = Provider.of<UiProvider>(
      getMainContext(),
      listen: false,
    );

    _uiProvider._disposeCacher(
      cacherID: cacherID,
      notify: notify,
    );
  }
  // -----------------------------------------------------------------------------

  /// CURRENT LANGUAGE : USED TO LIVE LISTEN TO CHANGES IN LOADING SCREEN

  // --------------------
  String _currentLangCode = 'en';
  String get currentLangCode => _currentLangCode;
  // --------------------
  /// TESTED : WORKS PERFECT
  static String proGetCurrentLangCode({
    required BuildContext context,
    required bool listen,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: listen);
    return _uiProvider.currentLangCode;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetCurrentLangCode({
    required BuildContext context,
    required String langCode,
    required bool notify,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider._setCurrentLangCode(
      notify: notify,
      langCode: langCode,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setCurrentLangCode({
    required bool notify,
    required String? langCode,
  }) {

    /// A. DETECT DEVICE LANGUAGE
    final String _langCode = langCode ?? Localizer.getCurrentLangCode();

    /// C. SET CURRENT LANGUAGE
    _currentLangCode = _langCode;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    required bool notify,
  }){

    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);

    /// _localAssetsPaths
    _uiProvider._setLocalAssetPaths(paths: <String>[], notify: false);
    /// _keyboardModel
    // _uiProvider.setKeyboard(model: null, notify: false, invoker: 'Ui provider wipeOut');
    /// _keyboardIsOn
    _uiProvider.setKeyboardIsOn(setTo: false, notify: false);
    /// _currentSavedFlyerTypeTab
    _uiProvider.setCurrentFlyerTypeTab(flyerType: FlyerType.general, notify: false);
    /// _currentBzTab
    _uiProvider.setCurrentBzTab(bzTab: BzTab.flyers, notify: false);
    /// _currentUserTab
    _uiProvider.setCurrentUserTab(userTab: UserTab.profile, notify: false);
    /// _flyerWidthFactor
    _uiProvider._setFlyerWidthSizeFactor(widthFactor: 1,notify: false);

    _uiProvider._setLayoutIsVisible(setTo: true, notify: false);
    _uiProvider._setPyramidsAreExpanded(setTo: false, notify: notify);
  }
  // -----------------------------------------------------------------------------
}
  // --------------------
/// TESTED : WORKS PERFECT
bool localAssetExists({
  required String assetName,
}){
  final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
  final List<String> _localAssetsPaths = _uiProvider.localAssetsPaths;
  final String? _path = Filers.getLocalAssetPathFromLocalPaths(
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
// --------------------
/// TESTED : WORKS PERFECT
String? getLocalAssetPath({
  required String? assetName,
}){
  final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
  final List<String> _localAssetsPaths = _uiProvider.localAssetsPaths;
  final String? _path = Filers.getLocalAssetPathFromLocalPaths(
      allAssetsPaths: _localAssetsPaths,
      assetName: assetName
  );

  return _path;
}
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
String? getCounterCaliber(int? x){
  return Numeric.formatNumToCounterCaliber(
    x: x,
    thousand: getWord('phid_thousand'),
    million: getWord('phid_million'),
  );
}
// --------------------
/// TESTED : WORKS PERFECT
String? phidIcon(dynamic icon){
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
  return _chainsProvider.getPhidIcon(
    son: icon,
  );
}
// -----------------------------------------------------------------------------
