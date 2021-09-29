import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FireStorageTest extends StatefulWidget {


  @override
  _FireStorageTestState createState() => _FireStorageTestState();
}


class _FireStorageTestState extends State<FireStorageTest> {
  String printVerse;
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
  // -----------------------------------------------------------------------
  void printResult(String verse){
    setState(() {printVerse = verse;});
    print(verse);
  }
  // -----------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> functions = <Map<String, dynamic>>[

      // -----------------------------------------------------------------------
      {'Name' : 'upload test image and get URL', 'function' : () async {
        _triggerLoading();

        String _url = await Fire.createStoragePicFromLocalAssetAndGetURL(
          context: context,
          picType: PicType.askPic,
          fileName: 'test',
          asset: Iconz.DumAuthorPic,
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

        String _url = 'https://ak1.ostkcdn.com/wp-content/uploads/2017/06/highheels-hero.jpg';


        File _file = await Imagers.urlToFile(_url);

        setState(() {
          _filePic = _file;
        });

        printResult('$_filePic');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'show pic from url', 'function' : () async {
        _triggerLoading();

        String _url = 'https://cdn3.volusion.com/tuac7.56np9/v/vspfiles/photos/U-Alexa%20Black-2.jpg?v-cache=1489488288';

        setState(() {
          _picURL = _url;
        });

        printResult('$_picURL');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'create pic url from another url', 'function' : () async {
        _triggerLoading();

        // String _url = 'https://www.cleopatraegypttours.com/wp-content/uploads/2019/10/The-Ankh.jpg';


        printResult('done');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'Delete storage picture', 'function' : () async {
        _triggerLoading();

        await Fire.deleteStoragePic(
            context: context,
            fileName: 'test',
            picType: PicType.askPic
        );

        printResult('done');

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
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
          margins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verseScaleFactor: 0.4,
          onTap: (){
            _triggerLoading();
          },
        ),

        DreamBox(
          height: 35,
          width: 50,
          verse: 'Clear Print',
          verseMaxLines: 2,
          margins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verseScaleFactor: 0.4,
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
                    margins: EdgeInsets.all(5),
                    verseMaxLines: 3,
                    verseScaleFactor: 0.7,
                    verse: functions[index]['Name'],
                    color: Colorz.BloodTest,
                    onTap: functions[index]['function'],
                  );
              }),


              DreamBox(
                width: Scale.superScreenWidth(context) * 0.95,
                height: 2.5,
                color: Colorz.White20,
                corners: 0,
                margins: EdgeInsets.symmetric(vertical: 10),
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


              /// test url from asset
              if(_picURL !=null)
                DreamBox(
                  height: 100,
                  width: 100,
                  icon: _picURL,
                  iconSizeFactor: 1,
                  color: Colorz.Blue225,
                ),



              PyramidsHorizon(),

            ],
          ),


          Positioned(
            bottom: 0,
            child: Bubble(
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
