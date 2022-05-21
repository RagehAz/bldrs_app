import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/theme/dumz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

class QuestionsProvider with ChangeNotifier {
// ----------------------------------------------------------------------------

  /// HOT QUESTIONS

// -------------------------------------
  List<QuestionModel> _hotQuestions = <QuestionModel>[];
// -------------------------------------
  List<QuestionModel> get hotQuestions {
    return [..._hotQuestions];
  }
// -------------------------------------
  Future<void> getSetHotQuestions({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final List<QuestionModel> _dummyQuestions = <QuestionModel>[
      QuestionModel(
        id: '1235',
        headline: 'احتاج لمساعدة',
        body: 'عندي شقة 230 متر عالمحارة و عايزين نبتدي تشظيب في أسرع وقت و محتاجين نعرف تتكلف كام العملية ديه.. معايا شوية صور عايزين نعمل حاجة زي كدة ،، شكرا',
        ownerID: superUserID(),
        repliesCount: 123,
        redirectCount: 12,
        niceCount: 5151,
        directedTo: BzType.contractor,
        keywordsIDs: [],
        pics: <String>[
          Dumz.xXzah_1,
          Iconz.dumSlide2,
        ],
        questionIsOpen: true,
        time: DateTime.now(),
        totalChats: 1235,
        totalViews: 1515,
        userDeletedQuestion: false,
        userSeenAll: false,
      ),
      QuestionModel(
        id: '12ee35',
        headline: 'ألوميتال',
        body: 'يا جماعة محتاج أقفل شبابيك في الوحدة عندي 4 شبابيك و بدور على حاجة تكون ضد التراب',
        ownerID: 'nM6NmPjhgwMKhPOsZVW4L1Jlg5N2',
        repliesCount: 123,
        redirectCount: 12,
        niceCount: 5151,
        directedTo: BzType.contractor,
        keywordsIDs: [],
        pics: <String>[
          Dumz.xXwindow_1,
          Dumz.xXwindow_2,
        ],
        questionIsOpen: true,
        time: DateTime.now(),
        totalChats: 1235,
        totalViews: 1515,
        userDeletedQuestion: false,
        userSeenAll: false,
      ),
      QuestionModel(
        id: '12eeeds35',
        headline: 'سيراميك مطبخ ولا رخام ؟',
        body: 'عندي استفسار بعد اذنكوا مش عارف ايه الأحسن في المطبخ نحط سيراميك في الأرض ولا رخام و لا بورسلين، الموضوع محير بصراحة و انا تعبت و قرفت اوي، ياريت حد يساعدني لو سمحتوا',
        ownerID: 'nM6NmPjhgwMKhPOsZVW4L1Jlg5N2',
        repliesCount: 123,
        redirectCount: 12,
        niceCount: 5151,
        directedTo: BzType.contractor,
        keywordsIDs: [],
        pics: <String>[
          Dumz.xXrack_4,
          Dumz.xXorgento,
        ],
        questionIsOpen: true,
        time: DateTime.now(),
        totalChats: 1235,
        totalViews: 1515,
        userDeletedQuestion: false,
        userSeenAll: false,
      ),

      QuestionModel.dummyQuestion(context: context, questionID: 'aaa'),
      QuestionModel.dummyQuestion(context: context, questionID: 'bbb'),
      QuestionModel.dummyQuestion(context: context, questionID: 'ccc'),
      QuestionModel.dummyQuestion(context: context, questionID: 'ddd'),
      QuestionModel.dummyQuestion(context: context, questionID: 'eee'),
      QuestionModel.dummyQuestion(context: context, questionID: 'fff'),
    ];

    _hotQuestions = _dummyQuestions;

    if (notify == true){
      notifyListeners();
    }

  }
// ----------------------------------------------------------------------------
}
