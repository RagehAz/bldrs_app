import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/text_lines_analyzer.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class ParagraphBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ParagraphBubble({
    @required this.headerViewModel,
    @required this.paragraph,
    this.maxLines = 5,
    this.centered = false,
    this.actionBtIcon,
    this.bubbleWidth,
    this.corners,
    this.margins,
    this.editMode = false,
    this.onParagraphTap,
    this.bubbleColor = Colorz.white10,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse paragraph;
  final int maxLines;
  final bool centered;
  final String actionBtIcon;
  final double bubbleWidth;
  final dynamic margins;
  final dynamic corners;
  final bool editMode;
  final Function onParagraphTap;
  final Color bubbleColor;
  final BubbleHeaderVM headerViewModel;
  /// --------------------------------------------------------------------------
  @override
  _ParagraphBubbleState createState() => _ParagraphBubbleState();
  /// --------------------------------------------------------------------------
}

class _ParagraphBubbleState extends State<ParagraphBubble> {
  // -----------------------------------------------------------------------------
  int _maxLines;
  bool _isMax = false;
  bool _canExpand;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _maxLines = widget.maxLines;
    _canExpand = widget.paragraph.id.length > 100;
  }
  // --------------------
  @override
  void didUpdateWidget(covariant ParagraphBubble oldWidget) {
    if (widget.editMode != oldWidget.editMode) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------
  void _onParagraphTap() {
    if (widget.editMode == true) {
      widget.onParagraphTap();
    } else if (_canExpand == true) {
      // widget.onParagraphTap();

      if (_maxLines == widget.maxLines) {
        blog('expanding maxLines');
        setState(() {
          _isMax = true;
          _maxLines = 1000;
        });
      } else {
        blog('contracting maxLines');
        setState(() {
          _isMax = false;
          _maxLines = widget.maxLines;
        });
      }
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // blog('B---> ParagraphBubble : edit mode : ${widget.editMode}');

    // bool _infoExceededMaxLines = superFlyer.i

    final TextStyle _paragraphTextStyle = SuperVerse.createStyle(
      context: context,
      // color: Colorz.white255,
      weight: VerseWeight.thin,
      // size: 2,
      italic: false,
      shadowIsOn: false,
    );

    return Bubble(
        bubbleHeaderVM: widget.headerViewModel,
        key: widget.key,
        width: widget.bubbleWidth,
        margin: widget.margins,
        corners: widget.corners,
        childrenCentered: widget.centered,
        bubbleColor: widget.bubbleColor,
        onBubbleTap: widget.editMode == true || _canExpand == true ?
        _onParagraphTap
            :
        null,
        columnChildren: <Widget>[

          /// PARAGRAPH TEXT
          if (widget.paragraph != null && widget.paragraph.id != '')
            Padding(
              padding: Scale.superMargins(margin: widget.margins),
              child: SuperVerse(
                verse: widget.paragraph,
                maxLines: _maxLines,
                weight: VerseWeight.thin,
                centered: widget.centered,
                // onTap: _onParagraphTap,
              ),
            ),

          /// ARROW
          if (widget.paragraph != null && widget.paragraph.id != '')
            TextLinesAnalyzer(
              text: widget.paragraph.id.trim(),
              textStyle: _paragraphTextStyle,
              maxLines: widget.maxLines,
              childIfWithinMaxLines: Container(),
              childIfExceededMaxLines: Container(
                width: widget.bubbleWidth,
                alignment: Alignment.center,
                child: DreamBox(
                  height: Ratioz.appBarMargin,
                  width: Ratioz.appBarMargin,
                  bubble: false,
                  margins: Ratioz.appBarPadding,
                  icon: _isMax ? Iconz.arrowUp : Iconz.arrowDown,
                  // onTap: _onParagraphTap,
                ),
              ),
            )

        ]
    );
  }
  // -----------------------------------------------------------------------------
}
