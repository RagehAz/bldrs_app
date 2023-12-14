import 'package:basics/animators/widgets/scroller.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/add_keywords_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class PhidsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsBubble({
    required this.titleVerse,
    required this.phids,
    required this.selectedWords,
    required this.addButtonIsOn,
    required this.onPhidTap,
    this.verseSize = 2,
    this.onTap,
    this.bubbleColor = Colorz.white20,
    this.bubbleWidth,
    this.margins,
    this.corners,
    this.passPhidOnTap = false,
    this.maxLines,
    this.scrollController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse titleVerse;
  final List<String>? phids;
  final int verseSize;
  final Function? onTap;
  final ValueChanged<String> onPhidTap;
  final Color bubbleColor;
  final List<dynamic>? selectedWords;
  final double? bubbleWidth;
  final dynamic margins;
  final dynamic corners;
  final bool passPhidOnTap;
  final bool addButtonIsOn;
  final int? maxLines;
  final ScrollController? scrollController;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double getLineHeightWithItsPadding(){
    return PhidButton.getHeight() + Ratioz.appBarPadding;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getMaxWrapHeight({
    required int? maxLines,
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
    final double _width = Bubble.bubbleWidth(
        context: context,
        bubbleWidthOverride: bubbleWidth,
    );

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
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: titleVerse,
      ),
      width: _width,
      onBubbleTap: passPhidOnTap == true ? null : onTap,
      columnChildren: <Widget>[

        /// STRINGS
        if (Lister.checkCanLoopList(phids) == true)
          Container(
            width: Bubble.clearWidth(context: context, bubbleWidthOverride: bubbleWidth),
            constraints: maxLines == null ? null : BoxConstraints(
              maxHeight: getMaxWrapHeight(maxLines: maxLines),
            ),
            decoration: BoxDecoration(
              color: Colorz.white10,
              borderRadius: SuperBoxController.boxCornersValue,
            ),
            child: Scroller(
              controller: scrollController,
              isOn: maxLines != null,
              child: ClipRRect(
                borderRadius: SuperBoxController.boxCornersValue,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: PhidButton.getHeight(),
                    ),
                    child: Wrap(
                      children: <Widget>[

                        if (Lister.checkCanLoopList(phids) == true)
                        ...List<Widget>.generate(phids!.length, (int index) {

                          final String _phid = phids![index];

                          return Padding(
                            padding: Scale.superInsets(
                              context: context,
                              appIsLTR: UiProvider.checkAppIsLeftToRight(),
                              enRight: Ratioz.appBarPadding,
                              bottom: Ratioz.appBarPadding,
                            ),
                            child: PhidButton(
                              phid: _phid,
                              onPhidTap: passPhidOnTap == true ?
                                  () => onPhidTap(_phid)
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

        if (phids != null && phids!.isEmpty == true && addButtonIsOn == true)
          AddKeywordsButton(
            onTap: passPhidOnTap == true ? null : () => onTap?.call(),
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
