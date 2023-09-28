import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:basics/layouts/separators/separator_line.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/d_settings_page/user_settings_page_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class DeleteMyDataScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const DeleteMyDataScreen({
    super.key
  });
  // --------------------
  @override
  State<DeleteMyDataScreen> createState() => _DeleteMyDataScreenState();
  // --------------------------------------------------------------------------
}

class _DeleteMyDataScreenState extends State<DeleteMyDataScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isObscured = ValueNotifier(true);
  final ValueNotifier<bool> _isSigningIn = ValueNotifier(true);
  final FocusNode _passwordNode = FocusNode();
  bool canRequestDeletion = false;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------

        if (Authing.getUserID() == null){
          await Authing.anonymousSignin(
            onError: (String? error) async {
              await AuthProtocols.onAuthError(
                error: error,
                invoker: 'DeleteMyDataScreen',
              );
            }
          );
        }

        // /// APP LANGUAGE
        // await initializeDonya(
        //   mounted: mounted,
        // );

        // -------------------------------
        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isSigningIn.dispose();
    _loading.dispose();
    _isObscured.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    final double _bodyWidth = Scale.superWidth(context, 0.6);

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      loading: _loading,
      skyType: SkyType.blackStars,
      child: WidgetFader(
          fadeType: FadeType.fadeIn,
          duration: const Duration(seconds: 2),
          child: FloatingList(
            padding: Stratosphere.stratosphereSandwich,
            columnChildren: <Widget>[

              /// DELETE MY DATA TITLE
              BldrsText(
                verse: const Verse(
                  id: 'Request to delete all my data', translate: false,
                  // translate: true,
                  // id: 'phid_delete_my_data',
                ),
                size: 5,
                scaleFactor: 1.5,
                centered: false,
                weight: VerseWeight.black,
                width: _bodyWidth,
                maxLines: 3,
              ),

              /// DELETE MY DATA WARNING
              BldrsText(
                verse: const Verse(
                  id: 'After requesting to delete your data, a confirmation email will be sent to you '
                      'of the successful deletion of your data, and please be noted that only the data '
                      'created by you and does not impact other entities and/or other users will be deleted.',
                  translate: false,
                  // translate: true,
                  // id: 'phid_delete_my_data_warning',
                ),
                width: _bodyWidth,
                weight: VerseWeight.thin,
                centered: false,
                size: 3,
                maxLines: 10,
              ),

              const DotSeparator(),

              /// EMAIL AND PASSWORD BUBBLES
              if (canRequestDeletion == false)
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[

                      /// ENTER E-MAIL
                      BldrsTextFieldBubble(
                        bubbleWidth: _bodyWidth,
                        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                          context: context,
                          redDot: true,
                          headlineVerse: const Verse(
                            id: 'Email address',
                            translate: false,
                          ),
                        ),
                        appBarType: AppBarType.non,
                        isFormField: true,
                        key: const ValueKey<String>('email'),
                        textController: _emailController,
                        textDirection: TextDirection.ltr,
                        keyboardTextInputType: TextInputType.emailAddress,
                        keyboardTextInputAction: TextInputAction.next,
                        hintVerse: const Verse(
                          id: 'rageh@bldrs.net',
                          translate: false,
                        ),
                        validator: (String? text) => Formers.emailValidator(
                          email: _emailController.text,
                          canValidate: true,
                          enterEmailWord: 'Enter your email',
                          emailInvalidWord: 'Email is invalid',
                        ),
                      ),

                      /// PASSWORD - CONFIRMATION
                      BldrsTextFieldBubble(
                        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                          context: context,
                          headlineVerse: const Verse(
                            id: 'Password',
                            translate: false,
                            // id: 'phid_password',
                            // translate: true,
                          ),
                          redDot: true,
                        ),
                        focusNode: _passwordNode,
                        appBarType: AppBarType.non,
                        bubbleWidth: _bodyWidth,
                        isFormField: true,
                        key: const ValueKey<String>('password'),
                        textController: _passwordController,
                        textDirection: TextDirection.ltr,
                        keyboardTextInputType: TextInputType.visiblePassword,
                        keyboardTextInputAction: TextInputAction.go,
                        validator: (String? text) => Formers.passwordValidator(
                          password: _passwordController.text,
                          canValidate: true,
                          enterPassword: 'Enter your password',
                          min6Chars: 'password should atleast be 6 characters long',
                        ),
                        isObscured: _isObscured,
                        onSubmitted: (String? text) async {
                          final bool _go = Formers.validateForm(_formKey);
                          if (_go == true) {
                            final bool _success = await AuthProtocols.signInBldrsByEmail(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (_success == true) {
                              setState(() {
                                canRequestDeletion = true;
                              });
                            }
                          }
                        },
                      ),

                    ],
                  ),
                ),

              /// SIGN IN BUTTONS
              if (canRequestDeletion == false)
                BldrsBox(
                  height: 50,
                  color: Colorz.yellow255,
                  verse: const Verse(
                    id: 'Sign in', translate: false,
                    // id: 'phid_signIn',
                    // translate: true,
                  ),
                  verseColor: Colorz.black255,
                  verseWeight: VerseWeight.black,
                  margins: const EdgeInsets.only(bottom: 5),
                  onTap: () async {
                    blog('a77a');

                    final bool _go = Formers.validateForm(_formKey);

                    if (_go == true) {
                      blog('wtf');

                      final AuthModel? _authModel = await EmailAuthing.signIn(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                        onError: (String? error) async {
                          await AuthProtocols.onAuthError(
                            error: error,
                            invoker: 'DeleteMyDataScreen',
                          );
                        },
                      );

                      if (_authModel != null) {
                        setState(() {
                          canRequestDeletion = true;
                        });
                      }
                    }
                  },
                ),

              SeparatorLine(width: _bodyWidth),

              /// DELETE MY DATA BUTTON
              BldrsBox(
                isDisabled: canRequestDeletion == false,
                verse: const Verse(
                  id: 'Delete All my data collected by Bldrs.net', translate: false,
                  // translate: true,
                  // id: 'phid_delete_my_data_title',
                ),
                width: _bodyWidth * 0.7,
                verseMaxLines: 4,
                verseScaleFactor: 0.3,
                height: 120,
                color: Colorz.yellow255,
                verseColor: Colorz.black255,
                verseWeight: VerseWeight.black,
                margins: 20,
                onTap: () async {
                  bool _go = await Dialogs.confirmProceed(
                    titleVerse: Verse.plain('Delete ?'),
                    yesVerse: Verse.plain('Yes, Delete'),
                    noVerse: Verse.plain('No'),
                    invertButtons: true,
                  );

                  if (_go == true) {

                    _go = await reAuthenticateUser(
                      dialogTitleVerse: const Verse(
                        id: 'Delete All my data', translate: false,
                        // id: 'phid_delete_my_data_title',
                        // translate: true,
                      ),
                      dialogBodyVerse: const Verse(
                        id: 'After confirming, your data will be deleted permanently',
                        translate: false,
                      ),
                      confirmButtonVerse: const Verse(
                        id: 'Yes Delete', translate: false,
                        // id: 'phid_yes_delete',
                        // translate: true,
                      ),
                    );

                    if (_go == true) {
                      WaitDialog.showUnawaitedWaitDialog();

                      await Real.createDoc(
                        coll: RealColl.deletionRequests,
                        map: {
                          'userID': Authing.getUserID(),
                          'time': Timers.cipherTime(time: DateTime.now(), toJSON: true),
                          'email': await Authing.getAuthEmail(),
                        },
                      );

                      await BldrsCenterDialog.showCenterDialog(
                        titleVerse: const Verse(
                          id: 'Deletion request has been sent', translate: false,
                          // id: 'phid_data_deletion_request_sent',
                          // translate: true,
                        ),
                        bodyVerse: const Verse(
                          id: '''
                          After your data is completely deleted,
                          we will send you a confirmation email.
                           ''',
                          translate: false,
                        ),
                        confirmButtonVerse: const Verse(
                          id: 'Great', translate: false,
                          // id: 'phid_great_!',
                          // translate: true,
                        ),
                      );

                      await WaitDialog.closeWaitDialog();

                      await Nav.goBack(context: context);
                    }
                  }
                },
              ),

            ],
          ),
        ),
    );

  }
  // --------------------
}
