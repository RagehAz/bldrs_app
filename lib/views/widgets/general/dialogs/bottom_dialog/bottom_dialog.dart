import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/widgets/general/artworks/blur_layer.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/buttons/flagbox_button.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
enum BottomDialogType {
  countries,
  cities,
  districts,
  languages,
  bottomSheet,
}
// -----------------------------------------------------------------------------
/// TASK: should check draggable scrollable sheet
class BottomDialog extends StatelessWidget {
  final double height;
  final bool draggable;
  final Widget child;
  final String title;

  const BottomDialog({
    this.height,
    this.draggable = true,
    this.child,
    this.title,
    Key key,
}) : super(key: key);

// -----------------------------------------------------------------------------
  /// one side value only
  static double draggerMarginValue({@required bool draggable}){
    final double _draggerHeight = draggerHeight(draggable: draggable);
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerMarginValue = draggable != true ? 0 : (_draggerZoneHeight - _draggerHeight)/2;
    return _draggerMarginValue;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets draggerMargins({@required bool draggable}){
    final EdgeInsets _draggerMargins = EdgeInsets.symmetric(vertical: draggerMarginValue(draggable: draggable));
    return _draggerMargins;

  }
// -----------------------------------------------------------------------------
  static double draggerZoneHeight({@required bool draggable}){
    final double _draggerZoneHeight = draggable == true ? Ratioz.appBarMargin * 3 : 0;
    return _draggerZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double draggerHeight({@required bool draggable}){
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerHeight = _draggerZoneHeight * 0.35 * 0.5;
    return _draggerHeight;
  }
// -----------------------------------------------------------------------------
  static double draggerWidth(BuildContext context){
    final double _draggerWidth = Scale.superScreenWidth(context) * 0.35;
    return _draggerWidth;
  }
// -----------------------------------------------------------------------------
  static double titleZoneHeight({@required bool titleIsOn}){
    final bool _titleIsOn = titleIsOn == null ? false : titleIsOn;
    final double _titleZoneHeight = _titleIsOn == true ? Ratioz.appBarSmallHeight :  0;

    return _titleZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double dialogWidth(BuildContext context){
    return Scale.superScreenWidth(context);
  }
// -----------------------------------------------------------------------------
  static const double dialogMarginValue = Ratioz.appBarMargin + Ratioz.appBarPadding;
// -----------------------------------------------------------------------------
  static const EdgeInsets dialogMargins = const EdgeInsets.symmetric(horizontal: dialogMarginValue);
// -----------------------------------------------------------------------------
  static double dialogClearWidth(BuildContext context){
    final double _dialogClearWidth = Scale.superScreenWidth(context) - (dialogMarginValue * 2);
    return _dialogClearWidth;
  }
// -----------------------------------------------------------------------------
  static double dialogHeight(BuildContext context, {double overridingDialogHeight, double ratioOfScreenHeight}){
    double _dialogHeight;
    final double _screenHeight = Scale.superScreenHeight(context);

    final double _ratioOfScreenHeight = ratioOfScreenHeight == null ? 0.5 : ratioOfScreenHeight;

    if (overridingDialogHeight == null){
      _dialogHeight =  _screenHeight * _ratioOfScreenHeight;
    }
    else {
      _dialogHeight = overridingDialogHeight;
    }

    return _dialogHeight;
  }
// -----------------------------------------------------------------------------
  static double dialogClearHeight({@required BuildContext context, double overridingDialogHeight, bool titleIsOn, @required bool draggable}){

    // bool _draggable = draggable == null ? false : draggable;

    final double _dialogHeight = dialogHeight(context, overridingDialogHeight: overridingDialogHeight);
    final double _titleZoneHeight = titleZoneHeight(titleIsOn: titleIsOn);
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);

    final double _dialogClearHeight = _dialogHeight - _titleZoneHeight - _draggerZoneHeight;
    return _dialogClearHeight;
  }
// -----------------------------------------------------------------------------
  static BorderRadius dialogCorners(BuildContext context){
    final BorderRadius _dialogCorners = Borderers.superBorderOnly(
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
    final double _corner = corner == null ? Ratioz.appBarCorner : corner ;
    return _corner;
  }
// -----------------------------------------------------------------------------
  static BorderRadius dialogClearCorners(BuildContext context){
    final BorderRadius _corners = Borderers.superBorderOnly(
      context: context,
      enBottomRight: 0,
      enBottomLeft: 0,
      enTopRight: dialogClearCornerValue(),
      enTopLeft: dialogClearCornerValue(),
    );
    return _corners;
  }
// -----------------------------------------------------------------------------
  static Future<void> showBottomDialog({@required BuildContext context, double height, @required bool draggable, @required Widget child, String title}) async {

    final double _height = height ?? BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.5);

    await showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius:
        Borderers.superBorderOnly(
          context:context,
          enTopLeft:Ratioz.bottomSheetCorner,
          enBottomLeft:0,
          enBottomRight:0,
          enTopRight:Ratioz.bottomSheetCorner,
        )),
        backgroundColor: Colorz.blackSemi255,
        barrierColor: Colorz.black150,
        enableDrag: draggable,
        elevation: 20,
        isScrollControlled: true,
        context: context,
        builder: (bCtx){
          return Container(
            height: _height,
            width: Scale.superScreenWidth(context),
            child: Scaffold(
              backgroundColor: Colorz.nothing,
              resizeToAvoidBottomInset: false,
              body: BottomDialog(
                height: _height,
                draggable: draggable,
                title: title,
                child: child,
              ),
            ),
          );}
    );
  }
// -----------------------------------------------------------------------------
  static Future<void> showButtonsBottomDialog({
    @required BuildContext context,
    @required bool draggable,
    @required List<Widget> buttons,
    @required double buttonHeight,
  }) async {

    final double _spacing = buttonHeight * 0.1;
    final double _height = (buttonHeight * buttons.length) + (_spacing * buttons.length) + 30 ;

    await showBottomDialog(
      context: context,
      draggable: draggable,
      height: _height,
      child: ListView.builder(
        itemCount: buttons.length,
        physics: const BouncingScrollPhysics(),
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
  static Future<void> showStatefulBottomDialog({@required BuildContext context, @required double height, @required bool draggable, @required Widget Function(BuildContext, String) builder, @required String title}) async {

    final double _height = height ?? BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.5);

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BottomDialog.dialogCorners(context)),
      backgroundColor: Colorz.blackSemi255,
      barrierColor: Colorz.black150,
      enableDrag: draggable,
      elevation: 20,
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        height: _height,
        width: Scale.superScreenWidth(context),
        child: Scaffold(
          backgroundColor: Colorz.nothing,
          resizeToAvoidBottomInset: false,
          body: BottomDialog(
            height: _height,
            draggable: draggable,
            title: title,
            child: builder(context, title),
          ),
        )

      ),
    );
  }
// -----------------------------------------------------------------------------
  static Future<void> slideBzBottomDialog({@required BuildContext context, @required BzModel bz, @required AuthorModel author}) async {

    final double _flyerBoxWidth = FlyerBox.width(context, 0.71);

    await BottomDialog.showBottomDialog(
        context: context,
        height: Scale.superScreenHeight(context) - 100,
        draggable: true,
        child: Center(
          child: FinalFlyer(
            flyerBoxWidth: _flyerBoxWidth,
            goesToEditor: false,
            flyerModel: FlyerModel(
              id: null,
              title: '',
              bzID: bz.id,
              authorID: author.userID,
              zone: bz.zone,
              info: '',
              priceTagIsOn: false,
              position: null,
              flyerType: null,
              times: [],
              slides: [],
              isBanned: null,
              keywordsIDs: [],
              specs: [],
              trigram: [],
              flyerState: FlyerState.draft,
              showsAuthor: false,
            ),
            onSwipeFlyer: (SwipeDirection direction){
              // print('Direction is ${direction}');
            },
          ),
        ));
  }
// -----------------------------------------------------------------------------
  static Widget wideButton({@required BuildContext context, @required String verse, Function onTap, String icon}){

    return
      DreamBox(
        height: 40,
        width: dialogClearWidth(context),
        verse: verse.toUpperCase(),
        verseWeight: VerseWeight.black,
        verseItalic: true,
        icon: icon,
        onTap: onTap,
      );
  }
// -----------------------------------------------------------------------------
  static Future<String> keyboardDialog({@required BuildContext context, String hintText, @required String flag}) async { /// TASK flag is temp

    final TextEditingController _textController = TextEditingController();

    const double _ratioOfScreenHeight = 0.65;
    final double _overridingDialogHeight = dialogHeight(context, ratioOfScreenHeight: _ratioOfScreenHeight);
    final double _clearWidth = dialogClearWidth(context);
    final double _clearHeight = dialogClearHeight(context: context, overridingDialogHeight: _overridingDialogHeight, draggable: true, titleIsOn: false);
    final double _corners = dialogClearCornerValue();

    await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        height: _overridingDialogHeight,
        child: Container(
          width: _clearWidth,
          height: _clearHeight,
          // color: Colorz.BloodTest,
          child: Column(
            children: <Widget>[

              SuperTextField(
                textController: _textController,
                width: _clearWidth,
                height: 200,
                maxLines: 2,
                keyboardTextInputAction: TextInputAction.done,
                onSubmitted: (String val) async {

                  await Nav.goBack(context);
                },
                counterIsOn: true,
                hintText: hintText ?? 'text here ...',
                corners: _corners,
              ),

              if (flag != null)
              FlagBox(flag: Flag.getFlagIconByCountryID(flag))

            ],
          ),
        ),
    );

    return _textController.text;
  }

  @override
  Widget build(BuildContext context) {


    final double _dialogWidth = dialogWidth(context);
    final double _dialogHeight = dialogHeight(context, overridingDialogHeight: height);
    final BorderRadius _dialogCorners = dialogCorners(context);

    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerHeight = draggerHeight(draggable: draggable);
    final double _draggerWidth = draggerWidth(context);
    final double _draggerCorner = _draggerHeight *0.5;
    final EdgeInsets _draggerMargins = draggerMargins(draggable: draggable);

    final bool _titleIsOn = title == null || TextMod.removeSpacesFromAString(title) == '' ? false : true;

    final double _titleZoneHeight = titleZoneHeight(titleIsOn: _titleIsOn);

    final double _dialogClearWidth = dialogClearWidth(context);
    final double _dialogClearHeight  = dialogClearHeight(context: context, titleIsOn: _titleIsOn, overridingDialogHeight: height, draggable: draggable);
    final BorderRadius _dialogClearCorners = dialogClearCorners(context);

    return Container(
      width: _dialogWidth,
      height: _dialogHeight,
      decoration: BoxDecoration(
        color: Colorz.white10,
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
                      color: Colorz.white200,
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
                    color: Colorz.white255,
                    centered: true,
                  ),
                ),

                /// --- DIALOG CONTENT
                Container(
                  width: _dialogClearWidth,
                  height: _dialogClearHeight,
                  decoration: BoxDecoration(
                    color: Colorz.white10,
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