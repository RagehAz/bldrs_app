import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/password_bubble/password_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:legalizer/legalizer.dart';
import 'package:mapper/mapper.dart';

class EmailAuthScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EmailAuthScreenView({
    @required this.formKey,
    @required this.emailController,
    @required this.passwordController,
    @required this.passwordConfirmationController,
    @required this.emailValidator,
    @required this.passwordValidator,
    @required this.passwordConfirmationValidator,
    @required this.switchSignIn,
    @required this.onSignin,
    @required this.onSignup,
    @required this.isSigningIn,
    @required this.appBarType,
    @required this.passwordNode,
    @required this.confirmPasswordNode,
    @required this.isRememberingMe,
    @required this.onSwitchRememberMe,
    @required this.onSelectAccount,
    @required this.myAccounts,
    @required this.isObscured,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final String Function(String) emailValidator;
  final String Function(String) passwordValidator;
  final String Function(String) passwordConfirmationValidator;
  final Function switchSignIn;
  final Function onSignin;
  final Function onSignup;
  final ValueNotifier<bool> isSigningIn;
  final AppBarType appBarType;
  final FocusNode passwordNode;
  final FocusNode confirmPasswordNode;
  final ValueNotifier<bool> isRememberingMe;
  final Function(bool rememberMe) onSwitchRememberMe;
  final Function(int index) onSelectAccount;
  final List<AccountModel> myAccounts;
  final ValueNotifier<bool> isObscured;
  /// --------------------------------------------------------------------------
  void _onSubmitted({
    @required bool signingIn,
    @required bool isOnConfirmPassword,
  }){

    blog('_onSubmitted : trying to submit');

    /// WHILE SIGN IN
    if (signingIn == true){

      /// WHILE ON PASSWORD
      if (isOnConfirmPassword == false){
        onSignin();
      }
    }

    /// WHILE SIGN UP
    else {
      if (isOnConfirmPassword == true){
        onSignup();
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _buttonHeight = 50;
    const double _verseScaleFactor = 0.7;
    // --------------------
    return Form(
      key: formKey,
      child: ValueListenableBuilder(
        valueListenable: isSigningIn,
        builder: (_, bool _isSigningIn, Widget child){

          return BldrsFloatingList(
            // physics: const BouncingScrollPhysics(),
            // padding: Stratosphere.stratosphereSandwich,
            columnChildren: <Widget>[

              /// ENTER E-MAIL
              BldrsTextFieldBubble(
                bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                  context: context,
                  redDot: true,
                  headlineVerse: const Verse(
                    id: 'phid_emailAddress',
                    translate: true,
                  ),
                ),
                appBarType: appBarType,
                isFormField: true,
                key: const ValueKey<String>('email'),
                textController: emailController,
                textDirection: TextDirection.ltr,
                keyboardTextInputType: TextInputType.emailAddress,
                keyboardTextInputAction: TextInputAction.next,
                hintVerse: const Verse(
                  id: 'rageh@bldrs.net',
                  translate: false,
                ),
                validator: emailValidator,
                columnChildren: <Widget>[

                  if (Mapper.checkCanLoopList(myAccounts) == true)
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.end,
                    children: <Widget>[

                        ...List.generate(myAccounts.length, (index) {
                          final AccountModel _account = myAccounts[index];

                          return FutureBuilder(
                            future: UserProtocols.fetch(
                              context: context,
                              userID: _account.id,
                            ),
                            builder: (_, AsyncSnapshot<UserModel> snap) {

                              final UserModel _userModel = snap.data;
                              final String _userEmail = ContactModel.getValueFromContacts(
                                contacts: _userModel?.contacts,
                                contactType: ContactType.email,
                              );

                              return ValueListenableBuilder(
                                  valueListenable: emailController,
                                  builder: (_, TextEditingValue currentEmail, Widget child) {
                                    return BldrsBox(
                                      height: 35,
                                      width: 35,
                                      icon: _userModel?.picPath,
                                      margins: 5,
                                      greyscale: _userEmail != currentEmail.text,
                                      onTap: () => onSelectAccount(index),
                                    );
                                  });
                            },
                          );
                        }),
                      ],
                    ),


                ],
              ),

              /// PASSWORD - CONFIRMATION
              PasswordBubbles(
                confirmPasswordNode: confirmPasswordNode,
                passwordNode: passwordNode,
                appBarType: appBarType,
                passwordController: passwordController,
                showPasswordOnly: _isSigningIn,
                passwordValidator: passwordValidator,
                passwordConfirmationController: passwordConfirmationController,
                passwordConfirmationValidator: passwordConfirmationValidator,
                onSubmitted: (String text) => _onSubmitted(
                  signingIn: _isSigningIn,
                  isOnConfirmPassword: false,
                ),
                isObscured: isObscured,
              ),

              /// REMEMBER ME
              ValueListenableBuilder(
                valueListenable: isRememberingMe,
                builder: (_, bool rememberMe, Widget child){

                  return BldrsTileBubble(
                    bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                      context: context,
                      headlineVerse: const Verse(
                        id: 'phid_remember_me',
                        translate: true,
                      ),
                      switchValue: rememberMe,
                      hasSwitch: true,
                      onSwitchTap: onSwitchRememberMe,
                    ),
                  );

                  },
              ),

              const SizedBox(height: 5),

              /// SIGN IN BUTTON
              if (_isSigningIn == true)
              BldrsBox(
                height: _buttonHeight,
                verseScaleFactor: _verseScaleFactor,
                color: _isSigningIn ? Colorz.yellow255 : Colorz.white20,
                verse: const Verse(
                  id: 'phid_signIn',
                  translate: true,
                ),
                verseColor: _isSigningIn ? Colorz.black255 : Colorz.white255,
                verseWeight: VerseWeight.black,
                margins: const EdgeInsets.only(bottom: 5),
                onTap: _isSigningIn ? onSignin : switchSignIn,
              ),

              /// REGISTER BUTTON
              // if (isSigningIn == true)
              BldrsBox(
                height: _buttonHeight,
                width: 150,
                verseScaleFactor: _verseScaleFactor,
                verseMaxLines: 2,
                verse: Verse(
                  id: _isSigningIn ? 'phid_create' : 'phid_register',
                  translate: true,
                ),
                secondLine: const Verse(
                  id: 'phid_new_account',
                  translate: true,
                ),
                verseColor: _isSigningIn ? Colorz.white255 : Colorz.black255,
                secondLineColor: _isSigningIn ? Colorz.white255 : Colorz.black255,
                color: _isSigningIn ? Colorz.white20 : Colorz.yellow255,
                margins: const EdgeInsets.only(bottom: 5),
                onTap: _isSigningIn ? switchSignIn : onSignup,
              ),

              const SizedBox(height: 10),

              /// DISCLAIMER LINE
              LegalDisclaimerLine(
                onPolicyTap: () => onPrivacyTap(),
                onTermsTap: () => onTermsAndTap(),
                disclaimerLine: Verse.transBake(
                  _isSigningIn == true ?
                  'phid_by_using_bldrs_you_agree_to_our'
                      :
                  'phid_by_signing_up_you_agree_to_our',
                ),
                andLine: Verse.transBake('phid_and'),
                policyLine: Verse.transBake('phid_privacy_policy'),
                termsLine: Verse.transBake('phid_terms_of_service'),
              ),

              const Horizon(),

            ],
          );

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
