import 'dart:async';

import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/x_author_editor_screen_controller.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';

import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class AuthorEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorEditorScreen({
    @required this.author,
    @required this.bzModel,
    this.checkLastSession = true,
    this.validateOnStartup = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel author;
  final BzModel bzModel;
  final bool checkLastSession;
  final bool validateOnStartup;
  /// --------------------------------------------------------------------------
  @override
  _AuthorEditorScreenState createState() => _AuthorEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _AuthorEditorScreenState extends State<AuthorEditorScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  bool _canValidate = false;
  void _switchOnValidation(){
    if (mounted == true){
      if (_canValidate != true){
        setState(() {
          _canValidate = true;
        });
      }
    }
  }  // --------------------
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<AuthorModel> _tempAuthor = ValueNotifier(null);
  // --------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------
  final FocusNode _nameNode = FocusNode();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _tempAuthor.value = widget.author;

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        await prepareAuthorPicForEditing(
          mounted: mounted,
          context: context,
          draftAuthor: _tempAuthor,
          oldAuthor: widget.author,
          bzModel: widget.bzModel,
        );
        // -------------------------------
        if (widget.checkLastSession == true){
          await loadAuthorEditorSession(
            mounted: mounted,
            context: context,
            oldAuthor: widget.author,
            bzModel: widget.bzModel,
            draftAuthor: _tempAuthor,
          );
        }
        // -----------------------------
        if (widget.validateOnStartup == true){
          _switchOnValidation();
          Formers.validateForm(_formKey);
        }
        // -----------------------------
        if (mounted == true){
          _tempAuthor.addListener((){
            _switchOnValidation();
            saveAuthorEditorSession(
              context: context,
              draftAuthor: _tempAuthor,
              bzModel: widget.bzModel,
              oldAuthor: widget.author,
              mounted: mounted,
            );
          });
        }
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _canPickImage.dispose();

    _nameNode.dispose();
    _titleNode.dispose();
    _phoneNode.dispose();
    _emailNode.dispose();

    _tempAuthor.dispose();

    // _fuckingNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onConfirmTap() async {

    Keyboard.closeKeyboard(context);

    await Future.delayed(const Duration(milliseconds: 100), () async {

      _switchOnValidation();

      await onConfirmAuthorUpdates(
        context: context,
        tempAuthor: _tempAuthor,
        bzModel: widget.bzModel,
        oldAuthor: widget.author,
      );

    });

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      key: const ValueKey<String>('AuthorEditorScreen'),
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      skyType: SkyType.black,
      pageTitleVerse: const Verse(
        text: 'phid_edit_author_details',
        translate: true,
      ),
      appBarRowWidgets: [

        AppBarButton(
          verse: Verse.plain('Validate'),
          onTap: (){

            Formers.validateForm(_formKey);
            // Snapper.snapToWidget(snapKey: _fuckingKey);

          },
        ),

      ],
      confirmButtonModel: ConfirmButtonModel(
        firstLine: const Verse(text: 'phid_confirm', translate: true),
        secondLine: const Verse(text: 'phid_update_author_details', translate: true),
        onTap: () => _onConfirmTap(),
      ),
      layoutWidget: Form(
        key: _formKey,
        child: ValueListenableBuilder(
          valueListenable: _tempAuthor,
          builder: (_, AuthorModel authorModel, Widget child){

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  const Stratosphere(),

                  /// --- AUTHOR IMAGE
                  Center(
                    child: AddImagePicBubble(
                      // width: BldrsAppBar.width(context),
                      picModel: authorModel.picModel,
                      titleVerse: const Verse(
                        text: 'phid_author_picture',
                        translate: true,
                      ),
                      redDot: true,
                      bubbleType: BubbleType.authorPic,
                      onAddPicture: (PicMakerType imagePickerType) => takeAuthorImage(
                        context: context,
                        author: _tempAuthor,
                        bzModel: widget.bzModel,
                        imagePickerType: imagePickerType,
                        canPickImage: _canPickImage,
                      ),
                    ),
                  ),

                  /// NAME
                  TextFieldBubble(
                    key: const ValueKey<String>('name'),
                    headerViewModel: const BubbleHeaderVM(
                      headlineVerse: Verse(
                        text: 'phid_author_name',
                        translate: true,
                      ),
                      redDot: true,
                    ),
                    formKey: _formKey,
                    focusNode: _nameNode,
                    appBarType: AppBarType.basic,
                    isFormField: true,
                    counterIsOn: true,
                    maxLength: 72,
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    bulletPoints: const <Verse>[
                      Verse(
                        text: 'phid_author_name_changing_note',
                        translate: true,
                      ),
                    ],
                    initialText: authorModel.name,
                    onTextChanged: (String text) => onAuthorNameChanged(
                      tempAuthor: _tempAuthor,
                      text: text,
                    ),
                    // autoValidate: true,
                    validator: (String text) => Formers.personNameValidator(
                      name: authorModel.name,
                      canValidate: _canValidate
                    ),

                  ),

                  /// TITLE
                  TextFieldBubble(
                    formKey: _formKey,
                    headerViewModel: const BubbleHeaderVM(
                      headlineVerse: Verse(
                        text: 'phid_job_title',
                        translate: true,
                      ),
                      redDot: true,
                    ),
                    focusNode: _titleNode,
                    appBarType: AppBarType.basic,
                    isFormField: true,
                    counterIsOn: true,
                    maxLength: 72,
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    onTextChanged: (String text) => onAuthorTitleChanged(
                      text: text,
                      tempAuthor: _tempAuthor,
                    ),
                    initialText: authorModel.title,
                    validator: (String text) => Formers.jobTitleValidator(
                        jobTitle: authorModel.title,
                        canValidate: _canValidate
                    ),
                  ),

                  const DotSeparator(),

                  /// PHONE
                  ContactFieldEditorBubble(
                    key: const ValueKey<String>('phone'),
                    formKey: _formKey,
                    focusNode: _phoneNode,
                    appBarType: AppBarType.basic,
                    isFormField: true,
                    headerViewModel: const BubbleHeaderVM(
                      headlineVerse: Verse(
                        text: 'phid_phone',
                        translate: true,
                      ),
                      redDot: true,
                    ),
                    canPaste: false,
                    keyboardTextInputType: TextInputType.phone,
                    keyboardTextInputAction: TextInputAction.next,
                    initialTextValue: ContactModel.getInitialContactValue(
                      type: ContactType.phone,
                      countryID: widget.bzModel.zone.countryID,
                      existingContacts: authorModel.contacts,
                    ),
                    textOnChanged: (String text) => onAuthorContactChanged(
                      contactType: ContactType.phone,
                      value: text,
                      tempAuthor: _tempAuthor,
                    ),
                    validator: (String text) => Formers.contactsPhoneValidator(
                      contacts: authorModel.contacts,
                      zoneModel: widget.bzModel.zone,
                      canValidate: _canValidate,
                      context: context,
                      isRequired: true,

                    ),
                  ),

                  /// EMAIL
                  ContactFieldEditorBubble(
                    key: const ValueKey<String>('email'),
                    formKey: _formKey,
                    focusNode: _emailNode,
                    appBarType: AppBarType.basic,
                    isFormField: true,
                    headerViewModel: const BubbleHeaderVM(
                      headlineVerse: Verse(
                        text: 'phid_emailAddress',
                        translate: true,
                      ),
                      redDot: true,
                    ),
                    keyboardTextInputType: TextInputType.emailAddress,
                    keyboardTextInputAction: TextInputAction.done,
                    initialTextValue: ContactModel.getInitialContactValue(
                      type: ContactType.email,
                      countryID: widget.bzModel.zone.countryID,
                      existingContacts: authorModel.contacts,
                    ),
                    textOnChanged: (String text) => onAuthorContactChanged(
                      contactType: ContactType.email,
                      value: text,
                      tempAuthor: _tempAuthor,
                    ),
                    canPaste: false,
                    validator: (String text) => Formers.contactsEmailValidator(
                        contacts: authorModel.contacts,
                        canValidate: _canValidate
                    ),
                  ),

                  const DotSeparator(),

                  // /// CONTACTS
                  // ContactsEditorsBubbles(
                  //   globalKey: _formKey,
                  //   contacts: tempAuthor.contacts,
                  //   contactsOwnerType: ContactsOwnerType.author,
                  //   appBarType: AppBarType.basic,
                  // ),

                  /// SNAPPER VALIDATION TEST
                  /*
                  Snapper(
                      snapKey: _fuckingKey,
                      child: SuperValidator(
                        width: Scale.superScreenWidth(context) - 20,
                        validator: (){
                          return _message;
                        },
                      ),
                  ),
                   */

                  const Horizon(),

                ],
              ),
            );

          },
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
