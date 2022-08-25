import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class FloatingDialog extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FloatingDialog({
    @required this.title,
    @required this.list,
    this.fieldIsRequired = false,
    this.actionBtColor,
    this.actionBtIcon,
    this.actionBtFunction,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final List<String> list;
  final bool fieldIsRequired;
  final String actionBtIcon;
  final Color actionBtColor;
  final Function actionBtFunction;
  /// --------------------------------------------------------------------------
  @override
  _FloatingDialogState createState() => _FloatingDialogState();
  /// --------------------------------------------------------------------------
}

class _FloatingDialogState extends State<FloatingDialog> {

  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    // const int titleVerseSize = 2;
    // final double actionBtSize = SuperVerse.superVerseRealHeight(context, titleVerseSize, 1, null);
    // final double actionBtCorner = actionBtSize * 0.4;

    const double _stripHeight = 50;

    final TextStyle _textStyle = SuperVerse.createStyle(
        context: context,
        color: Colorz.red230,
        weight: VerseWeight.thin,
        italic: false,
        // size: 2,
        shadowIsOn: false);

    return Bubble(
      // actionBtIcon: widget.actionBtIcon,
      // actionBtFunction: widget.actionBtFunction,
      title: widget.title,
      redDot: widget.fieldIsRequired,
      columnChildren: <Widget>[
        Container(
          width: Bubble.clearWidth(context),
          height: _stripHeight,
          decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: Borderers.superBorderAll(context, 10),
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
            icon: const DreamBox(
              height: _stripHeight,
              width: _stripHeight,
              icon: Iconz.arrowDown,
              iconSizeFactor: 0.2,
              bubble: false,
            ),

            /// DROP DOWN
            menuMaxHeight: 500,
            itemHeight: _stripHeight,
            hint: SuperVerse(
              verse: xPhrase(context, '##flotingDialingHint'),
            ),
            dropdownColor: Colorz.white255,
            elevation: 30,

            items: widget.list.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                onTap: () {
                  blog(item);
                },
                child: SuperVerse(
                  color: Colorz.black230,
                  verse: item,
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
