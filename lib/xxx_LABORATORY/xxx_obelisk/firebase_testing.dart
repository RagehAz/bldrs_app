import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/bz_ops.dart';
import 'package:bldrs/firestore/crud/flyer_ops.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
import 'package:bldrs/firestore/firebase_storage.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
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
      {'Name' : 'slides counters map creator', 'function' : () async {

        _triggerLoading();

        List<String> _list = ['bobo', 'koko', 'dodo'];

        dynamic _map = await getKeyWordsMap(_list);

        printResult(_map.toString());

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
      {'Name' : 'refactor all tiny flyers in bzz to nano flyers', 'function' : () async {

        _triggerLoading();

        List<dynamic> _allBzzMaps = await getFireStoreCollectionMaps(FireStoreCollection.bzz);
        List<OLDBzModel> _allBz = new List();

        for (var map in _allBzzMaps){

          _allBz.add(OLDdecipherBzMap(map['bzID'], map));

        }

        for (var bz in _allBz){

          List<TinyFlyer> _bzTinyFlyers = bz.bzFlyers;

          List<NanoFlyer> _finalBzNanoFlyers = new List();

          for (var tinyFlyer in _bzTinyFlyers){
            _finalBzNanoFlyers.add(
              NanoFlyer(
                  flyerID: tinyFlyer.flyerID,
                  flyerType: tinyFlyer.flyerType,
                  authorID: tinyFlyer.authorID,
                  slidePic: tinyFlyer.slidePic,
              )
            );
          }

          await updateFieldOnFirestore(
            context: context,
            collectionName: FireStoreCollection.bzz,
            documentName: bz.bzID,
            field: 'bzFlyers',
            input: cipherNanoFlyers(_finalBzNanoFlyers),
          );

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

/// delete after done
///
OLDBzModel OLDdecipherBzMap(String bzID, dynamic map){
  return OLDBzModel(
    bzID : bzID,
    // -------------------------
    bzType : decipherBzType(map['bzType']),
    bzForm : decipherBzForm(map['bzForm']),
    bldrBirth : decipherDateTimeString(map['bldrBirth']),
    accountType : decipherBzAccountType(map['accountType']),
    bzURL : map['bzURL'],
    // -------------------------
    bzName : map['bzName'],
    bzLogo : map['bzLogo'],
    bzScope : map['bzScope'],
    bzCountry : map['bzCountry'],
    bzProvince : map['bzProvince'],
    bzArea : map['bzArea'],
    bzAbout : map['bzAbout'],
    bzPosition : map['bzPosition'],
    bzContacts : decipherContactsMaps(map['bzContacts']),
    bzAuthors : decipherBzAuthorsMaps(map['bzAuthors']),
    bzShowsTeam : map['bzShowsTeam'],
    // -------------------------
    bzIsVerified : map['bzIsVerified'],
    bzAccountIsDeactivated : map['bzAccountIsDeactivated'],
    bzAccountIsBanned : map['bzAccountIsBanned'],
    // -------------------------
    bzTotalFollowers : map['bzTotalFollowers'],
    bzTotalSaves : map['bzTotalSaves'],
    bzTotalShares : map['bzTotalShares'],
    bzTotalSlides : map['bzTotalSlides'],
    bzTotalViews : map['bzTotalViews'],
    bzTotalCalls : map['bzTotalCalls'],
    // -------------------------
    bzFlyers: decipherTinyFlyersMaps(map['bzFlyers']),
  );
}

class OLDBzModel with ChangeNotifier{
  final String bzID;
  // -------------------------
  final BzType bzType;
  final BzForm bzForm;
  final DateTime bldrBirth;
  final BzAccountType accountType;
  final String bzURL;
  // -------------------------
  final String bzName;
  final dynamic bzLogo;
  final String bzScope;
  final String bzCountry; // countryID
  final String bzProvince;
  final String bzArea;// cityID
  final String bzAbout;
  final GeoPoint bzPosition;
  final List<ContactModel> bzContacts;
  final List<AuthorModel> bzAuthors;
  final bool bzShowsTeam;
  // -------------------------
  final bool bzIsVerified;
  final bool bzAccountIsDeactivated;
  final bool bzAccountIsBanned; // should use the word suspended instead
  // -------------------------
  int bzTotalFollowers;
  int bzTotalSaves;
  int bzTotalShares;
  int bzTotalSlides;
  int bzTotalViews;
  int bzTotalCalls;
  // -------------------------
  final List<TinyFlyer> bzFlyers;
// ###############################
  OLDBzModel({
    this.bzID,
    // -------------------------
    this.bzType,
    this.bzForm,
    this.bldrBirth,
    this.accountType,
    this.bzURL,
    // -------------------------
    this.bzName,
    this.bzLogo,
    this.bzScope,
    this.bzCountry,
    this.bzProvince,
    this.bzArea,
    this.bzAbout,
    this.bzPosition,
    this.bzContacts,
    this.bzAuthors,
    this.bzShowsTeam,
    // -------------------------
    this.bzIsVerified,
    this.bzAccountIsDeactivated,
    this.bzAccountIsBanned,
    // -------------------------
    this.bzTotalFollowers,
    this.bzTotalSaves,
    this.bzTotalShares,
    this.bzTotalSlides,
    this.bzTotalViews,
    this.bzTotalCalls,
    // -------------------------
    this.bzFlyers,
  });
// ###############################
  Map<String, dynamic> toMap(){
    return {
      'bzID' : bzID,
      // -------------------------
      'bzType' : cipherBzType(bzType),
      'bzForm' : cipherBzForm(bzForm),
      'bldrBirth' : cipherDateTimeToString(bldrBirth),
      'accountType' : cipherBzAccountType(accountType),
      'bzURL' : bzURL,
      // -------------------------
      'bzName' : bzName,
      'bzLogo' : bzLogo,
      'bzScope' : bzScope,
      'bzCountry' : bzCountry,
      'bzProvince' : bzProvince,
      'bzArea' : bzArea,
      'bzAbout' : bzAbout,
      'bzPosition' : bzPosition,
      'bzContacts' : cipherContactsModels(bzContacts),
      'bzAuthors' : cipherAuthorsModels(bzAuthors),
      'bzShowsTeam' : bzShowsTeam,
      // -------------------------
      'bzIsVerified' : bzIsVerified,
      'bzAccountIsDeactivated' : bzAccountIsDeactivated,
      'bzAccountIsBanned' : bzAccountIsBanned,
      // -------------------------
      'bzTotalFollowers' : bzTotalFollowers,
      'bzTotalSaves' : bzTotalSaves,
      'bzTotalShares' : bzTotalShares,
      'bzTotalSlides' : bzTotalSlides,
      'bzTotalViews' : bzTotalViews,
      'bzTotalCalls' : bzTotalCalls,
      // -------------------------
      'bzFlyers' : cipherTinyFlyers(bzFlyers),
    };
  }
}
