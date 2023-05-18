part of bldrs_app_bar;

class AppBarButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarButton({
    this.verse,
    this.verseColor = Colorz.white255,
    this.buttonColor = Colorz.white20,
    this.onTap,
    this.onDeactivatedTap,
    this.icon,
    this.bubble = true,
    this.isDeactivated = false,
    this.bigIcon = false,
    this.width,
    this.loading,
    this.iconColor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final Color verseColor;
  final Color buttonColor;
  final Function onTap;
  final Function onDeactivatedTap;
  final dynamic icon;
  final bool bubble;
  final bool isDeactivated;
  final bool bigIcon;
  final double width;
  final bool loading;
  final Color iconColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: Ratioz.appBarButtonSize,
      width: width,
      // width: Ratioz.appBarButtonSize * 3.5,
      margins: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enLeft: Ratioz.appBarPadding,
      ),
      verse: verse,
      icon: icon,
      verseColor: verseColor,
      // verseScaleFactor: 1,
      color: buttonColor,
      iconSizeFactor: bigIcon == true ? 1 : 0.6,
      bubble: bubble,
      iconColor: iconColor,
      onTap: onTap,
      isDisabled: isDeactivated,
      onDisabledTap: onDeactivatedTap,
      verseMaxLines: 2,
      loading: loading,
      // loading: loading,
    );

  }
  /// --------------------------------------------------------------------------
}
