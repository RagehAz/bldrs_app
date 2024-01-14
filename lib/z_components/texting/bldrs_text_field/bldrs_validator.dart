import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/texting/super_text_field/super_text_field.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/space/scale.dart';

class BldrsValidator extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BldrsValidator({
    required this.width,
    required this.validator,
    this.autoValidate = true,
    this.focusNode,
    super.key
  });
  // -----------------------------------------------------------------------------
    final double width;
    final String? Function()? validator;
    final bool autoValidate ;
    final FocusNode? focusNode;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperValidator(
      width: width,
      validator: validator,
      font: BldrsText.superVerseFont(VerseWeight.thin),
      autoValidate: autoValidate,
      focusNode: focusNode,
      textHeight: BldrsText.superVerseRealHeight(context: context, size: 2, sizeFactor: 1, hasLabelBox: false),
      errorTextColor: Colorz.red255,
      scrollPadding: EdgeInsets.only(
        bottom: Scale.screenHeight(context) * 0.3,
        top: Scale.screenHeight(context) * 0.3,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
