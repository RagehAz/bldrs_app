import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class UiProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// --- LOADING

// -------------------------------------
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
  bool _textFieldsObscured = true;
// -------------------------------------
  bool get textFieldsObscured => _textFieldsObscured;
// -------------------------------------
  void triggerTextFieldsObscured({bool setObscuredTo}){

    if (setObscuredTo == null){
      _textFieldsObscured = !_textFieldsObscured;
    }

    else {
      _textFieldsObscured = setObscuredTo;
    }

    notifyListeners();
  }
// -----------------------------------------------------------------------------

  /// --- IS SEARCHING

// -------------------------------------
  bool _isSearching = false;
// -------------------------------------
  bool get isSearching => _isSearching;
// -------------------------------------
  void triggerIsSearching({bool setIsSearchingTo}){

    if (setIsSearchingTo == null){
      _isSearching = !_isSearching;
    }

    else {
      _isSearching = setIsSearchingTo;
    }

    notifyListeners();

  }
// -------------------------------------
  void triggerIsSearchingAfterTextLengthIsAt({
    @required String text,
    int searchStartAtTextLength = 3,
    bool setIsSearchingTo,
}){

    // blog('triggerIsSearchingAfterTextLengthIsAt receives : text : $text : Length ${text.length}: _isSearching : $_isSearching');

    /// A - not searching
    if (_isSearching == false) {
      /// A.1 starts searching
      if (text.length >= searchStartAtTextLength) {
        triggerIsSearching(setIsSearchingTo: true);
      }
    }

    /// B - while searching
    else {
      /// B.1 ends searching
      if (text.length < searchStartAtTextLength) {
        triggerIsSearching(setIsSearchingTo: false);
      }

    }

  }
// -----------------------------------------------------------------------------
}
