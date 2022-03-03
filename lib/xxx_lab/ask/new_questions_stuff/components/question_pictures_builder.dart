import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/xxx_lab/ask/new_questions_stuff/components/question_picture.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionPicturesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionPicturesBuilder({
    @required this.questionModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QuestionModel questionModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);
    const double _height = 200;

    return SizedBox(
      width: _bubbleClearWidth,
      height: _height,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: questionModel.pics.length,
          itemBuilder: (_, index){

            return QuestionPictureThumbnail(
                picture: questionModel.pics[index],
                picHeight: _height,
            );

          }
      ),
    );
  }
}
