// ignore_for_file: join_return_with_assignment
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PriceField extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PriceField({
    required this.controller,
    required this.width,
    required this.height,
    required this.title,
    required this.selectedCurrencyID,
    required this.initialValue,
    required this.onChanged,
    required this.isRequired,
    super.key,
  });
  // ------------------------
  final TextEditingController controller;
  final double width;
  final double height;
  final Verse title;
  final double? initialValue;
  final String? selectedCurrencyID;
  final Function(String? text) onChanged;
  final bool isRequired;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          /// TITLE
          BldrsText(
            width: width,
            verse: title,
            scaleFactor: 0.7,
            centered: false,
            redDot: isRequired,
          ),

          BldrsTextField(
            textController: controller,
            appBarType: AppBarType.non,
            globalKey: null,
            width: width,
            centered: true,
            textInputType: TextInputType.number,
            textWeight: VerseWeight.black,
            initialValue: initialValue?.toString(),
            hintVerse: const Verse(
              id: '0',
              translate: false,
            ),
            onChanged: onChanged,
          ),

        ],
      ),
    );

  }
  // --------------------------------------------------------------------------
}
