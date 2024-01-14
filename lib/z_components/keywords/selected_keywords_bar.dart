import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class SelectedPhidsBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectedPhidsBar({
    required this.selectedPhids,
    // required this.scrollController,
    // required this.itemPositionListener,
    required this.highlightedPhid,
    required this.removePhid,
    super.key
  });
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
    required BuildContext context,
    required bool includeMargins,
  }){
    final double _bubbleHeightWithoutChildren = Bubble.getHeightWithoutChildren(
      headlineHeight: BldrsText.superVerseSizeValue(context, 2, 1),
    );
    final double _childrenHeight = getChildrenHeight(context);
    final double _marginsHeight = includeMargins ? Ratioz.appBarMargin * 2 : 0;
    return _bubbleHeightWithoutChildren + _childrenHeight + _marginsHeight;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    final String? _screenTitle = selectedPhids.isEmpty ?
    getWord('phid_select_keywords')
        :
    selectedPhids.length == 1 ?
    getWord('phid_selected')
        :
    '${selectedPhids.length} ${getWord('phid_selected')}';
    // --------------------
    return Bubble(
      width: _screenWidth,
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: Verse(
          id: _screenTitle,
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
