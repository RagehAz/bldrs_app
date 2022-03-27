import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/xxx_lab/ask/new_questions_stuff/components/question_pictures_builder.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionBody extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionBody({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.questionModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final QuestionModel questionModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _headerHeight = FlyerBox.headerBoxHeight(
        flyerBoxWidth: flyerBoxWidth,
    );

    final double _footerHeight = FooterBox.collapsedHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode
    );

    final double _bodyHeight = flyerBoxHeight - _headerHeight - _footerHeight;

    return SizedBox(
      width: flyerBoxWidth,
      height: flyerBoxHeight,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[

          /// FAKE HEADER FOOT PRINT,
          SizedBox(
            width: flyerBoxWidth,
            height: _headerHeight,
          ),

          SizedBox(
            width: flyerBoxWidth,
            height: _bodyHeight,
            child: Column(
              children: <Widget>[

                /// HEADLINE
                Container(
                  width: flyerBoxWidth,
                  height: _bodyHeight * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: flyerBoxWidth * 0.05),
                  child: SuperVerse(
                    verse: questionModel.headline,
                    maxLines: 3,
                    scaleFactor: flyerBoxWidth * 0.004,
                    size: 3,
                  ),
                ),

                /// QUESTION ITSELF
                Container(
                  width: flyerBoxWidth,
                  height: _bodyHeight * 0.4,
                  padding: EdgeInsets.symmetric(horizontal: flyerBoxWidth * 0.05),
                  child: ListView(
                    physics: tinyMode ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: <Widget>[

                      SuperVerse(
                        verse: questionModel.body,
                        maxLines: 1000,
                        // size: 2,
                        weight: VerseWeight.thin,
                        scaleFactor: flyerBoxWidth * 0.004,
                      ),

                    ],
                  ),
                ),


                /// QUESTION PICTURES
                if (canLoopList(questionModel?.pics))
                  QuestionPicturesBuilder(
                    questionModel: questionModel,
                    height: _bodyHeight * 0.4,
                  ),


              ],
            ),
          ),

          ///FAKE FOOTER FOOT PRINT
          SizedBox(
            width: flyerBoxWidth,
            height: _footerHeight,
          ),

        ],
      ),
    );
  }
}
