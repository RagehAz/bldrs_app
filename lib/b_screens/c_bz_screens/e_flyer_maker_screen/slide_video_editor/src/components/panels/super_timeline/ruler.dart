import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class Ruler extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Ruler({
    required this.height,
    required this.millimeters,
    required this.millimeterWidth,
    required this.availableWidth,
    this.lineThickness = 1,
    this.lineColor = Colorz.white80,
    super.key
  });
  // --------------------
  final double height;
  final int millimeters;
  final double millimeterWidth;
  final double lineThickness;
  final double availableWidth;
  final Color lineColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _timelineBoxWidth = Scale.screenWidth(context);
    final double _blankWidth = _timelineBoxWidth * 0.5;

    // --------------------
    final double _voidThickness = millimeterWidth - lineThickness;
    final bool _appIsLTR = UiProvider.checkAppIsLeftToRight();
    // --------------------
    return Column(
      children: <Widget>[

        /// LINES
        SizedBox(
          height: height,
          // width: millimeters * millimeterWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              /// LEFT BLANK
              SizedBox(
                width: _blankWidth,
                height: height,
              ),

              /// LINES
              ...List.generate(millimeters, (index){

                final bool _isDivisibleByTen = index % 10 == 0;
                final bool _isDivisibleByFive = index % 5 == 0;
                final double _heightFactor = _isDivisibleByTen ? 0.4 : _isDivisibleByFive ? 0.2 : 0.1;

                return Container(
                  width: lineThickness,
                  height: height * _heightFactor,
                  color: lineColor,
                  margin: Scale.superInsets(
                    context: context,
                    appIsLTR: _appIsLTR,
                    enRight: _voidThickness,
                  ),
                );

              }),

              /// RIGHT BLANK
              SizedBox(
                width: _blankWidth,
                height: height,
              ),

            ],
          ),
        ),

        /// TEXTS
        Container(
          width: availableWidth,
          height: 10,
          color: Colorz.yellow50,
          margin: Scale.superInsets(
            context: context,
            appIsLTR: _appIsLTR,
            enLeft: _blankWidth,
          ),
          child: Stack(
            children: <Widget>[

              ...List.generate(millimeters, (index){

                final bool _isDivisibleByTen = index % 10 == 0;
                // final bool _isDivisibleByFive = index % 5 == 0;

                if (_isDivisibleByTen == true){

                  final int _second = index ~/ 10;
                  final String _text = '${_second}s';

                  return Padding(
                    padding: Scale.superInsets(
                      context: context,
                      appIsLTR: _appIsLTR,
                      enLeft: index * millimeterWidth,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                        /// LINE
                        Container(
                          width: lineThickness,
                          height: 10,
                          color: lineColor,
                        ),

                        /// SECOND
                        BldrsText(
                          verse: Verse.plain(_text),
                          size: 0,
                          scaleFactor: height * 0.014,
                          color: Colorz.white200,
                          weight: VerseWeight.regular,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                        ),

                      ],
                    ),
                  );
                }

                else {
                  return const SizedBox();
                }

              }),

            ],
          ),
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}