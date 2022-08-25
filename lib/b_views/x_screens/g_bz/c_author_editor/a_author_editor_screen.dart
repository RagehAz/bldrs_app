import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/contact_field_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/c_author_editor/a_author_editor_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
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
  ValueNotifier<AuthorModel> _author;
  ValueNotifier<FileModel> _authorPicFile;
  TextEditingController _nameController;
  TextEditingController _titleController;
  List<TextEditingController> _generatedContactsControllers;
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

    blog('starting AuthorEditorScreen : with ${widget.author.userID}');

    final AuthorModel _theAuthor = widget.author;
    _theAuthor.blogAuthor(
      methodName: 'initState',
    );

    _author = ValueNotifier(_theAuthor);
    final FileModel _initialImageFile = FileModel(
      url: _theAuthor.pic,
      fileName: AuthorModel.generateAuthorPicID(
          authorID: _theAuthor.userID,
          bzID: widget.bzModel.id,
      ),
      size: null,
    );
    _authorPicFile = ValueNotifier(_initialImageFile);
    _nameController = TextEditingController(text: _theAuthor.name);
    _titleController = TextEditingController(text: _theAuthor.title);

    _generatedContactsControllers = ContactModel.initializeContactsControllers(
      existingContacts: _theAuthor.contacts,
      countryID: widget.bzModel.zone.countryID,
    );

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        _authorPicFile.value = await FileModel.completeModel(_authorPicFile.value);

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

    _author.dispose();
    _loading.dispose();
    _nameController.dispose();
    _titleController.dispose();

    TextChecker.disposeAllTextControllers(_generatedContactsControllers);

    super.dispose();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      key: const ValueKey<String>('AuthorEditorScreen'),
      // loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitleVerse: xPhrase(context, '##Edit Author Details'),
      // appBarBackButton: true,
      confirmButtonModel: ConfirmButtonModel(
        firstLine: xPhrase(context, '##Confirm'),
        secondLine: xPhrase(context, '##Update Author Details'),
        onTap: () => onConfirmAuthorUpdates(
          context: context,
          author: _author,
          titleController: _titleController,
          generatedControllers: _generatedContactsControllers,
          nameController: _nameController,
          bzModel: widget.bzModel,
        ),
      ),
      layoutWidget: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: Stratosphere.stratosphereSandwich,
          children: <Widget>[

            /// --- AUTHOR IMAGE
            ValueListenableBuilder(
              valueListenable: _author,
              builder: (_, AuthorModel author, Widget child){

                return AddImagePicBubble(
                  fileModel: _authorPicFile,
                  titleVerse: xPhrase(context, '##Author picture'),
                  redDot: true,
                  bubbleType: BubbleType.authorPic,
                  onAddPicture: (ImagePickerType imagePickerType) => takeAuthorImage(
                    context: context,
                    author: _author,
                    imagePickerType: imagePickerType,
                  ),
                );

              },
            ),

            /// NAME
            TextFieldBubble(
              isFormField: true,
              textController: _nameController,
              titleVerse: xPhrase(context, '##Author Name'),
              counterIsOn: true,
              maxLength: 72,
              keyboardTextInputType: TextInputType.name,
              fieldIsRequired: true,
              bulletPoints: <String>[
                xPhrase(context, '##This will only change your name inside this Business account'),
              ],
              validator: (){

                if (Stringer.checkStringIsEmpty(_nameController.text) == true){
                  return xPhrase(context, '##Author name can not be empty');
                }
                else if (_nameController.text.length <= 3){
                  return xPhrase(context, '##Author name should be more than 3 characters');
                }
                else {
                  return null;
                }

              },
            ),

            /// TITLE
            TextFieldBubble(
              isFormField: true,
              textController: _titleController,
              titleVerse: xPhrase(context, '##Job Title'),
              counterIsOn: true,
              maxLength: 72,
              keyboardTextInputType: TextInputType.name,
              fieldIsRequired: true,
              validator: (){

                if (Stringer.checkStringIsEmpty(_titleController.text) == true){
                  return xPhrase(context, '##Author name can not be empty');
                }
                else if (_titleController.text.length <= 3){
                  return xPhrase(context, '##Author name should be more than 3 characters');
                }
                else {
                  return null;
                }

              },
            ),

            /// CONTACTS
            ...List.generate(ContactModel.contactTypesList.length, (index){

              final ContactType _contactType = ContactModel.contactTypesList[index];

              final String _title = ContactModel.translateContactType(
                context: context,
                contactType: _contactType,
              );
              final bool _isRequired = ContactModel.checkContactIsRequired(
                contactType: _contactType,
                ownerType: ContactsOwnerType.author,
              );

              final TextInputType _textInputType = ContactModel.getContactTextInputType(
                contactType: _contactType,
              );

              return ContactFieldBubble(
                isFormField: true,
                textController: _generatedContactsControllers[index],
                title: _title,
                leadingIcon: ContactModel.getContactIcon(_contactType),
                keyboardTextInputAction: TextInputAction.next,
                fieldIsRequired: _isRequired,
                keyboardTextInputType: _textInputType,
              );

            }),

          ],
        ),
      ),
    );

  }
}
