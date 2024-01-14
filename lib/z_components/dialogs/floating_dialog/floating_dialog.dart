import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class FloatingDialog extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FloatingDialog({
    required this.titleVerse,
    required this.list,
    this.fieldIsRequired = false,
    this.actionBtColor,
    this.actionBtIcon,
    this.actionBtFunction,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse titleVerse;
  final List<String> list;
  final bool fieldIsRequired;
  final String? actionBtIcon;
  final Color? actionBtColor;
  final Function? actionBtFunction;
  /// --------------------------------------------------------------------------
  @override
  _FloatingDialogState createState() => _FloatingDialogState();
  /// --------------------------------------------------------------------------
}

class _FloatingDialogState extends State<FloatingDialog> {

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {

    // const int titleVerseSize = 2;
    // final double actionBtSize = SuperVerse.superVerseRealHeight(context, titleVerseSize, 1, null);
    // final double actionBtCorner = actionBtSize * 0.4;

    const double _stripHeight = 50;

    final TextStyle _textStyle = BldrsText.createStyle(
        context: context,
        color: Colorz.red230,
        weight: VerseWeight.thin,
        italic: false,
        // size: 2,
        shadowIsOn: false,
    );

    return Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: widget.titleVerse,
          redDot: widget.fieldIsRequired,
        ),
        // actionBtIcon: widget.actionBtIcon,
      // actionBtFunction: widget.actionBtFunction,
      columnChildren: <Widget>[
        Container(
          width: Bubble.clearWidth(context: context),
          height: _stripHeight,
          decoration: const BoxDecoration(
            color: Colorz.white10,
            borderRadius: Borderers.constantCornersAll10,
          ),
          child: DropdownButtonFormField<String>(
            /// INEFFECTIVE
            iconSize: 0,
            alignment: Alignment.center,
            style: _textStyle,
            value: widget.list[0],

            /// STRIP
            onTap: () {
              blog('ganzabeel');
            },

            /// STRIP STYLING
            isDense: false,
            decoration: InputDecoration(
              // border: Borderers.superOutlineInputBorder(Colorz.red255, 10),

              floatingLabelStyle: _textStyle,
              contentPadding: EdgeInsets.zero,
              filled: true,

              /// removes bottom line
              enabled: false,

              /// removes bottom line

              /// INEFFECTIVE
              isDense: false,

              /// UNNECESSARY
              // icon: const DreamBox(height: 35, icon: Iconz.DvGouran,),
              // labelText: 'label text',
              // floatingLabelBehavior: FloatingLabelBehavior.never,
              // focusColor: null,
            ),

            /// ARROW STYLING
            icon: const BldrsBox(
              height: _stripHeight,
              width: _stripHeight,
              icon: Iconz.arrowDown,
              iconSizeFactor: 0.2,
              bubble: false,
            ),

            /// DROP DOWN
            menuMaxHeight: 500,
            itemHeight: _stripHeight,
            // hint: const SuperVerse(
            //   verse: Verse(
            //     text: 'floatingDialogHint',
            //   ),
            // ),
            dropdownColor: Colorz.white255,
            elevation: 30,

            items: widget.list.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                onTap: () {
                  blog(item);
                },
                child: BldrsText(
                  color: Colorz.black230,
                  verse: Verse(
                    id: item,
                    translate: false,
                  ),
                ),
              );
            }).toList(),
            onChanged: (dynamic val) => setState(() => selectedIndex = val),
          ),
        ),
      ],
    );

  }

}
