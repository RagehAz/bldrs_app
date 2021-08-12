import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class NavDialog extends StatelessWidget {
  final String firstLine;
  final String secondLine;
  final bool isBig;


  const NavDialog({
    @required this.firstLine,
    @required this.secondLine,
    this.isBig = false,
});
// -----------------------------------------------------------------------------
  static Future<void> showNavDialog({BuildContext context, String firstLine, String secondLine, bool isBig}) async {

    bool _isBig = isBig == null ? false : isBig;
    double _screenWidth = Scale.superScreenWidth(context);

    Scaffold.of(context).hideCurrentSnackBar();
    await Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 7),
        backgroundColor: Colorz.Nothing,
        behavior: _isBig == true ? SnackBarBehavior.fixed :  SnackBarBehavior.fixed,
        // width: _isBig == true ? _screenWidth : null,

        // margin: _isBig == true ? EdgeInsets.all(0) : null,
        padding: EdgeInsets.only(top: 0),
        // onVisible: () {
        //   print('is visible now');
        // },
        elevation: 0,
        content: NavDialog(
        firstLine: firstLine,
        secondLine: secondLine,
        isBig: _isBig,
          ),
      ),
    );
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
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    BarType _barType = BarType.minWithText;

    return
        isBig == true ?
        Container(
          width: _screenWidth,
          height: Scale.navBarHeight(context: context, barType: _barType),
          // color: Colorz.BloodTest,
          alignment: Alignment.center,
          child: DreamBox(
            height: Scale.navBarHeight(context: context, barType: _barType),

            width: _screenWidth - (4 * Ratioz.appBarMargin),
            color: Colorz.DarkRed255,
            // corners: 0,
            verse: firstLine,
            verseScaleFactor: secondLine == null ? 0.8 : 0.65,
            secondLine: secondLine,
            secondLineScaleFactor: 1.1,
            secondLineColor: Colorz.White200,
            verseWeight: VerseWeight.bold,
            verseColor: Colorz.White255,
            verseShadow: true,
            verseItalic: true,
            bubble: false,
            verseCentered: true,
            onTap: () => Scaffold.of(context).hideCurrentSnackBar(),
          ),
        )
            :
        userModelBuilder(
            context: context,
            userID: superUserID(),
            builder: (ctx, userModel){
              return
                Container(
                  width: Scale.superScreenWidth(context),
                  height: Scale.navBarHeight(context: context, barType: _barType),
                  color: Colorz.Nothing,
                  alignment: Alignment.center,
                  child: DreamBox(
                    height: Scale.navBarHeight(context: context, barType: _barType),
                    width: Scale.navBarWidth(context: context,userModel: userModel, barType: _barType),
                    color: Colorz.DarkRed255,
                    corners: Scale.navBarCorners(context: context, barType: _barType),
                    verse: firstLine,
                    verseScaleFactor: secondLine == null ? 0.8 : 0.65,
                    secondLine: secondLine,
                    secondLineScaleFactor: 1.1,
                    secondLineColor: Colorz.White200,
                    verseWeight: VerseWeight.bold,
                    verseColor: Colorz.White255,
                    verseShadow: true,
                    verseItalic: true,
                    bubble: false,
                    verseCentered: true,
                    onTap: () => Scaffold.of(context).hideCurrentSnackBar(),
                  ),
                );
            }
        );
  }
}
