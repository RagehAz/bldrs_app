import 'dart:io';
import 'package:bldrs/controllers/drafters/file_formatters.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/search_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  // ---------------------------------------------------------------------------
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
  // ---------------------------------------------------------------------------
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

    List<Widget> _savesWidgets(List<SaveModel> savesModels){
      return <Widget>[

        if (savesModels != null)
          ...List.generate(savesModels.length, (index){

            SaveModel _save = savesModels[index];

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

        if (savesModels == null)
          SuperVerse(
            verse: 'No saved Model yet !',
            margin: 10,
            labelColor: Colorz.WhiteGlass,
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
      {'Name' : '-----------', 'function' : () async {

      },},
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
      {'Name' : 'Fix author Pic ID', 'function' : () async {
        _triggerLoading();

        /// 1 - get all bzz
        final FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
        List<TinyBz> _allTinyBzz = _prof.getAllTinyBzz;
        List<BzModel> _bzz = new List();
        for (var tinyBz in _allTinyBzz){
          BzModel _bz = await BzOps.readBzOps(
              context: context,
              bzID: tinyBz.bzID
          );
          _bzz.add(_bz);
        }

        /// 2 - loop in each bz
        for (var bz in _bzz){

          /// a - loop in each author
          List<AuthorModel> _originalAuthors = bz.bzAuthors;
          List<AuthorModel> _updatedAuthorsModels = new List();
          List<NanoFlyer> _bzFlyers = bz.bzFlyers;

          for (var author in _originalAuthors){

            String _pic = author.authorPic;
            String _newURL;

            /// x1 - create new url
            if (ObjectChecker.objectIsURL(_pic) == true) {
              File _file = await urlToFile(_pic);
              _newURL = await Fire.createStoragePicAndGetURL(
                context: context,
                picType: PicType.authorPic,
                fileName: AuthorModel.generateAuthorPicID(author.userID, bz.bzID),
                inputFile: _file,
              );
            }
            else {
              _newURL = await Fire.createStoragePicFromAssetAndGetURL(
                context: context,
                picType: PicType.authorPic,
                fileName: AuthorModel.generateAuthorPicID(author.userID, bz.bzID),
                asset: _pic,
              );
            }

            /// x2 - create new AuthorModel and add it to new _authorsModels
            AuthorModel _newAuthor = AuthorModel(
              userID : author.userID,
              authorName : author.authorName,
              authorPic : _newURL,
              authorTitle : author.authorTitle,
              authorIsMaster : author.authorIsMaster,
              authorContacts : author.authorContacts,
            );

            _updatedAuthorsModels.add(_newAuthor);

            /// x3 - update tinyAuthor in all bz Flyers
            TinyUser _tinyAuthor = AuthorModel.getTinyAuthorFromAuthorModel(_newAuthor);
            for (var flyer in _bzFlyers){
              if (_tinyAuthor.userID == flyer.authorID){

                /// -- update tiny author in flyers
                await Fire.updateDocField(
                  context: context,
                  collName: FireCollection.flyers,
                  docName: flyer.flyerID,
                  field: 'tinyAuthor',
                  input: _tinyAuthor.toMap(),
                );

              }
            }

          }

          /// b - update the new authors in bz doc
          await Fire.updateDocField(
            context: context,
            collName: FireCollection.bzz,
            docName: bz.bzID,
            field: 'bzAuthors',
            input: AuthorModel.cipherAuthorsModels(_updatedAuthorsModels),
          );


        }

        printResult('_tinyFlyers are ${_bzz.length}');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'upload local asset and get URL', 'function' : () async {
        _triggerLoading();

        String _url = await Fire.createStoragePicFromAssetAndGetURL(
          context: context,
          picType: PicType.authorPic,
          fileName: 'ASSET',
          asset: Dumz.XXhsi_1,
        );

        setState(() {
          _picURL = _url;
        });

        printResult('$_url');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'get FILE from url', 'function' : () async {
        _triggerLoading();

        UserModel _user = await UserOps().readUserOps(
          context: context,
          userID: superUserID(),
        );

        File _file = await urlToFile(_user.pic);

        setState(() {
          _filePic = _file;
        });

        printResult('$_filePic');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
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
      // -----------------------------------------------------------------------
      {'Name' : 'delete firebase user with email', 'function' : () async {
        _triggerLoading();

        String _email = 'tester@bldrs.net';
        String _password = '123456';

        // await AuthOps().deleteFirebaseUser(context, _email, _password);

        printResult('Done');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'getFirebaseUserProviderData', 'function' : ()  {
        _triggerLoading();

        dynamic _thing = AuthOps().getFirebaseUserProviderData();

        printResult('$_thing');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
    ];


    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      pageTitle: 'Firebase Testers',
      loading: _loading,
      appBarRowWidgets: <Widget>[

        Expanded(child: Container(),),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'trigger loading',
          verseMaxLines: 2,
          boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarPadding),
          verseScaleFactor: 0.5,
          boxFunction: (){
            _triggerLoading();
          },
        ),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'Clear Print',
          verseMaxLines: 2,
          boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarPadding),
          verseScaleFactor: 0.5,
          boxFunction: (){
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
                    boxMargins: EdgeInsets.all(5),
                    verseMaxLines: 3,
                    verseScaleFactor: 0.7,
                    verse: functions[index]['Name'],
                    color: Colorz.BloodTest,
                    boxFunction: functions[index]['function'],
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
                color: Colorz.WhiteGlass,
                corners: 0,
                boxMargins: EdgeInsets.symmetric(vertical: 10),
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
                color: Colorz.BabyBlue,
              ),


                PyramidsHorizon(heightFactor: 10,),

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
