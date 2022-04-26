import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/artworks/blur_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  /// --------------------------------------------------------------------------
  const BottomDialog({
    this.height,
    this.draggable = true,
    this.child,
    this.title,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final bool draggable;
  final Widget child;
  final String title;
  /// --------------------------------------------------------------------------
  /// one side value only
  static double draggerMarginValue({@required bool draggable}) {
    final double _draggerHeight = draggerHeight(draggable: draggable);
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerMarginValue =
        draggable != true ? 0 : (_draggerZoneHeight - _draggerHeight) / 2;
    return _draggerMarginValue;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets draggerMargins({@required bool draggable}) {
    final EdgeInsets _draggerMargins = EdgeInsets.symmetric(
        vertical: draggerMarginValue(draggable: draggable));
    return _draggerMargins;
  }
// -----------------------------------------------------------------------------
  static double draggerZoneHeight({@required bool draggable}) {
    final double _draggerZoneHeight =
        draggable == true ? Ratioz.appBarMargin * 3 : 0;
    return _draggerZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double draggerHeight({@required bool draggable}) {
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerHeight = _draggerZoneHeight * 0.35 * 0.5;
    return _draggerHeight;
  }
// -----------------------------------------------------------------------------
  static double draggerWidth(BuildContext context) {
    final double _draggerWidth = Scale.superScreenWidth(context) * 0.35;
    return _draggerWidth;
  }
// -----------------------------------------------------------------------------
  static double titleZoneHeight({@required bool titleIsOn}) {
    bool _titleIsOn;

    if (titleIsOn == null) {
      _titleIsOn = false;
    } else {
      _titleIsOn = titleIsOn;
    }

    final double _titleZoneHeight =
        _titleIsOn == true ? Ratioz.appBarSmallHeight : 0;

    return _titleZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double dialogWidth(BuildContext context) {
    return Scale.superScreenWidth(context);
  }
// -----------------------------------------------------------------------------
  static const double dialogMarginValue = Ratioz.appBarMargin + Ratioz.appBarPadding;
// -----------------------------------------------------------------------------
  static const EdgeInsets dialogMargins =
  EdgeInsets.symmetric(horizontal: dialogMarginValue);
// -----------------------------------------------------------------------------
  static double clearWidth(BuildContext context) {
    final double _dialogClearWidth =
        Scale.superScreenWidth(context)
            - (dialogMarginValue * 2);

    return _dialogClearWidth;
  }
// -----------------------------------------------------------------------------
  static double dialogHeight(
      BuildContext context,
      {
        double overridingDialogHeight,
        double ratioOfScreenHeight
      }) {

    double _dialogHeight;final double _screenHeight = Scale.superScreenHeight(context);

    final double _ratioOfScreenHeight = ratioOfScreenHeight ?? 0.5;

    if (overridingDialogHeight == null) {
      _dialogHeight = _screenHeight * _ratioOfScreenHeight;
    }

    else {
      _dialogHeight = overridingDialogHeight;
    }

    return _dialogHeight;
  }
// -----------------------------------------------------------------------------
  static double clearHeight({
    @required BuildContext context,
    @required bool draggable,
    double overridingDialogHeight,
    bool titleIsOn,
  }) {

    // bool _draggable = draggable == null ? false : draggable;

    final double _dialogHeight = dialogHeight(context, overridingDialogHeight: overridingDialogHeight);
    final double _titleZoneHeight = titleZoneHeight(titleIsOn: titleIsOn);
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);

    final double _dialogClearHeight = _dialogHeight - _titleZoneHeight - _draggerZoneHeight;
    return _dialogClearHeight;
  }
// -----------------------------------------------------------------------------
  static BorderRadius dialogCorners(BuildContext context) {
    final BorderRadius _dialogCorners = Borderers.superBorderOnly(
        context: context,
        enTopLeft: Ratioz.bottomSheetCorner,
        enBottomLeft: 0,
        enBottomRight: 0,
        enTopRight: Ratioz.bottomSheetCorner,
    );
    return _dialogCorners;
  }
// -----------------------------------------------------------------------------
  static double dialogClearCornerValue({double corner}) {
    return corner ?? Ratioz.appBarCorner;
  }
// -----------------------------------------------------------------------------
  static BorderRadius dialogClearCorners(BuildContext context) {
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
  static Future<void> showBottomDialog({
    @required BuildContext context,
    @required bool draggable,
    @required Widget child,
    double height,
    String title,
  }) async {

    final double _height = height ?? BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.5);

    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: Borderers.superBorderOnly(
              context: context,
              enTopLeft: Ratioz.bottomSheetCorner,
              enBottomLeft: 0,
              enBottomRight: 0,
              enTopRight: Ratioz.bottomSheetCorner,
            )
        ),
        backgroundColor: Colorz.blackSemi255,
        barrierColor: Colorz.black150,
        enableDrag: draggable,
        elevation: 20,
        isScrollControlled: true,
        context: context,
        builder: (_) {

          return StatefulBuilder(
              builder: (BuildContext xxx, state){

                // final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(xxx, listen: false);

                return SizedBox(
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
                );

              }
          );

        }
        );
  }
// -----------------------------------------------------------------------------
  static Future<void> showButtonsBottomDialog({
    @required BuildContext context,
    @required bool draggable,
    @required double buttonHeight,
    @required int numberOfWidgets,
    List<Widget> Function(BuildContext, PhraseProvider) builder,
    String title,
  }) async {

    final int _widgetsLength = numberOfWidgets;

    final double _spacing = buttonHeight * 0.1;
    final double _height =
        BottomDialog.draggerZoneHeight(draggable: draggable)
        + BottomDialog.draggerMarginValue(draggable: draggable)
        + BottomDialog.titleZoneHeight(titleIsOn: title != null)
        + (buttonHeight * _widgetsLength)
            + (_spacing * _widgetsLength);


    await showStatefulBottomDialog(
      context: context,
      draggable: draggable,
      height: _height,
      title: title,
      builder: (BuildContext ctx, title){

        final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(ctx, listen: false);

        final List<Widget> _widgets = builder(ctx, _phraseProvider);

        return ListView.builder(
          itemCount: _widgets.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, int index) {
            return Column(
              children: <Widget>[
                _widgets[index],
                SizedBox(height: _spacing),
              ],
              // children: builder(ctx, _phraseProvider),
            );
          },
        );

      },
    );
  }
// -----------------------------------------------------------------------------
  static Future<void> showStatefulBottomDialog({
    @required BuildContext context,
    @required double height,
    @required bool draggable,
    @required Widget Function(BuildContext, String) builder,
    @required String title
  }) async {

    final double _height = height ?? BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.5);

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BottomDialog.dialogCorners(context),
      ),
      backgroundColor: Colorz.blackSemi255,
      barrierColor: Colorz.black150,
      enableDrag: draggable,
      elevation: 20,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => SizedBox(
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
          )),
    );
  }
// -----------------------------------------------------------------------------
  static Future<void> slideBzBottomDialog({
    @required BuildContext context,
    @required BzModel bz,
    @required AuthorModel author,
  }) async {

    // final double _flyerBoxWidth = FlyerBox.width(context, 0.71);

    await BottomDialog.showBottomDialog(
        context: context,
        height: Scale.superScreenHeight(context) - 100,
        draggable: true,
        child: Container(),
        // child: Center(
          // child: FinalFlyer(
          //   flyerBoxWidth: _flyerBoxWidth,
          //   flyerModel: FlyerModel(
          //     id: null,
          //     title: '',
          //     bzID: bz.id,
          //     authorID: author.userID,
          //     zone: bz.zone,
          //     info: '',
          //     priceTagIsOn: false,
          //     position: null,
          //     flyerType: null,
          //     times: <PublishTime>[],
          //     slides: <SlideModel>[],
          //     isBanned: null,
          //     keywordsIDs: <String>[],
          //     specs: <SpecModel>[],
          //     trigram: <String>[],
          //   ),
          //   onSwipeFlyer: (Sliders.SwipeDirection direction) {
          //     // print('Direction is ${direction}');
          //   },
          // ),
        // )
    );
  }
// -----------------------------------------------------------------------------
  static const double wideButtonHeight = 45;

  static Widget wideButton({
    @required BuildContext context,
    @required String verse,
    Function onTap,
    String icon,
    bool verseCentered = false,
  }) {

    return DreamBox(
      height: wideButtonHeight,
      width: clearWidth(context),
      verse: verse,
      verseScaleFactor: 1.1,
      verseWeight: VerseWeight.thin,
      // verseItalic: false,
      icon: icon,
      iconSizeFactor: 0.6,
      verseCentered: verseCentered,
      verseMaxLines: 2,
      onTap: onTap,
    );

  }
// -----------------------------------------------------------------------------
  static Future<String> keyboardDialog({
    @required BuildContext context,
    @required String countryID,
    String hintText,
  }) async {

    /// TASK flag is temp

    final TextEditingController _textController = TextEditingController();

    const double _ratioOfScreenHeight = 0.65;
    final double _overridingDialogHeight = dialogHeight(context, ratioOfScreenHeight: _ratioOfScreenHeight);
    final double _clearWidth = clearWidth(context);
    final double _clearHeight = clearHeight(
        context: context,
        overridingDialogHeight: _overridingDialogHeight,
        draggable: true,
        titleIsOn: false
    );

    final double _corners = dialogClearCornerValue();

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _overridingDialogHeight,
      child: SizedBox(
        width: _clearWidth,
        height: _clearHeight,
        // color: Colorz.BloodTest,
        child: Column(
          children: <Widget>[

            SuperTextField(
              // height: 200,
              // keyboardTextInputAction: TextInputAction.done,
              textController: _textController,
              width: _clearWidth,
              maxLines: 2,
              onSubmitted: (String val) {
                Nav.goBack(context);
                // await null;
              },
              hintText: hintText ?? 'text here ...',
              corners: _corners,
            ),

            if (countryID != null)
              FlagBox(
                countryID: countryID,
              ),

          ],
        ),
      ),
    );

    return _textController.text;
  }
// -----------------------------------------------------------------------------
  bool _titleIsOnCheck() {
    bool _isOn;

    if (title == null || TextMod.removeSpacesFromAString(title) == '') {
      _isOn = false;
    } else {
      _isOn = true;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _dialogWidth = dialogWidth(context);
    final double _dialogHeight = dialogHeight(context, overridingDialogHeight: height);
    final BorderRadius _dialogCorners = dialogCorners(context);

    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerHeight = draggerHeight(draggable: draggable);
    final double _draggerWidth = draggerWidth(context);
    final double _draggerCorner = _draggerHeight * 0.5;
    final EdgeInsets _draggerMargins = draggerMargins(draggable: draggable);

    final bool _titleIsOn = _titleIsOnCheck();

    final double _titleZoneHeight = titleZoneHeight(titleIsOn: _titleIsOn);

    final double _dialogClearWidth = clearWidth(context);
    final double _dialogClearHeight = clearHeight(
        context: context,
        titleIsOn: _titleIsOn,
        overridingDialogHeight: height,
        draggable: draggable
    );

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
          SizedBox(
            width: _dialogWidth,
            height: _dialogHeight,
            child: Column(
              children: <Widget>[
                /// --- DRAGGER
                if (draggable == true)
                  Container(
                    width: _dialogWidth,
                    height: _draggerZoneHeight,
                    alignment: Alignment.center,
                    // color: Colorz.BloodTest,
                    child: Container(
                      width: _draggerWidth,
                      height: _draggerHeight,
                      margin: _draggerMargins,
                      decoration: BoxDecoration(
                        color: Colorz.white200,
                        borderRadius:
                            Borderers.superBorderAll(context, _draggerCorner),
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
