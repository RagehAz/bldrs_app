import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class QuestionModel {
  final String questionID;
  final String ownerID;
  final FlyerType questionType;
  final DateTime time;
  final List<Keyword> keywords;
  final List<dynamic> pics;
  final String body;
  final String title;
  int totalViews;
  int totalChats;
  bool userSeenAll;
  bool questionIsOpen;
  final bool userDeletedQuestion;

  QuestionModel({
    @required this.questionID,
    @required this.ownerID,
    @required this.body,
    @required this.questionType,
    @required this.time,
    @required this.keywords,
    @required this.pics,
    @required this.title,
    @required this.totalViews,
    @required this.totalChats,
    @required this.userSeenAll,
    @required this.questionIsOpen,
    @required this.userDeletedQuestion,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
    'questionID' : questionID,
    'userID' : ownerID,
    'questionType' : FlyerTypeClass.cipherFlyerType(questionType),
    'askTime' : cipherDateTimeToString(time),
    'keywords' : keywords,
    'pics' : pics,
    'body' : body,
    'title' : title,
    'totalViews' : totalViews,
    'totalChats' : totalChats,
    'userSeenAll' : userSeenAll,
    'questionIsOpen' : questionIsOpen,
    'userDeletedQuestion' : userDeletedQuestion,
    };
  }
// -----------------------------------------------------------------------------
  static QuestionModel decipherQuestion(dynamic map){
    QuestionModel _question;

    if (map != null){
      _question = QuestionModel(
          questionID: map['askID'],
          ownerID: map['userID'],
          body: map['body'],
          questionType: FlyerTypeClass.decipherFlyerType(map['questionType']),
          time: map['askTime'],
          keywords: map['keywords'],
          pics: map['pics'],
          title: map['title'],
          totalViews: map['totalViews'],
          totalChats: map['totalChats'],
          userSeenAll: map['userSeenAll'],
          questionIsOpen: map['questionIsOpen'],
          userDeletedQuestion: map['userDeletedQuestion']
      );
    }

    return _question;
  }
// -----------------------------------------------------------------------------
  static QuestionModel updatePicsWithURLs({QuestionModel question, List<String> picsURLS}){
    QuestionModel _question;

    if (picsURLS != null && picsURLS.length != 0){

      _question = QuestionModel(
        questionID : question.questionID,
        ownerID : question.ownerID,
        body : question.body,
        questionType : question.questionType,
        time : question.time,
        keywords : question.keywords,
        pics : picsURLS,
        title : question.title,
        totalViews : question.totalViews,
        totalChats : question.totalChats,
        userSeenAll : question.userSeenAll,
        questionIsOpen : question.questionIsOpen,
        userDeletedQuestion : question.userDeletedQuestion,
      );

    }

    else {
      _question = question;
    }

    return _question;
  }
// -----------------------------------------------------------------------------
  static bool questionIsUpdated({QuestionModel originalQuestion, QuestionModel updateQuestion}){
    bool _questionIsUpdated = true;

    if(
        originalQuestion != null &&
        updateQuestion != null &&
        Imagers.picturesURLsAreTheSame(urlsA: originalQuestion.pics, urlsB: updateQuestion.pics) == true &&
        originalQuestion.questionID == updateQuestion.questionID &&
        originalQuestion.body == updateQuestion.body &&
        originalQuestion.title == updateQuestion.title &&
        originalQuestion.ownerID == updateQuestion.ownerID &&
        Keyword.KeywordsListsAreTheSame(originalQuestion.keywords, updateQuestion.keywords,) == true &&
        originalQuestion.questionIsOpen == updateQuestion.questionIsOpen &&
        originalQuestion.questionType == updateQuestion.questionType &&
        originalQuestion.userDeletedQuestion == updateQuestion.userDeletedQuestion &&
        originalQuestion.userSeenAll == updateQuestion.userSeenAll
    ){
      _questionIsUpdated = false;
    }

    return _questionIsUpdated;
}
// -----------------------------------------------------------------------------
}


