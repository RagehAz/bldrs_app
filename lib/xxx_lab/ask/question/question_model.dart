import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
class QuestionModel {
  /// --------------------------------------------------------------------------
  QuestionModel({
    @required this.questionID,
    @required this.ownerID,
    @required this.body,
    @required this.directedTo,
    @required this.time,
    @required this.keywords,
    @required this.pics,
    @required this.title,
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
  final String questionID;
  final String ownerID;
  final BzType directedTo;
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
  int repliesCount;
  int niceCount;
  int redirectCount;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({bool toJSON = false}) {
    return <String, dynamic>{
      'questionID': questionID,
      'userID': ownerID,
      'directedTo': BzModel.cipherBzType(directedTo),
      'askTime': Timers.cipherTime(time: time, toJSON: toJSON),
      'keywords': keywords,
      'pics': pics,
      'body': body,
      'title': title,
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
        questionID: map['askID'],
        ownerID: map['userID'],
        body: map['body'],
        directedTo: BzModel.decipherBzType(map['directedTo']),
        time: Timers.decipherTime(time: map['askTime'], fromJSON: fromJSON),
        keywords: map['keywords'],
        pics: map['pics'],
        title: map['title'],
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

    if (Mapper.canLoopList(picsURLS)) {
      _question = QuestionModel(
        questionID: question.questionID,
        ownerID: question.ownerID,
        body: question.body,
        directedTo: question.directedTo,
        time: question.time,
        keywords: question.keywords,
        pics: picsURLS,
        title: question.title,
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

    if (originalQuestion != null &&
        updateQuestion != null &&
        Imagers.picturesURLsAreTheSame(
                urlsA: originalQuestion.pics, urlsB: updateQuestion.pics) ==
            true &&
        originalQuestion.questionID == updateQuestion.questionID &&
        originalQuestion.body == updateQuestion.body &&
        originalQuestion.title == updateQuestion.title &&
        originalQuestion.ownerID == updateQuestion.ownerID &&
        KW.keywordsListsAreTheSame(
              originalQuestion.keywords,
              updateQuestion.keywords,
            ) ==
            true &&
        originalQuestion.questionIsOpen == updateQuestion.questionIsOpen &&
        originalQuestion.directedTo == updateQuestion.directedTo &&
        originalQuestion.userDeletedQuestion ==
            updateQuestion.userDeletedQuestion &&
        originalQuestion.userSeenAll == updateQuestion.userSeenAll) {
      _questionIsUpdated = false;
    }

    return _questionIsUpdated;
  }
// -----------------------------------------------------------------------------
  static QuestionModel dummyQuestion(BuildContext context){

    return QuestionModel(
      questionID: 'questionID',
      ownerID: 'userID',
      body: 'This is a dummy question baby,, are you okey ? \n Lorum Ipsum gowa loa7 Gypsum',
      directedTo: BzType.contractor,
      time: Timers.createDateAndClock(year: 1987, month: 06, day: 10, hour: 12, minute: 05),
      keywords: KW.dummyKeywords(context: context),
      pics: <String>[
        Iconz.dumSlide6,
        Iconz.dumSlide1,
        Iconz.dumSlide2,
        Iconz.dumSlide3,
        Iconz.dumSlide4,
      ],
      title: 'Dummy Question',
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
}
