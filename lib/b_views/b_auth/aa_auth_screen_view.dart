import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:basics/layouts/separators/separator_line.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/legalizer/legalizer.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/b_auth/x_auth_controllers.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/password_bubble/password_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/general_buttons/main_button.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/horizon.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class AuthScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthScreenView({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
    required this.emailValidator,
    required this.passwordValidator,
    required this.passwordConfirmationValidator,
    required this.switchSignIn,
    required this.onSignin,
    required this.onSignup,
    required this.isSigningIn,
    required this.appBarType,
    required this.passwordNode,
    required this.confirmPasswordNode,
    required this.onSelectAccount,
    required this.myAccounts,
    required this.isObscured,
    required this.onForgotPassword,
    required this.currentAccount,
    this.hasMargins = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? passwordConfirmationValidator;
  final Function switchSignIn;
  final Function onSignin;
  final Function onSignup;
  final bool isSigningIn;
  final AppBarType appBarType;
  final FocusNode passwordNode;
  final FocusNode confirmPasswordNode;
  final Function(int index) onSelectAccount;
  final List<AccountModel> myAccounts;
  final ValueNotifier<bool> isObscured;
  final bool hasMargins;
  final Function onForgotPassword;
  final AccountModel? currentAccount;
  // --------------------------------------------------------------------------
  void _onSubmitted({
    required bool signingIn,
    required bool isOnConfirmPassword,
  }){

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
  // --------------------
  bool accountIsSocial({
    required String? currentEmail
  }){
      bool _isSocial = false;

      if (currentAccount != null && currentAccount?.email == currentEmail){
        _isSocial =
            currentAccount!.signInMethod == SignInMethod.google ||
            currentAccount!.signInMethod == SignInMethod.facebook ||
            currentAccount!.signInMethod == SignInMethod.apple
        ;
      }

      blog('account is social : $_isSocial');
      return _isSocial;
    }
  // --------------------
  String? getBySocialPhid(SignInMethod method){
    String? _phid;
    switch (method){
      case SignInMethod.google:     _phid = 'phid_by_google';   break;
      case SignInMethod.facebook:   _phid = 'phid_by_facebook'; break;
      case SignInMethod.apple:      _phid = 'phid_by_apple';    break;
      case SignInMethod.anonymous:  _phid = null; break;
      case SignInMethod.password:   _phid = null; break;
    }
    return _phid;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _buttonHeight = 50;
    const double _verseScaleFactor = 0.6;
    // --------------------
    final double _bubbleWidth = BldrsAppBar.responsiveWidth();
    // --------------------
    final List<SignInMethod> methods = [
      if (DeviceChecker.deviceIsIOS() == true)
        SignInMethod.apple,
      SignInMethod.google,
      // SignInMethod.facebook
    ];
    // --------------------
    return Form(
      key: formKey,
      child: ValueListenableBuilder(
          valueListenable: emailController,
          builder: (_, TextEditingValue currentEmail, Widget? child) {

            final bool _currentAccountIsSocial = accountIsSocial(
              currentEmail: currentEmail.text,
            );

          return BldrsFloatingList(
            // physics: const BouncingScrollPhysics(),
            // padding: Stratosphere.stratosphereSandwich,
            hasMargins: hasMargins,
            columnChildren: <Widget>[

              /// ENTER E-MAIL
              BldrsTextFieldBubble(
                bubbleWidth: _bubbleWidth,
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
                hintTextDirection: TextDirection.ltr,
                keyboardTextInputType: TextInputType.emailAddress,
                keyboardTextInputAction: TextInputAction.next,
                hintVerse: const Verse(
                  id: 'rageh@bldrs.net',
                  translate: false,
                ),
                validator: emailValidator,
                autoCorrect: Keyboard.autoCorrectIsOn(),
                enableSuggestions: Keyboard.suggestionsEnabled(),
                columnChildren: <Widget>[

                  if (Lister.checkCanLoop(myAccounts) == true)
                    FloatingList(
                      mainAxisAlignment:  MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      boxAlignment: BldrsAligners.superInverseCenterAlignment(context),
                      width: Bubble.clearWidth(context: context),
                      height: 45,
                      scrollDirection: Axis.horizontal,
                      columnChildren: <Widget>[

                        ...List.generate(myAccounts.length, (index) {

                          final AccountModel _account = myAccounts[index];

                          return FutureBuilder<UserModel?>(
                            future: UserProtocols.fetch(userID: _account.id),
                            builder: (_, AsyncSnapshot<UserModel?> snap) {

                              final UserModel? _userModel = snap.data;
                              final String? _userEmail = ContactModel.getValueFromContacts(
                                contacts: _userModel?.contacts,
                                contactType: ContactType.email,
                              );

                              final bool _isSelected = _userEmail == currentEmail.text;

                              return Stack(
                                children: <Widget>[

                                  BldrsBox(
                                    height: 35,
                                    width: 35,
                                    icon: _userModel?.picPath,
                                    margins: 5,
                                    greyscale: !_isSelected,
                                    borderColor: _isSelected == true ? Colorz.white200 : null,
                                    solidGreyScale: _userModel?.picPath == Iconz.anonymousUser,
                                    onTap: () => onSelectAccount(index),
                                  ),

                                  BldrsBox(
                                    width: 10,
                                    height: 10,
                                    icon: AuthModel.getSignInMethodIcon(
                                      signInMethod: _account.signInMethod,
                                    ),
                                  ),

                                ],
                              );

                              },
                          );

                        }),
                      ],
                    ),

                ],
              ),

              /// PASSWORD - CONFIRMATION
              Disabler(
                isDisabled: _currentAccountIsSocial,
                disabledOpacity: 0.2,
                child: PasswordBubbles(
                  bubbleWidth: _bubbleWidth,
                  confirmPasswordNode: confirmPasswordNode,
                  passwordNode: passwordNode,
                  appBarType: appBarType,
                  passwordController: passwordController,
                  showPasswordOnly: isSigningIn,
                  passwordValidator: passwordValidator,
                  passwordConfirmationController: passwordConfirmationController,
                  passwordConfirmationValidator: passwordConfirmationValidator,
                  onSubmitted: (String? text) => _onSubmitted(
                    signingIn: isSigningIn,
                    isOnConfirmPassword: false,
                  ),
                  onForgotPassword: onForgotPassword,
                  isObscured: isObscured,
                ),
              ),

              /// SIGN IN - REGISTER BUTTONS
              SizedBox(
                width: _bubbleWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    /// REGISTER BUTTON
                    BldrsBox(
                      height: _buttonHeight,
                      width: _bubbleWidth * 0.35,
                      verseScaleFactor: _verseScaleFactor,
                      verseMaxLines: 2,
                      verse: Verse(
                        id: isSigningIn ? 'phid_create' : 'phid_register',
                        translate: true,
                      ),
                      secondLine: const Verse(
                        id: 'phid_new_account',
                        translate: true,
                      ),
                      verseColor: isSigningIn ? Colorz.white255 : Colorz.black255,
                      secondLineColor: isSigningIn ? Colorz.white255 : Colorz.black255,
                      color: isSigningIn ? Colorz.white20 : Colorz.yellow255,
                      onTap: isSigningIn ? switchSignIn : onSignup,
                    ),

                    /// SIGN IN BUTTON
                    Disabler(
                      isDisabled: _currentAccountIsSocial,
                      disabledOpacity: 0.1,
                      child: BldrsBox(
                        isDisabled: isSigningIn == false,
                        width: _bubbleWidth * 0.65 - 10,
                        height: _buttonHeight,
                        verseScaleFactor: _verseScaleFactor,
                        color: isSigningIn || _currentAccountIsSocial ? Colorz.yellow255 : Colorz.white20,
                        verse: const Verse(
                          id: 'phid_sing_in_by_email',
                          translate: true,
                          casing: Casing.upperCase,
                        ),
                        verseColor: isSigningIn || _currentAccountIsSocial ? Colorz.black255 : Colorz.white255,
                        verseItalic: true,
                        verseWeight: VerseWeight.black,
                        // margins: const EdgeInsets.only(bottom: 5),
                        onTap: isSigningIn ? onSignin : switchSignIn,
                        verseMaxLines: 2,
                        onDisabledTap: () => switchSignIn(),
                      ),
                    ),

                  ],
                ),
              ),

              /// SOCIAL AUTH BUTTONS
              if (AuthProtocols.showSocialAuthButtons == true)
                Disabler(
                  isDisabled: !isSigningIn,
                  disabledOpacity: 0.1,
                  child: SizedBox(
                    width: _bubbleWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        ...List.generate(methods.length, (index) {

                          final SignInMethod method = methods[index];

                          return Column(
                            children: <Widget>[

                              /// SOCIAL BUTTON
                              SocialAuthButton(
                                signInMethod: method,
                                socialKeys: BldrsKeys.socialKeys,
                                onSuccess: (AuthModel? authModel) => authBySocialMedia(
                                  authModel: authModel,
                                  mounted: true,
                                ),
                                onError: (String? error) => AuthProtocols.onAuthError(
                                  error: error,
                                  invoker: 'SocialSignIn.$method',
                                ),
                                onAuthLoadingChanged: (bool loading){
                                  blog('is loading : $loading');
                                  },
                                manualAuthing: DeviceChecker.deviceIsAndroid(),
                              ),

                              /// BY VERSE
                              BldrsText(
                                width: SocialAuthButton.standardSize * 1.2,
                                verse: Verse(
                                  id: getBySocialPhid(method),
                                  translate: true,
                                ),
                                size: 1,
                                maxLines: 2,
                                weight: VerseWeight.thin,
                                scaleFactor: 0.8,
                              ),

                            ],
                          );

                        }),

                      ],
                    ),
                  ),
                ),

              /// SEPARATOR
              SeparatorLine(
                width: MainButton.getButtonWidth(context: context),
                withMargins: true,
              ),

              /// DISCLAIMER LINE
              LegalDisclaimerLine(
                onPolicyTap: () => onPrivacyTap(),
                onTermsTap: () => onTermsAndTap(),
                disclaimerLine: getWord('phid_by_using_bldrs_you_agree_to_our'),
                andLine: getWord('phid_and'),
                policyLine: getWord('phid_privacy_policy'),
                termsLine: getWord('phid_terms_of_service'),
                textDirection: UiProvider.getAppTextDir(),
              ),

              /// SEPARATOR
              const DotSeparator(
                bottomMarginIsOn: false,
              ),

              /// COPYRIGHTS
              CopyrightsLine(
                isArabic: !UiProvider.checkAppIsLeftToRight(),
                textHeight: 15,
                companyName: BldrsKeys.bldrsHoldingCompanyName,
              ),

              /// RAGE7 LOGO
              const Padding(
                padding: EdgeInsets.all(10),
                child: BldrsImage(
                  height: 15,
                  width: 15,
                  pic: Iconz.dvRagehIcon,
                  iconColor: Colorz.yellow200,
                ),
              ),

              /// SEPARATOR
              SeparatorLine(
                width: MainButton.getButtonWidth(context: context),
                withMargins: true,
              ),

              /// HORIZON
              const Horizon(heightFactor: 0.1),

            ],
          );
          }
          ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
