import 'package:bldrs/controllers/drafters/file_formatters.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/crud/bz_ops.dart';
import 'package:bldrs/firestore/crud/flyer_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/flyers_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// Should include all user firestore operations
/// except reading data for widgets injection
class UserCRUD{
// -----------------------------------------------------------------------------
  /// user firestore collection reference
  final CollectionReference _usersCollectionRef = Fire.getCollectionRef(FireCollection.users);
// -----------------------------------------------------------------------------
  /// users firestore collection reference getter
  CollectionReference userCollectionRef(){
    return
      _usersCollectionRef;
  }
// -----------------------------------------------------------------------------
  /// user firestore document reference
  DocumentReference userDocRef(String userID){
    return
      Fire.getDocRef(FireCollection.users, userID);
  }
// -----------------------------------------------------------------------------
  Future<UserModel> readUserOps({BuildContext context, String userID}) async {

    Map<String, dynamic> _userMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.users,
      docName: userID,
    );

    UserModel _user = UserModel.decipherUserMap(_userMap);

    return _user;
  }
// -----------------------------------------------------------------------------
  /// create or update user document
  Future<void> _createOrUpdateUserDoc({BuildContext context, UserModel userModel}) async {

    await Fire.updateDoc(
      context: context,
      collName: FireCollection.users,
      docName: userModel.userID,
      input: userModel.toMap(),
    );

}
// -----------------------------------------------------------------------------
  Future<void> createUserOps({BuildContext context, UserModel userModel}) async {

    /// check if user pic is file to upload or URL from facebook to keep
    String _userPicURL;
    if (ObjectChecker.objectIsFile(userModel.pic) == true){
      _userPicURL = await Fire.createStoragePicAndGetURL(
            context: context,
            inputFile: userModel.pic,
            fileName: userModel.userID,
            picType: PicType.userPic
        );
    }

    /// create final UserModel
    UserModel _finalUserModel = UserModel(
      userID : userModel.userID,
      joinedAt : DateTime.now(),
      userStatus : userModel.userStatus,
      // -------------------------
      name : userModel.name,
      pic : _userPicURL ?? userModel.pic,
      title : userModel.title,
      company : userModel.company,
      gender : userModel.gender,
      country : userModel.country,
      province : userModel.province,
      area : userModel.area,
      language : userModel.language,
      position : userModel.position,
      contacts : userModel.contacts,
      // -------------------------
      myBzzIDs : userModel.myBzzIDs,
    );

    /// create user doc in fireStore
    await _createOrUpdateUserDoc(
      context: context,
      userModel: _finalUserModel,
    );

    /// create TinyUser in firestore
    await Fire.createNamedDoc(
      context: context,
      collName: FireCollection.tinyUsers,
      docName: userModel.userID,
      input: TinyUser.getTinyUserFromUserModel(_finalUserModel).toMap(),
    );

  }
// -----------------------------------------------------------------------------
  Future<void> updateUserOps({BuildContext context, UserModel oldUserModel, UserModel updatedUserModel}) async {

    /// update picture if changed or continue without changing pic
    String _userPicURL;
    if (ObjectChecker.objectIsFile(updatedUserModel.pic) == true){
      _userPicURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: updatedUserModel.pic,
          fileName: updatedUserModel.userID,
          picType: PicType.userPic
      );
    }

    /// create final UserModel
    UserModel _finalUserModel = UserModel(
      userID : updatedUserModel.userID,
      joinedAt : oldUserModel.joinedAt,
      userStatus : updatedUserModel.userStatus,
      // -------------------------
      name : updatedUserModel.name,
      pic : _userPicURL ?? oldUserModel.pic,
      title : updatedUserModel.title,
      company : updatedUserModel.company,
      gender : updatedUserModel.gender,
      country : updatedUserModel.country,
      province : updatedUserModel.province,
      area : updatedUserModel.area,
      language : updatedUserModel.language,
      position : updatedUserModel.position,
      contacts : updatedUserModel.contacts,
      // -------------------------
      myBzzIDs : updatedUserModel.myBzzIDs,
    );

    /// update firestore user doc
    await _createOrUpdateUserDoc(
      context: context,
      userModel: _finalUserModel,
    );


    /// update tiny user if changed:-
    if (
    oldUserModel.name != updatedUserModel.name ||
    oldUserModel.title != updatedUserModel.title ||
    oldUserModel.pic != updatedUserModel.pic ||
    oldUserModel.userStatus != updatedUserModel.userStatus
    ){
      await Fire.updateDoc(
        context: context,
        collName: FireCollection.tinyUsers,
        docName: updatedUserModel.userID,
        input: TinyUser.getTinyUserFromUserModel(_finalUserModel).toMap(),
      );
    }

  }
// -----------------------------------------------------------------------------
  /// delete all user related data
  Future<void> deactivateUserOps({BuildContext context, UserModel userModel}) async {
    /// x. Alert user that he will forever lose his (name, pic, title, contacts,
    /// status, company, gender, zone, position, saved flyers, followed bzz) in
    /// [bool dialog]

    bool _result = await superDialog(
      context: context,
      title: 'Watch Out !',
      body: 'Your data can not be retrieved after deactivating your account\nAre you sure you want to proceed ?',
      boolDialog: true,
    );

    if (_result == false){
      // do nothing
      print('no Do not deactivate ');
    }
    else {

      print('CRUD OPS');

      /// A. if user is Author :-
      if (userModel.myBzzIDs.length != 0){

        /// WAITING DIALOG
        superDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: Loading(loading: true,),
        );

        FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

        /// a - get user tiny bzz
        List<BzModel> _bzzToDeactivate = new List();
        List<BzModel> _bzzToKeep = new List();
        for (var id in userModel.myBzzIDs){

          BzModel _bz = await BzCRUD.readBzOps(
            context: context,
            bzID: id,
          );

          if (_bz.bzAuthors.length == 1){
            _bzzToDeactivate.add(_bz);
          } else{
            _bzzToKeep.add(_bz);
          }

        }

        /// CLOSE WAITING DIALOG
        Nav.goBack(context);

        /// b - show dialog
        bool _bzzReviewResult = await superDialog(
          context: context,
          title: 'You Have ${_bzzToDeactivate.length + _bzzToKeep.length} business accounts',
          body: 'All Business accounts will be deactivated except those shared with other authors',
          boolDialog: true,
          height: Scale.superScreenHeight(context) * 0.8,
          child: Column(
            children: <Widget>[

              BzzBubble(
                tinyBzz: TinyBz.getTinyBzzFromBzzModels(_bzzToDeactivate),
                onTap: (value){print(value);},
                numberOfColumns: 6,
                numberOfRows: 1,
                scrollDirection: Axis.horizontal,
                title: 'These Accounts will be deactivated',
              ),

              BzzBubble(
                tinyBzz: TinyBz.getTinyBzzFromBzzModels(_bzzToKeep),
                onTap: (value){print(value);},
                numberOfColumns: 6,
                numberOfRows: 1,
                scrollDirection: Axis.horizontal,
                title: 'Can not deactivate these businesses',
              ),

              SuperVerse(
               verse: 'Would you like to continue ?',
               margin: 10,
              ),

            ],
          ),
        );

        if (_bzzReviewResult == false) {
          // do nothing
          print('no Do not deactivate ');
        } else {

          int _totalNumOfFlyers = FlyerModel.getNumberOfFlyersFromBzzModels(_bzzToDeactivate);
          int _numberOfBzz = _bzzToDeactivate.length;

          /// b - show dialog
          bool _flyersReviewResult = await superDialog(
            context: context,
            title: '',
            body: 'You Have $_totalNumOfFlyers flyers that will be deactivated and can not be retrieved',
            boolDialog: true,
            height: Scale.superScreenHeight(context) * 0.9,
            child: Column(
              children: <Widget>[

                Container(
                  // width: superBubbleClearWidth(context),
                  height: Scale.superScreenHeight(context) * 0.6,
                  child: ListView.builder(
                    itemCount: _numberOfBzz,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){

                      return
                        FlyersBubble(
                          tinyFlyers: TinyFlyer.getTinyFlyersFromBzModel(_bzzToDeactivate[index]),
                          flyerSizeFactor: 0.2,
                          numberOfColumns: 2,
                          title: 'flyers of ${_bzzToDeactivate[index].bzName}',
                          numberOfRows: 1,
                          bubbleWidth: Scale.superDialogWidth(context) - (Ratioz.ddAppBarMargin * 4),
                          onTap: (value){
                            print(value);
                          },
                        );
                    },



                  ),
                ),

                SuperVerse(
                  verse: 'Would you like to continue ?',
                  margin: 10,
                ),

              ],
            ),
          );

          if (_flyersReviewResult == false){
            // do nothing
            print('no Do not deactivate ');
          } else {

            /// SHOW WAITING DIALOG
            superDialog(
              context: context,
              title: '',
              boolDialog: null,
              height: null,
              body: 'Waiting',
              child: Loading(loading: true,),
            );

            for (var bz in _bzzToDeactivate){

              // /// de-activate flyers
              // for (var flyer in bz.bzFlyers){
              //   await FlyerCRUD().deactivateFlyerOps(
              //     context: context,
              //     bzModel: bz,
              //     flyerID: flyer.flyerID,
              //   );
              // }

              /// de-activate bz
             await BzCRUD().deactivateBzOps(
               context: context,
               bzModel: bz,
             );

            }

            /// CLOSE WAITING DIALOG
            Nav.goBack(context);


          }

        }





      }

      /// change user status in user doc to deactivated
      await Fire.updateDocField(
        context: context,
        collName: FireCollection.users,
        docName: userModel.userID,
        field: 'userStatus',
        input: UserModel.cipherUserStatus(UserStatus.Deactivated),
      );

      /// change user status in TinyUser doc to deactivated
      await Fire.updateDocField(
        context: context,
        collName: FireCollection.tinyUsers,
        docName: userModel.userID,
        field: 'userStatus',
        input: UserModel.cipherUserStatus(UserStatus.Deactivated),
      );

      superDialog(
        context: context,
        title: '',
        boolDialog: false,
        height: null,
        body: 'Done',
      );

      /// CLOSE WAITING DIALOG
      Nav.goBack(context);


    }

  }
// -----------------------------------------------------------------------------

}
