import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/contact_field_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/c_author_editor/a_author_editor_controller.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:flutter/material.dart';

class AuthorEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorEditorScreen({
    @required this.author,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel author;
  /// --------------------------------------------------------------------------
  @override
  _AuthorEditorScreenState createState() => _AuthorEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _AuthorEditorScreenState extends State<AuthorEditorScreen> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<AuthorModel> _author; /// tamam disposed
  TextEditingController _nameController; /// tamam disposed
  TextEditingController _titleController; /// tamam disposed
  List<TextEditingController> _generatedContactsControllers; /// tamam disposed
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  /*
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'xxxxx',);
    }
  }
   */
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
    _nameController = TextEditingController(text: _theAuthor.name);
    _titleController = TextEditingController(text: _theAuthor.title);

    _generatedContactsControllers = ContactModel.generateContactsControllers(
      existingContacts: _theAuthor.contacts,
    );

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading().then((_) async {
      //
      //   await _triggerLoading();
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
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
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitle: 'Edit Author Details', // createBzAccount
      // appBarBackButton: true,
      layoutWidget: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[

            ListView(
              physics: const BouncingScrollPhysics(),
              padding: Stratosphere.stratosphereSandwich,
              children: <Widget>[

                /// --- AUTHOR IMAGE
                ValueListenableBuilder(
                  valueListenable: _author,
                  builder: (_, AuthorModel author, Widget child){

                    return AddGalleryPicBubble(
                      picture: ValueNotifier(author.pic),
                      title: 'Author picture',
                      redDot: true,
                      bubbleType: BubbleType.authorPic,
                      onAddPicture: () => takeAuthorImage(
                        author: _author,
                      ),
                      onDeletePicture: () => onDeleteAuthorImage(
                        author: _author,
                      ),
                    );

                  },
                ),

                /// NAME
                TextFieldBubble(
                  isFormField: true,
                  textController: _nameController,
                  title: 'Author Name',
                  counterIsOn: true,
                  maxLength: 72,
                  keyboardTextInputType: TextInputType.name,
                  fieldIsRequired: true,
                  comments: const <String>['This will only change your name inside this Business account'],
                  validator: (){

                    if (TextChecker.stringIsEmpty(_nameController.text) == true){
                      return 'Author name can not be empty';
                    }
                    else if (_nameController.text.length <= 3){
                      return 'Author name should be more than 3 characters';
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
                  title: 'Job Title',
                  counterIsOn: true,
                  maxLength: 72,
                  keyboardTextInputType: TextInputType.name,
                  fieldIsRequired: true,
                  validator: (){

                    if (TextChecker.stringIsEmpty(_titleController.text) == true){
                      return 'Author name can not be empty';
                    }
                    else if (_titleController.text.length <= 3){
                      return 'Author name should be more than 3 characters';
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

            /// ---  CONFIRM BUTTON
            EditorConfirmButton(
              firstLine: 'Confirm',
              secondLine: 'Update Author Details',
              positionedAlignment: Alignment.bottomLeft,
              onTap: () => onConfirmAuthorUpdates(
                context: context,
                author: _author,
                titleController: _titleController,
                generatedControllers: _generatedContactsControllers,
                nameController: _nameController,
              ),
            ),

          ],
        ),
      ),
    );

  }
}
