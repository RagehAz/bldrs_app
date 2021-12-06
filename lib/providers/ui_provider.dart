import 'package:flutter/material.dart';

// final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class UiProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// test
  int _counter = 0;

  int get theCounter => _counter;

  void incrementCounter(){
    _counter++;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  String _name = 'Rageh';

  String get name => _name;

  void changeName(){
    if (_name == 'Rageh'){
      _name = 'GIGZ';
    }
    else {
      _name = 'Rageh';
    }
    notifyListeners();
  }
// -----------------------------------------------------------------------------
}
