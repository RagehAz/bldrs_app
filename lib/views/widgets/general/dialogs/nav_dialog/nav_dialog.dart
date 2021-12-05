import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class NavDialog extends StatelessWidget {
  final String firstLine;
  final String secondLine;
  final Color color;

  const NavDialog({
    @required this.firstLine,
    @required this.secondLine,
    this.color = Colorz.darkRed255,
    Key key,
}) : super(key: key);
  
// -----------------------------------------------------------------------------
  static Future<void> showNavDialog({
    @required BuildContext context,
    @required String firstLine,
    String secondLine,
    Color color = Colorz.black255,
  }) async {

    final Color _color = color == null ? Colorz.darkRed255 : color;

    // double _screenWidth = Scale.superScreenWidth(context);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colorz.nothing,

        behavior: SnackBarBehavior.fixed,
        // width: _isBig == true ? _screenWidth : null,

        // margin: _isBig == true ? EdgeInsets.all(0) : null,
        padding: const EdgeInsets.only(),
        // onVisible: () {
        //   print('is visible now');
        // },
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
  static Future<void> showNoInternetDialog(BuildContext context) async {
    await showNavDialog(
      context: context,
      firstLine: 'No Internet',
      secondLine: 'Check your connection',
    );
  }
// -----------------------------------------------------------------------------
  bool _verseIsCentered(){

    bool _isCentered;
    if (secondLine == null){
      _isCentered = false;
    }
    else {
      _isCentered = true;
    }

    return _isCentered;
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

    return
        GestureDetector(
          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          child: Container(
            width: _screenWidth,
            height: _navBarHeight,
            alignment: Alignment.center,
            child: Container(
              height: _navBarHeight,
              width: _navBarClearWidth,
              decoration: BoxDecoration(
                color: color,
                borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: secondLine == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    height: _titleHeight,
                    width: _navBarClearWidth,
                    alignment: secondLine == null ? Alignment.center : Aligners.superCenterAlignment(context),
                    padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin,),
                    child: SuperVerse(
                      verse: firstLine,
                      scaleFactor: secondLine == null ? 0.8 : 0.9,
                      shadow: true,
                      centered: _verseIsCentered(),
                    ),
                  ),

                  if (secondLine != null)
                  Container(
                    height: _bodyHeight,
                    width: _navBarClearWidth,
                    alignment: Aligners.superCenterAlignment(context),
                    padding: const EdgeInsets.only(left: Ratioz.appBarMargin, right: Ratioz.appBarMargin, bottom: Ratioz.appBarPadding),
                    child: SuperVerse(
                      verse: secondLine,
                      size: 1,
                      color: Colorz.white200,
                      weight: VerseWeight.thin,
                      maxLines: 3,
                      centered: false,
                    ),
                  ),

                ],
              ),

            ),
          ),
        );
  }
}
