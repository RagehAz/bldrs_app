import 'dart:io';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/search_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/records/save_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Firebasetesting extends StatefulWidget {

  @override
  _FirebasetestingState createState() => _FirebasetestingState();
}

class _FirebasetestingState extends State<Firebasetesting> {
  // List<Map<String, Object>> functions;
  String printVerse;
  File _dumFile;
  String _dumURL;
  List<SaveModel> _userSavesModels;
  Map<String, dynamic> _userSavesMap;
  List<SaveModel> _decipheredSavesModels;
  List<TinyFlyer> _tinyFlyers;
  List<FlyerModel> _allFLyers;
  String _picURL;
  File _filePic;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();
  }
// -----------------------------------------------------------------------------
  void printResult(String verse){
    setState(() {printVerse = verse;});
    print(verse);
  }
// -----------------------------------------------------------------------------
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
      if(_userSavesModels == null || _userSavesModels.length == 0){
        setState(() {
        _userSavesModels = new List();
        _userSavesModels.add(_newSaveModel);
        });
      }
      /// if userSaveModels is initialized and have other entries
      else {
        setState(() {
        _userSavesModels.add(_newSaveModel);
        });
      }

    }
    // -----------------------------------------------
    /// --- IF FLYER WAS SAVED THEN UNSAVED OR STILL SAVED
    else {

      /// get the SlideModel from the List
      SaveModel _existingSaveModel = _userSavesModels.singleWhere((sm) => sm.flyerID == flyerID);

      /// overwrite slideIndex with the new one, add new timeStamp, and change state to saved
      SaveModel _updatedSaveModel = new SaveModel(
        flyerID: flyerID,
        slideIndexes: [...(_existingSaveModel.slideIndexes), slideIndex],
        saveState: _existingSaveModel.saveState == SaveState.Saved ? SaveState.UnSaved : SaveState.Saved,
        timeStamps: <DateTime>[...(_existingSaveModel.timeStamps), DateTime.now()],
      );

      /// update the List with the new Model
      int _existingSaveModelIndex = _userSavesModels.indexWhere((sm) => sm.flyerID == flyerID);
      setState(() {
      _userSavesModels.removeAt(_existingSaveModelIndex);
      _userSavesModels.insert(_existingSaveModelIndex, _updatedSaveModel);
      });
    }
    // -----------------------------------------------

  }
// -----------------------------------------------------------------------------
  bool _flyerWasSavedOnce(String flyerID){
    bool _flyerWasSavedOnce;

    /// if user's saves list is null or empty
    if (_userSavesModels == null || _userSavesModels.length == 0){
      _flyerWasSavedOnce = false;
    } else {
      /// so user's saves list have some save models
      for (int i = _userSavesModels.length - 1; i >= 0; i--){

        if (_userSavesModels[i].flyerID == flyerID){
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
// -----------------------------------------------------------------------------
  bool _flyerIsSaved(String flyerID){
    bool _flyerIsSaved;

    if (_flyerWasSavedOnce(flyerID) == true){

      SaveModel _thisFlyersSaveModel = _userSavesModels.singleWhere((saveModel) => saveModel.flyerID == flyerID);

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
// -----------------------------------------------------------------------------
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
            color: _buttonIsOn ? Colorz.Yellow255 : Colorz.Grey225,
            verse: '$_flyerID - 0',
            onTap: () => _save(_flyerID, 0),
          ),

          DreamBox(
            height: 50,
            iconSizeFactor: 0.6,
            color: _buttonIsOn ? Colorz.Yellow255 : Colorz.Grey225,
            verse: '$_flyerID - 1',
            onTap: () => _save(_flyerID, 1),
          ),

          DreamBox(
            height: 50,
            iconSizeFactor: 0.6,
            color: _buttonIsOn ? Colorz.Yellow255 : Colorz.Grey225,
            verse: '$_flyerID - 2',
            onTap: () => _save(_flyerID, 2),
          ),

        ],
      );
    }

    List<Widget> _savesWidgets(List<SaveModel> savesModels){
      return <Widget>[

        if (savesModels != null)
          ...List.generate(savesModels.length, (index){

            SaveModel _save = savesModels[index];

            return
              SuperVerse(
                verse: '${_save.flyerID}-${_save.slideIndexes[_save.slideIndexes.length-1]} '
                    ': ${_save.saveState}\n'
                    '${Timers.hourMinuteSecondListOfStringsWithIndexes(_save.timeStamps, _save.slideIndexes)}',
                margin: 10,
                labelColor: Colorz.White20,
                weight: VerseWeight.thin,
                size: 2,
                maxLines: 10,
              );
          }),

        if (savesModels == null)
          SuperVerse(
            verse: 'No saved Model yet !',
            margin: 10,
            labelColor: Colorz.White20,
            weight: VerseWeight.thin,
            size: 2,
          ),

      ];

    }

    List<Map<String, dynamic>> functions = <Map<String, dynamic>>[

      {'Name' : 'Fire.readDoc', 'function' : () async {
        _triggerLoading();

        dynamic _subDoc = await Fire.readDoc(
          collName: FireCollection.flyers,
          docName: 'f005',
        );

        printResult(_subDoc.toString());

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Fire.readSubDoc', 'function' : () async {
        _triggerLoading();

        dynamic _subDoc = await Fire.readSubDoc(
          collName: 'aCOLL',
          docName: 'doc2',
          subCollName: 'subColl',
          subDocName: 'subDoc',
        );

        printResult(_subDoc.toString());

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Fire.createNamedDoc', 'function' : () async {
        _triggerLoading();

        dynamic _subDoc = await Fire.createNamedDoc(
          context: context,
          collName: 'aCOLL',
          docName: 'doc2',
          input: {'testy' : false},
        );

        printResult(_subDoc.toString());

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Fire.createNamedSubDoc', 'function' : () async {
        _triggerLoading();

        dynamic _subDoc = await Fire.createNamedSubDoc(
          context: context,
          collName: 'aCOLL',
          docName: 'doc2',
          subCollName: 'subColl',
          subDocName: 'subDoc',
          input: {'oh baby' : 'aywa ba2aaaa'},
        );

        printResult(_subDoc.toString());

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Fire.replaceDoc', 'function' : () async {
        _triggerLoading();

        await Fire.updateDoc(
          context: context,
          collName: 'aCOLL',
          docName: 'doc2',
          input: {'pop' : 'the fuckسسسس'},
        );

        printResult('done');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Fire.readSubCollectionDocs', 'function' : () async {
        _triggerLoading();

        List<dynamic> _maps = await Fire.readSubCollectionDocs(
          context: context,
          addDocsIDs: true,
          collName: 'aCOLL',
          docName: 'doc2',
          subCollName: 'subColl',
        );


        printResult(_maps[1]['id']);

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Fire.deleteSubDoc', 'function' : () async {
        _triggerLoading();

        await Fire.deleteSubDoc(
          context: context,
          collName: 'aCOLL',
          docName: 'doc2',
          subCollName: 'subColl',
          subDocName: 'subDoc',
        );

        printResult('deleted isa');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Fire.updateSubDoc', 'function' : () async {
        _triggerLoading();

        await Fire.updateSubDoc(
          context: context,
          collName: 'aCOLL',
          docName: 'doc2',
          subCollName: 'subColl',
          subDocName: 'subDoc',
          input: {
            'field 1' : 'bitch',
            'field 2' : 'slap',
          }
        );

        printResult('deleted isa');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Fire.updateSubDocField', 'function' : () async {
        _triggerLoading();

        List<String> _newList = <String>['wa7ed', 'etneen', 'talata'];

        await Fire.updateSubDocField(
          context: context,
          collName: 'aCOLL',
          docName: 'doc2',
          subCollName: 'subColl',
          subDocName: 'subDoc',
          field: 'field 4',
          input: _newList
        );

        printResult('deleted isa');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : '-----------', 'function' : () async {

      },},
// -----------------------------------------------------------------------------
      {'Name' : 'FireSearch.getDocByFieldValue', 'function' : () async {
        _triggerLoading();

        List<Map<String, dynamic>> _result = await FireSearch.mapsByFieldValue(
          context: context,
          collRef: Fire.getCollectionRef(FireCollection.flyers),
          field: 'flyerID',
          compareValue: 'f007',
          valueIs: ValueIs.EqualTo,
          addDocsIDs: true,
        );

        printResult(_result.toString());

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'read All flyers', 'function' : () async {
        _triggerLoading();

        // final FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
        // List<TinyFlyer> _allTinyFlyers = _prof.getAllTinyFlyers;

        List<dynamic> _allMaps = await Fire.readCollectionDocs(FireCollection.flyers);
        //
        List<FlyerModel> _flyers = FlyerModel.decipherFlyersMaps(_allMaps);

        List<TinyFlyer> _dbTinyFlyers = TinyFlyer.getTinyFlyersFromFlyersModels(_flyers);

        setState(() {
          _tinyFlyers = _dbTinyFlyers;
          _allFLyers = _flyers;
        });

        printResult('_tinyFlyers are ${_tinyFlyers.length}');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'create firebase user with email', 'function' : () async {
        _triggerLoading();

        String _email = 'tester@bldrs.net';
        String _password = '123456';

        final FirebaseAuth _auth = FirebaseAuth?.instance;
        UserCredential _result = await _auth.createUserWithEmailAndPassword(
            email: _email.trim(), password: _password);

        printResult('${_result.toString()}');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'delete firebase user with email', 'function' : () async {
        _triggerLoading();

        String _email = 'tester@bldrs.net';
        String _password = '123456';

        // await AuthOps().deleteFirebaseUser(context, _email, _password);

        printResult('Done');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'getFirebaseUserProviderData', 'function' : ()  {
        _triggerLoading();

        dynamic _thing = AuthOps().getFirebaseUserProviderData();

        printResult('$_thing');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'read a user that does not exist', 'function' : () async {
        _triggerLoading();

        UserModel _user = await UserOps().readUserOps(
          context: context,
          userID: 'fdfd',
        );

        printResult('$_user');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'Delete firebase user', 'function' : () async {
        _triggerLoading();

        dynamic _result = await AuthOps().deleteFirebaseUser(context, 'aI870q75S9Pt2zs77SDOZzVdlgQ2');

        printResult('$_result');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'fix user zone', 'function' : () async {
        _triggerLoading();

        List<dynamic> _allUsersMaps = await Fire.readCollectionDocs(FireCollection.users);

        for (var map in _allUsersMaps){

          String _userID = map['userID'];

          Zone _userZone = Zone(
            countryID: map['country'],
            cityID: map['province'],
            districtID: map['area'],
          );

          await Fire.updateDocField(
            context: context,
            collName: FireCollection.users,
            docName: _userID,
            field: 'zone',
            input: _userZone.toMap(),
          );

          await Fire.deleteDocField(
            context: context,
            collName: FireCollection.users,
            docName: _userID,
            field: 'country',
          );

          await Fire.deleteDocField(
            context: context,
            collName: FireCollection.users,
            docName: _userID,
            field: 'province',
          );

          await Fire.deleteDocField(
            context: context,
            collName: FireCollection.users,
            docName: _userID,
            field: 'area',
          );

        }

        // await Fire.updateDocFieldKeyValue(
        //     collName: 'aCOLL',
        //     docName: 'doc',
        //     context: context,
        //     field: 'thing',
        //     key: 'koko',
        //     input: 'it works man'
        // );


        printResult('DOne');

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'fix flyer zone strings', 'function' : () async {
        _triggerLoading();

        List<dynamic> _allMaps = await Fire.readCollectionDocs(FireCollection.bzz);


        for (var map in _allMaps){

          String _id = map['bzID'];

          dynamic _bzZone =  map['bzZone'];

          dynamic _districtID = _bzZone['areaID']; /// TASK : should change areaID to districtID in firebase

          if (await ObjectChecker.objectIsIntInString(context, _districtID) == true){
            /// so district is int,, leave it
            print('no action needed for $_id');
          } else {

            Zone _zone1 = Zone(
              countryID: 'egy',
              cityID: 'Cairo',
              districtID: '1',
            );

            await Fire.updateDocField(
              context: context,
              collName: FireCollection.bzz,
              docName: _id,
              field: 'bzZone',
              input: _zone1.toMap(),
            );

          }




          // printResult('done  : ${_bzNanoFlyers.length} : ${_flyersMaps.length} flyers');

        }


        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
      {'Name' : 'fix hany saad user and tinyUser', 'function' : () async {
        _triggerLoading();


        BzModel _bz = await BzOps.readBzOps(
          context: context,
          bzID: 'dr2',
        );

        AuthorModel _author = _bz.bzAuthors[1];

        await Fire.updateDocField(
          context: context,
          collName: FireCollection.tinyUsers,
          docName: _author.userID,
          field: 'pic',
          input: _author.authorPic,
        );

        printResult(_author.authorName);

        _triggerLoading();
      },},
// -----------------------------------------------------------------------------
    // ListOfMapsContains
    ];


    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      pageTitle: 'Firebase Testers',
      loading: _loading,
      appBarRowWidgets: <Widget>[

        Expander(),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'trigger loading',
          verseMaxLines: 2,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verseScaleFactor: 0.5,
          onTap: (){
            _triggerLoading();
          },
        ),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'Clear Print',
          verseMaxLines: 2,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verseScaleFactor: 0.5,
          onTap: (){
            printResult('');
          },
        ),

      ],
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
                    margins: const EdgeInsets.all(5),
                    verseMaxLines: 3,
                    verseScaleFactor: 0.7,
                    verse: functions[index]['Name'],
                    color: Colorz.BloodTest,
                    onTap: functions[index]['function'],
                  );
              }),

              // _theSlides('flyerA'),
              //
              // _theSlides('flyerB'),
              //
              // _theSlides('flyerC'),
              //
              // ..._savesWidgets(_userSavesModels),

              DreamBox(
                width: Scale.superScreenWidth(context) * 0.95,
                height: 2.5,
                color: Colorz.White20,
                corners: 0,
                margins: const EdgeInsets.symmetric(vertical: 10),
              ),

              // ..._savesWidgets(_decipheredSavesModels),

              SuperVerse(
                verse: _tinyFlyers == null ? 'saved flyers' : 'dbFlyers',
              ),

              if (_tinyFlyers != null)
              FlyersGrid(
                gridZoneWidth: Scale.superScreenWidth(context),
                scrollable: false,
                stratosphere: false,
                numberOfColumns: 6,
                tinyFlyers: _tinyFlyers,
              ),

                /// test url from asset
              if(_filePic !=null)
              DreamBox(
                height: 100,
                width: 100,
                // icon: _filePic,
                iconFile: _filePic,
                iconSizeFactor: 1,
                color: Colorz.Blue225,
              ),


                PyramidsHorizon(heightFactor: 10,),

            ],
          ),


          Positioned(
            bottom: 0,
            child: InPyramidsBubble(
              bubbleColor: Colorz.Black230,
              centered: true,
              stretchy: false,
              columnChildren: <Widget>[
                SuperVerse(
                  verse: printVerse ?? 'print Area',
                  maxLines: 12,
                  weight: VerseWeight.thin,
                  color: printVerse == null ? Colorz.White20 : Colorz.White255,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
