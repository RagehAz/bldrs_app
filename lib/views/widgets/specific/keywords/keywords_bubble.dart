import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/specific/keywords/keyword_button.dart';
import 'package:flutter/material.dart';

class KeywordsBubble extends StatelessWidget {
  final String title;
  final List<Keyword> keywords;
  final int verseSize;
  final Function onTap;
  final Color bubbleColor;
  final List<dynamic> selectedWords;
  final double bubbleWidth;
  final dynamic margins;
  final dynamic corners;
  final bool passKeywordOnTap;
  final bool addButtonIsOn;
  final Key key;

  const KeywordsBubble({
    @required this.title,
    @required this.keywords,
    this.verseSize = 2,
    this.onTap,
    this.bubbleColor = Colorz.white20,
    @required this.selectedWords,
    this.bubbleWidth,
    this.margins,
    this.corners,
    this.passKeywordOnTap = false,
    @required this.addButtonIsOn,
    this.key,
  });
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// the keyword bottom bubble corner when set in flyer info page
    final double _bottomPadding = ((bubbleWidth) * Ratioz.xxflyerBottomCorners) - Ratioz.appBarPadding - Ratioz.appBarMargin;

    return Bubble(
      key: key,
      centered: false,
      bubbleColor: bubbleColor,
      margins: margins,
      corners: corners,
      title: title,
      width: bubbleWidth,
      bubbleOnTap: passKeywordOnTap == true ? null : onTap,
      columnChildren: <Widget>[

        /// STRINGS
        if(keywords != null && keywords?.length != 0)
        Wrap(
          children: <Widget>[

            ...List<Widget>.generate(
                keywords?.length,
                    (index){

                  Keyword _keyword = keywords[index];

                  return

                    Padding(
                      padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
                      child: KeywordBarButton(
                        keyword: _keyword,
                        xIsOn: false,
                        onTap: passKeywordOnTap == true ? () => onTap(_keyword) : null,
                      ),
                    );

                }
            ),

          ],
        ),

        if(keywords != null && keywords.length == 0 && addButtonIsOn == true)
          AddKeywordsButton(
            onTap: passKeywordOnTap == true ? null : onTap,
          ),


        Container(
          height: _bottomPadding,
        ),

      ],
    );
  }
}
