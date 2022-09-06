import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SuperValidator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperValidator({
    @required this.width,
    @required this.validator,
    this.autoValidate = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final String Function() validator;
  final bool autoValidate;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: width,
        child: TextFormField(

          /// VALIDATION
          autovalidateMode: autoValidate == true ? AutovalidateMode.always : AutovalidateMode.disabled,
          validator: (String text) => validator(),

          /// SPAN SPACING
          scrollPadding: EdgeInsets.only(
            bottom: Scale.superScreenHeight(context) * 0.3,
            top: Scale.superScreenHeight(context) * 0.3,
          ),

          /// DISABLE TEXT FIELD
          readOnly: true,
          enabled: true,

          /// BOX STYLING => COLLAPSE BOX HEIGHT TO ZERO + MAKE BORDER TRANSPARENT
          decoration: InputDecoration(

            /// COLLAPSES FIELD HEIGHT TO THE MINIMUM TEXT HEIGHT GIVEN
            isCollapsed: true,

            /// as field is enabled : this overrides the ( enabledBorder )
            enabledBorder: SuperTextField.createOutlineBorder(
              borderColor: Colorz.nothing,
              corners: 0,
            ),
            /// as field is disabled : this overrides the ( disabledBorder )
            disabledBorder: SuperTextField.createOutlineBorder(
              borderColor: Colorz.nothing,
              corners: 0,
            ),
            /// as field is in error : this overrides the ( errorBorder )
            errorBorder: SuperTextField.createOutlineBorder(
              borderColor: Colorz.nothing,
              corners: 0,
            ),

            /// ERROR TEXT STYLE
            errorStyle: SuperTextField.createErrorStyle(
              context: context,
              textSize: 2,
              textItalic: true,
              textSizeFactor: 1,
            ),
            errorMaxLines: 3,
            // errorText: 'initial state error text',

          ),

          /// TEXT STYLING => TO COLLAPSE ITS HEIGHT TO ZERO
          style: const TextStyle(
            height: 0,
            fontSize: 0,
          ),

        ),
      ),
    );

  }
}
