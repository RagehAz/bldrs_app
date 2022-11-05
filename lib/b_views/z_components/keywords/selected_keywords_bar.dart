import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SelectedPhidsBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectedPhidsBar({
    @required this.selectedPhids,
    // @required this.scrollController,
    // @required this.itemPositionListener,
    @required this.highlightedPhid,
    @required this.removePhid,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> selectedPhids;
  // final ItemScrollController scrollController;
  // final ItemPositionsListener itemPositionListener;
  final String highlightedPhid;
  final ValueChanged<String> removePhid;
  /// --------------------------------------------------------------------------
  static double getChildrenHeight(BuildContext context){
    return PhidButton.getHeight() + (Ratioz.appBarMargin * 2);
  }
  // --------------------
  static double getBubbleHeight({
    @required BuildContext context,
    @required bool includeMargins,
  }){
    final double _bubbleHeightWithoutChildren = Bubble.getHeightWithoutChildren(context);
    final double _childrenHeight = getChildrenHeight(context);
    final double _marginsHeight = includeMargins ? Ratioz.appBarMargin * 2 : 0;
    return _bubbleHeightWithoutChildren + _childrenHeight + _marginsHeight;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // --------------------
    final String _screenTitle = selectedPhids.isEmpty ?
    xPhrase(context, 'phid_select_keywords')
        :
    selectedPhids.length == 1 ?
    xPhrase(context, 'phid_selected')
        :
    '${selectedPhids.length} ${xPhrase(context, 'phid_selected')}';
    // --------------------
    return Bubble(
      width: _screenWidth,
      headerViewModel: BubbleHeaderVM(
        headlineVerse: Verse(
          text: _screenTitle,
          translate: false,
        ),
      ),
      columnChildren: <Widget>[

        SizedBox(
          width: _screenWidth,
          height: getChildrenHeight(context),
          child: selectedPhids.isEmpty ?
          const SizedBox()
              :
              const SizedBox()

            /*
                      ScrollablePositionedList.builder(
            physics: const BouncingScrollPhysics(),
            itemScrollController: scrollController,
            scrollDirection: Axis.horizontal,
            itemPositionsListener: itemPositionListener,
            itemCount: selectedKeywordsIDs.length,
            padding: Scale.superInsets(
              context: context,
              enLeft: Ratioz.appBarPadding,
              enRight: Ratioz.horizon,
            ),
            itemBuilder: (BuildContext ctx, int index) {

              final String _keyword = selectedKeywordsIDs[index];
              return KeywordBarButton(
                keywordID: _keyword,
                xIsOn: true,
                onTap: () => removeKeyword(_keyword),
              );

            },
          ),

             */

        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
