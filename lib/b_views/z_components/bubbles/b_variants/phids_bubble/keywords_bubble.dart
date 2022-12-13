import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/add_keywords_button.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class KeywordsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeywordsBubble({
    @required this.titleVerse,
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
    this.maxLines,
    this.scrollController,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse titleVerse;
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
  final int maxLines;
  final ScrollController scrollController;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double getLineHeightWithItsPadding(){
    return PhidButton.getHeight() + Ratioz.appBarPadding;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getMaxWrapHeight({
    @required int maxLines,
  }){
    if (maxLines == null){
      return 0;
    }
    else {
      final double _lineHeight = getLineHeightWithItsPadding();
      /// GETS TOTAL LINES HEIGHT + HALF LINE HEIGHT TO SHOW USER THAT ITS SCROLLABLE
      return (_lineHeight * maxLines) + (_lineHeight * 0.5);
    }
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _width = Bubble.bubbleWidth(context, bubbleWidthOverride: bubbleWidth);

    /// the keyword bottom bubble corner when set in flyer info page
    final double _bottomPadding = FlyerDim.footerBoxBottomCornerValue(_width)
                                  -
                                  Ratioz.appBarPadding
                                  -
                                  Ratioz.appBarMargin;
    // --------------------
    return Bubble(
      key: const ValueKey<String>('KeywordsBubble'),
      bubbleColor: bubbleColor,
      margin: margins,
      corners: corners,
      bubbleHeaderVM: BubbleHeaderVM(
        headlineVerse: titleVerse,
      ),
      width: _width,
      onBubbleTap: passKeywordOnTap == true ? null : onTap,
      columnChildren: <Widget>[

        /// STRINGS
        if (Mapper.checkCanLoopList(phids) == true)
          Container(
            width: Bubble.clearWidth(context, bubbleWidthOverride: bubbleWidth),
            constraints: maxLines == null ? null : BoxConstraints(
              maxHeight: getMaxWrapHeight(maxLines: maxLines),
            ),
            decoration: BoxDecoration(
              color: Colorz.white10,
              borderRadius: DreamBox.boxCorners,
            ),
            child: Scroller(
              controller: scrollController,
              isOn: maxLines != null,
              child: ClipRRect(
                borderRadius: DreamBox.boxCorners,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: PhidButton.getHeight(),
                    ),
                    child: Wrap(
                      children: <Widget>[

                        ...List<Widget>.generate(phids?.length, (int index) {

                          final String _phid = phids[index];

                          return Padding(
                            padding: Scale.superInsets(
                              context: context,
                              enRight: Ratioz.appBarPadding,
                              bottom: Ratioz.appBarPadding,
                            ),
                            child: PhidButton(
                              phid: _phid,
                              onPhidTap: passKeywordOnTap == true ?
                                  () => onKeywordTap(_phid)
                                  :
                              null,
                            ),
                          );
                        }),

                      ],
                    ),
                  ),
                ),
              ),
            ),
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
    // --------------------
  }
/// --------------------------------------------------------------------------
}
