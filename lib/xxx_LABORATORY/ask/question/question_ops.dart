import 'dart:io';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/xxx_LABORATORY/ask/question/question_model.dart';
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
  CollectionReference questionCollectionRef(){
    return Fire.getCollectionRef(FireCollection.questions);
  }
// -----------------------------------------------------------------------------
  /// chat doc ref
  DocumentReference questionDocRef(String questionID, String chatID){
    return
      Fire.getDocRef(
          collName: FireCollection.questions,
          docName: questionID,
      );
  }
// -----------------------------------------------------------------------------
  static Future<void> createQuestionOps({
    BuildContext context,
    QuestionModel question
  }) async {

    List<String> _picsURLs;
    QuestionModel _question;

    /// A - save image attachments if existed
    if (Mapper.canLoopList(question?.pics)){

      /// A2 - create pics names
      List<String> _picsNames = <String>[];
      for (int i = 0; i < question.pics.length; i++){
        final File _file = question.pics[i];
        final String _name = TextMod.trimTextBeforeLastSpecialCharacter(_file.path, '.');
        _picsNames.add(_name);
      }

      /// A3 - upload pics and get URLs
      _picsURLs = await Fire.createMultipleStoragePicsAndGetURLs(
        context: context,
        names: _picsNames,
        pics: question.pics,
      );

    }

    /// B - update question model with pics urls
    _question = QuestionModel.updatePicsWithURLs(question: question, picsURLS: _picsURLs);

    /// C - create question doc with _question on firebase
    final DocumentReference _questionDocRef = await Fire.createDoc(
      context: context,
      collName: FireCollection.questions,
      input: _question.toMap(),
    );

    print('createQuestionOps : _questionDocRef : $_questionDocRef');

    /// D - update user questionsIDs list adding this new questionID
    final List<String> _updatedQuestionsIDs = <String> []; //TASK :QUESTION OPS WTF WHY IS THIS EMPTY

    // String _questionID = _questionDocRef.id;
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.users,
      docName: _question.ownerID,
      field: 'questions',
      input: _updatedQuestionsIDs,
    );


  }
// -----------------------------------------------------------------------------
  static Future<QuestionModel> readQuestionOps({BuildContext context, String questionID}) async {
    final dynamic _questionMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.questions,
      docName: questionID,
    );

    final QuestionModel _question = QuestionModel.decipherQuestion(map: _questionMap, fromJSON: false);

    return _question;

  }
// -----------------------------------------------------------------------------
  static Future<QuestionModel> updateQuestionOps({BuildContext context, QuestionModel originalQuestion, QuestionModel updatedQuestion}) async {
    QuestionModel _question;

    final bool _questionIsUpdated = QuestionModel.questionIsUpdated(
      originalQuestion: originalQuestion,
      updateQuestion: updatedQuestion,
    );

    if (_questionIsUpdated == true){
      await Fire.updateDoc(
        context: context,
        collName: FireCollection.questions,
        docName: updatedQuestion.questionID,
        input: updatedQuestion.toMap(),
      );

    }

    _question = updatedQuestion;

    return _question;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteQuestionOps({BuildContext context, QuestionModel question}) async {

    await Fire.deleteDoc(
      context: context,
      collName: FireCollection.questions,
      docName: question.questionID,
    );

  }
// ----------------------------------------------------------------------
}
