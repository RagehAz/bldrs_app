import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/password_bubble/password_bubble.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';

class PasswordScreen extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const PasswordScreen({
    Key key
  }) : super(key: key);
  // --------------------
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
  // -----------------------------------------------------------------------------
}

class _PasswordScreenState extends State<PasswordScreen> {
  // -----------------------------------------------------------------------------
  final TextEditingController _password = TextEditingController();
  final ValueNotifier<bool> _isObscured = ValueNotifier(true);
  final FocusNode _node = FocusNode();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _node.requestFocus();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _password.dispose();
    _isObscured.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Material(
        color: Colorz.nothing,
        child: GestureDetector(
          onTap: () => Nav.goBack(context: context),
          child: Center(
            child: DismissiblePage(
              onDismissed: () => Nav.goBack(context: context),
              // direction: DismissiblePageDismissDirection.vertical,
              startingOpacity: 0,
              minScale: 1,
              child: Container(
                width: Scale.screenWidth(context),
                height: Scale.screenHeight(context),
                // color: Colorz.black200,
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[

                    /// BLUR LAYER
                    BlurLayer(
                      height: Scale.screenHeight(context),
                      width: Scale.screenWidth(context),
                      color: Colorz.black200,
                      blurIsOn: true,
                    ),

                    /// PASSWORD BUBBLE
                    Padding(
                      padding: const EdgeInsets.only(bottom: 150),
                      child: PasswordBubbles(
                        mainAxisAlignment: MainAxisAlignment.center,
                        passwordNode: _node,
                        confirmPasswordNode: null,
                        appBarType: AppBarType.non,
                        bubbleWidth: CenterDialog.clearWidth(context) - 20,
                        passwordController: _password,
                        showPasswordOnly: true,
                        passwordValidator: (String text) => Formers.passwordValidator(
                          password: _password.text,
                          canValidate: true,
                        ),
                        passwordConfirmationController: null,
                        passwordConfirmationValidator: null,
                        goOnKeyboardGo: false,
                        onSubmitted: (String text) async {

                          Keyboard.closeKeyboard();

                          await Nav.goBack(
                              context: context,
                              passedData: text
                          );

                        },
                        isObscured: _isObscured,
                        // isTheSuperKeyboardField: false,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
