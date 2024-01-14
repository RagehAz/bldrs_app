import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/bubbles/bubble/bubble_switcher.dart';
import 'package:basics/components/bubbles/model/bubble_header_vm.dart';
import 'package:basics/components/drawing/expander.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

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
    this.moreButtonIcon = Iconz.more,
  });
  /// --------------------------------------------------------------------------
  final double? headerWidth;
  final dynamic leadingIcon;
  final double leadingIconSizeFactor;
  final Color? leadingIconBoxColor;
  final bool leadingIconIsBubble;
  final Function? onLeadingIconTap;
  final bool hasSwitch;
  final bool hasMoreButton;
  final Verse? headlineVerse;
  final Color headlineColor;
  final bool centered;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchTap;
  final Function? onMoreButtonTap;
  final bool redDot;
  final String moreButtonIcon;
  /// --------------------------------------------------------------------------
  static BubbleHeaderVM bake({
    required BuildContext context,
    double? headerWidth,
    dynamic leadingIcon,
    double leadingIconSizeFactor = 1,
    Color? leadingIconBoxColor,
    bool leadingIconIsBubble = false,
    Function? onLeadingIconTap,
    bool hasSwitch = false,
    bool hasMoreButton = false,
    Verse? headlineVerse,
    Color headlineColor = Colorz.white255,
    bool centered = false,
    bool? switchValue = false,
    ValueChanged<bool>? onSwitchTap,
    Function? onMoreButtonTap,
    bool redDot = false,
    VerseWeight weight = VerseWeight.black,
    TextDirection? textDirection,
    bool? appIsLTR,
    bool loading = false,
    String? moreButtonIcon,
  }){

        final double _textSizeValue = BldrsText.superVerseRealHeight(context: context, size: 2, sizeFactor: 1, hasLabelBox: false);

        return BubbleHeaderVM(
          headerWidth: headerWidth,
          leadingIcon: leadingIcon,
          leadingIconSizeFactor: leadingIconSizeFactor,
          leadingIconBoxColor: leadingIconBoxColor,
          leadingIconIsBubble: leadingIconIsBubble,
          loading: loading,
          onLeadingIconTap: onLeadingIconTap,
          hasSwitch: hasSwitch,
          hasMoreButton: hasMoreButton,
          headlineText: Verse.bakeVerseToString(verse: headlineVerse),
          headlineColor: headlineColor,
          switchValue: switchValue ?? false,
          onSwitchTap: onSwitchTap,
          onMoreButtonTap: onMoreButtonTap,
          moreButtonIcon: moreButtonIcon,
          redDot: redDot,
          centered: centered,
          font: BldrsText.superVerseFont(weight),
          headlineHighlight: headlineVerse?.notifier,
          headlineHeight: _textSizeValue,
          appIsLTR: appIsLTR ?? UiProvider.checkAppIsLeftToRight(),
          textDirection: textDirection ?? UiProvider.getAppTextDir(),
          // moreButtonIcon: Iconz.more,
          // moreButtonIconSizeFactor: 0.6,
          switchActiveColor: Colorz.yellow255,
          switchDisabledColor: Colorz.grey255,
          switchDisabledTrackColor: Colorz.grey80,
          switchFocusColor: Colorz.white255,
          switchTrackColor: Colorz.yellow80,

          wordSpacing: BldrsText.superVerseWordSpacing(
            verseSize: _textSizeValue,
            weight: weight,
          ),
          letterSpacing: BldrsText.superVerseWordSpacing(
            verseSize: _textSizeValue,
            weight: weight,
          ),
          
        );
      }
  /// --------------------------------------------------------------------------
  BldrsBubbleHeaderVM copyWith({
    double? headerWidth,
    dynamic leadingIcon,
    double? leadingIconSizeFactor,
    Color? leadingIconBoxColor,
    bool? leadingIconIsBubble,
    bool? hasSwitch,
    bool? hasMoreButton,
    Verse? headlineVerse,
    Color? headlineColor,
    bool? switchValue,
    ValueChanged<bool>? onSwitchTap,
    Function? onMoreButtonTap,
    bool? redDot,
    Function? onLeadingIconTap,
    bool? centered,
    String? moreButtonIcon,
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
      moreButtonIcon: moreButtonIcon ?? this.moreButtonIcon,
    );
  }
  /// --------------------------------------------------------------------------
}

class BldrsBubbleHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsBubbleHeader({
    required this.viewModel,
    super.key
  });
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
            BldrsBox(
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
            child: BldrsText(
              verse: viewModel.headlineVerse,
              color: viewModel.headlineColor,
              maxLines: 3,
              centered: viewModel.centered,
              redDot: viewModel.redDot,
              margin: const EdgeInsets.only(bottom: verseBottomMargin),
              highlight: viewModel.headlineVerse?.notifier,
              textDirection: UiProvider.getAppTextDir(),
            ),
          ),

          const Expander(),

          /// SWITCH
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

          /// MORE BUTTON
          if (viewModel.hasMoreButton == true)
            BldrsBox(
              height: moreButtonSize,
              width: moreButtonSize,
              icon: viewModel.moreButtonIcon,
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
