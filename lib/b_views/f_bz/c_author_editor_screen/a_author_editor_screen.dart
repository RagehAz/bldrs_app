import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/x_author_editor_screen_controller.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/contact_field_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
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
    if (_canValidate != true){
      setState(() {
        _canValidate = true;
      });
    }
  }
  // --------------------
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<AuthorModel> _tempAuthor = ValueNotifier(null);
  final ValueNotifier<AuthorModel> _lastTempAuthor = ValueNotifier(null);
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
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'AuthorEditorScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initializeAuthorEditorLocalVariables(
      tempAuthor: _tempAuthor,
      oldAuthor: widget.author,
      bzModel: widget.bzModel,
    );

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
          tempAuthor: _tempAuthor,
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
            tempAuthor: _tempAuthor,
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
              tempAuthor: _tempAuthor,
              lastTempAuthor: _lastTempAuthor,
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
    _canPickImage.dispose();

    _nameNode.dispose();
    _titleNode.dispose();
    _phoneNode.dispose();
    _emailNode.dispose();

    _loading.dispose();

    _tempAuthor.dispose();
    _lastTempAuthor.dispose();

    // _fuckingNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onConfirmTap() async {

    _switchOnValidation();

    await onConfirmAuthorUpdates(
      context: context,
      tempAuthor: _tempAuthor,
      bzModel: widget.bzModel,
      oldAuthor: widget.author,
    );

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
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitleVerse: 'phid_edit_author_details',
      appBarRowWidgets: [

        AppBarButton(
          verse: 'Validate',
          onTap: (){

            Formers.validateForm(_formKey);
            // Snapper.snapToWidget(snapKey: _fuckingKey);

          },
        ),

      ],
      confirmButtonModel: ConfirmButtonModel(
        firstLine: 'phid_confirm',
        secondLine: 'phid_update_author_details',
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
                      fileModel: authorModel.pic,
                      titleVerse: 'phid_author_picture',
                      redDot: true,
                      bubbleType: BubbleType.authorPic,
                      onAddPicture: (ImagePickerType imagePickerType) => takeAuthorImage(
                        context: context,
                        author: _tempAuthor,
                        imagePickerType: imagePickerType,
                        canPickImage: _canPickImage,
                      ),
                    ),
                  ),

                  /// NAME
                  TextFieldBubble(
                    key: const ValueKey<String>('name'),
                    globalKey: _formKey,
                    focusNode: _nameNode,
                    appBarType: AppBarType.basic,
                    isFormField: true,
                    titleVerse: 'phid_author_name',
                    counterIsOn: true,
                    maxLength: 72,
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    bulletPoints: const <String>[
                      '##This will only change your name inside this Business account',
                    ],
                    initialTextValue: authorModel.name,
                    textOnChanged: (String text) => onAuthorNameChanged(
                      tempAuthor: _tempAuthor,
                      text: text,
                    ),
                    // autoValidate: true,
                    validator: () => Formers.personNameValidator(
                      name: authorModel.name,
                      canValidate: _canValidate
                    ),

                  ),

                  /// TITLE
                  TextFieldBubble(
                    globalKey: _formKey,
                    focusNode: _titleNode,
                    appBarType: AppBarType.basic,
                    isFormField: true,
                    titleVerse: 'phid_job_title',
                    counterIsOn: true,
                    maxLength: 72,
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    textOnChanged: (String text) => onAuthorTitleChanged(
                      text: text,
                      tempAuthor: _tempAuthor,
                    ),
                    initialTextValue: authorModel.title,
                    validator: () => Formers.jobTitleValidator(
                        jobTitle: authorModel.title,
                        canValidate: _canValidate
                    ),
                  ),

                  const DotSeparator(),

                  /// PHONE
                  ContactFieldBubble(
                    key: const ValueKey<String>('phone'),
                    globalKey: _formKey,
                    focusNode: _phoneNode,
                    appBarType: AppBarType.basic,
                    isFormField: true,
                    headerViewModel: const BubbleHeaderVM(
                      headlineVerse: 'phid_phone',
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
                    validator: () => Formers.contactsPhoneValidator(
                        contacts: authorModel.contacts,
                        zoneModel: widget.bzModel.zone,
                        canValidate: _canValidate
                    ),
                  ),

                  /// EMAIL
                  ContactFieldBubble(
                    key: const ValueKey<String>('email'),
                    globalKey: _formKey,
                    focusNode: _emailNode,
                    appBarType: AppBarType.basic,
                    isFormField: true,
                    headerViewModel: const BubbleHeaderVM(
                      headlineVerse: 'phid_email',
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
                    validator: () => Formers.contactsEmailValidator(
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
