import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class QuestionModel {
  /// --------------------------------------------------------------------------
  QuestionModel({
    @required this.id,
    @required this.ownerID,
    @required this.body,
    @required this.directedTo,
    @required this.time,
    @required this.keywordsIDs,
    @required this.pics,
    @required this.headline,
    @required this.totalViews,
    @required this.totalChats,
    @required this.userSeenAll,
    @required this.questionIsOpen,
    @required this.userDeletedQuestion,
    @required this.niceCount,
    @required this.repliesCount,
    @required this.redirectCount,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String ownerID;
  final BzType directedTo;
  final DateTime time;
  final List<String> keywordsIDs;
  final List<dynamic> pics;
  final String body;
  final String headline;
  int totalViews;
  int totalChats;
  bool userSeenAll;
  bool questionIsOpen;
  final bool userDeletedQuestion;
  int repliesCount;
  int niceCount;
  int redirectCount;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({bool toJSON = false}) {
    return <String, dynamic>{
      'id': id,
      'userID': ownerID,
      'directedTo': BzModel.cipherBzType(directedTo),
      'askTime': Timers.cipherTime(time: time, toJSON: toJSON),
      'keywords': keywordsIDs,
      'pics': pics,
      'body': body,
      'headline': headline,
      'totalViews': totalViews,
      'totalChats': totalChats,
      'userSeenAll': userSeenAll,
      'questionIsOpen': questionIsOpen,
      'userDeletedQuestion': userDeletedQuestion,
      'repliesCount' : repliesCount,
      'niceCount' : niceCount,
      'redirectCount' : redirectCount,
    };
  }
// -----------------------------------------------------------------------------
  static QuestionModel decipherQuestion({
    @required dynamic map,
    bool fromJSON
  }) {

    QuestionModel _question;

    if (map != null) {
      _question = QuestionModel(
        id: map['askID'],
        ownerID: map['userID'],
        body: map['body'],
        directedTo: BzModel.decipherBzType(map['directedTo']),
        time: Timers.decipherTime(time: map['askTime'], fromJSON: fromJSON),
        keywordsIDs: map['keywords'],
        pics: map['pics'],
        headline: map['headline'],
        totalViews: map['totalViews'],
        totalChats: map['totalChats'],
        userSeenAll: map['userSeenAll'],
        questionIsOpen: map['questionIsOpen'],
        userDeletedQuestion: map['userDeletedQuestion'],
        repliesCount: map['repliesCount'],
        niceCount: map['niceCount'],
        redirectCount: map['redirectCount'],
      );
    }

    return _question;
  }
// -----------------------------------------------------------------------------
  static QuestionModel updatePicsWithURLs({
    QuestionModel question,
    List<String> picsURLS
  }) {

    QuestionModel _question;

    if (Mapper.checkCanLoopList(picsURLS)) {
      _question = QuestionModel(
        id: question.id,
        ownerID: question.ownerID,
        body: question.body,
        directedTo: question.directedTo,
        time: question.time,
        keywordsIDs: question.keywordsIDs,
        pics: picsURLS,
        headline: question.headline,
        totalViews: question.totalViews,
        totalChats: question.totalChats,
        userSeenAll: question.userSeenAll,
        questionIsOpen: question.questionIsOpen,
        userDeletedQuestion: question.userDeletedQuestion,
        niceCount: question.niceCount,
        redirectCount: question.redirectCount,
        repliesCount: question.repliesCount,
      );
    }

    else {
      _question = question;
    }

    return _question;
  }
// -----------------------------------------------------------------------------
  static bool questionIsUpdated({
    QuestionModel originalQuestion,
    QuestionModel updateQuestion
  }) {
    bool _questionIsUpdated = true;

    if (originalQuestion != null
        &&
        updateQuestion != null
        &&
        Imagers.picturesURLsAreIdentical(
            urls1: originalQuestion.pics,
            urls2: updateQuestion.pics
        ) == true
        &&
        originalQuestion.id == updateQuestion.id
        &&
        originalQuestion.body == updateQuestion.body
        &&
        originalQuestion.headline == updateQuestion.headline
        &&
        originalQuestion.ownerID == updateQuestion.ownerID
        &&
        Mapper.checkListsAreIdentical(
          list1: originalQuestion.keywordsIDs,
          list2: updateQuestion.keywordsIDs
        ) == true
        &&
        originalQuestion.questionIsOpen == updateQuestion.questionIsOpen
        &&
        originalQuestion.directedTo == updateQuestion.directedTo
        &&
        originalQuestion.userDeletedQuestion == updateQuestion.userDeletedQuestion
        &&
        originalQuestion.userSeenAll == updateQuestion.userSeenAll
    ) {
      _questionIsUpdated = false;
    }

    return _questionIsUpdated;
  }
// -----------------------------------------------------------------------------
  static QuestionModel dummyQuestion({
    @required BuildContext context,
    @required String questionID,
  }){

    return QuestionModel(
      id: questionID,
      ownerID: 'nM6NmPjhgwMKhPOsZVW4L1Jlg5N2',
      headline: 'Dummy Question Headline',
      body: 'This is a dummy question baby,, are you okey dude ? \n Lorum Ipsum gowa loa7 Gypsum',
      directedTo: BzType.developer,
      time: Timers.createDateAndClock(year: 1987, month: 06, day: 10, hour: 12, minute: 05),
      keywordsIDs: [],
      pics: <String>[
        Iconz.dumSlide6,
        Iconz.dumSlide1,
        Iconz.dumSlide2,
        Iconz.dumSlide3,
        Iconz.dumSlide4,
      ],
      totalViews: 123,
      totalChats: 12,
      userSeenAll: false,
      questionIsOpen: true,
      userDeletedQuestion: false,
      repliesCount: 1542,
      redirectCount: 12,
      niceCount: 45065,
    );

  }
// -----------------------------------------------------------------------------
  static List<QuestionModel> filterQuestionsByBzType({
    List<QuestionModel> questions,
    BzType bzType,
  }){

    List<QuestionModel> _filteredQuestions = <QuestionModel>[];

    if(Mapper.checkCanLoopList(questions)){

      if (bzType == null){
        _filteredQuestions = questions;
      }

      else {
        for (final QuestionModel question in questions){
          if (question.directedTo == bzType){
            _filteredQuestions.add(question);
          }
        }
      }

    }

    return _filteredQuestions;
  }
// -----------------------------------------------------------------------------

}
