import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/bubbles/model/bubble_header_vm.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_clip_board.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_text_field.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class ContactFieldEditorBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ContactFieldEditorBubble({
    required this.appBarType,
    required this.headerViewModel,
    required this.formKey,
    required this.contactsArePublic,
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
    this.textController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? hintVerse;
  // final TextEditingController textController;
  final ValueChanged<String?>? textOnChanged;
  final bool? isFormField;
  final ValueChanged<String?>? onSaved;
  final TextInputAction? keyboardTextInputAction;
  final String? initialTextValue;
  final String? Function(String?)? validator;
  final List<Verse>? bulletPoints;
  final bool fieldIsRequired;
  final bool loading;
  final Function? horusOnTapDown;
  final Function? horusOnTapUp;
  final Function? horusOnTapCancel;
  final String? fieldLeadingIcon;
  final TextInputType keyboardTextInputType;
  final bool canPaste;
  final AppBarType appBarType;
  final BubbleHeaderVM headerViewModel;
  final GlobalKey? formKey;
  final FocusNode? focusNode;
  final bool autoValidate;
  final TextEditingController? textController;
  final bool contactsArePublic;
  /// --------------------------------------------------------------------------
  @override
  _ContactFieldEditorBubbleState createState() => _ContactFieldEditorBubbleState();
  /// --------------------------------------------------------------------------
  static List<Verse> privacyPoint({
    required bool contactsArePublic,
  }){
    return <Verse>[

      if (Mapper.boolIsTrue(contactsArePublic) == true)
        const Verse(
          id: 'phid_all_contacts_are_public',
          translate: true,
        ),

      if (Mapper.boolIsTrue(contactsArePublic) == false)
        const Verse(
          id: 'phid_contact_is_hidden_from_public',
          translate: true,
        ),

    ];
  }
  /// --------------------------------------------------------------------------
}

class _ContactFieldEditorBubbleState extends State<ContactFieldEditorBubble> {
  // -----------------------------------------------------------------------------
  String paste = '';
  late TextEditingController _textController;
  String? _error;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _textController = widget.textController ?? TextEditingController(text: widget.initialTextValue);

    if (widget.validator != null){
      /// REMOVED
      _textController.addListener(_textControllerListener);
    }


  }
  // --------------------
  @override
  void dispose() {

    if (widget.validator != null){
      _textController.removeListener(_textControllerListener);
    }

    if (widget.textController == null){
      _textController.dispose();
    }

    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant ContactFieldEditorBubble oldWidget) {

    if (
    oldWidget.headerViewModel != widget.headerViewModel ||
    oldWidget.contactsArePublic != widget.contactsArePublic
    ){
      setState(() {});
    }

    // if (oldWidget.initialTextValue != widget.initialTextValue){
    //   setState(() {
    //     _textController = widget.textController;
    //   });
    // _textController.text = widget.initialTextValue;
    // }
    super.didUpdateWidget(oldWidget);
  }
  // --------------------------------------------------------------------------

  /// TEXT CONTROLLER LISTENER

  // --------------------
  void _textControllerListener() {

    final String? _message = widget.validator!.call(_textController.text);

    if (_message != null){
      setState(() {
        _error = _message;
      });
    }

    if (_message == null && _error != null){
      setState(() {
        _error = null;
      });
    }

  }
  // --------------------------------------------------------------------------

  /// PASTE

  // --------------------
  Future<void> _pasteFunction() async {

    final String? value = await TextClipBoard.paste();

    if (TextCheck.isEmpty(value) == false){
      _textController.text = value ?? '';
    }

    if (widget.textOnChanged != null){
      widget.textOnChanged?.call(value);
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// TEXT FIELD HEIGHT
    final double _textFieldHeight = BldrsTextField.getFieldHeight(
        context: context,
        minLines: 1,
        textSize: 2,
        scaleFactor: 1,
        withBottomMargin: false,
        withCounter: false,
    );
    // --------------------
    /// CLEAR WIDTH - SPACING
    final double _bubbleWidth = Bubble.bubbleWidth(context: context);
    final double bubbleClearWidth = Bubble.clearWidth(context: context);
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
        bubbleColor: widget.contactsArePublic == false ? Colorz.white255.withOpacity(0.01)
            :
        Formers.validatorBubbleColor(
          validator: (){
            return _error;
          },
        ),
        bubbleHeaderVM: widget.headerViewModel,
        width: _bubbleWidth,
        columnChildren: <Widget>[

          /// BULLET POINTS
          if (widget.bulletPoints != null)
            BldrsBulletPoints(
              bulletPoints: widget.bulletPoints,
              showBottomLine: false,
            ),

          /// TEXT FIELD ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[

              /// LEADING ICON
              if (widget.fieldLeadingIcon != null)
                BldrsBox(
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
              BldrsTextField(
                textController: _textController,
                // focusNode: widget.focusNode,
                appBarType: widget.appBarType,
                globalKey: widget.formKey,
                // titleVerse: Verse.plain(widget.headerViewModel.headlineText),
                width: fieldWidth,
                isFormField: widget.isFormField,
                initialValue: paste == '' ? widget.initialTextValue : null,
                hintVerse: widget.hintVerse,
                textInputType: widget.keyboardTextInputType,
                onChanged: widget.textOnChanged,
                onSavedForForm: widget.onSaved,
                textInputAction: widget.keyboardTextInputAction,
                // validator: widget.validator,
                autoValidate: widget.autoValidate,
                textDirection: TextDirection.ltr,
                hintTextDirection: TextDirection.ltr,
                textColor: widget.contactsArePublic == true ? Colorz.white255 : Colorz.white80,
                fieldColor: widget.contactsArePublic == true ? Colorz.white10 : Colorz.white255.withOpacity(0.02),
              ),

              if (widget.canPaste == true)
                const SizedBox(width: _spacer,),

              if (widget.canPaste == true)
                BldrsBox(
                  height: _pasteButtonHeight,
                  width: _pasteButtonWidth,
                  icon: Iconz.paste,
                  iconSizeFactor: 0.5,
                  // verse:  const Verse(
                  //   id: 'phid_paste',
                  //   translate: true,
                  // ),
                  // verseScaleFactor: 0.5,
                  // verseWeight: VerseWeight.thin,
                  // verseItalic: true,
                  color: Colorz.white10,
                  onTap: _pasteFunction,
                ),


            ],
          ),

          /// VALIDATOR
          BldrsValidator(
            width: _bubbleWidth,
            autoValidate: widget.autoValidate,
            focusNode: widget.focusNode,
            // validator: () => widget.validator?.call(_textController.text),
            validator: (){
              return _error;
            },
          ),

        ]
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
