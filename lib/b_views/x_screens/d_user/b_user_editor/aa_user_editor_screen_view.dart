import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/contact_field_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/gender_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/c_controllers/d_user_controllers/b_user_editor/a_user_editor_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class UserEditorScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserEditorScreenView({
    @required this.loading,
    @required this.formKey,
    @required this.picture,
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
    @required this.oldUserModel,
    @required this.createNewUserModel,
    @required this.onFinish,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> loading;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<dynamic> picture;
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
  final UserModel oldUserModel;
  final UserModel Function() createNewUserModel;
  final Function onFinish;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _keyboardIsOn = Keyboarders.keyboardIsOn(context);

    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (_, bool _isLoading, Widget child){

        if (_isLoading == true){
          return const LoadingFullScreenLayer();
        }

        else {
          return child;
        }

      },

      child: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: <Widget>[

                const Stratosphere(),

                /// PICTURE
                AddGalleryPicBubble(
                  title: 'Picture',
                  redDot: true,
                  picture: picture,
                  bubbleType: BubbleType.userPic,
                  onDeletePicture: () => deleteUserPicture(
                    picture: picture,
                  ),
                  onAddPicture: () => takeUserPicture(
                      canPickImage: canPickImage,
                      picture: picture
                  ),
                ),

                /// NAME
                TextFieldBubble(
                  isFormField: true,
                  textController: nameController,
                  key: const Key('name'),
                  title: superPhrase(context, 'phid_name'),
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  validator: () => nameController.text.isEmpty ?
                  superPhrase(context, 'phid_enterName')
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
                  title: superPhrase(context, 'phid_jobTitle'),
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  validator: () => titleController.text.isEmpty ?
                  superPhrase(context, 'phid_enterJobTitle')
                      :
                  null,
                ),

                /// COMPANY NAME
                TextFieldBubble(
                  isFormField: true,
                  textController: companyController,
                  key: const Key('company'),
                  title: superPhrase(context, 'phid_companyName'),
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  validator: () => companyController.text.isEmpty ?
                  superPhrase(context, 'phid_enterCompanyName')
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
                  title: superPhrase(context, 'phid_emailAddress'),
                  leadingIcon: Iconz.comEmail,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  keyboardTextInputType: TextInputType.emailAddress,
                ),

                /// PHONE
                ContactFieldBubble(
                  isFormField: true,
                  textController: phoneController,
                  title: superPhrase(context, 'phid_phone'),
                  leadingIcon: Iconz.comPhone,
                  keyboardTextInputAction: TextInputAction.next,
                  keyboardTextInputType: TextInputType.phone,
                ),

                const DotSeparator(),

                /// --- EDIT FACEBOOK
                ContactFieldBubble(
                  isFormField: true,
                  textController: facebookController,
                  title: superPhrase(context, 'phid_facebookLink'),
                  leadingIcon: Iconz.comFacebook,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                /// --- EDIT INSTAGRAM
                ContactFieldBubble(
                  isFormField: true,
                  textController: instagramController,
                  title: superPhrase(context, 'phid_instagramLink'),
                  leadingIcon: Iconz.comInstagram,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                /// --- EDIT LINKEDIN
                ContactFieldBubble(
                  isFormField: true,
                  textController: linkedInController,
                  title: superPhrase(context, 'phid_linkedinLink'),
                  leadingIcon: Iconz.comLinkedin,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                /// --- EDIT TWITTER
                ContactFieldBubble(
                  isFormField: true,
                  textController: twitterController,
                  title: superPhrase(context, 'phid_twitterLink'),
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

            /// --- CONFIRM BUTTON
            EditorConfirmButton(
              firstLine: superPhrase(context, 'phid_updateProfile').toUpperCase(),
              positionedAlignment: Alignment.bottomLeft,
              onTap: () => confirmEdits(
                  context: context,
                  formKey: formKey,
                  newUserModel: createNewUserModel(),
                  oldUserModel: oldUserModel,
                  onFinish: onFinish,
                  loading: loading
              ),
            ),

          ],
        ),
      ),
    );
  }
}
