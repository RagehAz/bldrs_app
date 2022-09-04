import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ContactFieldBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ContactFieldBubble({
    @required this.appBarType,
    @required this.headerViewModel,
    @required this.globalKey,
    this.hintText = '...',
    this.textController,
    this.textOnChanged,
    this.isFormField,
    this.onSaved,
    this.keyboardTextInputAction,
    this.initialTextValue,
    this.validator,
    this.bulletPoints,
    this.translateBulletPoints = true,
    this.fieldIsRequired = false,
    this.loading = false,
    this.horusOnTapDown,
    this.horusOnTapUp,
    this.horusOnTapCancel,
    this.fieldLeadingIcon,
    this.keyboardTextInputType = TextInputType.url,
    this.canPaste = true,
    this.focusNode,
    this.autoValidate = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String hintText;
  final TextEditingController textController;
  final Function textOnChanged;
  final bool isFormField;
  final Function onSaved;
  final TextInputAction keyboardTextInputAction;
  final String initialTextValue;
  final Function validator;
  final List<String> bulletPoints;
  final bool translateBulletPoints;
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
  final GlobalKey globalKey;
  final FocusNode focusNode;
  final bool autoValidate;
  /// --------------------------------------------------------------------------
  @override
  _ContactFieldBubbleState createState() => _ContactFieldBubbleState();

  /// --------------------------------------------------------------------------
}

class _ContactFieldBubbleState extends State<ContactFieldBubble> {
  // --------------------------------------------------------------------------
  String paste = '';
  TextEditingController _textController;
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    if (widget.textController == null){
      _textController = TextEditingController(text: widget.initialTextValue);
    }
    else {
      _textController = widget.textController;
    }

  }
  // --------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {

    if (widget.textController == null){
      _textController?.dispose();
    }

    super.dispose();
  }
  // --------------------------------------------------------------------------
  @override
  void didUpdateWidget(covariant ContactFieldBubble oldWidget) {
    // if (oldWidget.textController?.text != widget.textController?.text){
      setState(() {
        _textController = widget.textController;
      });
    // }
    super.didUpdateWidget(oldWidget);
  }
  // --------------------------------------------------------------------------
  Future<void> _pasteFunction() async {
    final String value = await FlutterClipboard.paste();

    _textController.text = value;

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
    // ---------------------------
    /// TEXT FIELD HEIGHT
    final double _textFieldHeight = SuperTextField.getFieldHeight(
        context: context,
        minLines: 1,
        textSize: 2,
        scaleFactor: 1,
        withBottomMargin: false,
        withCounter: false,
    );
    // ---------------------------
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
    // ---------------------------

    return Bubble(
      headerViewModel: widget.headerViewModel,
      width: _bubbleWidth,
        columnChildren: <Widget>[

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
                focusNode: widget.focusNode,
                appBarType: widget.appBarType,
                globalKey: widget.globalKey,
                titleVerse: '##Contact',
                width: fieldWidth,
                isFormField: widget.isFormField,
                initialValue: paste == '' ? widget.initialTextValue : null,
                hintVerse: widget.hintText,
                textInputType: widget.keyboardTextInputType,
                textController: _textController,
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
                  verse:  'phid_paste  ',
                  verseScaleFactor: 0.5,
                  verseWeight: VerseWeight.thin,
                  verseItalic: true,
                  color: Colorz.white10,
                  onTap: _pasteFunction,
                ),


            ],
          ),

          /// BUBBLE COMMENTS
          if (widget.bulletPoints != null)
            BubbleBulletPoints(
              bulletPoints: widget.bulletPoints,
              translateBullets: widget.translateBulletPoints,
            ),

        ]
    );

  }
}
