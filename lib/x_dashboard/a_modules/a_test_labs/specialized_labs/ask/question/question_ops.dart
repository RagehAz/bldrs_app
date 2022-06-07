import 'dart:io';

import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/foundation/storage.dart' as Storage;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// for all asks IDs update the the tiny user
// /// PLAN : while update user Ops ,, get all asks IDs in a list
// List<String> _userAsksIDs = [];
// List<QueryDocumentSnapshot> _asksMaps = await getFireStoreSubCollectionMaps(
//   collectionName: FireStoreCollection.users,
//   docName: oldUserModel.userID,
//   subCollectionName: FireStoreCollection.subUserAsks,
// );
// for (var map in _asksMaps){_userAsksIDs.add(map.id);}

// if (_userAsksIDs.length > 0){
//   TinyUser _newTinyUser = getTinyUserFromUserModel(newUserModel);
//   for (var id in _userAsksIDs){
//     await updateFieldOnFirestore(
//       context: context,
//       collectionName: FireStoreCollection.users,
//       documentName: id,
//       field: 'tinyUser',
//       input: _newTinyUser,
//       // TASK : check dialogs as they will pop with each ask doc update loop
//     );
//   }
//
// }

class QuestionOps {
// -----------------------------------------------------------------------------
  /// Question collection ref
  CollectionReference<Object> questionCollectionRef() {
    return Fire.getCollectionRef(FireColl.questions);
  }

// -----------------------------------------------------------------------------
  /// chat doc ref
  DocumentReference<Object> questionDocRef(String questionID, String chatID) {
    return Fire.getDocRef(
      collName: FireColl.questions,
      docName: questionID,
    );
  }

// -----------------------------------------------------------------------------
  static Future<void> createQuestionOps({
    @required BuildContext context,
    @required QuestionModel question,
    @required String userID,
  }) async {
    List<String> _picsURLs;
    QuestionModel _question;

    /// A - save image attachments if existed
    if (Mapper.checkCanLoopList(question?.pics)) {
      /// A2 - create pics names
      final List<String> _picsNames = <String>[];
      for (int i = 0; i < question.pics.length; i++) {
        final File _file = question.pics[i];
        final String _name =
            TextMod.removeTextBeforeLastSpecialCharacter(_file.path, '.');
        _picsNames.add(_name);
      }

      /// A3 - upload pics and get URLs
      _picsURLs = await Storage.createMultipleStoragePicsAndGetURLs(
        context: context,
        names: _picsNames,
        pics: question.pics,
        userID: userID,
      );
    }

    /// B - update question model with pics urls
    _question = QuestionModel.updatePicsWithURLs(
        question: question, picsURLS: _picsURLs);

    /// C - create question doc with _question on firebase
    final DocumentReference<Object> _questionDocRef = await Fire.createDoc(
      context: context,
      collName: FireColl.questions,
      input: _question.toMap(),
    );

    blog('createQuestionOps : _questionDocRef : $_questionDocRef');

    /// D - update user questionsIDs list adding this new questionID
    final List<String> _updatedQuestionsIDs =
        <String>[]; //TASK :QUESTION OPS WTF WHY IS THIS EMPTY

    // String _questionID = _questionDocRef.id;
    await Fire.updateDocField(
      context: context,
      collName: FireColl.users,
      docName: _question.ownerID,
      field: 'questions',
      input: _updatedQuestionsIDs,
    );
  }

// -----------------------------------------------------------------------------
  static Future<QuestionModel> readQuestionOps(
      {BuildContext context, String questionID}) async {
    final dynamic _questionMap = await Fire.readDoc(
      context: context,
      collName: FireColl.questions,
      docName: questionID,
    );

    final QuestionModel _question =
        QuestionModel.decipherQuestion(map: _questionMap, fromJSON: false);

    return _question;
  }

// -----------------------------------------------------------------------------
  static Future<QuestionModel> updateQuestionOps({
    BuildContext context,
    QuestionModel originalQuestion,
    QuestionModel updatedQuestion,
  }) async {

    final bool _questionIsUpdated = QuestionModel.questionIsUpdated(
      originalQuestion: originalQuestion,
      updateQuestion: updatedQuestion,
    );

    if (_questionIsUpdated == true) {
      await Fire.updateDoc(
        context: context,
        collName: FireColl.questions,
        docName: updatedQuestion.id,
        input: updatedQuestion.toMap(),
      );
    }

    return updatedQuestion;
  }

// -----------------------------------------------------------------------------
  static Future<void> deleteQuestionOps({
    BuildContext context,
    QuestionModel question
  }) async {

    await Fire.deleteDoc(
      context: context,
      collName: FireColl.questions,
      docName: question.id,
    );

  }
// ----------------------------------------------------------------------
}
