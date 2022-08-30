import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
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
    @required this.title,
    @required this.appBarType,
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
    this.actionBtIcon,
    this.actionBtFunction,
    this.horusOnTapDown,
    this.horusOnTapUp,
    this.horusOnTapCancel,
    this.leadingIcon,
    this.keyboardTextInputType = TextInputType.url,
    this.canPaste = true,
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
  final List<String> bulletPoints;
  final bool translateBulletPoints;
  final bool fieldIsRequired;
  final bool loading;
  final String actionBtIcon;
  final Function actionBtFunction;
  final Function horusOnTapDown;
  final Function horusOnTapUp;
  final Function horusOnTapCancel;
  final String leadingIcon;
  final TextInputType keyboardTextInputType;
  final bool canPaste;
  final AppBarType appBarType;
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
      _textController.dispose();
    }

    super.dispose();
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
    final double leadingIconSize = widget.leadingIcon == null ? 0 : _textFieldHeight;
    final double leadingAndFieldSpacing = widget.leadingIcon == null ? 0 : _spacer;
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
      width: _bubbleWidth,
        title: widget.title,
        redDot: widget.fieldIsRequired,
        actionBtIcon: widget.actionBtIcon, // widget.actionBtColor
        actionBtFunction: widget.actionBtFunction,
        columnChildren: <Widget>[

          /// TEXT FIELD ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[

              /// LEADING ICON
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

              /// SPACER
              if (widget.leadingIcon != null)
                const SizedBox(width: _spacer,),

              /// TEXT FIELD
              SuperTextField(
                appBarType: widget.appBarType,
                globalKey: null,
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
