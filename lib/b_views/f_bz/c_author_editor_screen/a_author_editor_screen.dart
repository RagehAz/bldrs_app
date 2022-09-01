import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/x_author_editor_screen_controller.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/editors/contacts_editor_bubbles.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter/material.dart';

class AuthorEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorEditorScreen({
    @required this.author,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel author;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  _AuthorEditorScreenState createState() => _AuthorEditorScreenState();
/// --------------------------------------------------------------------------
}

class _AuthorEditorScreenState extends State<AuthorEditorScreen> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<AuthorModel> _tempAuthor = ValueNotifier(null);
  // --------------------
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  // --------------------
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleNode = FocusNode();
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
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
      nameController: _nameController,
      titleController: _titleController,
      oldAuthor: widget.author,
      bzModel: widget.bzModel,
    );

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        await prepareAuthorPicForEditing(
          context: context,
          tempAuthor: _tempAuthor,
        );

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _canPickImage.dispose();

    _nameController.dispose();
    _nameNode.dispose();

    _titleController.dispose();
    _titleNode.dispose();

    _loading.dispose();

    ContactModel.disposeContactsControllers(_tempAuthor.value.contacts);
    _tempAuthor.dispose();

    super.dispose();
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
      confirmButtonModel: ConfirmButtonModel(
        firstLine: 'phid_confirm',
        secondLine: 'phid_update_author_details',
        onTap: () => onConfirmAuthorUpdates(
          context: context,
          tempAuthor: _tempAuthor,
          titleController: _titleController,
          nameController: _nameController,
          bzModel: widget.bzModel,
          oldAuthor: widget.author,
        ),
      ),
      layoutWidget: Form(
        key: _formKey,
        child: ValueListenableBuilder(
          valueListenable: _tempAuthor,
          builder: (_, AuthorModel tempAuthor, Widget child){

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: Stratosphere.stratosphereSandwich,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[

                /// --- AUTHOR IMAGE
                AddImagePicBubble(
                  fileModel: tempAuthor.pic,
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

                /// NAME
                TextFieldBubble(
                  globalKey: _formKey,
                  focusNode: _nameNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  textController: _nameController,
                  titleVerse: 'phid_author_name',
                  counterIsOn: true,
                  maxLength: 72,
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  bulletPoints: const <String>[
                    '##This will only change your name inside this Business account',
                  ],
                  validator: (){

                    if (Stringer.checkStringIsEmpty(_nameController.text) == true){
                      return '##Author name can not be empty';
                    }
                    else if (_nameController.text.length <= 3){
                      return '##Author name should be more than 3 characters';
                    }
                    else {
                      return null;
                    }

                  },
                ),

                /// TITLE
                TextFieldBubble(
                  globalKey: _formKey,
                  focusNode: _titleNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  textController: _titleController,
                  titleVerse: 'phid_job_title',
                  counterIsOn: true,
                  maxLength: 72,
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  validator: (){

                    if (Stringer.checkStringIsEmpty(_titleController.text) == true){
                      return '##Author name can not be empty';
                    }
                    else if (_titleController.text.length <= 3){
                      return '##Author name should be more than 3 characters';
                    }
                    else {
                      return null;
                    }

                  },
                ),

                /// CONTACTS
                ContactsEditorsBubbles(
                  globalKey: _formKey,
                  contacts: tempAuthor.contacts,
                  contactsOwnerType: ContactsOwnerType.author,
                  appBarType: AppBarType.basic,
                ),

              ],
            );

          },
        ),
      ),
    );

  }
}
