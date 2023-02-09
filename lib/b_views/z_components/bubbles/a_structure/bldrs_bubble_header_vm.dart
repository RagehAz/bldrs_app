import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

@immutable
class BldrsBubbleHeaderVM {
  /// --------------------------------------------------------------------------
  const BldrsBubbleHeaderVM({
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
  static BubbleHeaderVM bake({
    double headerWidth,
    dynamic leadingIcon,
    double leadingIconSizeFactor = 1,
    Color leadingIconBoxColor,
    bool leadingIconIsBubble = false,
    Function onLeadingIconTap,
    bool hasSwitch = false,
    bool hasMoreButton = false,
    Verse headlineVerse,
    Color headlineColor = Colorz.white255,
    bool centered = false,
    bool switchValue = false,
    ValueChanged<bool> onSwitchTap,
    Function onMoreButtonTap,
    bool redDot = false,
    VerseWeight weight = VerseWeight.black,
  }){
    
        final BuildContext context = getContext();

        final double _textSizeValue = SuperVerse.superVerseRealHeight(context: context, size: 2, sizeFactor: 1, hasLabelBox: false);

        return BubbleHeaderVM(
          headerWidth: headerWidth,
          leadingIcon: leadingIcon,
          leadingIconSizeFactor: leadingIconSizeFactor,
          leadingIconBoxColor: leadingIconBoxColor,
          leadingIconIsBubble: leadingIconIsBubble,
          onLeadingIconTap: onLeadingIconTap,
          hasSwitch: hasSwitch,
          hasMoreButton: hasMoreButton,
          headlineText: Verse.bakeVerseToString(context: context, verse: headlineVerse),
          headlineColor: headlineColor,
          switchValue: switchValue,
          onSwitchTap: onSwitchTap,
          onMoreButtonTap: onMoreButtonTap,
          redDot: redDot,
          centered: centered,
          font: SuperVerse.superVerseFont(context, weight),
          headlineHighlight: headlineVerse?.notifier,
          headlineHeight: _textSizeValue,
          appIsLTR: UiProvider.checkAppIsLeftToRight(context),
          textDirection: UiProvider.getAppTextDir(context),
          // moreButtonIcon: Iconz.more,
          // moreButtonIconSizeFactor: 0.6,
          switchActiveColor: Colorz.yellow255,
          switchDisabledColor: Colorz.grey255,
          switchDisabledTrackColor: Colorz.grey80,
          switchFocusColor: Colorz.white255,
          switchTrackColor: Colorz.yellow80,

          wordSpacing: SuperVerse.superVerseWordSpacing(_textSizeValue),
          letterSpacing: SuperVerse.superVerseWordSpacing(_textSizeValue),
          
        );
      }
  /// --------------------------------------------------------------------------
  BldrsBubbleHeaderVM copyWith({
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
    return BldrsBubbleHeaderVM(
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
  final BldrsBubbleHeaderVM viewModel;
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
    final double _bubbleWidth = Bubble.clearWidth(
      context: context,
      bubbleWidthOverride: viewModel.headerWidth,
    );
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

          // const SizedBox(
          //   width: 5,
          // ),

          if (viewModel.hasMoreButton == true)
            DreamBox(
              height: moreButtonSize,
              width: moreButtonSize,
              icon: Iconz.more,
              iconSizeFactor: 0.6,
              onTap: viewModel.onMoreButtonTap,
              // margins: const EdgeInsets.symmetric(horizontal: 5),
            ),

        ],
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
