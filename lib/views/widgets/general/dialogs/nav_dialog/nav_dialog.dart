import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/providers/users/user_streamer.dart';


class NavDialog extends StatelessWidget {
  final String firstLine;
  final String secondLine;
  final bool isBig;
  final Color color;


  const NavDialog({
    @required this.firstLine,
    @required this.secondLine,
    this.isBig = false,
    this.color = Colorz.DarkRed255,
});
// -----------------------------------------------------------------------------
  static Future<void> showNavDialog({BuildContext context, String firstLine, String secondLine, bool isBig, Color color}) async {

    final Color _color = color == null ? Colorz.DarkRed255 : color;

    final bool _isBig = isBig == null ? false : isBig;
    // double _screenWidth = Scale.superScreenWidth(context);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    await ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
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
          color: _color,
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

    final double _screenWidth = Scale.superScreenWidth(context);
    const BarType _barType = BarType.minWithText;

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
            color: color,
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
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
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
                    onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                );
            }
        );
  }
}
