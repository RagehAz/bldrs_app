import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/specific/keywords/keyword_button.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class KeywordsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeywordsBubble({
    @required this.title,
    @required this.keywords,
    @required this.selectedWords,
    @required this.addButtonIsOn,
    @required this.onKeywordTap,
    this.verseSize = 2,
    this.onTap,
    this.bubbleColor = Colorz.white20,
    this.bubbleWidth,
    this.margins,
    this.corners,
    this.passKeywordOnTap = false,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String title;
  final List<KW> keywords;
  final int verseSize;
  final Function onTap;
  final ValueChanged<KW> onKeywordTap;
  final Color bubbleColor;
  final List<dynamic> selectedWords;
  final double bubbleWidth;
  final dynamic margins;
  final dynamic corners;
  final bool passKeywordOnTap;
  final bool addButtonIsOn;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// the keyword bottom bubble corner when set in flyer info page
    final double _bottomPadding = (bubbleWidth * Ratioz.xxflyerBottomCorners) -
        Ratioz.appBarPadding -
        Ratioz.appBarMargin;

    return Bubble(
      key: key,
      bubbleColor: bubbleColor,
      margins: margins,
      corners: corners,
      title: title,
      width: bubbleWidth,
      bubbleOnTap: passKeywordOnTap == true ? null : onTap,
      columnChildren: <Widget>[
        /// STRINGS
        if (Mapper.canLoopList(keywords))
          Wrap(
            children: <Widget>[
              ...List<Widget>.generate(keywords?.length, (int index) {
                final KW _keyword = keywords[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
                  child: KeywordBarButton(
                    keyword: _keyword,
                    xIsOn: false,
                    onTap: passKeywordOnTap == true
                        ? () => onKeywordTap(_keyword)
                        : null,
                  ),
                );
              }),
            ],
          ),

        if (keywords != null && keywords.isEmpty && addButtonIsOn == true)
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
