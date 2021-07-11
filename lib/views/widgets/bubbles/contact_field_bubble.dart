import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'in_pyramids_bubble.dart';

class ContactFieldBubble extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController textController;
  final Function textOnChanged;
  final bool fieldIsFormField;
  final Function onSaved;
  final TextInputAction keyboardTextInputAction;
  final String initialTextValue;
  final Function validator;
  final String comments;
  final bool fieldIsRequired;
  final bool loading;
  final String actionBtIcon;
  final Color actionBtColor;
  final Function actionBtFunction;
  final Function horusOnTapDown;
  final Function horusOnTapUp;
  final Function horusOnTapCancel;
  final String leadingIcon;
  final TextInputType keyboardTextInputType;

  ContactFieldBubble({
    @required this.title,
    this.hintText = '...',
    this.textController,
    this.textOnChanged,
    this.fieldIsFormField,
    this.onSaved,
    this.keyboardTextInputAction,
    this.initialTextValue,
    this.validator,
    this.comments,
    this.fieldIsRequired = false,
    this.loading = false,
    this.actionBtColor,
    this.actionBtIcon,
    this.actionBtFunction,
    this.horusOnTapDown,
    this.horusOnTapUp,
    this.horusOnTapCancel,
    this.leadingIcon,
    this.keyboardTextInputType = TextInputType.url,
  });

  @override
  _ContactFieldBubbleState createState() => _ContactFieldBubbleState();
}

class _ContactFieldBubbleState extends State<ContactFieldBubble> {
  String paste = '';
  TextEditingController pasteController = TextEditingController();

  Future<void> _pasteFunction() async {
    final value = await FlutterClipboard.paste();
    setState(() {
      paste = value;
      pasteController.text = paste;
      // widget.textOnChanged(paste);
    });
  }

  @override
  Widget build(BuildContext context) {

    int titleVerseSize = 2;
    double actionBtSize = superVerseRealHeight(context, titleVerseSize, 1, null);
    double actionBtCorner = actionBtSize * 0.4;
    double leadingIconSize = 35;
    double leadingAndFieldSpacing = 5;
    double bubbleClearWidth = Scale.superBubbleClearWidth(context);
    double fieldWidth = widget.leadingIcon == null ? bubbleClearWidth : bubbleClearWidth - leadingIconSize - leadingAndFieldSpacing;

    return
      InPyramidsBubble(
          columnChildren: <Widget>[

            Container(
              // color: Colorz.YellowSmoke,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  // --- BUBBLE TITLE
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                    child: SuperVerse(
                      verse: widget.title,
                      size: titleVerseSize,
                      redDot: widget.fieldIsRequired,
                    ),
                  ),

                  // --- ACTION BUTTON
                  widget.actionBtIcon == null ? Container() :
                  DreamBox(
                    height: actionBtSize,
                    width: actionBtSize,
                    corners: actionBtCorner,
                    color: widget.actionBtColor,
                    icon: widget.actionBtIcon,
                    iconSizeFactor: 0.6,
                    onTap: widget.actionBtFunction,
                  ),

                ],
              ),
            ),

            Container(
              // color: Colorz.BloodTest,
              child: Stack(
                alignment: Aligners.superInverseTopAlignment(context),
                children: <Widget>[

                  // --- TEXT FIELD
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[

                      widget.leadingIcon == null ? Container() :
                      DreamBox(
                        height: 35,
                        width: 35,
                        icon: widget.leadingIcon,
                        iconSizeFactor: widget.leadingIcon == Iconz.ComWebsite ||
                            widget.leadingIcon == Iconz.ComEmail ||
                            widget.leadingIcon == Iconz.ComPhone ?
                        0.6 : 1,
                      ),

                      widget.leadingIcon == null ? Container() :
                      Container(
                        width: 5,
                      ),

                      Container(
                        width: fieldWidth,
                        child: SuperTextField(
                          fieldIsFormField: widget.fieldIsFormField,
                          hintText: widget.hintText,
                          counterIsOn: false,
                          keyboardTextInputType: widget.keyboardTextInputType,
                          textController: paste == '' ? widget.textController : pasteController,
                          onChanged: widget.textOnChanged,
                          onSaved: widget.onSaved,
                          keyboardTextInputAction: widget.keyboardTextInputAction,
                          initialValue: paste == '' ? widget.initialTextValue : null,
                          validator: widget.validator,
                          inputSize: 2,
                          textDirection: TextDirection.ltr,
                        ),
                      ),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[

                      // --- LOADING INDICATOR
                      if (widget.loading)
                      Loading(size: 35,loading: widget.loading,),

                      DreamBox(
                        height: 35,
                        verse: '${Wordz.paste(context)}  ',
                        verseScaleFactor: 0.5,
                        verseWeight: VerseWeight.thin,
                        verseItalic: true,
                        color: Colorz.White10,
                        onTap: _pasteFunction,
                      ),

                    ],
                  ),

                ],
              ),
            ),

            // --- BUBBLE COMMENTS
            widget.comments == null ? Container() :
            SuperVerse(
              verse: widget.comments,
              italic: true,
              color: Colorz.White80,
              size: 2,
              weight: VerseWeight.thin,
              leadingDot: true,
            ),

          ]
      )
    ;
  }
}
