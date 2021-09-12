import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class TrigramTest extends StatefulWidget {

  @override
  _TrigramTestState createState() => _TrigramTestState();
}

class _TrigramTestState extends State<TrigramTest> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _input = 'Muhammed Abdul Quddouss a7mad';
  List<String> _result = ['Nothing Yet'];

  void _createTrigramOld(){

    List<String> _resultTrigram = [];


    /// 1 - to lower case and remove Spaces
    final String _lowerCased = _input.toLowerCase();

    /// 1 - add each word separately first
    final List<String> _splitWords = _lowerCased.trim().split(' ');
    _resultTrigram.addAll(_splitWords);


    final String _withoutSpaces = TextMod.removeSpacesFromAString(_lowerCased);

    /// 2 - split characters into a list
    final List<String> _splitString = _withoutSpaces.split('');

    /// 3 - generate the triplets
    for (int i = 0; i < _splitString.length - 2; i++){
      String _first = _splitString[i];
      String _second = _splitString[i+1];
      String _third = _splitString[i+2];
      String _combined = '$_first$_second$_third';
      _resultTrigram = TextMod.addStringToListIfDoesNotContainIt(strings : _resultTrigram, stringToAdd : _combined,);
    }

    /// 4 - generate quadruplets
    for (int i = 0; i < _splitString.length - 3; i++){
      String _first = _splitString[i];
      String _second = _splitString[i+1];
      String _third = _splitString[i+2];
      String _fourth = _splitString[i+3];
      String _combined = '$_first$_second$_third$_fourth';
      _resultTrigram = TextMod.addStringToListIfDoesNotContainIt(strings : _resultTrigram, stringToAdd : _combined,);
    }

    /// 5 - generate Quintuplets
    for (int i = 0; i < _splitString.length - 4; i++){
      String _first = _splitString[i];
      String _second = _splitString[i+1];
      String _third = _splitString[i+2];
      String _fourth = _splitString[i+3];
      String _fifth = _splitString[i+4];
      String _combined = '$_first$_second$_third$_fourth$_fifth';
      _resultTrigram = TextMod.addStringToListIfDoesNotContainIt(strings : _resultTrigram, stringToAdd : _combined,);
    }

    /// 6 - generate Sextuplets
    for (int i = 0; i < _splitString.length - 5; i++){
      String _first = _splitString[i];
      String _second = _splitString[i+1];
      String _third = _splitString[i+2];
      String _fourth = _splitString[i+3];
      String _fifth = _splitString[i+4];
      String _sixth = _splitString[i+5];
      String _combined = '$_first$_second$_third$_fourth$_fifth$_sixth';
      _resultTrigram = TextMod.addStringToListIfDoesNotContainIt(strings : _resultTrigram, stringToAdd : _combined,);
    }

    setState(() {
      _result = _resultTrigram;
    });

    print(_result);
  }

  void _createTrigram(){

    List<String> _trigram = TextMod.createTrigram(
      input: _input,
      maxTrigramLength: null,
    );

    setState(() {
      _result = _trigram;
    });
  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);

    return TestLayout(
        screenTitle: 'Trigram Test',
        appbarButtonVerse: null,
        appbarButtonOnTap: null,
        scrollable: false,
        listViewWidgets: <Widget>[

          Container(
            width: _screenWidth,
            height: 300,
            color: Colorz.Yellow125,
            child: Center(

              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _result.length,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (ctx, index){
                    String _tri = _result[index];
                    return
                      SuperVerse(
                        verse: '$index : $_tri',
                        size: 2,
                        color: Colorz.Black255,
                        centered: false,
                      );

                  }
              ),
            ),
          ),

          DreamBox(
            height: 50,
            width: 200,
            verse: 'Do Trigram for $_input',
            verseScaleFactor: 0.6,
            onTap: _createTrigram,
          ),

          SuperVerse(
            verse: 'tirgram has : ${_result.length} entries',
            labelColor: Colorz.Blue125,
            margin: 10,
          ),

      ],
    );
  }
}
