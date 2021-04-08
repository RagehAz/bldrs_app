import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/crud/flyer_ops.dart';
import 'package:bldrs/firestore/firebase_storage.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer_model.dart';
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
      {'Name' : 'add pic to fireStorage', 'function' : () async {
        _triggerLoading();

        File _file = await takeGalleryPicture(PicType.askPic);

        await savePicOnFirebaseStorageAndGetURL(
          context: context,
          picType: PicType.askPic,
          inputFile: _file,
          fileName: 'highSky',
        );

        printResult('Added');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'delete pic from fireStorage', 'function' : () async {
        _triggerLoading();

        await deleteFireBaseStoragePic(
          context: context,
          picType: PicType.askPic,
          fileName: 'highSky',
        );

        printResult('Deleted');

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
