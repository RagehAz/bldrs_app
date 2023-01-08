import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class MainButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MainButton({
    @required this.verse,
    @required this.icon,
    @required this.onTap,
    this.buttonColor = Colorz.white50,
    this.splashColor = Colorz.yellow255,
    this.buttonVerseShadow = true,
    this.stretched = false,
    this.iconSizeFactor = 0.75,
    this.verseColor = Colorz.white255,
    this.verseWeight = VerseWeight.bold,
    this.iconColor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final dynamic icon;
  final Color buttonColor;
  final Color splashColor;
  final bool buttonVerseShadow;
  final dynamic onTap;
  final bool stretched;
  final double iconSizeFactor;
  final Color verseColor;
  final VerseWeight verseWeight;
  final Color iconColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    final double _buttonCorner = _screenHeight * Ratioz.mainButtonCornerRatioToScreenHeight;
    final double _buttonZoneHeight = _screenHeight * 0.08;
    final double _buttonZonePaddings = _screenHeight * 0.01;
    // --------------------
    final double _buttonWidth = stretched == true ? _screenWidth : _screenHeight * 22 * 0.017;
    final double _buttonHeight = _buttonZoneHeight * 0.85;
    // --------------------
    /// BUTTON FOOTPRINT
    return Container(
      key: const ValueKey<String>('Main_button'),
      width: _screenWidth,
      height: _buttonZoneHeight,
      // color: Colorz.Yellow,
      alignment: Alignment.center,
      // padding: EdgeInsets.all(_buttonZonePaddings),

      /// BUTTON ITSELF
      child: Container(
        width: _buttonWidth,
        height: _buttonHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_buttonCorner),
            boxShadow: <BoxShadow>[
              CustomBoxShadow(
                  color: Colorz.black230,
                  blurRadius: _buttonZoneHeight * 0.09,
                  style: BlurStyle.outer),
            ]
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (onTap.runtimeType != String) {

              await Future.delayed( const Duration(milliseconds: 200),

                      () => onTap()

              );


            } else {
              if (onTap == 'GoBackFucker') {
                Navigator.pop(context);
              } else {
                await Navigator.pushNamed(context, onTap);
              }
            }
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_buttonCorner),
            )),
            foregroundColor: MaterialStateProperty.all(Colorz.grey80),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            animationDuration: Ratioz.durationFading200,
            // splashFactory: ElevatedButton.styleFrom(
            //   splashFactory: NoSplash.splashFactory,
            // ),
          ),
          // splashColor: splashColor,

          /// BUTTON CONTENTS
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// BUTTON HIGHLIGHT
              Container(
                width: _buttonWidth * 0.9,
                height: _buttonHeight * 0.22,
                decoration: BoxDecoration(
                  // color: Colorz.White,
                    borderRadius: BorderRadius.circular(_buttonCorner -
                        (_buttonHeight - (_buttonHeight * 0.22))),
                    boxShadow: <BoxShadow>[
                      CustomBoxShadow(
                          color: Colorz.white50,
                          offset: Offset(0, _buttonHeight * -0.23),
                          blurRadius: _buttonHeight * 0.18),
                    ]
                ),
              ),

              /// BUTTON GRADIENT
              Container(
                height: _buttonHeight,
                width: _buttonWidth,
                decoration: BoxDecoration(
                  // color: Colorz.Grey,
                  borderRadius: BorderRadius.circular(_buttonCorner),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colorz.black10, Colorz.black125],
                      stops: <double>[0.1, 1]),
                ),
              ),

              /// BUTTON COMPONENTS
              if (icon == '')

              /// --- WHEN BUTTON DOES NOT HAVE AN ICON
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /// --- ONLY THE BUTTON VERSE HERE
                    Padding(
                      padding: EdgeInsets.all(_buttonZonePaddings),
                      child: SuperVerse(
                        verse: verse,
                        color: verseColor,
                        weight: verseWeight,
                        shadow: buttonVerseShadow,
                      ),
                    ),
                  ],
                ),

              if (icon != '')

              /// --- WHEN BUTTON HAS AN ICON
                Padding(
                  padding: EdgeInsets.only(
                      left: _buttonZonePaddings,
                      right: _buttonZonePaddings
                  ),
                  child: Row(
                    children: <Widget>[

                      /// --- OLD BUTTON ICON
                      Flexible(
                        child: Container(
                          // color: Colorz.BloodTest,
                          width: _buttonZoneHeight * 0.4,
                          height: _buttonZoneHeight * 0.4,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(_buttonZoneHeight * 0.1),
                          // padding: EdgeInsets.all(_buttonHeight * 0),
                          child: icon.runtimeType != String ? icon
                              :
                              ObjectCheck.fileExtensionOf(icon) == 'jpg' ||
                              ObjectCheck.fileExtensionOf(icon) == 'jpeg' ||
                              ObjectCheck.fileExtensionOf(icon) == 'png' ? Container(
                            width: _buttonZoneHeight * 0.4,
                            height: _buttonZoneHeight * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    icon,
                                    // package: Iconz.bldrsTheme,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              :
                          WebsafeSvg.asset(icon,
                              fit: BoxFit.fill,
                              color: iconColor,
                              // package: Iconz.bldrsTheme,
                          ),
                        ),
                      ),

                      /// BUTTON VERSE
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _buttonZonePaddings),
                          child: SuperVerse(
                            verse: verse,
                            color: verseColor,
                            weight: verseWeight,
                            centered: false,
                            shadow: buttonVerseShadow,
                            maxLines: 2,
                          ),

                        ),
                      ),

                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
