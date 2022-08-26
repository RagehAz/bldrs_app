import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/editors/contacts_editor_bubbles.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/gender_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/c_controllers/d_user_controllers/b_user_editor/a_user_editor_controllers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:flutter/material.dart';

class UserEditorScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserEditorScreenView({
    @required this.formKey,
    @required this.fileModel,
    @required this.canPickImage,
    @required this.nameController,
    @required this.genderNotifier,
    @required this.titleController,
    @required this.companyController,
    @required this.zone,
    @required this.contacts,
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
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _keyboardIsOn = Keyboard.keyboardIsOn(context);

    return Form(
      key: formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[

          const Stratosphere(),

          /// PICTURE
          AddImagePicBubble(
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

          /// NAME
          TextFieldBubble(
            isFormField: true,
            textController: nameController,
            key: const Key('name'),
            titleVerse: 'phid_name',
            keyboardTextInputType: TextInputType.name,
            keyboardTextInputAction: TextInputAction.next,
            fieldIsRequired: true,
            validator: () => nameController.text.isEmpty ?
            'phid_enterName'
                :
            null,
          ),

          /// GENDER
          GenderBubble(
            selectedGender: genderNotifier,
            onTap: (Gender gender) => onChangeGender(
              selectedGender: gender,
              genderNotifier: genderNotifier,
            ),
          ),

          /// JOB TITLE
          TextFieldBubble(
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
            contacts: contacts,
            contactsOwnerType: ContactsOwnerType.user,
          ),

          const Horizon(),

          if (_keyboardIsOn == true)
            const SizedBox(
              width: 20,
              height: 150,
            ),

        ],
      ),
    );
  }
}
