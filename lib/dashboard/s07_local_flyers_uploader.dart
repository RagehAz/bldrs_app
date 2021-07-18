import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/buttons/main_button.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LocalFlyersUploader extends StatefulWidget {
  @override
  _LocalFlyersUploaderState createState() => _LocalFlyersUploaderState();
}

class _LocalFlyersUploaderState extends State<LocalFlyersUploader> {
  String _userID;

  int _bzzLength = 0;
  int _currentBzIndex = 0;
  String _currentBzName = '  ';
  String _currentBzID = '  ';
  int _flyersLength = 0;
  int _currentFlyerIndex = 0;
  String _currentFlyerTitle = '  ';
  String _currentFlyerID = '  ';
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
    _userID = superUserID();
    super.initState();
  }
  // -----------------------------------------------------------------------------
// void _doBz(int length, int index, String name, String id){
//     setState(() {
//       _bzzLength = length;
//       _currentBzIndex = index;
//       _currentBzName = name;
//       _currentBzIndex = index;
//     });
// }
// -----------------------------------------------------------------------------
//   void _doFlyer(int length, int index, String title, String id){
//     setState(() {
//       _flyersLength = length;
//       _currentFlyerIndex = index;
//       _currentFlyerTitle = title;
//       _currentFlyerIndex = index;
//     });
//   }
  // -----------------------------------------------------------------------------

//   Future<void> _upload(UserModel userModel) async {
//   print('starting upload ---------------------------------');
//     _triggerLoading();
//
//     List<BzModel> _localBzz = dbBzz;
//     List<FlyerModel> _localFlyers = dbFlyers;
//     List<dynamic> _localBzzIDs = [];
//     int _bi = 17;
//     int _fi = 0;
//     int _batchLength = 5;
//
//     /// upload all bzz ops without their tiny flyers
//
//   for (int i = _bi; i< _batchLength+_bi ; i++ ){
//
//     BzModel bz = _localBzz[i];
//
//     _doBz(_localBzz.length, _bi, bz.bzName, bz.bzID);
//
//     if(userModel.myBzzIDs.contains(bz.bzID) || i >= _localBzz.length){
//
//       print('skipping bz ${bz.bzID}');
//
//     } else {
//
//
//       /// save logo to fireStorage and get its URL
//       String _bzLogoURL = await savePicOnFirebaseStorageAndGetURL(
//           context: context,
//           fileName: bz.bzID,
//           picType: PicType.bzLogo,
//           inputFile: await getImageFileFromAssets(context, bz.bzLogo)
//       );
//
//       /// create master author model in a list
//       List<AuthorModel> _updatedAuthors = [
//         AuthorModel(
//           userID: _userID,
//           authorName: userModel.name,
//           authorPic: userModel.pic,
//           authorTitle: userModel.title  ,
//           authorIsMaster: true,
//           authorContacts: userModel.contacts,
//         )];
//
//       /// create final bzModel
//       BzModel _bzModel = BzModel(
//         bzID: bz.bzID,
//         // -------------------------
//         bzType: bz.bzType,
//         bzForm: bz.bzForm,
//         bldrBirth: DateTime.now(),
//         accountType: bz.accountType,
//         bzURL: bz.bzURL,
//         // -------------------------
//         bzName: bz.bzName,
//         bzLogo: _bzLogoURL,
//         bzScope: bz.bzScope,
//         bzCountry: bz.bzCountry,
//         bzProvince: bz.bzProvince,
//         bzArea: bz.bzArea,
//         bzAbout: bz.bzAbout,
//         bzPosition: bz.bzPosition,
//         bzContacts: bz.bzContacts,
//         bzAuthors: _updatedAuthors,
//         bzShowsTeam: bz.bzShowsTeam,
//         // -------------------------
//         bzIsVerified: bz.bzIsVerified,
//         bzAccountIsDeactivated: bz.bzAccountIsDeactivated,
//         bzAccountIsBanned: bz.bzAccountIsBanned,
//         // -------------------------
//         bzTotalFollowers: bz.bzTotalFollowers,
//         bzTotalSaves: bz.bzTotalSaves,
//         bzTotalShares: bz.bzTotalShares,
//         bzTotalSlides: bz.bzTotalSlides,
//         bzTotalViews: bz.bzTotalViews,
//         bzTotalCalls: bz.bzTotalCalls,
//         // -------------------------
//         nanoFlyers: [], // will update this after uploading flyers
//       );
//
//       /// upload the new bz to FireStore
//       await createFireStoreNamedDocument(
//         context: context,
//         collectionName: FireCollection.bzz,
//         docName: bz.bzID,
//         input: _bzModel.toMap(),
//       );
//
//       /// create TinyBz
//       TinyBz _tinyBz = TinyBz.getTinyBzFromBzModel(_bzModel);
//
//       /// upload the new tiny bz to FireStore
//       await createFireStoreNamedDocument(
//         context: context,
//         collectionName: FireCollection.tinyBzz,
//         docName: bz.bzID,
//         input: _tinyBz.toMap(),
//       );
//
//
//       /// add _bzID to users existing list
//       List<dynamic> _userBzzIDs = await getFireStoreDocumentField(
//         collectionName: FireCollection.users,
//         documentName: superUserID(),
//         fieldName: 'myBzzIDs',
//       );
//       _userBzzIDs.add(bz.bzID);
//
//       await updateFieldOnFirestore(
//         context: context,
//         collectionName: FireCollection.users,
//         documentName: _userID,
//         field: 'myBzzIDs',
//         input: _userBzzIDs,
//       );
//
//       /// for every tiny flyer in bz.tinyFlyers,, will start create flyer ops
//       for (var tinyFlyer in bz.nanoFlyers){
//
//         _doFlyer(bz.nanoFlyers.length, _fi, flyerTypeSingleStringer(context, tinyFlyer.flyerType), tinyFlyer.flyerID);
//
//         /// get flyer
//         FlyerModel _flyer = geebFlyerByFlyerID(tinyFlyer.flyerID);
//
//         /// convert flyer slide pics to files
//         List<SlideModel> _updatedSlides = new List();
//         for (var slide in _flyer.slides){
//           _updatedSlides.add(
//               SlideModel(
//                 slideIndex: slide.slideIndex,
//                 picture: await getImageFileFromAssets(context, slide.picture),
//                 headline: slide.headline,
//                 description: slide.description,
//                 sharesCount: slide.sharesCount,
//                 viewsCount: slide.viewsCount,
//                 savesCount: slide.savesCount,
//               )
//           );
//         }
//
//         TinyUser _tinyAuthor = TinyUser(
//           userID: _userID,
//           name: userModel.name,
//           title: userModel.title,
//           pic: userModel.pic,
//           userStatus: userModel.userStatus,
//           contact: getAContactValueFromContacts(userModel.contacts, ContactType.Phone),
//         );
//
//         /// create final flyer model
//         FlyerModel _finalFlyer = FlyerModel(
//           flyerID: _flyer.flyerID,
//           flyerType: _flyer.flyerType,
//           flyerState: _flyer.flyerState,
//           keyWords: _flyer.keyWords,
//           flyerShowsAuthor: _flyer.flyerShowsAuthor,
//           flyerURL: _flyer.flyerURL,
//           tinyAuthor: _tinyAuthor,
//           tinyBz: _tinyBz,
//           publishTime: DateTime.now(),
//           flyerPosition: _flyer.flyerPosition,
//           ankhIsOn: _flyer.ankhIsOn,
//           slides: _updatedSlides,
//         );
//
//         /// start create flyer ops
//         await createNamedFlyersOps(context, _finalFlyer, _bzModel);
//
//         print('uploaded flyer:${_finalFlyer.flyerID}');
//       }
//
//       print('uploaded bz:${bz.bzID}');
//
//     }  }
//
//       await superDialog(context, 'Congratulations', 'Great');
//
//   _triggerLoading();
//   print('upload finished ---------------------------------');
//
// }
  // -----------------------------------------------------------------------------
//   Future<void> _fixUserBzzIDsList() async {
//
//   /// add _bzID to users existing list
//   List<dynamic> _userBzzIDs = await getFireStoreDocumentField(
//     collectionName: FireCollection.users,
//     documentName: superUserID(),
//     fieldName: 'myBzzIDs',
//   );
//   List<String> _finalBzzIDsList = new List();
//
//   _userBzzIDs.forEach((id) {
//     if (_finalBzzIDsList.contains(id)){
//       print('skip $id');
//     } else {
//       _finalBzzIDsList.add(id);
//     }
//   });
//
//
//   await updateFieldOnFirestore(
//       context: context,
//       collectionName: FireCollection.users,
//       documentName: _userID,
//       field: 'myBzzIDs',
//       input: _finalBzzIDsList,
//   );
//
//   setState(() {});
//
//   await superDialog(context, 'Congratulations', 'Great');
// }


  @override
  Widget build(BuildContext context) {
    return MainLayout(
      loading: _loading,
      // appBarBackButton: true,
      pageTitle: 'Local Bzz & Flyers Uploader',
      pyramids: Iconz.PyramidsYellow,
      appBarType: AppBarType.Basic,
      sky: Sky.Black,
      tappingRageh: () async {
        _triggerLoading();

        // print(dbBzz.length);

        _triggerLoading();
      },
      layoutWidget:
      ListView(
        children: <Widget>[

          Stratosphere(),

          SuperVerse(
            verse: 'This Page will upload The Hard coded flyers and bzz to this user $_userID on firestore',
            maxLines: 5,
            size: 2,
            labelColor: Colorz.Black230,
            margin: 10,
          ),

          /// bzz progress
          Progressor(
            title: 'Bzz',
            length: _bzzLength,
            index: _currentBzIndex,
            name: _currentBzName,
            id: _currentBzID,
            goingNext: true,
          ),

          /// flyers progress bar
          Progressor(
            title: 'Flyers',
            length: _flyersLength,
            index: _currentFlyerIndex,
            name: _currentFlyerTitle,
            id: _currentFlyerID,
            goingNext: true,
          ),


          // MyDreamBox(
          //   upload: (userModel) => _upload(userModel),
          // ),


          PyramidsHorizon(heightFactor: 5,),

        ],

      ),



    );
  }
}

// -----------------------------------------------------------------------------
/// create empty firestore flyer doc and return flyerID 'docID'
Future<FlyerModel> createNamedFlyersOps(BuildContext context, FlyerModel inputFlyerModel, BzModel bzModel) async {

  print('1- staring create flyer ops');

  /// create empty firestore flyer document to get back _flyerID
  DocumentReference _docRef = await Fire.createNamedDoc(
    context: context,
    collName: FireCollection.flyers,
    docName: inputFlyerModel.flyerID,
    input: {},
  );
  String _flyerID = _docRef.id;

  print('2- flyer doc ID created : $_flyerID');

  /// save slide pictures on fireStorage and get back their URLs
  List<String> _picturesURLs = await Fire.createStorageSlidePicsAndGetURLs(
      context: context,
      slides: inputFlyerModel.slides,
      flyerID: _flyerID
  );

  print('3- _picturesURLs created index 0 is : ${_picturesURLs[0]}');

  /// update slides with URLs
  List<SlideModel> _updatedSlides = await SlideModel.replaceSlidesPicturesWithNewURLs(_picturesURLs, inputFlyerModel.slides);

  print('4- slides updated with URLs');

  /// TASK : generate flyerURL
  String _flyerURL = 'www.bldrs.net' ;

  /// update FlyerModel with newSlides & flyerURL
  FlyerModel _finalFlyerModel = FlyerModel(
    flyerID: _flyerID,
    // -------------------------
    flyerType: inputFlyerModel.flyerType,
    flyerState: inputFlyerModel.flyerState,
    keyWords: inputFlyerModel.keyWords,
    flyerShowsAuthor: inputFlyerModel.flyerShowsAuthor,
    flyerURL: _flyerURL,
    flyerZone: inputFlyerModel.flyerZone,
    // -------------------------
    tinyAuthor: inputFlyerModel.tinyAuthor,
    tinyBz: inputFlyerModel.tinyBz,
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: inputFlyerModel.flyerPosition,
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: _updatedSlides,
    flyerIsBanned: inputFlyerModel.flyerIsBanned,
    deletionTime: inputFlyerModel.deletionTime,
  );

  print('5- flyer model updated with flyerID, flyerURL & updates slides pic URLs');

  /// replace empty flyer document with the new refactored one _finalFlyerModel
  await Fire.updateDoc(
    context: context,
    collName: FireCollection.flyers,
    docName: _flyerID,
    input: _finalFlyerModel.toMap(),
  );

  print('6- flyer model added to flyers/$_flyerID');

  /// add new TinyFlyer in firestore
  TinyFlyer _finalTinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(_finalFlyerModel);
  await Fire.createNamedDoc(
    context: context,
    collName: FireCollection.tinyFlyers,
    docName: _flyerID,
    input: _finalTinyFlyer.toMap(),
  );

  print('7- Tiny flyer model added to tinyFlyers/$_flyerID');

  /// add new flyerKeys in fireStore
  /// TASK : perform string.toLowerCase() on each string before upload
  await Fire.createNamedDoc(
    context: context,
    collName: FireCollection.flyersKeys,
    docName: _flyerID,
    input: await getKeyWordsMap(_finalFlyerModel.keyWords),
  );

  print('8- flyer keys add');

  /// add flyer counters sub collection and document in flyer store
  await Fire.createNamedSubDoc(
    context: context,
    collName: FireCollection.flyers,
    docName: _flyerID,
    subCollName: FireCollection.subFlyerCounters,
    subDocName: FireCollection.subFlyerCounters,
    input: await SlideModel.cipherSlidesCounters(_updatedSlides),
  );

  print('9- flyer counters added');

  /// add nano flyer to bz document in 'tinyFlyers' field
  List<NanoFlyer> _bzNanoFlyers = bzModel.nanoFlyers;
  NanoFlyer _nanoFlyer = NanoFlyer.getNanoFlyerFromFlyerModel(_finalFlyerModel);
  _bzNanoFlyers.add(_nanoFlyer);
  await Fire.updateDocField(
    context: context,
    collName: FireCollection.bzz,
    docName: _finalFlyerModel.tinyBz.bzID,
    field: 'nanoFlyers',
    input: NanoFlyer.cipherNanoFlyers(_bzNanoFlyers),
  );

  print('10- tiny flyer added to bzID in bzz/${_finalFlyerModel.tinyBz.bzID}');

  return _finalFlyerModel;
}
// ----------------------------------------------------------------------
class Progressor extends StatelessWidget {
  final String title;
  final int length;
  final int index;
  final String name;
  final String id;
  final bool goingNext;

  Progressor({
    @required this.title,
    @required this.length,
    @required this.index,
    @required this.name,
    @required this.id,
    @required this.goingNext,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: Scale.superScreenWidth(context),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colorz.White20,
        borderRadius: Borderers.superBorderAll(context, 5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SuperVerse(
              verse: '$title : $name : $id',
              size: 2,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SuperVerse(
              verse: 'completed ${index+1} / $length',
              size: 1,
              weight: VerseWeight.thin,
            ),
          ),

          ProgressBar(
            flyerZoneWidth: Scale.superScreenWidth(context),
            numberOfStrips: length,
            barIsOn: true,
            slideIndex: index,
            margins: const EdgeInsets.all(5),
            swipeDirection: SwipeDirection.next,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
            child: SuperVerse(
              verse: 'currently progressing in [ ${index+1}-$name ]',
              size: 1,
              maxLines: 2,
              centered: false,
            ),
          ),

        ],
      ),
    );
  }
}

class MyDreamBox extends StatelessWidget {
  final Function upload;

  MyDreamBox({
    @required this.upload
});

  @override
  Widget build(BuildContext context) {
    return userModelBuilder(
        userID: superUserID(),
        context: context,
        builder: (ctx, UserModel userModel){

          // List<String> _bzzIDs = [];
          // userModel.myBzzIDs.forEach((id) {_bzzIDs.add(id); });
          return Column(
            children: <Widget>[


              MainButton(
                buttonVerse: 'Upload ya basha to user : ${superUserID()}',
                buttonIcon: null,
                buttonColor: Colorz.Yellow255,
                splashColor: Colorz.White255,
                stretched: false,
                function: () => upload(userModel),
              ),



              DreamBox(
                height: 40,
                verse: userModel.name,
                icon: userModel.pic,
              ),

              KeywordsBubble(
                title: '${userModel.name} ${userModel?.myBzzIDs?.length} bzz IDs list',
                keywords: userModel?.myBzzIDs ?? [],
                verseSize: 2,
                onTap: (){},
                bubbles: false,
                bubbleColor: Colorz.White20,
                selectedWords: [],
              ),

            ],
          );
        }
    );
  }
}


