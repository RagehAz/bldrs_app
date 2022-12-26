import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_switcher.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

@immutable
class BubbleHeaderVM {
  /// --------------------------------------------------------------------------
  const BubbleHeaderVM({
    this.headerWidth,
    this.leadingIcon,
    this.leadingIconSizeFactor = 1,
    this.leadingIconBoxColor,
    this.leadingIconIsBubble = false,
    this.onLeadingIconTap,
    this.hasSwitch = false,
    this.hasMoreButton = false,
    this.headlineVerse,
    this.headlineColor = Colorz.white255,
    this.switchValue = false,
    this.onSwitchTap,
    this.onMoreButtonTap,
    this.redDot = false,
    this.centered = false,
  });
  /// --------------------------------------------------------------------------
  final double headerWidth;
  final dynamic leadingIcon;
  final double leadingIconSizeFactor;
  final Color leadingIconBoxColor;
  final bool leadingIconIsBubble;
  final Function onLeadingIconTap;
  final bool hasSwitch;
  final bool hasMoreButton;
  final Verse headlineVerse;
  final Color headlineColor;
  final bool centered;
  final bool switchValue;
  final ValueChanged<bool> onSwitchTap;
  final Function onMoreButtonTap;
  final bool redDot;
  /// --------------------------------------------------------------------------
  BubbleHeaderVM copyWith({
    double headerWidth,
    dynamic leadingIcon,
    double leadingIconSizeFactor,
    Color leadingIconBoxColor,
    bool leadingIconIsBubble,
    bool hasSwitch,
    bool hasMoreButton,
    Verse headlineVerse,
    Color headlineColor,
    bool switchValue,
    ValueChanged<bool> onSwitchTap,
    Function onMoreButtonTap,
    bool redDot,
    Function onLeadingIconTap,
    bool centered,
  }){
    return BubbleHeaderVM(
      headerWidth: headerWidth ?? this.headerWidth,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      leadingIconSizeFactor: leadingIconSizeFactor ?? this.leadingIconSizeFactor,
      leadingIconBoxColor: leadingIconBoxColor ?? this.leadingIconBoxColor,
      leadingIconIsBubble: leadingIconIsBubble ?? this.leadingIconIsBubble,
      hasSwitch: hasSwitch ?? this.hasSwitch,
      hasMoreButton: hasMoreButton ?? this.hasMoreButton,
      headlineVerse: headlineVerse ?? this.headlineVerse,
      headlineColor: headlineColor ?? this.headlineColor,
      switchValue: switchValue ?? this.switchValue,
      onSwitchTap: onSwitchTap ?? this.onSwitchTap,
      onMoreButtonTap: onMoreButtonTap ?? this.onMoreButtonTap,
      redDot: redDot ?? this.redDot,
      onLeadingIconTap: onLeadingIconTap ?? this.onLeadingIconTap,
      centered: centered ?? this.centered,
    );
  }
  /// --------------------------------------------------------------------------
}

class BubbleHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BubbleHeader({
    @required this.viewModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BubbleHeaderVM viewModel;
  // -----------------------------------------------------------------------------
  static const double iconBoxSize = 30;
  static const double switcherButtonWidth = 50;
  static const double moreButtonSize = iconBoxSize;
  static const double verseBottomMargin = 5;
  // --------------------
  static double getHeight(){
    return iconBoxSize + verseBottomMargin; // verse bottom margin
  }
  // --------------------
  /*

  // -----------------------------------------------------------------------------
    final double _actionBtSize = Bubble._getTitleHeight(context);
// -----------------------------------------------------------------------------
    final double _actionBtCorner = _actionBtSize * 0.4;
// -----------------------------------------------------------------------------


   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = viewModel.headerWidth ?? Bubble.clearWidth(context);
    // --------------------
    /// LEADING ICON
    final bool _hasIcon = viewModel.leadingIcon != null;
    final double _leadingIconWidth = _hasIcon == true ? iconBoxSize : 0;
    // --------------------
    /// SWITCHER
    final double _switcherWidth = viewModel.hasSwitch == true ? switcherButtonWidth : 0;
    // --------------------
    /// MORE BUTTON
    final double _moreButtonWidth = viewModel.hasMoreButton == true ? moreButtonSize + 10 : 0;
    // --------------------
    /// HEADLINE
    final double _headlineWidth = _bubbleWidth - _leadingIconWidth - _switcherWidth - _moreButtonWidth;
    // --------------------
    if (
    viewModel.headlineVerse == null
        &&
        viewModel.leadingIcon == null
        &&
        viewModel.switchValue == false
        &&
        viewModel.hasMoreButton == false
    ){
      return const SizedBox();
    }
    // --------------------
    else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// --- LEADING ICON
          if (_hasIcon == true)
            DreamBox(
              width: iconBoxSize,
              height: iconBoxSize,
              icon: viewModel.leadingIcon,
              // iconColor: Colorz.Green255,
              iconSizeFactor: viewModel.leadingIconSizeFactor,
              color: viewModel.leadingIconBoxColor,
              margins: EdgeInsets.zero,
              bubble: viewModel.leadingIconIsBubble,
              onTap: viewModel.onLeadingIconTap,
            ),

          /// --- HEADLINE
          Container(
            width: _headlineWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SuperVerse(
              verse: viewModel.headlineVerse,
              color: viewModel.headlineColor,
              maxLines: 3,
              centered: viewModel.centered,
              redDot: viewModel.redDot,
              margin: const EdgeInsets.only(bottom: verseBottomMargin),
              highlight: viewModel.headlineVerse?.notifier,
            ),
          ),

          const Expander(),

          if (viewModel.hasSwitch == true)
            BubbleSwitcher(
              width: _switcherWidth,
              height: iconBoxSize,
              switchIsOn: viewModel.switchValue,
              onSwitch: viewModel.onSwitchTap,
            ),

          if (viewModel.hasMoreButton == true)
            DreamBox(
              height: moreButtonSize,
              width: moreButtonSize,
              icon: Iconz.more,
              iconSizeFactor: 0.6,
              onTap: viewModel.onMoreButtonTap,
              margins: const EdgeInsets.symmetric(horizontal: 5),
            ),

        ],
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
