


class DoubleFromStringTest {

  /// lets just make a method that takes dynamic and returns double
  /// and it should process the strings and doubles
  static double getDoubleIfPossible(dynamic input){
    double _output;

    print('starting : getDoubleIfPossible : input : ${input}');
    print('starting : getDoubleIfPossible : input.runtimeType : ${input.runtimeType}');

    /// some safety layer first
    if (input != null){

      /// when its already a double,, we are good
      if (input.runtimeType == double){

        _output = input;
      }

      /// when its a string
      else if (input.runtimeType == String){

        /// we need to make sure that it's a double inside a string,, and not a combination of doubles & characters in one string like '15X8wS'
        /// so lets do an another method and call it here
        bool _inputIsDoubleInsideAString = _objectIsDoubleInString(input);

        if (_inputIsDoubleInsideAString == true){

          /// so its a double inside a string,, then we can get the double now without firing an error
          _output = _stringToDouble(input);

        }

        // else {
        //   /// input is not a double in a string
        //   /// will do nothing,, and the _output shall return null
        //   /// so I will comment these unnecessary lines
        // }


      }

      // /// it not a string and its not a double
      // else {
      //   /// do nothing and return null
      //   /// so I will comment these unnecessary lines
      // }

    }

    return _output;
  }

  static bool _objectIsDoubleInString(dynamic string) {

    bool _objectIsDoubleInString;
    double _double;

    if (string != null){
      _double = double.tryParse(string.trim());
    }

    if (_double == null){
      _objectIsDoubleInString = false;
    } else {
      _objectIsDoubleInString = true;
    }

    print('objectIsDoubleInString : _double is : $_double');

    return _objectIsDoubleInString;

  }

  static double _stringToDouble(String string){
    double _value;

    if (string != null){
      _value = double.parse(string);
    }

    return _value;
  }

}