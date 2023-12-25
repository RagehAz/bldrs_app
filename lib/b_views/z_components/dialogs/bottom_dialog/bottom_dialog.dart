import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/classes/shadowers.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';
// -----------------------------------------------------------------------------
enum BottomDialogType {
  countries,
  cities,
  languages,
  bottomSheet,
}
// -----------------------------------------------------------------------------
/// TASK: should check draggable scrollable sheet
class BottomDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BottomDialog({
    this.height,
    this.child,
    this.titleVerse,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? height;
  final Widget? child;
  final Verse? titleVerse;
  /// --------------------------------------------------------------------------
  /// one side value only
  static double draggerMarginValue() {
    // final double _draggerHeight = draggerHeight();
    // final double _draggerZoneHeight = draggerZoneHeight();
    const double _draggerMarginValue = 0;
    return _draggerMarginValue;
  }
  // -----------------------------------------------------------------------------
  static EdgeInsets draggerMargins() {
    final EdgeInsets _draggerMargins = EdgeInsets.symmetric(
        vertical: draggerMarginValue()
    );
    return _draggerMargins;
  }
  // --------------------
  static double draggerZoneHeight() {
    return Ratioz.appBarMargin * 3;
  }
  // --------------------
  static double draggerHeight() {
    final double _draggerZoneHeight = draggerZoneHeight();
    final double _draggerHeight = _draggerZoneHeight * 0.35 * 0.5;
    return _draggerHeight;
  }
  // --------------------
  static double draggerWidth(BuildContext context) {
    final double _draggerWidth = Scale.screenWidth(context) * 0.35;
    return _draggerWidth;
  }
  // --------------------
  static double titleZoneHeight({
    required bool? titleIsOn,
  }) {
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
  // --------------------
  static double calculateDialogHeight({
    required bool titleIsOn,
    required double childHeight,
  }){
    final double _draggerHeight = draggerZoneHeight();
    final double _titleHeight = titleZoneHeight(titleIsOn: titleIsOn);

    final double _topZoneHeight = _draggerHeight + _titleHeight + childHeight;

    return _topZoneHeight;
  }
  // --------------------
  static double dialogWidth() {
    return Bubble.bubbleWidth(context: getMainContext()) + 20;
  }
  // --------------------
  static const double dialogMarginValue = Ratioz.appBarMargin + Ratioz.appBarPadding;
  // --------------------
  static const EdgeInsets dialogMargins = EdgeInsets.symmetric(
      horizontal: dialogMarginValue
  );
  // --------------------
  static double clearWidth() {
    final double _dialogClearWidth = dialogWidth() - (dialogMarginValue * 2);
    return _dialogClearWidth;
  }
  // --------------------
  static double dialogHeight(
      BuildContext context,
      {
        double? overridingDialogHeight,
        double? ratioOfScreenHeight
      }) {

    double _dialogHeight;final double _screenHeight = Scale.screenHeight(context);

    final double _ratioOfScreenHeight = ratioOfScreenHeight ?? 0.5;

    if (overridingDialogHeight == null) {
      _dialogHeight = _screenHeight * _ratioOfScreenHeight;
    }

    else {
      _dialogHeight = overridingDialogHeight;
    }

    return _dialogHeight;
  }
  // --------------------
  static double clearHeight({
    required BuildContext context,
    double? overridingDialogHeight,
    bool? titleIsOn,
  }) {

    final double _dialogHeight = dialogHeight(context, overridingDialogHeight: overridingDialogHeight);
    final double _titleZoneHeight = titleZoneHeight(titleIsOn: titleIsOn);
    final double _draggerZoneHeight = draggerZoneHeight();

    final double _dialogClearHeight = _dialogHeight - _titleZoneHeight - _draggerZoneHeight;
    return _dialogClearHeight;
  }
  // --------------------
  static BorderRadius dialogCorners() {
    final BorderRadius _dialogCorners = Borderers.cornerOnly(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enTopLeft: Ratioz.bottomSheetCorner,
      enBottomLeft: 0,
      enBottomRight: 0,
      enTopRight: Ratioz.bottomSheetCorner,
    );
    return _dialogCorners;
  }
  // --------------------
  static double dialogClearCornerValue({double? corner}) {
    return corner ?? Ratioz.appBarCorner;
  }
  // --------------------
  static BorderRadius dialogClearCorners() {
    final BorderRadius _corners = Borderers.cornerOnly(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enBottomRight: 0,
      enBottomLeft: 0,
      enTopRight: dialogClearCornerValue(),
      enTopLeft: dialogClearCornerValue(),
    );
    return _corners;
  }
  // --------------------
  static Future<void> showBottomDialog({
    required Widget child,
    double? height,
    Verse? titleVerse,
  }) async {

    final BuildContext context = getMainContext();
    final double _height = height ?? BottomDialog.dialogHeight(getMainContext(), ratioOfScreenHeight: 0.5);

    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: Borderers.cornerOnly(
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
              enTopLeft: Ratioz.bottomSheetCorner,
              enBottomLeft: 0,
              enBottomRight: 0,
              enTopRight: Ratioz.bottomSheetCorner,
            )
        ),
        backgroundColor: Colorz.blackSemi255,
        barrierColor: Colorz.black150,
        enableDrag: true,
        elevation: 20,
        isScrollControlled: true,
        context: context,
        constraints: BoxConstraints(
          maxWidth: dialogWidth(),
        ),
        builder: (_) {

          return StatefulBuilder(
              builder: (BuildContext xxx, state){

                // final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(xxx, listen: false);

                return SizedBox(
                  height: _height,
                  width: Scale.screenWidth(getMainContext()),
                  child: Scaffold(
                    backgroundColor: Colorz.nothing,
                    resizeToAvoidBottomInset: false,
                    body: BottomDialog(
                      height: _height,
                      titleVerse: titleVerse,
                      child: child,
                    ),
                  ),
                );

              }
          );

        }
    );
  }
  // --------------------
  static Future<void> showButtonsBottomDialog({
    required int numberOfWidgets,
    required List<Widget> Function(BuildContext, Function setState) builder,
    double buttonHeight = wideButtonHeight,
    Verse? titleVerse,
  }) async {

    final int _widgetsLength = numberOfWidgets;

    final double _spacing = buttonHeight * 0.1;
    double _height =
        BottomDialog.draggerZoneHeight()
            + BottomDialog.draggerMarginValue()
            + BottomDialog.titleZoneHeight(titleIsOn: titleVerse != null)
            + (buttonHeight * _widgetsLength)
            + (_spacing * _widgetsLength);

    _height = _height.clamp(0, Scale.screenHeight(getMainContext()) * 0.8);

    await showStatefulBottomDialog(
      height: _height,
      titleVerse: titleVerse,
      builder: (BuildContext ctx, Function setState) {

        final List<Widget> _widgets = builder(ctx, setState);

        return ListView.builder(
          itemCount: _widgets.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showStatefulBottomDialog({
    required Widget Function(BuildContext, Function setState) builder,
    required Verse? titleVerse,
    double? height,
  }) async {

    final double _height = height ?? BottomDialog.dialogHeight(getMainContext(), ratioOfScreenHeight: 0.5);

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BottomDialog.dialogCorners(),
      ),
      backgroundColor: Colorz.blackSemi255,
      barrierColor: Colorz.black150,
      enableDrag: true,
      elevation: 20,
      isScrollControlled: true,
      context: getMainContext(),
      builder: (BuildContext context) => SizedBox(
          height: _height,
          width: Scale.screenWidth(context),
          child: Scaffold(
            backgroundColor: Colorz.nothing,
            resizeToAvoidBottomInset: false,
            body: BottomDialog(
              height: _height,
              titleVerse: titleVerse,
              child: StatefulBuilder(
                builder: (_, Function setState){

                  return builder(context, setState);

                },
              ),
            ),
          )),
    );
  }
  // --------------------
  static Future<void> slideBzBottomDialog({
    required BuildContext context,
    required BzModel bz,
    required AuthorModel author,
  }) async {

    // final double _flyerBoxWidth = FlyerBox.width(context, 0.71);

    await BottomDialog.showBottomDialog(
      height: Scale.screenHeight(context) - 100,
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
  // --------------------
  static const double wideButtonHeight = 40;
  // --------------------
  static Widget wideButton({
    Verse? verse,
    Function? onTap,
    dynamic icon,
    double height = wideButtonHeight,
    bool? verseCentered,
    bool isDisabled = false,
    Function? onDisabledTap,
    Color? color,
    bool bigIcon = false,
  }) {

    return BldrsBox(
      height: height,
      width: clearWidth(),
      verse: verse,
      verseScaleFactor: bigIcon == true ? 0.7 : 0.7 /0.6,
      verseWeight: VerseWeight.thin,
      // verseItalic: false,
      icon: icon,
      iconSizeFactor: bigIcon == true ? 1 : 0.6,
      verseCentered: verseCentered ?? icon == null,
      verseMaxLines: 2,
      onTap: onTap,
      isDisabled: isDisabled,
      onDisabledTap: onDisabledTap,
      color: color,
    );

  }
  // --------------------
  bool _titleIsOnCheck() {
    bool _isOn;

    if (titleVerse == null || TextMod.removeSpacesFromAString(titleVerse?.id) == '') {
      _isOn = false;
    }

    else {
      _isOn = true;
    }

    return _isOn;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _dialogWidth = dialogWidth();
    final double _dialogHeight = dialogHeight(context, overridingDialogHeight: height);
    final BorderRadius _dialogCorners = dialogCorners();
    // --------------------
    final double _draggerZoneHeight = draggerZoneHeight();
    final double _draggerHeight = draggerHeight();
    final double _draggerWidth = draggerWidth(context);
    final double _draggerCorner = _draggerHeight * 0.5;
    final EdgeInsets _draggerMargins = draggerMargins();
    // --------------------
    final bool _titleIsOn = _titleIsOnCheck();
    final double _titleZoneHeight = titleZoneHeight(titleIsOn: _titleIsOn);
    // --------------------
    final double _dialogClearWidth = clearWidth();
    final double _dialogClearHeight = clearHeight(
        context: context,
        titleIsOn: _titleIsOn,
        overridingDialogHeight: height,
    );
    // --------------------
    final BorderRadius _dialogClearCorners = dialogClearCorners();
    // --------------------
    return Center(
      child: Container(
        width: _dialogWidth,
        height: _dialogHeight,
        decoration: BoxDecoration(
          color: Colorz.white10,
          borderRadius: _dialogCorners,
        ),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// --- SHADOW LAYER
            Container(
              width: _dialogWidth,
              height: _dialogHeight,
              decoration: BoxDecoration(
                borderRadius: _dialogCorners,
                boxShadow: Shadower.appBarShadow,
              ),
            ),

            /// --- DIALOG CONTENTS
            SizedBox(
              width: _dialogWidth,
              height: _dialogHeight,
              child: Column(
                children: <Widget>[

                  /// --- DRAGGER
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
                          Borderers.cornerAll(_draggerCorner),
                        ),
                      ),
                    ),

                  /// --- TITLE
                  if (titleVerse != null)
                    BldrsText(
                        verse: titleVerse,
                        width: _dialogWidth * 0.8,
                        height: _titleZoneHeight,
                        maxLines: 2,
                      ),

                  /// --- DIALOG CONTENT
                  ClipRRect(
                    borderRadius: _dialogClearCorners,
                    child: Container(
                      width: _dialogClearWidth,
                      height: _dialogClearHeight,
                      decoration: BoxDecoration(
                        color: Colorz.white10,
                        borderRadius: _dialogClearCorners,
                        // gradient: Colorizer.superHeaderStripGradient(Colorz.White20)
                      ),
                      child: child,
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
// --------------------
}
// -----------------------------------------------------------------------------
