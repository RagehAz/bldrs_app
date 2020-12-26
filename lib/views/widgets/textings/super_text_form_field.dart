import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';

class SuperTextFormField extends StatelessWidget {
  final String errorMessageIfEmpty;
  final Function onSaved;
  final int maxLength;
  final int maxLines;
  final bool obscureText;
  final double fontSize;
  final String hintText;
  final double fieldCorners;

  SuperTextFormField({
    @required this.errorMessageIfEmpty,
    @required this.onSaved,
    this.maxLength = 500,
    this.maxLines = 10,
    this.obscureText = false,
    this.fontSize = 18,
    @required this.hintText,
    this.fieldCorners = 10,
  });


  @override
  Widget build(BuildContext context) {

    double letterSpacing = 0.0;

    return TextFormField(
      validator: (value) => value.isEmpty ? errorMessageIfEmpty : null,
      onSaved: (String koko) => onSaved(koko),
      maxLength: maxLength,
      maxLines: maxLines,
      autocorrect: false,
      textDirection: superTextDirection(context),
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: obscureText,

      style: TextStyle(
          fontFamily: getTranslated(context, 'Body_Font'),
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: fontSize,
          color: Colorz.White,
          letterSpacing: letterSpacing,
      ),

      cursorColor: Colorz.WhiteAir,
      cursorRadius: Radius.circular(3),
      cursorWidth: 2,

      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colorz.WhiteSmoke,
            fontFamily: getTranslated(context, 'Body_Font'),
            fontStyle: FontStyle.normal,
            fontSize: fontSize * 0.90,
            letterSpacing: letterSpacing,
          ),

          errorStyle: TextStyle(
              color: Colorz.BloodRed,
              fontFamily: getTranslated(context, 'Body_Font'),
              fontStyle: FontStyle.normal,
              fontSize: fontSize * 0.95,
              letterSpacing: letterSpacing
          ),

          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(fieldCorners),
              borderSide: BorderSide(color: Colorz.BloodRed)
          ),

          focusColor: Colorz.Yellow,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(fieldCorners),
              borderSide: BorderSide(color: Colorz.YellowSmoke)
          ),

                filled: true,
                fillColor: Colorz.WhiteAir,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(fieldCorners),
                  borderSide: BorderSide(
                      color: Colorz.BabyBlue
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(fieldCorners),
                  borderSide: BorderSide(color: Colorz.BloodRed)
                ),

                counterStyle: TextStyle(
//                height: MediaQuery.of(context).size.height,
                  color: Colorz.GreySmoke,
                  letterSpacing: 1.5,
                  fontFamily: getTranslated(context, 'Body_Font'),
                  fontSize: fontSize * 0.5

                )

              ),

            );
  }
}
