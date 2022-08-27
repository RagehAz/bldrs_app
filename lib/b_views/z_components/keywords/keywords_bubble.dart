import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/z_components/keywords/add_keywords_button.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class KeywordsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeywordsBubble({
    @required this.title,
    @required this.phids,
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
  final List<String> phids;
  final int verseSize;
  final Function onTap;
  final ValueChanged<String> onKeywordTap;
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
      onBubbleTap: passKeywordOnTap == true ? null : onTap,
      columnChildren: <Widget>[

        /// STRINGS
        if (Mapper.checkCanLoopList(phids))
          Wrap(
            children: <Widget>[

              ...List<Widget>.generate(phids?.length, (int index) {

                final String _phid = phids[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
                  child: PhidButton(
                    phid: _phid,
                    onTap: passKeywordOnTap == true ?
                        () => onKeywordTap(_phid)
                        :
                    null,
                  ),
                );
              }),

            ],
          ),

        if (phids != null && phids.isEmpty && addButtonIsOn == true)
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
