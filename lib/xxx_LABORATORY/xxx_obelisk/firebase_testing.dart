import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
import 'package:bldrs/firestore/firebase_storage.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_temp_hard_database/dumz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firebasetesting extends StatefulWidget {

  @override
  _FirebasetestingState createState() => _FirebasetestingState();
}

class _FirebasetestingState extends State<Firebasetesting> {
  List<Map<String, Object>> functions;
  String printVerse;
  File _dumFile;
  String _dumURL;
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
      // {'Name' : 'get user Model', 'function' : () async {
      //
      //   await tryAndCatch(
      //     context: context,
      //     functions: () async {
      //       UserModel _user = await UserProvider(userID: superUserID()).getUserModel(superUserID());
      //       printResult(_user.pic);
      //     }
      //   );
      //
      // },},
      // -----------------------------------------------------------------------
      // {'Name' : 'saving a reference to a firestore document', 'function' : () async {
      //   _triggerLoading();
      //
      //   await tryAndCatch(
      //     context: context,
      //     functions: () async {
      //       dynamic ref = {
      //         'content' : 'Content ...',
      //         'ref' : UserCRUD().userCollectionRef().doc('/' + superUserID()),
      //       };
      //
      //       CollectionReference _collection = _fireInstance.collection('test');
      //
      //       await _collection.add(ref);
      //     }
      //   );
      //
      //   _triggerLoading();
      // },},
      // -----------------------------------------------------------------------
    //   {'Name' : 'Save Asset to firestorage', 'function' : () async {
    //
    //     _triggerLoading();
    //
    //     String _asset = Dumz.XXhs_logo;
    //
    //     String _url = await saveAssetToFireStorageAndGetURL(
    //       context: context,
    //       picType: PicType.dum,
    //       fileName: getFileNameFromAsset(_asset),
    //       asset: _asset,
    //     );
    //
    //     setState(() {
    //       _dumURL = _url;
    //     });
    //
    //     _triggerLoading();
    //
    //   },
    // },
      // -----------------------------------------------------------------------
      // {'Name' : 'slides counters map creator', 'function' : () async {
      //
      //   _triggerLoading();
      //
      //   List<String> _list = ['bobo', 'koko', 'dodo'];
      //
      //   dynamic _map = await getKeyWordsMap(_list);
      //
      //   printResult(_map.toString());
      //
      //   _triggerLoading();
      // },},
      // -----------------------------------------------------------------------
      // {'Name' : 'add contact to tiny user in flyers', 'function' : () async {
      //   _triggerLoading();
      //
      //   List<dynamic> _flyersMaps = await getFireStoreCollectionMaps(FireStoreCollection.flyers);
      //   List<FlyerModel> _fixedFlyers = new List();
      //
      //   // printResult(_fixedFlyer.tinyAuthor.name);
      //
      //   for (var map in _flyersMaps){
      //
      //     FlyerModel _fixedFlyer = FlyerModel(
      //       flyerID: map['flyerID'],
      //       // -------------------------
      //       flyerType: decipherFlyerType(map['flyerType']),
      //       flyerState: decipherFlyerState(map['flyerState']),
      //       keyWords: map['keyWords'],
      //       flyerShowsAuthor: map['flyerShowsAuthor'],
      //       flyerURL: map['flyerURL'],
      //       // -------------------------
      //       tinyAuthor: TinyUser(
      //         userID: map['tinyAuthor']['userID'],
      //         name: map['tinyAuthor']['name'],
      //         title: map['tinyAuthor']['title'],
      //         pic: map['tinyAuthor']['pic'],
      //         userStatus: decipherUserStatus(map['tinyAuthor']['userStatus']),
      //         contact: '015545551107',
      //       ),
      //       tinyBz: TinyBz.decipherTinyBzMap(map['tinyBz']),
      //       // -------------------------
      //       publishTime: decipherDateTimeString(map['publishTime']),
      //       flyerPosition: map['flyerPosition'],
      //       // -------------------------
      //       slides: decipherSlidesMaps(map['slides']),
      //     );
      //
      //     await replaceFirestoreDocument(
      //       context: context,
      //       collectionName: FireStoreCollection.flyers,
      //       docName: _fixedFlyer.flyerID,
      //       input: _fixedFlyer.toMap(),
      //     );
      //
      //   }
      //
      //   _triggerLoading();
      // },},
      // -----------------------------------------------------------------------
      {'Name' : 'inster new tinybz in all tinyFlyers', 'function' : () async {
        _triggerLoading();

        List<dynamic> _tinyFlyersMaps = await getFireStoreCollectionMaps(FireStoreCollection.tinyFlyers);


          int i = 0;

        for (var map in _tinyFlyersMaps){

          String _bzID = map['tinyBz']['bzID'];

          dynamic _tinyBzMap = await getFireStoreDocumentMap(
            collectionName: FireStoreCollection.tinyBzz,
            documentName: _bzID,
          );

          TinyFlyer _fixedTinyFlyer = TinyFlyer(
            flyerID: map['flyerID'],
            flyerType: decipherFlyerType(map['flyerType']),
            authorID: map['authorID'],
            slideIndex: map['slideIndex'],
            slidePic: map['slidePic'],
            tinyBz: TinyBz.decipherTinyBzMap(_tinyBzMap),
          );

          printResult(_fixedTinyFlyer.flyerID);

          await replaceFirestoreDocument(
            context: context,
            collectionName: FireStoreCollection.tinyFlyers,
            docName: _fixedTinyFlyer.flyerID,
            input: _fixedTinyFlyer.toMap(),
          );

          i++;

        }

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
  @override
  Widget build(BuildContext context) {


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

              DreamBox(
                height: 50,
                width: 50,
                iconFile: _dumFile,
                color: Colorz.Grey,
                // verse: 'wtf',
                boxFunction: (){
                },
              ),



              DreamBox(
                height: 100,
                width: 100,
                icon: _dumURL,
                color: Colorz.Grey,
                // verse: 'wtf',
                boxFunction: (){

                },
              ),



              PyramidsHorizon(),

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
