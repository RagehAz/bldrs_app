

// -----------------------------------------------------------------------------

/// --- UI PROVIDER : KEYWORDS DRAWER

// -------------------------------------
/*
bool _keywordsDrawerIsOn = false;
// -------------------------------------
bool get keywordsDrawerIsOn => _keywordsDrawerIsOn;
// -------------------------------------
void setKeywordsDrawerIsOn({
  @required bool setTo,
  @required bool notify,
}){

  _keywordsDrawerIsOn = setTo;

  if (notify == true){
    notifyListeners();
  }

}
// -------------------------------------
void closeDrawerIfOpen(BuildContext context){
  if (_keywordsDrawerIsOn == true){
    Nav.goBack(context);
  }
}
 */
// -----------------------------------------------------------------------------

/// --- MAIN LAYOUT

// -------------------------------------
/*
void _onDrawerChanged(context, bool drawerIsOn){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.setKeywordsDrawerIsOn(
    setTo: drawerIsOn,
    notify: true,
  );
}
 */
// -------------------------------------
/// IN MAIN LAYOUT SCAFFOLD
/*
/// DRAWER
drawer: sectionButtonIsOn == true ? const ChainsDrawerStarter() : null,
drawerEdgeDragWidth: ChainsDrawerStarter.drawerEdgeDragWidth,
drawerScrimColor: ChainsDrawerStarter.drawerScrimColor,
onDrawerChanged: (bool drawerIsOn) => _onDrawerChanged(context, drawerIsOn),
 */
/// IN MAIN LAYOUT ON BACK METHOD : IT WAS LIKE THIS
/*
  void _onBack(BuildContext context){

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    final bool _keyboardIsOn = _uiProvider.keyboardIsOn;

    // blog('wtf : _keyboardIsOn : $_keyboardIsOn');

    if (_keyboardIsOn == true){
      Keyboarders.closeKeyboard(context);
    }

    else if (_drawerIsOn == true){
      Keyboarders.closeKeyboard(context);
      Nav.goBack(context);

      _uiProvider.setKeywordsDrawerIsOn(
        setTo: false,
        notify: true,
      );
    }

    else if (onBack != null){
      onBack();
    }

    else if (canGoBack == true){
      Nav.goBack(context);
    }

  }
 */
// -----------------------------------------------------------------------------
