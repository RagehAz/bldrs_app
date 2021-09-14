import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class RandomTestSpace extends StatefulWidget {
final double flyerZoneWidth;

RandomTestSpace({
  @required this.flyerZoneWidth,
});

  @override
  _RandomTestSpaceState createState() => _RandomTestSpaceState();
}

class _RandomTestSpaceState extends State<RandomTestSpace> {
  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here

        _triggerLoading(
          function: (){
            /// set new values here
          }
        );
      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;


    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },

      appBarRowWidgets: <Widget>[

        DreamBox(
            height: 40,
            width: 100,
            color: Colorz.BloodTest,
            verse: 'create',
            verseMaxLines: 2,
            verseScaleFactor: 0.6,
            onTap: () async {

              print(' staring sub field update test');

              await Fire.createNamedDoc(
                context: context,
                collName: FireCollection.admin,
                docName: 'test',
                input: {
                  'key1' : 'value1',
                  'key2' : 'value2',
                  'key3' : {
                    '0': {
                      'sub1' : 'x',
                      'sub2' : 'a',
                      'sub3' : '2',
                    }
                    ,
                    '1': {
                      'sub1' : 'd',
                      'sub2' : 'f',
                      'sub3' : 'v',
                    }
                    ,
                    '2': {
                      'sub1' : 't',
                      'sub2' : 'h',
                      'sub3' : 'j',
                    }
                  },
                }
              );

              print('test finished el7amdolellah');

            }
        ),


        DreamBox(
          height: 40,
          width: 100,
          margins: 5,
          color: Colorz.BloodTest,
          verse: 'update',
          verseMaxLines: 2,
          verseScaleFactor: 0.6,
          onTap: () async {

            print(' staring sub field update test');

            await Fire.updateDocField(
              context: context,
              collName: FireCollection.admin,
              docName: 'test',
              field: 'key3.1.sub2',
              input: 'koko',
            );


            print('test finished el7amdolellah');

          }
        ),


      ],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: ScrollController(),
            children: <Widget>[

              Stratosphere(),

              DreamBox(
                height: 50,
                width: 200,
                verse: 'fix rBjNU5WybKgJXaiBnlcBnfFaQSq1',
                verseScaleFactor: 0.7,
                onTap: () async {

                  // String ragehID = superUserID();
                  // // String _oldID = 'rBjNU5WybKgJXaiBnlcBnfFaQSq1';
                  //
                  // // fix bzz
                  // List<dynamic> _bzzMaps = await Fire.readCollectionDocs(
                  //   limit: 200,
                  //   collectionName: FireCollection.bzz,
                  //   orderBy: 'bzID',
                  //   startAfter: null,
                  //   addDocSnapshotToEachMap: false,
                  // );
                  //
                  // List<BzModel> _bzz = await BzModel.decipherBzzMapsFromFireStore(_bzzMaps);
                  //
                  // List<BzModel> _myBzz = [];
                  //
                  // for (var bz in _bzz){
                  //   if (bz.authorsIDs.contains(ragehID) == true){
                  //     print('bz is : ${bz.bzID}');
                  //     _myBzz.add(bz);
                  //   }
                  //   else {
                  //     print('not ${bz.bzID} -> authors are ${bz.authorsIDs.toString()}');
                  //   }
                  // }
                  //
                  // /// fix my bzz
                  // for (var biz in _myBzz){
                  //
                  //   print('working on ${biz.bzID}');
                  //
                  //   // AuthorModel _rbjAuthor = AuthorModel.getAuthorFromBzByAuthorID(biz, _oldID);
                  //   // AuthorModel _ragehAuthor = AuthorModel(
                  //   //   userID: ragehID,
                  //   //   authorName: _rbjAuthor.authorName,
                  //   //   authorPic: _rbjAuthor.authorPic,
                  //   //   authorTitle: _rbjAuthor.authorTitle,
                  //   //   authorIsMaster: true,
                  //   //   authorContacts: _rbjAuthor.authorContacts,
                  //   // );
                  //
                  //   // List<String> _newIDs = AuthorModel.replaceAuthorIDInAuthorsIDsList(
                  //   //   originalAuthors: biz.bzAuthors,
                  //   //     oldAuthor: _rbjAuthor,
                  //   //     newAuthor: _ragehAuthor
                  //   // );
                  //   //
                  //   // List<AuthorModel> _newAuthors = AuthorModel.replaceAuthorModelInAuthorsList(
                  //   //     originalAuthors: biz.bzAuthors,
                  //   //     oldAuthor: _rbjAuthor,
                  //   //     newAuthor: _ragehAuthor
                  //   // );
                  //   //
                  //   // await Fire.updateDocField(
                  //   //   context: context,
                  //   //   collName: FireCollection.bzz,
                  //   //   docName: biz.bzID,
                  //   //   field: 'bzAuthors',
                  //   //   input: AuthorModel.cipherAuthorsModels(_newAuthors),
                  //   // );
                  //   //
                  //   // await Fire.updateDocField(
                  //   //   context: context,
                  //   //   collName: FireCollection.bzz,
                  //   //   docName: biz.bzID,
                  //   //   field: 'authorsIDs',
                  //   //   input: _newIDs,
                  //   // );
                  //
                  //   List<NanoFlyer> nanos = biz.nanoFlyers;
                  //
                  //   for (NanoFlyer nano in nanos){
                  //
                  //     FlyerModel _flyer = await FlyerOps().readFlyerOps(
                  //       context: context,
                  //       flyerID: nano.flyerID,
                  //     );
                  //
                  //     TinyUser _oldTinyAuthor = _flyer.tinyAuthor;
                  //
                  //     TinyUser _newTinyAuthor = TinyUser(
                  //       userID: ragehID,
                  //       name: _oldTinyAuthor.name,
                  //       title: _oldTinyAuthor.title,
                  //       pic: _oldTinyAuthor.pic,
                  //       userStatus: _oldTinyAuthor.userStatus,
                  //       email: _oldTinyAuthor.email,
                  //       phone: _oldTinyAuthor.phone,
                  //     );
                  //
                  //     await Fire.updateDocField(
                  //       context: context,
                  //       collName: FireCollection.flyers,
                  //       docName: nano.flyerID,
                  //       field: 'tinyAuthor',
                  //       input: _newTinyAuthor.toMap(),
                  //     );
                  //
                  //     await Fire.updateDocField(
                  //       context: context,
                  //       collName: FireCollection.tinyFlyers,
                  //       docName: nano.flyerID,
                  //       field: 'authorID',
                  //       input: ragehID,
                  //     );
                  //
                  //   }


                    // print('_newIDs : $_newIDs');

                  // }
                  //
                  // print('DONEEEEEEEEEEEEEEEEEEEE');

                },
              ),


              DreamBox(
                height: 50,
                width: 200,
                verse: 'user',
                verseScaleFactor: 0.7,
                onTap: () async {

                  String ragehID = superUserID();
                  String _oldID = 'rBjNU5WybKgJXaiBnlcBnfFaQSq1';

                  UserModel _oldUser =  await UserOps().readUserOps(
                    context: context,
                    userID: _oldID,
                  );

                  UserModel _newUser = UserModel(
                    userID: _oldUser.userID,
                    authBy: _oldUser.authBy,
                    joinedAt: _oldUser.joinedAt,
                    userStatus: _oldUser.userStatus,
                    name: _oldUser.name,
                    pic: _oldUser.pic,
                    title: _oldUser.title,
                    company: _oldUser.company,
                    gender: _oldUser.gender,
                    zone: _oldUser.zone,
                    language: _oldUser.language,
                    position: _oldUser.position,
                    contacts: _oldUser.contacts,
                    myBzzIDs: _oldUser.myBzzIDs,
                    emailIsVerified: _oldUser.emailIsVerified,
                    isAdmin: _oldUser.isAdmin,
                    fcmToken: _oldUser.fcmToken,
                  );

                  await Fire.updateDoc(
                    context: context,
                    collName: FireCollection.users,
                    docName: ragehID,
                    input: _newUser.toMap(),
                  );

                  _newUser.printUserModel(methodName: 'KKKK');

                },
              ),

            ],
          ),
        ),
      ),
    );
  }

}

/*

clean cdCn0xNwoGaxWOgTc3gvN6sr6BH2
qEmHQl1d5wM0lORHSGopNhFvkg82
OhkyYuCTdOX6X3pnOPUc6kTigYH3
bFMwW4QaJqNwFznjtg6YoZ5jMmC2

 */