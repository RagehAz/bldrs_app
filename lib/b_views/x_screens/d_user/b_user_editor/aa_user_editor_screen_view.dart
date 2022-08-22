import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/contact_field_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/gender_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/c_controllers/d_user_controllers/b_user_editor/a_user_editor_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
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
    @required this.emailController,
    @required this.phoneController,
    @required this.facebookController,
    @required this.instagramController,
    @required this.linkedInController,
    @required this.twitterController,
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
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController facebookController;
  final TextEditingController instagramController;
  final TextEditingController linkedInController;
  final TextEditingController twitterController;
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
            title: 'Picture',
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
            title: xPhrase(context, 'phid_name'),
            keyboardTextInputType: TextInputType.name,
            keyboardTextInputAction: TextInputAction.next,
            fieldIsRequired: true,
            validator: () => nameController.text.isEmpty ?
            xPhrase(context, 'phid_enterName')
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
            title: xPhrase(context, 'phid_jobTitle'),
            keyboardTextInputType: TextInputType.name,
            keyboardTextInputAction: TextInputAction.next,
            fieldIsRequired: true,
            validator: () => titleController.text.isEmpty ?
            xPhrase(context, 'phid_enterJobTitle')
                :
            null,
          ),

          /// COMPANY NAME
          TextFieldBubble(
            isFormField: true,
            textController: companyController,
            key: const Key('company'),
            title: xPhrase(context, 'phid_companyName'),
            keyboardTextInputType: TextInputType.name,
            keyboardTextInputAction: TextInputAction.next,
            fieldIsRequired: true,
            validator: () => companyController.text.isEmpty ?
            xPhrase(context, 'phid_enterCompanyName')
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

          const DotSeparator(),

          /// EMAIL
          ContactFieldBubble(
            isFormField: true,
            textController: emailController,
            title: xPhrase(context, 'phid_emailAddress'),
            leadingIcon: Iconz.comEmail,
            keyboardTextInputAction: TextInputAction.next,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.emailAddress,
          ),

          /// PHONE
          ContactFieldBubble(
            isFormField: true,
            textController: phoneController,
            title: xPhrase(context, 'phid_phone'),
            leadingIcon: Iconz.comPhone,
            keyboardTextInputAction: TextInputAction.next,
            keyboardTextInputType: TextInputType.phone,
          ),

          const DotSeparator(),

          /// --- EDIT FACEBOOK
          ContactFieldBubble(
            isFormField: true,
            textController: facebookController,
            title: xPhrase(context, 'phid_facebookLink'),
            leadingIcon: Iconz.comFacebook,
            keyboardTextInputAction: TextInputAction.next,
          ),

          /// --- EDIT INSTAGRAM
          ContactFieldBubble(
            isFormField: true,
            textController: instagramController,
            title: xPhrase(context, 'phid_instagramLink'),
            leadingIcon: Iconz.comInstagram,
            keyboardTextInputAction: TextInputAction.next,
          ),

          /// --- EDIT LINKEDIN
          ContactFieldBubble(
            isFormField: true,
            textController: linkedInController,
            title: xPhrase(context, 'phid_linkedinLink'),
            leadingIcon: Iconz.comLinkedin,
            keyboardTextInputAction: TextInputAction.next,
          ),

          /// --- EDIT TWITTER
          ContactFieldBubble(
            isFormField: true,
            textController: twitterController,
            title: xPhrase(context, 'phid_twitterLink'),
            leadingIcon: Iconz.comTwitter,
            keyboardTextInputAction: TextInputAction.done,
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
