import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
enum BottomSheetType {
  Country,
  Province,
  District,
  Language,
  BottomSheet,
}
// -----------------------------------------------------------------------------
/// TASK: should check draggable scrollable sheet
class BottomDialog extends StatelessWidget {
  final double height;
  final bool draggable;
  final Widget child;
  final String title;

  BottomDialog({
    this.height,
    this.draggable = true,
    this.child,
    this.title,
});

// -----------------------------------------------------------------------------
  /// one side value only
  static double draggerMarginValue({@required bool draggable}){
    double _draggerHeight = draggerHeight(draggable: draggable);
    double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    double _draggerMarginValue = draggable != true ? 0 : (_draggerZoneHeight - _draggerHeight)/2;
    return _draggerMarginValue;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets draggerMargins({@required bool draggable}){
    EdgeInsets _draggerMargins = EdgeInsets.symmetric(vertical: draggerMarginValue(draggable: draggable));
    return _draggerMargins;

  }
// -----------------------------------------------------------------------------
  static double draggerZoneHeight({@required bool draggable}){
    double _draggerZoneHeight = draggable == true ? Ratioz.appBarMargin * 3 : 0;
    return _draggerZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double draggerHeight({@required bool draggable}){
    double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    double _draggerHeight = _draggerZoneHeight * 0.35 * 0.5;
    return _draggerHeight;
  }
// -----------------------------------------------------------------------------
  static double draggerWidth(BuildContext context){
      double _draggerWidth = Scale.superScreenWidth(context) * 0.35;
    return _draggerWidth;
  }
// -----------------------------------------------------------------------------
  static double titleZoneHeight({@required bool titleIsOn}){
    bool _titleIsOn = titleIsOn == null ? false : titleIsOn;

    double _titleZoneHeight = _titleIsOn == true ? Ratioz.appBarSmallHeight :  0;

    return _titleZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double dialogWidth(BuildContext context){
    return Scale.superScreenWidth(context);
  }
// -----------------------------------------------------------------------------
  static double dialogMarginValue(){
    return
      Ratioz.appBarMargin + Ratioz.appBarPadding;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets dialogMargins(){
    EdgeInsets _margins = EdgeInsets.symmetric(horizontal: dialogMarginValue());
    return _margins;
  }
// -----------------------------------------------------------------------------
  static double dialogClearWidth(BuildContext context){
    double _dialogClearWidth = Scale.superScreenWidth(context) - (dialogMarginValue() * 2);
    return _dialogClearWidth;
  }
// -----------------------------------------------------------------------------
  static double dialogHeight(BuildContext context, {double overridingDialogHeight, double ratioOfScreenHeight}){
    double _dialogHeight;
    double _screenHeight = Scale.superScreenHeight(context);

    double _ratioOfScreenHeight = ratioOfScreenHeight == null ? 0.5 : ratioOfScreenHeight;

    if (overridingDialogHeight == null){
      _dialogHeight =  _screenHeight * _ratioOfScreenHeight;
    }
    else {
      _dialogHeight = overridingDialogHeight;
    }

    return _dialogHeight;
  }
// -----------------------------------------------------------------------------
  static double dialogClearHeight({BuildContext context, double overridingDialogHeight, bool titleIsOn, @required bool draggable}){

    // bool _draggable = draggable == null ? false : draggable;

    double _dialogHeight = dialogHeight(context, overridingDialogHeight: overridingDialogHeight);
    double _titleZoneHeight = titleZoneHeight(titleIsOn: titleIsOn);
    double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);

    double _dialogClearHeight = _dialogHeight - _titleZoneHeight - _draggerZoneHeight;
    return _dialogClearHeight;
  }
// -----------------------------------------------------------------------------
  static BorderRadius dialogCorners(BuildContext context){
    BorderRadius _dialogCorners = Borderers.superBorderOnly(
        context: context,
        enTopLeft: Ratioz.bottomSheetCorner,
        enBottomLeft: 0,
        enBottomRight: 0,
        enTopRight: Ratioz.bottomSheetCorner
    );
    return _dialogCorners;
  }
// -----------------------------------------------------------------------------
  static double dialogClearCornerValue({double corner}){
    double _corner = corner == null ? Ratioz.appBarCorner : corner ;
      return _corner;
  }
// -----------------------------------------------------------------------------
  static BorderRadius dialogClearCorners(BuildContext context){
    BorderRadius _corners = Borderers.superBorderOnly(
      context: context,
      enBottomRight: 0,
      enBottomLeft: 0,
      enTopRight: dialogClearCornerValue(),
      enTopLeft: dialogClearCornerValue(),
    );
    return _corners;
  }
// -----------------------------------------------------------------------------
  static Future<void> slideBottomDialog({BuildContext context, double height, bool draggable, Widget child, String title}) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius:
        Borderers.superBorderOnly(
          context:context,
          enTopLeft:Ratioz.bottomSheetCorner,
          enBottomLeft:0,
          enBottomRight:0,
          enTopRight:Ratioz.bottomSheetCorner,
        )),
        backgroundColor: Colorz.BlackSemi255,
        barrierColor: Colorz.Black150,
        enableDrag: draggable,
        elevation: 20,
        isScrollControlled: true,
        context: context,
        builder: (bCtx){
          return Container(
            height: height,
            width: Scale.superScreenWidth(context),
            child: Scaffold(
              backgroundColor: Colorz.Nothing,
              body: BottomDialog(
                height: height,
                draggable: draggable,
                title: title,
                child: child,
              ),
            ),
          );}
    );
  }
// -----------------------------------------------------------------------------
  static void slideButtonsBottomDialog({
    BuildContext context,
    bool draggable,
    List<Widget> buttons,
    double buttonHeight,
  }){

    double _spacing = buttonHeight * 0.1;
    double _height = (buttonHeight * buttons.length) + (_spacing * buttons.length) + 30 ;

    slideBottomDialog(
      context: context,
      draggable: draggable,
      height: _height,
      child: ListView.builder(
        itemCount: buttons.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (ctx, index){
          return
            Column(
              children: <Widget>[

                buttons[index],

                SizedBox(height: _spacing),

              ],
            );
        },

      ),
    );
  }
// -----------------------------------------------------------------------------
  static Future<void> slideStatefulBottomDialog({BuildContext context, double height, bool draggable, Widget Function(BuildContext, String) builder, String title}) async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BottomDialog.dialogCorners(context)),
      backgroundColor: Colorz.BlackSemi255,
      barrierColor: Colorz.Black150,
      enableDrag: draggable,
      elevation: 20,
      isScrollControlled: true,
      context: context,
      builder: (context) => builder(context, title),
    );
  }
// -----------------------------------------------------------------------------
  static void slideBzBottomDialog({BuildContext context, BzModel bz, AuthorModel author}) {

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, 0.71);

    BottomDialog.slideBottomDialog(
        context: context,
        height: Scale.superScreenHeight(context) - 100,
        draggable: true,
        child: Center(
          child: FinalFlyer(
            flyerZoneWidth: _flyerZoneWidth,
            goesToEditor: false,
            flyerModel: FlyerModel(
              flyerID: null,
              tinyBz: TinyBz.getTinyBzFromBzModel(bz),
              tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(author),
              flyerZone: bz.bzZone,
              info: '',

            ),

          ),
        ));
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    double _dialogWidth = dialogWidth(context);
    double _dialogHeight = dialogHeight(context, overridingDialogHeight: height);
    BorderRadius _dialogCorners = dialogCorners(context);

    double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    double _draggerHeight = draggerHeight(draggable: draggable);
    double _draggerWidth = draggerWidth(context);
    double _draggerCorner = _draggerHeight *0.5;
    EdgeInsets _draggerMargins = draggerMargins(draggable: draggable);

    bool _titleIsOn = title == null || TextMod.removeSpacesFromAString(title) == '' ? false : true;

    double _titleZoneHeight = titleZoneHeight(titleIsOn: _titleIsOn);

    double _dialogClearWidth = dialogClearWidth(context);
    double _dialogClearHeight  = dialogClearHeight(context: context, titleIsOn: _titleIsOn, overridingDialogHeight: height, draggable: draggable);
    BorderRadius _dialogClearCorners = dialogClearCorners(context);

    return Container(
      width: _dialogWidth,
      height: _dialogHeight,
      decoration: BoxDecoration(
        color: Colorz.White10,
        borderRadius: _dialogCorners,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// --- SHADOW LAYER
          Container(
            width: _dialogWidth,
            height: _dialogHeight,
            decoration: BoxDecoration(
                borderRadius: _dialogCorners,
                boxShadow: Shadowz.appBarShadow,
            ),
          ),

          /// --- BLUR LAYER
          BlurLayer(
            width: _dialogWidth,
            height: _dialogHeight,
            borders: _dialogCorners,
          ),

          /// --- DIALOG CONTENTS
          Container(
            width: _dialogWidth,
            height: _dialogHeight,
            child: Column(
              children: <Widget>[

                /// --- DRAGGER
                if (draggable == true)
                Container(
                  width : _dialogWidth,
                  height: _draggerZoneHeight,
                  alignment: Alignment.center,
                  // color: Colorz.BloodTest,
                  child: Container(
                    width: _draggerWidth,
                    height: _draggerHeight,
                    margin: _draggerMargins,
                    decoration: BoxDecoration(
                      color: Colorz.White200,
                      borderRadius: Borderers.superBorderAll(context, _draggerCorner),
                    ),
                  ),
                ),

                /// --- TITLE
                if (title != null)
                Container(
                  width: _dialogWidth,
                  height: _titleZoneHeight,
                  alignment: Alignment.center,
                  // color: Colorz.BloodTest,
                  child: SuperVerse(
                    verse: title,
                    size: 2,
                    color: Colorz.White255,
                    centered: true,
                  ),
                ),

                /// --- DIALOG CONTENT
                Container(
                  width: _dialogClearWidth,
                  height: _dialogClearHeight,
                  decoration: BoxDecoration(
                    color: Colorz.White10,
                    borderRadius: _dialogClearCorners,
                    // gradient: Colorizer.superHeaderStripGradient(Colorz.White20)
                  ),
                  child: child,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
// -----------------------------------------------------------------------------