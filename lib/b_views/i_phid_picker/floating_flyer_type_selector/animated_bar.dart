import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AnimatedBar({
    @required this.curvedAnimation,
    @required this.tween,
    @required this.text,
    @required this.verseColor,
    @required this.onTap,
    @required this.icon,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CurvedAnimation curvedAnimation;
  final Tween<double> tween;
  final String text;
  final Color verseColor;
  final Function onTap;
  final String icon;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    const AppBarType _appBarType = AppBarType.basic;

    final double _appBarHeight = BldrsAppBar.height(context, _appBarType);
    final double _appBarBoxHeight = _appBarHeight + Ratioz.appBarMargin;
    // --------------------
    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (BuildContext context, Widget child) {

        final double _val = tween.evaluate(curvedAnimation);

        return SizedBox(
          width: _screenWidth,
          height: _appBarBoxHeight,
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[

              Positioned(
                left: - _screenWidth,
                top: 0,
                child: Opacity(
                  opacity: _val > 1 ? 1 : _val,
                  child: Container(
                    width: _screenWidth * 2,
                    height: _appBarBoxHeight,
                    // color: Colorz.bloodTest,
                    padding: EdgeInsets.only(left: _val * _screenWidth),
                    alignment: Alignment.centerLeft,
                    child: child,
                  ),
                ),
              ),

            ],
          ),
        );

      },
      child: Container(
        height: _appBarHeight,
        decoration: BoxDecoration(
          color: Colorz.black255,
          borderRadius: Borderers.superCorners(
            context: context,
            corners: BldrsAppBar.corners,
          ),
        ),
        margin: const EdgeInsets.only(
          top: Ratioz.appBarMargin,
          left: Ratioz.appBarMargin,
        ),
        // alignment: Alignment.bottomCenter,
        child: DreamBox(
          height: _appBarHeight - Ratioz.appBarMargin,
          verse: Verse.plain(text),
          icon: icon,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          onTap: onTap,
          verseItalic: true,

        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
