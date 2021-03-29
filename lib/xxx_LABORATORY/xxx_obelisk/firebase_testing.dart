import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
import 'package:bldrs/firestore/firebase_storage.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/author_label.dart';
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
      {'Name' : 'get user Model', 'function' : () async {

        await tryAndCatch(
          context: context,
          functions: () async {
            UserModel _user = await UserProvider(userID: superUserID()).getUserModel(superUserID());
            printResult(_user.pic);
          }
        );

      },},
      // -----------------------------------------------------------------------
      {'Name' : 'saving a reference to a firestore document', 'function' : () async {
        _triggerLoading();

        await tryAndCatch(
          context: context,
          functions: () async {
            dynamic ref = {
              'content' : 'Content ...',
              'ref' : UserCRUD().userCollectionRef().doc('/' + superUserID()),
            };

            CollectionReference _collection = _fireInstance.collection('test');

            await _collection.add(ref);
          }
        );

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'Save Asset to firestorage', 'function' : () async {

        _triggerLoading();

        String _asset = Dumz.XXhs_logo;

        String _url = await saveAssetToFireStorageAndGetURL(
          context: context,
          picType: PicType.dum,
          fileName: getFileNameFromAsset(_asset),
          asset: _asset,
        );

        setState(() {
          _dumURL = _url;
        });

        _triggerLoading();

      },
    },
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
