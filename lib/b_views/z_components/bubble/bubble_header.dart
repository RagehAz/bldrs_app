import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_switcher.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class BubbleHeaderVM {
  /// --------------------------------------------------------------------------
  const BubbleHeaderVM({
    this.headerWidth,
    this.leadingIcon,
    this.leadingIconSizeFactor = 1,
    this.leadingIconBoxColor,
    this.leadingIconIsBubble = false,
    this.hasSwitch = false,
    this.hasMoreButton = false,
    this.headlineVerse,
    this.headlineColor = Colorz.white255,
    this.switchIsOn,
    this.onSwitchTap,
    this.onMoreButtonTap,
  });
  /// --------------------------------------------------------------------------
  final double headerWidth;
  final String leadingIcon;
  final double leadingIconSizeFactor;
  final Color leadingIconBoxColor;
  final bool leadingIconIsBubble;
  final bool hasSwitch;
  final bool hasMoreButton;
  final String headlineVerse;
  final Color headlineColor;
  final bool switchIsOn;
  final ValueChanged<bool> onSwitchTap;
  final Function onMoreButtonTap;
/// --------------------------------------------------------------------------
  BubbleHeaderVM copyWith({
    double headerWidth,
    String leadingIcon,
    double leadingIconSizeFactor,
    Color leadingIconBoxColor,
    bool leadingIconIsBubble,
    bool hasSwitch,
    bool hasMoreButton,
    String headlineVerse,
    Color headlineColor,
    bool switchIsOn,
    ValueChanged<bool> onSwitchTap,
    Function onMoreButtonTap,
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
      switchIsOn: switchIsOn ?? this.switchIsOn,
      onSwitchTap: onSwitchTap ?? this.onSwitchTap,
      onMoreButtonTap: onMoreButtonTap ?? this.onMoreButtonTap,
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
  /// --------------------------------------------------------------------------
  static const double iconBoxSize = 30;
  static const double switcherButtonWidth = 50;
  static const double moreButtonSize = iconBoxSize;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = viewModel.headerWidth ?? Bubble.clearWidth(context);

    /// LEADING ICON
    final bool _hasIcon = viewModel.leadingIcon != null;
    final double _leadingIconWidth = _hasIcon == true ? iconBoxSize : 0;

    /// SWITCHER
    final double _switcherWidth = viewModel.hasSwitch == true ? switcherButtonWidth : 0;

    /// MORE BUTTON
    final double _moreButtonWidth = viewModel.hasMoreButton == true ? moreButtonSize : 0;

    /// HEADLINE
    final double _headlineWidth = _bubbleWidth - _leadingIconWidth - _switcherWidth - _moreButtonWidth;

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
          ),

        /// --- HEADLINE
        Container(
          width: _headlineWidth,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SuperVerse(
            verse: viewModel.headlineVerse,
            color: viewModel.headlineColor,
            maxLines: 2,
            centered: false,
          ),
        ),

        const Expander(),

        if (viewModel.hasSwitch == true)
          BubbleSwitcher(
            width: _switcherWidth,
            height: iconBoxSize,
            switchIsOn: viewModel.switchIsOn,
            onSwitch: viewModel.onSwitchTap,
          ),

        if (viewModel.hasMoreButton == true)
          DreamBox(
            height: moreButtonSize,
            width: moreButtonSize,
            icon: Iconz.more,
            iconSizeFactor: 0.6,
            onTap: viewModel.onMoreButtonTap,
          ),

      ],
    );

  }
}
