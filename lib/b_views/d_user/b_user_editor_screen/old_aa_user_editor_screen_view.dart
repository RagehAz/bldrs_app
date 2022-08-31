import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/x_user_editor_controllers.dart';
import 'package:bldrs/b_views/z_components/editors/contacts_editor_bubbles.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/gender_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OLDUserEditorScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OLDUserEditorScreenView({
    @required this.formKey,
    @required this.fileModel,
    @required this.canPickImage,
    @required this.nameController,
    @required this.genderNotifier,
    @required this.titleController,
    @required this.companyController,
    @required this.zone,
    @required this.contacts,
    @required this.appBarType,
    @required this.nameNode,
    @required this.jobNode,
    @required this.companyNode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final ValueNotifier<FileModel> fileModel;
  final ValueNotifier<bool> canPickImage;
  final TextEditingController nameController;
  final ValueNotifier<Gender> genderNotifier;
  final TextEditingController titleController;
  final TextEditingController companyController;
  final ValueNotifier<ZoneModel> zone;
  final List<ContactModel> contacts;
  final AppBarType appBarType;
  final FocusNode nameNode;
  final FocusNode jobNode;
  final FocusNode companyNode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final bool _keyboardIsOn = Keyboard.keyboardIsOn(context);

    return Form(
      key: formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: <Widget>[

          const Stratosphere(),

          /// PICTURE
          OLDAddImagePicBubble(
            titleVerse: '##Picture',
            redDot: true,
            fileModel: fileModel,
            bubbleType: BubbleType.userPic,
            onAddPicture: (ImagePickerType imagePickerType) => takeUserPicture(
              context: context,
              canPickImage: canPickImage,
              fileModel: fileModel,
              imagePickerType: imagePickerType,
            ),
          ),

          /// GENDER
          OLDGenderBubble(
            selectedGender: genderNotifier,
            onTap: (Gender gender) => onChangeGender(
              selectedGender: gender,
              genderNotifier: genderNotifier,
            ),
          ),


          /// NAME
          TextFieldBubble(
            key: const Key('name'),
            globalKey: formKey,
            focusNode: nameNode,
            appBarType: appBarType,
            isFormField: true,
            textController: nameController,
            titleVerse: 'phid_name',
            keyboardTextInputType: TextInputType.name,
            keyboardTextInputAction: TextInputAction.next,
            fieldIsRequired: true,
            validator: () => nameController.text.isEmpty ?
            'phid_enterName'
                :
            null,
          ),

          /// JOB TITLE
          TextFieldBubble(
            globalKey: formKey,
            focusNode: jobNode,
            appBarType: appBarType,
            isFormField: true,
            key: const Key('title'),
            textController: titleController,
            titleVerse: 'phid_jobTitle',
            keyboardTextInputType: TextInputType.name,
            keyboardTextInputAction: TextInputAction.next,
            fieldIsRequired: true,
            validator: () => titleController.text.isEmpty ?
            'phid_enterJobTitle'
                :
            null,
          ),

          /// COMPANY NAME
          TextFieldBubble(
            globalKey: formKey,
            focusNode: companyNode,
            appBarType: appBarType,
            isFormField: true,
            textController: companyController,
            key: const Key('company'),
            titleVerse: 'phid_companyName',
            keyboardTextInputType: TextInputType.name,
            keyboardTextInputAction: TextInputAction.next,
            fieldIsRequired: true,
            validator: () => companyController.text.isEmpty ?
            'phid_enterCompanyName'
                :
            null,
          ),

          /// ZONE
          ValueListenableBuilder(
              valueListenable: zone,
              builder: (_, ZoneModel _zoneModel, Widget child){

                return ZoneSelectionBubble(
                  currentZone: _zoneModel,
                  onZoneChanged: (ZoneModel zoneModel) => onZoneChanged(
                    selectedZone: zoneModel,
                    zoneNotifier: zone,
                  ),
                );

              }
          ),

          /// CONTACTS
          ContactsEditorsBubbles(
            globalKey: formKey,
            contacts: contacts,
            contactsOwnerType: ContactsOwnerType.user,
            appBarType: appBarType,
          ),

          const Horizon(),

        ],
      ),
    );
  }
}
