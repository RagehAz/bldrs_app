import 'package:bldrs/f_helpers/drafters/tracers.dart';
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

  /// --- IS SEARCHING

// -------------------------------------
  bool _isSearchingCountry = false;
  bool _isSearchingCity = false;
  bool _isSearchingDistrict = false;
  bool _isSearchingFlyersAndBzz = false;
// -------------------------------------
  bool get isSearchingCountry => _isSearchingCountry;
  bool get isSearchingCity => _isSearchingCity;
  bool get isSearchingDistrict => _isSearchingDistrict;
  bool get isSearchingFlyersAndBzz => _isSearchingFlyersAndBzz;
// -------------------------------------
  void triggerIsSearching({
    @required SearchingModel searchingModel,
    @required bool setIsSearchingTo,
  }){

    if (searchingModel == SearchingModel.country){
      _isSearchingCountry = setIsSearchingTo;
    }

    else if (searchingModel == SearchingModel.city){
      _isSearchingCity = setIsSearchingTo;
    }

    else if (searchingModel == SearchingModel.district){
      _isSearchingDistrict = setIsSearchingTo;
    }

    else if (searchingModel == SearchingModel.flyersAndBzz){
      _isSearchingFlyersAndBzz = setIsSearchingTo;
    }

    notifyListeners();
  }
// -------------------------------------
  void triggerIsSearchingAfterMaxTextLength({
    @required String text,
    @required SearchingModel searchModel,
    @required bool isSearching,
    @required bool setIsSearchingTo,
    int maxTextLength = 3,
}){

    // blog('triggerIsSearchingAfterTextLengthIsAt receives : text : $text : Length ${text.length}: _isSearching : $_isSearching');

    /// A - not searching
    if (isSearching == false) {
      /// A.1 starts searching
      if (text.length >= maxTextLength) {
        triggerIsSearching(
          searchingModel: searchModel,
          setIsSearchingTo: true,
        );
      }
    }

    /// B - while searching
    else {
      /// B.1 ends searching
      if (text.length < maxTextLength) {
        triggerIsSearching(
          searchingModel: searchModel,
          setIsSearchingTo: false,
        );
      }

    }

    /// CAUTION : [triggerIsSearching] method has notifyListeners();
  }
// -------------------------------------
  void closeAllSearches(){

    _isSearchingCountry = false;
    _isSearchingCity = false;
    _isSearchingDistrict = false;

    notifyListeners();

  }
// -----------------------------------------------------------------------------
}
