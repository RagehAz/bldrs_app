import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ContactFieldEditorBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ContactFieldEditorBubble({
    @required this.appBarType,
    @required this.headerViewModel,
    @required this.formKey,
    this.hintVerse,
    // this.textController,
    this.textOnChanged,
    this.isFormField,
    this.onSaved,
    this.keyboardTextInputAction,
    this.initialTextValue,
    this.validator,
    this.bulletPoints,
    this.fieldIsRequired = false,
    this.loading = false,
    this.horusOnTapDown,
    this.horusOnTapUp,
    this.horusOnTapCancel,
    this.fieldLeadingIcon,
    this.keyboardTextInputType = TextInputType.url,
    this.canPaste = true,
    this.focusNode,
    this.autoValidate = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse hintVerse;
  // final TextEditingController textController;
  final Function textOnChanged;
  final bool isFormField;
  final Function onSaved;
  final TextInputAction keyboardTextInputAction;
  final String initialTextValue;
  final Function(String) validator;
  final List<Verse> bulletPoints;
  final bool fieldIsRequired;
  final bool loading;
  final Function horusOnTapDown;
  final Function horusOnTapUp;
  final Function horusOnTapCancel;
  final String fieldLeadingIcon;
  final TextInputType keyboardTextInputType;
  final bool canPaste;
  final AppBarType appBarType;
  final BubbleHeaderVM headerViewModel;
  final GlobalKey formKey;
  final FocusNode focusNode;
  final bool autoValidate;
  /// --------------------------------------------------------------------------
  @override
  _ContactFieldEditorBubbleState createState() => _ContactFieldEditorBubbleState();
  /// --------------------------------------------------------------------------
}

class _ContactFieldEditorBubbleState extends State<ContactFieldEditorBubble> {
  // -----------------------------------------------------------------------------
  String paste = '';
  TextEditingController _textController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    // if (widget.textController == null){
      _textController = TextEditingController(text: widget.initialTextValue);
    // }
    // else {
    //   _textController = widget.textController;
    // }

  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {

    // if (widget.textController == null){
      _textController?.dispose();
    // }

    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant ContactFieldEditorBubble oldWidget) {
    // if (oldWidget.initialTextValue != widget.initialTextValue){
    //   setState(() {
    //     _textController = widget.textController;
    //   });
    // _textController.text = widget.initialTextValue;
    // }
    super.didUpdateWidget(oldWidget);
  }
  // --------------------------------------------------------------------------
  Future<void> _pasteFunction() async {
    final String value = await FlutterClipboard.paste();

    blog(value);

    // if (_textController != null){
      _textController.text = value;
    // }

    if (widget.textOnChanged != null){
      widget.textOnChanged(value);
    }

    // setState(() {
    //   paste = value;
    //   pasteController.text = paste;
    //   // widget.textOnChanged(paste);
    // });
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// TEXT FIELD HEIGHT
    final double _textFieldHeight = SuperTextField.getFieldHeight(
        context: context,
        minLines: 1,
        textSize: 2,
        scaleFactor: 1,
        withBottomMargin: false,
        withCounter: false,
    );
    // --------------------
    /// CLEAR WIDTH - SPACING
    final double _bubbleWidth = BldrsAppBar.width(context,);
    final double bubbleClearWidth = Bubble.clearWidth(context);
    const double _spacer = 5;
    /// LEADING ICON SIZE
    final double leadingIconSize = widget.fieldLeadingIcon == null ? 0 : _textFieldHeight;
    final double leadingAndFieldSpacing = widget.fieldLeadingIcon == null ? 0 : _spacer;
    /// PASTE BUTTON SIZE
    final double _pasteButtonHeight = _textFieldHeight;
    final double _pasteButtonWidth = widget.canPaste == true ? 50 : 0;
    final double _pasteButtonSpacer = widget.canPaste == true ? _spacer : 0;
    /// FIELD SIZE
    final double fieldWidth =
          bubbleClearWidth
        - leadingIconSize
        - leadingAndFieldSpacing
        - _pasteButtonWidth
        - _pasteButtonSpacer;
    // --------------------
    return Bubble(
        bubbleColor: Formers.validatorBubbleColor(
          validator: () => widget.validator(_textController.text),
        ),
        headerViewModel: widget.headerViewModel,
      width: _bubbleWidth,
        columnChildren: <Widget>[

          /// BULLET POINTS
          if (widget.bulletPoints != null)
            BulletPoints(
              bulletPoints: widget.bulletPoints,
            ),

          /// TEXT FIELD ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[

              /// LEADING ICON
              if (widget.fieldLeadingIcon != null)
                DreamBox(
                  height: 35,
                  width: 35,
                  icon: widget.fieldLeadingIcon,
                  iconSizeFactor: widget.fieldLeadingIcon == Iconz.comWebsite ||
                      widget.fieldLeadingIcon == Iconz.comEmail ||
                      widget.fieldLeadingIcon == Iconz.comPhone
                      ? 0.6 : 1,
                ),

              /// SPACER
              if (widget.fieldLeadingIcon != null)
                const SizedBox(width: _spacer,),

              /// TEXT FIELD
              SuperTextField(
                textController: _textController,

                focusNode: widget.focusNode,
                appBarType: widget.appBarType,
                globalKey: widget.formKey,
                titleVerse: widget.headerViewModel?.headlineVerse,
                width: fieldWidth,
                isFormField: widget.isFormField,
                initialValue: paste == '' ? widget.initialTextValue : null,
                hintVerse: widget.hintVerse,
                textInputType: widget.keyboardTextInputType,
                onChanged: widget.textOnChanged,
                onSavedForForm: widget.onSaved,
                textInputAction: widget.keyboardTextInputAction,
                validator: widget.validator,
                autoValidate: widget.autoValidate,
                textDirection: TextDirection.ltr,

              ),

              if (widget.canPaste == true)
                const SizedBox(width: _spacer,),

              if (widget.canPaste == true)
                DreamBox(
                  height: _pasteButtonHeight,
                  width: _pasteButtonWidth,
                  verse:  const Verse(
                    text: 'phid_paste',
                    translate: true,
                  ),
                  verseScaleFactor: 0.5,
                  verseWeight: VerseWeight.thin,
                  verseItalic: true,
                  color: Colorz.white10,
                  onTap: _pasteFunction,
                ),


            ],
          ),

        ]
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
