import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/crud/flyer_ops.dart';
import 'package:bldrs/firestore/firebase_storage.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Firebasetesting extends StatefulWidget {

  @override
  _FirebasetestingState createState() => _FirebasetestingState();
}

class _FirebasetestingState extends State<Firebasetesting> {
  List<Map<String, Object>> functions;
  String printVerse;
  File _dumFile;
  String _dumURL;
  List<SaveModel> _userSaveModels;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------

  @override
  void initState() {

    final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;

    functions = [
      // -----------------------------------------------------------------------
      {'Name' : '', 'function' : () async {
        _triggerLoading();


        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
    ];

    super.initState();
  }
  // -----------------------------------------------------------------------
  void printResult(String verse){
    setState(() {printVerse = verse;});
    print(verse);
  }
  // -----------------------------------------------------------------------
  void _save (String flyerID, int slideIndex){

    /// --- IF FLYER WAS NEVER SAVED
    if (_flyerIsSaved(flyerID) == null){

      /// create a new SaveModel
      SaveModel _newSaveModel = SaveModel(
        flyerID: flyerID,
        slideIndexes: [slideIndex],
        saveState: SaveState.Saved,
        timeStamps: <DateTime>[DateTime.now()],
      );

      /// if userSaveModels is not initialized
      if(_userSaveModels == null || _userSaveModels.length == 0){
        setState(() {
        _userSaveModels = new List();
        _userSaveModels.add(_newSaveModel);
        });
      }
      /// if userSaveModels is initialized and have other entries
      else {
        setState(() {
        _userSaveModels.add(_newSaveModel);
        });
      }

    }
    // -----------------------------------------------
    /// --- IF FLYER WAS SAVED THEN UNSAVED OR STILL SAVED
    else {

      /// get the SlideModel from the List
      SaveModel _existingSaveModel = _userSaveModels.singleWhere((sm) => sm.flyerID == flyerID);

      /// overwrite slideIndex with the new one, add new timeStamp, and change state to saved
      SaveModel _updatedSaveModel = new SaveModel(
        flyerID: flyerID,
        slideIndexes: [...(_existingSaveModel.slideIndexes), slideIndex],
        saveState: _existingSaveModel.saveState == SaveState.Saved ? SaveState.UnSaved : SaveState.Saved,
        timeStamps: <DateTime>[...(_existingSaveModel.timeStamps), DateTime.now()],
      );

      /// update the List with the new Model
      int _existingSaveModelIndex = _userSaveModels.indexWhere((sm) => sm.flyerID == flyerID);
      setState(() {
      _userSaveModels.removeAt(_existingSaveModelIndex);
      _userSaveModels.insert(_existingSaveModelIndex, _updatedSaveModel);
      });
    }
    // -----------------------------------------------

  }

  bool _flyerWasSavedOnce(String flyerID){
    bool _flyerWasSavedOnce;

    /// if user's saves list is null or empty
    if (_userSaveModels == null || _userSaveModels.length == 0){
      _flyerWasSavedOnce = false;
    } else {
      /// so user's saves list have some save models
      for (int i = _userSaveModels.length - 1; i >= 0; i--){

        if (_userSaveModels[i].flyerID == flyerID){
          /// we found a saveModel for this flyerID
          _flyerWasSavedOnce = true;
          break;
        } else {
          /// we didn't find this flyer in the list
          _flyerWasSavedOnce = false;
        }
      }

    }

    return _flyerWasSavedOnce;
  }
  // ---------------------------------------------------------------------------
  bool _flyerIsSaved(String flyerID){
    bool _flyerIsSaved;

    if (_flyerWasSavedOnce(flyerID) == true){

      SaveModel _thisFlyersSaveModel = _userSaveModels.singleWhere((saveModel) => saveModel.flyerID == flyerID);

      if (_thisFlyersSaveModel.saveState == SaveState.Saved){
        _flyerIsSaved = true; // is saved
      } else {
        _flyerIsSaved = false; // was saved once but now its not
      }

    } else {
      _flyerIsSaved = null; // was never saved
    }

    return _flyerIsSaved;
  }
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    Widget _theSlides(String flyerID){

      String _flyerID = flyerID;

      bool _buttonIsOn =
      _flyerIsSaved(flyerID) == true ? true :
      _flyerIsSaved(flyerID) == false ? false :
          false;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          DreamBox(
            height: 50,
            iconSizeFactor: 0.6,
            color: _buttonIsOn ? Colorz.Yellow : Colorz.Grey,
            verse: '$_flyerID - 0',
            boxFunction: () => _save(_flyerID, 0),
          ),

          DreamBox(
            height: 50,
            iconSizeFactor: 0.6,
            color: _buttonIsOn ? Colorz.Yellow : Colorz.Grey,
            verse: '$_flyerID - 1',
            boxFunction: () => _save(_flyerID, 1),
          ),

          DreamBox(
            height: 50,
            iconSizeFactor: 0.6,
            color: _buttonIsOn ? Colorz.Yellow : Colorz.Grey,
            verse: '$_flyerID - 2',
            boxFunction: () => _save(_flyerID, 2),
          ),

        ],
      );
    }

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      pageTitle: 'Firebase Testers',
      loading: _loading,
      layoutWidget: Stack(
        children: <Widget>[

          ListView(
            children: <Widget>[

              Stratosphere(),

              ...List.generate(
                  functions.length, (index){
                return
                  DreamBox(
                    height: 60,
                    width: 300,
                    boxMargins: EdgeInsets.all(5),
                    verseMaxLines: 3,
                    verseScaleFactor: 0.7,
                    verse: functions[index]['Name'],
                    color: Colorz.BloodTest,
                    boxFunction: functions[index]['function'],
                  );
              }),

              _theSlides('flyerA'),

              _theSlides('flyerB'),

              _theSlides('flyerC'),

              if (_userSaveModels != null)
              ...List.generate(_userSaveModels.length, (index){

                SaveModel _save = _userSaveModels[index];

                return
                  SuperVerse(
                    verse: '${_save.flyerID}-${_save.slideIndexes[_save.slideIndexes.length-1]} '
                        ': ${_save.saveState}\n'
                        '${TextGenerator.hourMinuteSecondListOfStringsWithIndexes(_save.timeStamps, _save.slideIndexes)}',
                    margin: 10,
                    labelColor: Colorz.WhiteGlass,
                    weight: VerseWeight.thin,
                    size: 2,
                    maxLines: 10,
                  );
              }),

              if (_userSaveModels == null)
                SuperVerse(
                  verse: 'No saved Model yet !',
                  margin: 10,
                  labelColor: Colorz.WhiteGlass,
                  weight: VerseWeight.thin,
                  size: 2,
                ),


                PyramidsHorizon(heightFactor: 5,),

            ],
          ),


          Positioned(
            bottom: 0,
            child: InPyramidsBubble(
              bubbleColor: Colorz.BlackBlack,
              centered: true,
              stretchy: false,
              columnChildren: <Widget>[
                SuperVerse(
                  verse: printVerse ?? 'print Area',
                  maxLines: 12,
                  weight: VerseWeight.thin,
                  color: printVerse == null ? Colorz.WhiteGlass : Colorz.White,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
