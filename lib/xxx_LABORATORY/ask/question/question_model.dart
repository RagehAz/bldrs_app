import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class QuestionModel {
  final String questionID;
  final String ownerID;
  final FlyerType questionType;
  final DateTime time;
  final List<KW> keywords;
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
  Map<String, dynamic> toMap({bool toJSON = false}){
    return {
    'questionID' : questionID,
    'userID' : ownerID,
    'questionType' : FlyerTypeClass.cipherFlyerType(questionType),
    'askTime' : Timers.cipherTime(time: time, toJSON: toJSON),
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
  static QuestionModel decipherQuestion({@required dynamic map, bool fromJSON}){
    QuestionModel _question;

    if (map != null){
      _question = QuestionModel(
          questionID: map['askID'],
          ownerID: map['userID'],
          body: map['body'],
          questionType: FlyerTypeClass.decipherFlyerType(map['questionType']),
          time: Timers.decipherTime(time: map['askTime'], fromJSON: fromJSON),
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

    if (Mapper.canLoopList(picsURLS)){

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
        KW.KeywordsListsAreTheSame(originalQuestion.keywords, updateQuestion.keywords,) == true &&
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


