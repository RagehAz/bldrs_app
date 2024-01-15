import 'dart:async';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/a_models/x_ui/ui_image_cache_model.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
  StreamSubscription<bool>? _keyboardSubscription;
  KeyboardVisibilityController? keyboardVisibilityController;
  // --------------------
  static void proInitializeKeyboard(){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider._initializeKeyboard();
  }
  // --------------------
  static void disposeKeyword(){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider._disposeKeyboard();
  }
  // --------------------
  void _initializeKeyboard(){

    keyboardVisibilityController ??= KeyboardVisibilityController();

    /// Subscribe
    _keyboardSubscription ??= Keyboard.initializeKeyboardListener(
      controller: keyboardVisibilityController!,
    );

  }
  // --------------------
  void _disposeKeyboard(){
    _keyboardSubscription?.cancel();
    keyboardVisibilityController = null;
    _keyboardSubscription = null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proGetKeyboardIsOn () {
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    final bool _keyboardIsOn = _uiProvider.keyboardIsOn;
    return _keyboardIsOn;
  }
  // --------------------
  static void proSetKeyboardIsOn({
    required bool setTo,
    required bool notify,
  }){
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    _uiProvider._setKeyboardIsOn(
      notify: notify,
      setTo: setTo,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setKeyboardIsOn({
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

    /// _keyboardModel
    // _uiProvider.setKeyboard(model: null, notify: false, invoker: 'Ui provider wipeOut');
    /// _keyboardIsOn
    UiProvider.proSetKeyboardIsOn(setTo: false, notify: false);
    /// _currentSavedFlyerTypeTab
    _uiProvider.setCurrentFlyerTypeTab(flyerType: FlyerType.general, notify: false);
    /// _currentBzTab
    _uiProvider.setCurrentBzTab(bzTab: BzTab.flyers, notify: false);
    /// _currentUserTab
    _uiProvider.setCurrentUserTab(userTab: UserTab.profile, notify: false);

    _uiProvider._setLayoutIsVisible(setTo: true, notify: false);
    _uiProvider._setPyramidsAreExpanded(setTo: false, notify: notify);
  }
  // -----------------------------------------------------------------------------

  /// DEPRECATED

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
}
// -----------------------------------------------------------------------------
