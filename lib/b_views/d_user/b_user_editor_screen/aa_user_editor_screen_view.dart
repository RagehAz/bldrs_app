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

class UserEditorScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserEditorScreenView({
    @required this.formKey,
    @required this.canPickImage,
    @required this.nameController,
    @required this.titleController,
    @required this.companyController,
    @required this.appBarType,
    @required this.nameNode,
    @required this.jobNode,
    @required this.companyNode,
    @required this.tempUser,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> canPickImage;
  final TextEditingController nameController;
  final TextEditingController titleController;
  final TextEditingController companyController;
  final AppBarType appBarType;
  final FocusNode nameNode;
  final FocusNode jobNode;
  final FocusNode companyNode;
  final ValueNotifier<UserModel> tempUser;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
      child: ValueListenableBuilder(
        valueListenable: tempUser,
        builder: (_, UserModel userModel, Widget child){

          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: <Widget>[

              const Stratosphere(),

              /// PICTURE
              AddImagePicBubble(
                titleVerse: 'phid_picture',
                redDot: true,
                fileModel: userModel.pic,
                bubbleType: BubbleType.userPic,
                onAddPicture: (ImagePickerType imagePickerType) => takeUserPicture(
                  context: context,
                  canPickImage: canPickImage,
                  userNotifier: tempUser,
                  imagePickerType: imagePickerType,
                ),
              ),

              /// GENDER
              GenderBubble(
                selectedGender: userModel.gender,
                onTap: (Gender gender) => onChangeGender(
                  selectedGender: gender,
                  userNotifier: tempUser,
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
              ZoneSelectionBubble(
                currentZone: userModel.zone,
                onZoneChanged: (ZoneModel zoneModel) => onUserZoneChanged(
                  selectedZone: zoneModel,
                  userNotifier: tempUser,
                ),
              ),

              /// CONTACTS
              ContactsEditorsBubbles(
                globalKey: formKey,
                contacts: userModel.contacts,
                contactsOwnerType: ContactsOwnerType.user,
                appBarType: appBarType,
              ),

              const Horizon(),

            ],
          );

        },
      ),
    );
  }
}
