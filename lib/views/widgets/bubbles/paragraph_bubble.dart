import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/text_lines_analyzer.dart';
import 'package:flutter/material.dart';

class ParagraphBubble extends StatefulWidget {
  final String title;
  final String paragraph;
  final int maxLines;
  final bool centered;
  final String actionBtIcon;
  final double bubbleWidth;
  final dynamic margins;
  final dynamic corners;
  final bool editMode;
  final Function onParagraphTap;

  ParagraphBubble({
    this.title,
    @required this.paragraph,
    this.maxLines = 5,
    this.centered = false,
    this.actionBtIcon,
    this.bubbleWidth,
    this.corners,
    this.margins,
    this.editMode = false,
    this.onParagraphTap,
});

  @override
  _ParagraphBubbleState createState() => _ParagraphBubbleState();
}

class _ParagraphBubbleState extends State<ParagraphBubble> {
  int _maxLines;
  bool _isMax = false;
  bool _canExpand;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _maxLines = widget.maxLines;
    _canExpand = widget.paragraph.length > 100;
    super.initState();
  }
// -----------------------------------------------------------------------------
  void _onParagraphTap(){

    if (widget.editMode == true){
      widget.onParagraphTap();
    }

    else if (_canExpand == true){
      // widget.onParagraphTap();

      if (_maxLines == widget.maxLines){
        print('expanding maxLines');
        setState(() {
          _isMax = true;
          _maxLines = 1000;
        });
      }

      else {
        print('contracting maxLines');
        setState(() {
          _isMax = false;
          _maxLines = widget.maxLines;
        });
      }

    }


  }
// -----------------------------------------------------------------------------

  @override
  void didUpdateWidget(covariant ParagraphBubble oldWidget) {
    if(widget.editMode != oldWidget.editMode){
      setState(() {

      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    print('B---> ParagraphBubble : edit mode : ${widget.editMode}');

    // bool _infoExceededMaxLines = superFlyer.i

    TextStyle _paragraphTextStyle = superVerseStyle(
      context: context,
      color: Colorz.White255,
      weight: VerseWeight.thin,
      size: 2,
      italic: false,
      shadow: false,
      designMode: false,
      scaleFactor: 1,
    );

    return InPyramidsBubble(
        bubbleWidth: widget.bubbleWidth,
        margins: widget.margins,
        corners: widget.corners,
        title: widget.title,
        centered: widget.centered,
        actionBtIcon: widget.actionBtIcon,
        bubbleOnTap: widget.editMode == true || _canExpand == true ? _onParagraphTap : null,
        columnChildren: <Widget>[

          /// PARAGRAPH TEXT
          if (widget.paragraph != null && widget.paragraph != '')
          Padding(
            padding: Scale.superMargins(margins: widget.margins),
            child: SuperVerse(
              verse: widget.paragraph,
              maxLines: _maxLines,
              weight: VerseWeight.thin,
              centered: widget.centered,
              // onTap: _onParagraphTap,
            ),
          ),

          /// ARROW
          if (widget.paragraph != null && widget.paragraph != '')
          TextLinesAnalyzer(
              text: widget.paragraph.trim(),
              textStyle: _paragraphTextStyle,
              maxLines: widget.maxLines,
              childBeforeMaxLines: Container(),
              childAfterMaxLines: Container(
                width: widget.bubbleWidth,
                alignment: Alignment.center,
                child: DreamBox(
                  height: Ratioz.appBarMargin,
                  width: Ratioz.appBarMargin,
                  bubble: false,
                  margins: Ratioz.appBarPadding,
                  icon : _isMax ? Iconz.ArrowUp : Iconz.ArrowDown,
                  // onTap: _onParagraphTap,
                ),
              ),
          )


        ]
    );
  }
}
