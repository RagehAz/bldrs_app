import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_picture.dart';
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionPicturesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionPicturesBuilder({
    @required this.questionModel,
    @required this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QuestionModel questionModel;
  final double height;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);

    return SizedBox(
      width: _bubbleClearWidth,
      height: height,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: questionModel.pics.length,
          itemBuilder: (_, index){

            return QuestionPictureThumbnail(
                picture: questionModel.pics[index],
                picHeight: height,
            );

          }
      ),
    );
  }
}
