import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ContactFieldBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ContactFieldBubble({
    @required this.title,
    this.hintText = '...',
    this.textController,
    this.textOnChanged,
    this.isFormField,
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
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final String hintText;
  final TextEditingController textController;
  final Function textOnChanged;
  final bool isFormField;
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

  /// --------------------------------------------------------------------------
  @override
  _ContactFieldBubbleState createState() => _ContactFieldBubbleState();

  /// --------------------------------------------------------------------------
}

class _ContactFieldBubbleState extends State<ContactFieldBubble> {
  // --------------------------------------------------------------------------
  String paste = '';
  final TextEditingController pasteController = TextEditingController();
  // --------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    pasteController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  Future<void> _pasteFunction() async {
    final String value = await FlutterClipboard.paste();
    setState(() {
      paste = value;
      pasteController.text = paste;
      // widget.textOnChanged(paste);
    });
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const int titleVerseSize = 2;
    final double actionBtSize = SuperVerse.superVerseRealHeight(
        context: context,
        size: titleVerseSize,
        sizeFactor: 1,
        hasLabelBox: false,
    );
    final double actionBtCorner = actionBtSize * 0.4;
    const double leadingIconSize = 35;
    const double leadingAndFieldSpacing = 5;
    final double bubbleClearWidth = Bubble.clearWidth(context);
    final double fieldWidth = widget.leadingIcon == null ?
    bubbleClearWidth
        :
    bubbleClearWidth - leadingIconSize - leadingAndFieldSpacing;

    return Bubble(columnChildren: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// BUBBLE TITLE
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            child: SuperVerse(
              verse: widget.title,
              redDot: widget.fieldIsRequired,
            ),
          ),

          /// ACTION BUTTON
          if (widget.actionBtIcon != null)
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

      Stack(
        alignment: Aligners.superInverseTopAlignment(context),
        children: <Widget>[

          /// TEXT FIELD
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[

              if (widget.leadingIcon != null)
                DreamBox(
                  height: 35,
                  width: 35,
                  icon: widget.leadingIcon,
                  iconSizeFactor: widget.leadingIcon == Iconz.comWebsite ||
                          widget.leadingIcon == Iconz.comEmail ||
                          widget.leadingIcon == Iconz.comPhone
                      ? 0.6 : 1,
                ),

              if (widget.leadingIcon != null)
                Container(
                  width: 5,
                ),

              /// TEXT FIELD
              SuperTextField(
                title: 'Contact',
                width: fieldWidth,
                isFormField: widget.isFormField,
                initialValue: paste == '' ? widget.initialTextValue : null,
                hintText: widget.hintText,
                textInputType: widget.keyboardTextInputType,
                textController: paste == '' ? widget.textController : pasteController,
                onChanged: widget.textOnChanged,
                onSavedForForm: widget.onSaved,
                textInputAction: widget.keyboardTextInputAction,
                validator: widget.validator,
                textDirection: TextDirection.ltr,
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.ltr,
            children: <Widget>[

              /// LOADING INDICATOR
              if (widget.loading)
                Loading(
                  size: 35,
                  loading: widget.loading,
                ),

              DreamBox(
                height: 35,
                verse: '${xPhrase(context, 'phid_paste')}  ',
                verseScaleFactor: 0.5,
                verseWeight: VerseWeight.thin,
                verseItalic: true,
                color: Colorz.white10,
                onTap: _pasteFunction,
              ),

            ],
          ),
        ],
      ),

      /// BUBBLE COMMENTS
      if (widget.comments != null)
        SuperVerse(
          verse: widget.comments,
          italic: true,
          color: Colorz.white80,
          weight: VerseWeight.thin,
          leadingDot: true,
        ),

    ]
    );
  }
}
