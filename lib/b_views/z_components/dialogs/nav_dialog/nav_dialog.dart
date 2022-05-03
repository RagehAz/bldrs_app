import 'package:bldrs/b_views/z_components/nav_bar/nav_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
class NavDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NavDialog({
    @required this.firstLine,
    @required this.secondLine,
    this.color = Colorz.darkRed255,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String firstLine;
  final String secondLine;
  final Color color;
  /// --------------------------------------------------------------------------
  static Future<void> showNavDialog({
    @required BuildContext context,
    @required String firstLine,
    String secondLine,
    Color color = Colorz.black255,
    double seconds,
  }) async {

    final Color _color = color ?? Colorz.darkRed255;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds ?? 5),
        backgroundColor: Colorz.nothing,
        behavior: SnackBarBehavior.fixed,
        padding: EdgeInsets.zero,
        // onVisible: () {print('is visible now');},
        elevation: 0,
        content: NavDialog(
          firstLine: firstLine,
          secondLine: secondLine,
          color: _color,
        ),
      ),
    );
    // await null;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    // const BarType _barType = BarType.minWithText;

    final double _navBarHeight = NavBar.navBarHeight(context: context);
    final double _navBarClearWidth = _screenWidth - (4 * Ratioz.appBarMargin);
    final double _titleHeight = secondLine == null ? _navBarHeight : _navBarHeight * 0.35;
    final double _bodyHeight = secondLine == null ? 0 : (_navBarHeight - _titleHeight);

    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      child: Container(
        width: _screenWidth,
        height: _navBarHeight + NavBar.navbarPaddings,
        alignment: Alignment.topCenter,
        child: Container(
          height: _navBarHeight,
          width: _navBarClearWidth,
          decoration: BoxDecoration(
            color: color,
            borderRadius: NavBar.navBarCorners(context: context),
            boxShadow: Shadowz.appBarShadow,
          ),
          alignment: Alignment.center,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                width: _navBarClearWidth,
                child: SuperVerse(
                  verse: firstLine,
                  scaleFactor: 1.1,
                  shadow: true,
                  margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin,),
                ),
              ),

              if (secondLine != null)
                SizedBox(
                  width: _navBarClearWidth,
                  child: SuperVerse(
                    verse: secondLine,
                    color: Colorz.white200,
                    weight: VerseWeight.thin,
                    maxLines: 3,
                    margin: const EdgeInsets.only(
                        left: Ratioz.appBarMargin,
                        right: Ratioz.appBarMargin,
                        bottom: Ratioz.appBarPadding
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
